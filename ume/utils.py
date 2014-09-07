# -*- coding: utf-8 -*-
import logging as l
import importlib
import os
import json

import jsonnet
import numpy as np
import scipy.io as sio
from sklearn.cross_validation import KFold, ShuffleSplit, LeaveOneOut


def feature_functions(module_name):
    somemodule = importlib.import_module(module_name)
    return somemodule, [
        name for name in somemodule.__dict__.keys()
        if name.startswith('gen_')
    ]


def dynamic_load(cls_path):
    parts = cls_path.split('.')
    module_name = '.'.join(parts[:-1])
    class_name = parts[-1]
    somemodule = importlib.import_module(module_name)
    return getattr(somemodule, class_name)

MAT_FORMAT = "./data/working/{0}.mat"


def save_mat(feature_name, output_dict):
    sio.savemat(MAT_FORMAT.format(feature_name), output_dict)


def load_mat(feature_name):
    exists, path = get_feature_stats(func_name)
    if not exists:
        raise RuntimeError("Matrix not found: {0}".format(feature_name))

    return sio.loadmat(path)


def get_feature_stats(func_name):
    exist_mat = os.path.exists(MAT_FORMAT.format(func_name))

    if exist_mat:
        return True, MAT_FORMAT.format(func_name)
    else:
        return False, None


class PredictProba(object):
    def __init__(self, settings):
        self.metrics = settings['metrics']
        self.prediction = settings['prediction']
        self.model = settings['model']

    def solve(self, X_train, X_test, y_train):
        params = self.prediction['params']
        if "dense" in params and params['dense'] == "True":
            l.info("Convert sparse matrix into dense matrix")
            X_train = X_train.todense()
            X_test = X_test.todense()
            l.info("Convert sparse matrix into dense matrix ... done")

        klass = dynamic_load(self.model['class'])
        clf = klass(**self.model['params'])
        l.info("Training model: {0}".format(str(clf)))
        clf.fit(X_train, y_train)
        l.info("Training model ... done")
        y_pred = clf.predict_proba(X_test)[:, 0]

        return y_pred


def load_settings(path):
    if path.endswith(".jsonnet"):
        settings = json.loads(jsonnet.load(path).decode())
    else:
        with open(path, 'r') as f:
            settings = json.load(f)

    return settings


def kfoldcv(X, y, settings):
    metrics = dynamic_load(settings['metrics']['method'])
    metrics_params = settings['metrics']['params']
    kfold_params = settings['cross_validation']['params']
    prediction = settings['prediction']

    scores = []
    kf = KFold(X.shape[0], **kfold_params)
    for idx_train, idx_test in kf:
        X_train, X_test = X[idx_train], X[idx_test]
        y_train, y_test = y[idx_train], y[idx_test]

        predict_klass = dynamic_load(prediction['method'])
        p = predict_klass(settings)
        y_pred = p.solve(X_train, X_test, y_train)

        score = metrics(y_test, y_pred, **metrics_params)
        l.info("Score: {0:.4f}".format(score))
        scores.append(score)
    return np.array(scores).mean(), np.array(scores).var()


def _load_features(f_names):
    X = None
    for f_name in f_names:
        l.info(f_name)
        var_name = 'X'
        if type(f_name) is dict:
            var_name = f_name['name']
            f_name = f_name['file']

        X_add = sio.loadmat(f_name)[var_name]
        if X is None:
            X = X_add
        elif type(X) is np.ndarray and type(X_add) is np.ndarray:
            X = np.hstack((X, X_add))
        else:
            X = X_add if X is None else ss.hstack((X, X_add))
    return X


def load_dataset(settings):
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
    #y_train = y_train[:, 0, 0]
    y_train = y_train[:, 0]
    return X_train, X_test, y_train


def loocv(X, y, settings):
    prediction = settings['prediction']

    scores = []
    l.info("Matrix shape: {0}".format(X.shape))
    loo = LeaveOneOut(X.shape[0])
    for idx_train, idx_test in loo:
        X_train, X_test = X[idx_train], X[idx_test]
        y_train, y_test = y[idx_train], y[idx_test]

        predict_klass = dynamic_load(prediction['method'])
        p = predict_klass(settings)
        y_pred = p.solve(X_train, X_test, y_train)

        if y_pred.tolist()[0] >= 0.5 and y_test.tolist()[0] >= 0.5:
            scores.append(1.0)
        elif y_pred.tolist()[0] < 0.5 and y_test.tolist()[0] < 0.5:
            scores.append(1.0)
        else:
            scores.append(0.0)

        l.info("Score: yes={0}, trial={1}, size={2}".format(
            int(np.array(scores).sum()), len(scores), X.shape[0]))

    return np.array(scores).mean(), np.array(scores).var()


def unsafe_shuffle_split(X, y, settings):
    metrics = dynamic_load(settings['metrics']['method'])
    metrics_params = settings['metrics']['params']
    cv_params = settings['cross_validation']['params']
    prediction = settings['prediction']

    scores = []
    k = cv_params.get('n_iter', 5)

    while True:
        ss = ShuffleSplit(X.shape[0], **cv_params)
        for idx_train, idx_test in ss:
            X_train, X_test = X[idx_train], X[idx_test]
            y_train, y_test = y[idx_train], y[idx_test]

            if y_test.sum() < 1.0:
                continue

            predict_klass = dynamic_load(prediction['method'])
            p = predict_klass(settings)
            y_pred = p.solve(X_train, X_test, y_train)

            score = metrics(y_test, y_pred, **metrics_params)
            l.info("Score: {0:.4f}".format(score))
            scores.append(score)
            if len(scores) >= k:
                break
        if len(scores) >= k:
            break

    return np.array(scores).mean(), np.array(scores).var()
