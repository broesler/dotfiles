#!/usr/bin/env python3
#==============================================================================
#     File: startup.py
#  Created: 2019-06-17 09:50
#   Author: Bernie Roesler
#
"""
  Description: IPython start-up file.
"""
#==============================================================================

import sys
import os

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.gridspec import GridSpec
import seaborn as sns

from IPython import get_ipython
ipython = get_ipython()

if 'ipython' in globals():
    ipython.magic('load_ext autoreload')
    ipython.magic('autoreload 2')

#==============================================================================
#==============================================================================
