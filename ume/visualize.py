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

from ume.utils import dynamic_load


BASE_COLORS = [
    (55/256.0, 166/256.0, 134/256.0),
    (54/256.0, 89/256.0, 63/256.0),
    (242/256.0, 186/256.0, 82/256.0),
    (217/256.0, 118/256.0, 61/256.0),
    (217/256.0, 65/256.0, 65/256.0),
]
PLATE_TS_KWARGS = [
    'color',
    'linewidth',
]
PLATE_BAR_KWARGS = [
    'linewidth',
    'color',
]
AX_PLOT_KWARGS = [
    'linewidth',
    'color',
    'markersize',
]
BLACK = (0/256.0, 0/256.0, 0/256.0)


def _change_tick_fontsize(ax, size):
    for tl in ax.get_xticklabels():
        tl.set_fontsize(size)
    for tl in ax.get_yticklabels():
        tl.set_fontsize(size)


def _transform_date(l, fmt="%Y-%m-%d"):
    return [datetime.datetime.strptime(x, fmt) for x in l]


def plate_timeseries(ax, X, y, params):
    plate_timeseries_params = {
        k: params[k]
        for k in params.keys() if k in PLATE_TS_KWARGS
    }
    tr_param = {'fmt': params['dateformat']} if 'dateformat' in params else {}
    datelist = _transform_date(X, **tr_param)
    ax.plot(datelist, y, **plate_timeseries_params)


def plate_bar(ax, X, y, params):
    plate_bar_params = {
        k: params[k]
        for k in params.keys() if k in PLATE_BAR_KWARGS
    }
    ax.bar(X, y, **plate_bar_params)


def plate_line(ax, X, y, params):
    ax_plot_params = {
        k: params[k]
        for k in params.keys() if k in AX_PLOT_KWARGS
    }
    ax.plot(X, y, **ax_plot_params)


def plate_scatter(ax, X, y, params):
    ax_plot_params = {
        k: params[k]
        for k in params.keys() if k in AX_PLOT_KWARGS
    }
    ax.plot(X, y, '.', **ax_plot_params)


class Plot(object):
    def __init__(self, title="No title"):
        self.datastore = []
        self.title = title

    def add(self, plot_data):
        self.datastore.append(plot_data)

    def _ax_plot_with_params(self, ax, plate):
        params = plate['params']
        X = plate["X"]
        y = plate["y"]
        plot_func = plate.get('plot_func', 'line')
        func = dynamic_load(plot_func)
        func(ax, X, y, params)

    def _plot(self, idx, ax):
        plot_data_list = self.datastore[idx]

        if type(plot_data_list) is dict:
            for plot_data in plot_data_list['plot']:
                self._ax_plot_with_params(ax, plot_data)
            # ax change
            params = plot_data_list['ax_param']
            if 'xlim' in params:
                plt.xlim(params['xlim'])
            if 'ylim' in params:
                plt.ylim(params['ylim'])
            if 'xlabel' in params:
                plt.xlabel(params['xlabel'])
            if 'xlabel' in params:
                ax.set_xlabel(params['xlabel'], fontsize=8)
            if 'ylabel' in params:
                ax.set_ylabel(params['ylabel'], fontsize=8)

            #p1 = plt.Rectangle((0, 0), 0.5, 0.5, fc=BASE_COLORS[0], lw=0.2)
            #p2 = plt.Rectangle((0, 0), 0.5, 0.5, fc=BASE_COLORS[2], lw=0.2)
            #p3 = plt.Rectangle((0, 0), 0.5, 0.5, fc=BASE_COLORS[4], lw=0.2)
            #ax.legend([p1, p2, p3], ["bucket5", "bucket7", "bucket11"],
            #          fontsize=8)
            if 'grid' in params and params['grid'] == 'True':
                ax.grid(color=(200/256.0, 200/256.0, 200/256.0),
                        linestyle=':',
                        linewidth=0.5)
            if 'dateformat' in params:
                plt.gcf().axes[idx].xaxis.set_major_formatter(
                    mdates.DateFormatter('%Y-%m-%d'))
            if 'xticks_rotation' in params:
                plt.xticks(rotation=params['xticks_rotation'])

            _change_tick_fontsize(ax, 8)

        else:
            raise RuntimeError("Plot#add is required list parameter'")

    def save(self, plot_filename, max_col=2):
        fig = plt.figure()
        fig.suptitle(self.title, fontsize=8)

        if len(self.datastore) <= max_col:
            colsz = len(self.datastore)
            rowsz = 1
            for i, d in enumerate(self.datastore):
                ax = fig.add_subplot(rowsz, colsz, i + 1)
                self._plot(i, ax)
        else:
            sz = len(self.datastore)
            colsz = max_col
            rowsz = sz / max_col
            rowsz = rowsz if sz % max_col == 0 else rowsz + 1
            for i, d in enumerate(self.datastore):
                ax = fig.add_subplot(rowsz, colsz, i + 1)
                self._plot(i, ax)

        #plt.tight_layout(pad=0.4, w_pad=0.5, h_pad=1.0)
        plt.tight_layout()
        plt.savefig(plot_filename)

        return self
