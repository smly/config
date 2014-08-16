# -*- coding: utf-8 -*-
import logging as l
import argparse
import os
import sys

import numpy as np
import scipy.sparse as ss
import scipy.io as sio
import pandas as pd

from ume.utils import feature_functions, save_mat, dynamic_load, load_settings


def parse_args():
    p = argparse.ArgumentParser(
        description='CLI interface UME')
    p.add_argument('--config', dest='inifile', default='config.ini')

    subparsers = p.add_subparsers(
        dest='subparser_name',
        help='sub-commands for instant action')

    f_parser = subparsers.add_parser('feature')
    f_parser.add_argument('-a', '--all', action='store_true', default=False)
    f_parser.add_argument('-n', '--name', type=str, required=True)
    i_parser = subparsers.add_parser('init')

    v_parser = subparsers.add_parser('validate')
    v_parser.add_argument('-m', '--model',
        required=True,
        type=str,
        help='model description file described by json format')

    p_parser = subparsers.add_parser('predict')
    p_parser.add_argument('-m', '--model',
        required=True,
        type=str,
        help='model description file described by json format')
    p_parser.add_argument('-o', '--output',
        required=True,
        type=str,
        help='output file')

    return p.parse_args()


def run_feature(args):
    sys.path.append(os.getcwd())
    if args.all is True:
        print(args.name)
        mod, names = feature_functions(args.name)
        for name in names:
            target = "{0}.{1}".format(args.name, name)
            l.info("Feature generation: {0}".format(target))
            func = getattr(mod, name)
            result = func()
            save_mat(target, result)
    else:
        l.info("Feature generation: {0}".format(args.name))
        klass = dynamic_load(args.name)
        result = klass()
        save_mat(args.name, result)


def run_initialize(args):
    pwd = os.getcwd()
    os.makedirs(os.path.join(pwd, "data/input/model"))
    os.makedirs(os.path.join(pwd, "data/output"))
    os.makedirs(os.path.join(pwd, "data/working"))
    os.makedirs(os.path.join(pwd, "note"))
    os.makedirs(os.path.join(pwd, "trunk"))


def _load_features(f_names):
    X = None
    for f_name in f_names:
        X_add = sio.loadmat(f_name)['X']
        X = X_add if X is None else ss.hstack((X, X_add))
    return X


def _load_train_test(settings):
    X = _load_features(settings['features'])
    idx_train = sio.loadmat(settings['idx']['train']['file'])[
        settings['idx']['train']['name']
    ]
    idx_test = sio.loadmat(settings['idx']['test']['file'])[
        settings['idx']['test']['name']
    ]
    idx_train = idx_train[:, 0]
    idx_test = idx_test[:, 0]
    X_train = X[idx_train]
    X_test = X[idx_test]
    y_train = sio.loadmat(settings['target']['file'])[
        settings['target']['name']
    ]
    y_train = y_train[:, 0, 0]
    return X_train, X_test, y_train


def run_validation(args):
    settings = load_settings(args.model)
    l.info("Loading dataset")
    X, _, y = _load_train_test(settings)
    kfoldcv = dynamic_load(settings['cross_validation']['method'])
    score, variance = kfoldcv(X, y)
    l.info("CV score: {0:.4f} (var: {1:.6f})".format(score, variance))


def run_prediction(args):
    settings = load_settings(args.model)
    prediction = settings['prediction']
    l.info("Loading dataset")
    X_train, X_test, y_train = _load_train_test(settings)

    predict_klass = dynamic_load(prediction['method'])
    p = predict_klass(settings)
    y_pred = p.solve(X_train, X_test, y_train)

    pd.DataFrame({'y_pred': y_pred}).to_csv(args.output, index=False)


def main():
    l.basicConfig(format='%(asctime)s %(message)s', level=l.INFO)
    args = parse_args()
    if args.subparser_name == 'validate':
        run_validation(args)
    elif args.subparser_name == 'predict':
        run_prediction(args)
    elif args.subparser_name == 'feature':
        run_feature(args)
    elif args.subparser_name == 'init':
        run_initialize(args)
    else:
        raise RuntimeError("No such sub-command.")
