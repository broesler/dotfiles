#!/usr/bin/env python3
# =============================================================================
#     File: startup.py
#  Created: 2019-06-17 09:50
#   Author: Bernie Roesler
#
"""
  Description: IPython start-up file.
"""
# =============================================================================

import sys
import os

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

from IPython import get_ipython
ipython = get_ipython()

if 'ipython' in globals():
    ipython.run_line_magic('load_ext', 'autoreload')
    ipython.run_line_magic('autoreload', '2')
    # ipython.run_line_magic('autoindent', 'off')  # for use with BReptile

np.set_printoptions(precision=4, linewidth=300, suppress=True)

π = np.pi

# =============================================================================
# =============================================================================
