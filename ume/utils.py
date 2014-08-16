# -*- coding: utf-8 -*-
import logging as l
import importlib
import sys
import os
import warnings
import json

import numpy as np
import scipy.io as sio
from sklearn.cross_validation import KFold


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
    with open(path, 'r') as f:
        settings = json.load(f)
    return settings


def kfoldcv(X, y):
    settings = load_settings("data/input/model/1.json")
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
        scores.append(score)
    return np.array(scores).mean(), np.array(scores).var()
