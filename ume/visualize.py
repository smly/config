# -*- coding: utf-8 -*-
"""
Example:

```
df = pd.DataFrame({
    'date': ['2014-01-01', '2014-01-02', '2014-01-03', '2014-01-04'],
    'c1': [1.0, 3.0, 4.0, 2.4],
    'c2': [1.0, 3.0, 4.0, 9.4],
    'c3': [1.0, 3.0, 4.0, 1.4],
})

p = TimeSeriesPlot()
p.add(df['date'], df['c1'])
p.add(df['date'], df['c2'])
p.add(df['date'], df['c3'])
p.save("hoge.png", max_col=1)
```
"""
import datetime

import matplotlib.pylab as plt
import matplotlib.dates as mdates


BASE_COLORS = [
    (55/256.0, 166/256.0, 134/256.0),
    (54/256.0, 89/256.0, 63/256.0),
    (242/256.0, 186/256.0, 82/256.0),
    (217/256.0, 118/256.0, 61/256.0),
    (217/256.0, 65/256.0, 65/256.0),
]


def _change_tick_fontsize(ax, size):
    for tl in ax.get_xticklabels():
        tl.set_fontsize(size)
    for tl in ax.get_yticklabels():
        tl.set_fontsize(size)


def _transform_date(l):
    #return [datetime.datetime.strptime("-".join(x.split('-')[:2]), '%Y-%m') for x in l]
    return [datetime.datetime.strptime(x, '%Y-%m-%d') for x in l]



def _select_dateformat():
    pass


class TimeSeriesPlot(object):
    def __init__(self):
        self.datastore = []
        self.dateformat = []  # TODO

    def add(self, X, y):
        self.datastore.append((X, y))
        return self

    def _plot(self, plot_data, plot_param, ax, idx):
        color_sz = len(BASE_COLORS)
        color_idx = idx % color_sz
        plot_param.update({'color': BASE_COLORS[color_idx]})

        _change_tick_fontsize(ax, 8)
        date_list = _transform_date(plot_data[0])
        ax.plot(date_list, plot_data[1], **plot_param)
        plt.gcf().axes[idx].xaxis.set_major_formatter(
            mdates.DateFormatter('%Y-%m-%d'))

    def save(self, plot_filename, title='hoge', max_col=2):
        fig = plt.figure()
        fig.suptitle(title, fontsize=8)
        plot_param = {
            'linewidth': 0.5,
            'color': BASE_COLORS[0],
        }

        if len(self.datastore) <= max_col:
            colsz = len(self.datastore)
            rowsz = 1
            for i, d in enumerate(self.datastore):
                ax = fig.add_subplot(rowsz, colsz, i + 1)
                self._plot(d, plot_param, ax)
        else:
            sz = len(self.datastore)
            colsz = max_col
            rowsz = sz / max_col
            rowsz = rowsz if sz % max_col == 0 else rowsz + 1
            for i, d in enumerate(self.datastore):
                ax = fig.add_subplot(rowsz, colsz, i + 1)
                self._plot(d, plot_param, ax, i)

        plt.savefig(plot_filename)

        return self
