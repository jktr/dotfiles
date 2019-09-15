import sys, os

sys.path.append(
    f'/home/{os.environ["USER"]}/.local/lib/python3.7/site-packages')

import itertools as it
import functools as ft
import collections as coll

from pprint import pprint as print

import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

# https://amoffat.github.io/sh/
import sh
# https://3.python-requests.org/
import requests

def slurp(f):
    from glob import glob

    if len(glob(f)) == 1:
        f = glob(f)[0]
    with open(f) as fh:
        if f.endswith('.csv'):
            import csv
            return list(csv.reader(fh))
        elif f.endswith('.json'):
            import json
            return json.load(fh)
        elif f.endswith('.yaml') or f.endswith('.yml'):
            import yaml
            return yaml.safe_load(fh)
        else:
            return [l.strip() for l in fh]