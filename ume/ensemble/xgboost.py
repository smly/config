# -*- coding: utf-8 -*-
import os

import numpy as np
import pandas as pd
import ume.ensemble.xgboost_origin as xgb


class XGBoost(object):
    def __init__(self, **karg):
        self.parameters = karg

    def __str__(self):
        param_str = ", ".join(
            ["{0}={1}".format(k, v) for k, v in self.parameters.items()])
        return "XGBoost({0})".format(param_str)

    def get_params(self, deep=False):
        return self.parameters

    def set_params(self, **param):
        if not param:
            return self

        self.parameters.update(param)
        return self

    def fit(self, X, Y):
        data = xgb.DMatrix(X)
        data.set_label(Y)
        data.set_group([len(Y)])
        evallist  = [(data, 'train')]

        num_round = self.parameters['num_round']
        params = {k: v for k, v in self.parameters.items() if k != 'num_round'}

        self.model = xgb.train(params, data, num_round, evallist)

    def predict_proba(self,X):
        data = xgb.DMatrix(X)
        yhat = np.zeros((X.shape[0], 2))
        yhat[:, 1] = self.model.predict(data)
        yhat[:, 0] = 1 - yhat[:, 1]
        return yhat
