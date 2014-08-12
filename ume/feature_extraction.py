# -*- coding: utf-8 -*-
from functools import reduce

from sklearn.preprocessing import OneHotEncoder as OHE
from sklearn.preprocessing import LabelEncoder as LE
import numpy as np
"""
Feature extraction
------------------

## cat, cat_multi

```
df = pd.DataFrame({'col1': ['a', 'b', 'c', 'a'], 'col2': [1, 2, 2, 1]})

# Multiple columns
X = cat(df, ["cal1", "cal2"])

# Conjunction features
X = cat(df, ["cal1", "cal2", ("cal1", "cal2")])

# Multiple dataframes
X_dict = cat_multi({'train': df_train, 'test': df_test}, ["cal1", "cal2", ("cal1", "cal2")])
```
"""


def cat(df_, cals_):
    df = df_.copy().astype(str)
    cals = []
    for cal in cals_:
        if type(cal) is tuple:
            cal_name = "$".join(cal)
            df[cal_name] = reduce(
                lambda x, y: x + "_!_" + y,
                [df[c] for c in cal])
            cals.append(cal_name)
        elif type(cal) is not str:
            raise RuntimeError("No support type")
        else:
            cals.append(cal)

    df = df[cals].fillna(method='pad')
    df = np.array(df)
    for i in range(0, df.shape[1]):
        le = LE()
        df[:, i] = le.fit_transform(df[:, i])
    df = df.astype(float)

    ohe = OHE()
    mat = ohe.fit_transform(df)
    return mat
