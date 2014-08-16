ume
===

My personal toolbox.

Usage
-----

```
$ ume feature -n feature -a
$ ume validate -m data/input/model/lr_tfidf.json
$ ume predict -m data/input/model/lr_tfidf.json -o data/working/result/lr_tfidf.csv

$ ls feature.py utils.py
feature.py  utils.py
$ cat requirements.txt
https://github.com/smly/ume/archive/1.4.zip
$ cat data/input/model/lr_tfidf.json
{
    "model": {
        "class": "sklearn.linear_model.LogisticRegression",
        "params": {
            "C": 1.0
        }
    },
    "features": [
        "data/working/feature.gen_tfidf.mat"
    ],
    "target": {
        "file": "data/working/feature.gen_y.mat",
        "name": "y"
    },
    "idx": {
        "train": {
            "file": "data/working/feature.gen_y.mat",
            "name": "idx_train"
        },
        "test": {
            "file": "data/working/feature.gen_y.mat",
            "name": "idx_test"
        }
    },
    "metrics": {
        "method": "ume.metrics.apk_score",
        "params": { }
    },
    "prediction": {
        "method": "utils.PredictProba",
        "params": { }
    },
    "cross_validation": {
        "method": "ume.utils.kfoldcv",
        "params": {
            "n_folds": 5
        }
    }
}
```
