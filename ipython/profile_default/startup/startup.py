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

from pathlib import Path

try:
    # import pandas as pd
    import numpy as np
    import matplotlib.pyplot as plt
    # import seaborn as sns

    from scipy import linalg as la, sparse 
    from scipy.sparse import linalg as spla

    # my own package
    # import csparse

    np.set_printoptions(precision=4, linewidth=300, suppress=True)
    π = np.pi

except ImportError:
    print('Error importing one of '
          '{pandas, numpy, matplotlib, scipy, seaborn, csparse}.'
          'Please ensure they are installed.')


from IPython import get_ipython
ipython = get_ipython()

if 'ipython' in globals():
    ipython.run_line_magic('load_ext', 'autoreload')
    ipython.run_line_magic('autoreload', '2')
    # ipython.run_line_magic('autoindent', 'off')  # for use with BReptile

# =============================================================================
# =============================================================================
