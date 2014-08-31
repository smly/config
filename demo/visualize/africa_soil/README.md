The dataset for this demo is from "Africa Soil Property Prediction Challenge".
You can  use the following commands to run the example:

```
$ tree
data
├── input
│   ├── model
│   ├── sample_submission.csv
│   ├── sorted_test.csv
│   ├── test.zip
│   ├── training.csv
│   ├── train.zip
│   └── visualize
│       └── ca_vs_ph.json
├── output
│   └── visualize
└── working

5 directories, 6 files

$ ume visualize -j data/input/visualize/ca_vs_ph.json -o data/output/visualize/ca_vs_ph.png && echo OK
OK
$ display data/output/visualize/ca_vs_ph.png
```

## Input file

`data/input/visualize/ca_vs_ph.json`

```json
{
    "title": "Ca vs pH",
    "datasource": {
        "df": "./data/input/training.csv"
    },
    "plotdata": [
        {
            "ax_param": {
                "xlabel": "Ca",
                "ylabel": "Freq",
                "grid": "True"
            },
            "plot": [
                {
                    "X": "Ca",
                    "source": "df",
                    "plot_func": "ume.visualize.plate_hist",
                    "params": {
                        "bins": 50,
                        "color": [0.8, 0.2, 0.2]
                    }
                }
            ]
        },
        {
            "ax_param": {
                "xlabel": "pH",
                "ylabel": "Ca",
                "grid": "True"
            },
            "plot": [
                {
                    "X": "pH",
                    "y": "Ca",
                    "source": "df",
                    "plot_func": "ume.visualize.plate_scatter",
                    "params": {
                        "linewidth": 0.2,
                        "color": [0.8, 0.2, 0.2]
                    }
                }
            ]
        },
        {},
        {
            "ax_param": {
                "xlabel": "pH",
                "ylabel": "Freq",
                "grid": "True"
            },
            "plot": [
                {
                    "X": "pH",
                    "source": "df",
                    "plot_func": "ume.visualize.plate_hist",
                    "params": {
                        "bins": 50,
                        "color": [0.8, 0.2, 0.2]
                    }
                }
            ]
        }
    ]
}
```

## Output file

![ca_vs_ph.png](https://github.com/smly/ume/raw/master/demo/visualize/africa_soil/ca_vs_ph.png)
`data/output/visualize/ca_vs_ph.png`
