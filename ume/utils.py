# -*- coding: utf-8 -*-
import logging as l
import importlib
import sys
import os

import numpy as np
import scipy.io as sio


def dynamic_load(cls_path):
    parts = cls_path.split('.')
    module_name = '.'.join(parts[:-1])
    class_name = parts[-1]
    somemodule = importlib.import_module(module_name)
    return getattr(somemodule, class_name)

NPZ_EMPTY = np.array([])
NPZ_FORMAT = "./data/working/{0}.npz"
MAT_FORMAT = "./data/working/{0}.mat"


def save_mat(feature_name, output_dict):
    if type(output_dict['X']) is np.ndarray:
        np.savez(NPZ_FORMAT.format(feature_name), **output_dict)
    else:
        sio.savemat(MAT_FORMAT.format(feature_name), output_dict)


def load_mat(feature_name):
    exists, path = get_feature_stats(func_name)
    if not exists:
        raise RuntimeError("Matrix not found: {0}".format(feature_name))

    if path.endswith(".npz"):
        return np.load(path)
    else:
        return sio.loadmat(path)


def get_feature_stats(func_name):
    exist_npz = os.path.exists(NPZ_FORMAT.format(func_name))
    exist_mat = os.path.exists(MAT_FORMAT.format(func_name))

    if exist_npz and exist_mat:
        l.warn("Critical: both npz and mat file format exists")
        sys.exit(1)
    elif exist_npz:
        return True, NPZ_FORMAT.format(func_name)
    elif exist_mat:
        return True, MAT_FORMAT.format(func_name)
    else:
        return False, None
