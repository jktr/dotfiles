import sys, os

sys.path.append(
    f'/home/{os.environ["USER"]}/.local/lib/python3/site-packages')

import itertools as it
import functools as ft
import collections as coll

from pprint import pprint as print

import numpy as np
import matplotlib; matplotlib.use('module://matplotlib-backend-kitty')
import matplotlib.pyplot as plt
import pandas as pd

try:
    # https://amoffat.github.io/sh/
    import sh
    # https://3.python-requests.org/
    import requests
except Exception:
    pass

df, series = pd.DataFrame, pd.Series

def slurp(*fs, xf=lambda x: x, rf=lambda _: None):
    from glob import glob
    fs = [x for xs in [glob(f) for f in fs] for x in xs]
    if not fs:
        return

    acc = []
    for f in fs:
        with open(f) as fh:
            if f.endswith('.csv'):
                import csv
                acc.extend(csv.DictReader(fh))
            elif f.endswith('.json'):
                import json
                acc.append(json.load(fh))
            elif f.endswith(('.yml', '.yaml')):
                import yaml
                acc.extend(x for x in yaml.safe_load_all(fh) if x is not None)
            else:
                acc.extend(x.strip() for x in fh)

    for x in map(xf, acc):
        rf(x)
        yield x

def figure3d(v=1, l=('X','Y','Z')):
    from mpl_toolkits.mplot3d import Axes3D
    f = plt.figure().gca(projection='3d')
    f.set_xlabel(l[0])
    f.set_ylabel(l[1])
    f.set_zlabel(l[2])
    f.set_xlim3d([-v,v])
    f.set_ylim3d([-v,v])
    f.set_zlim3d([-v,v])
    return f
