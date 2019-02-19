#==============================================================================
#     File: ~/.ipython/profile_default/ipython_config.py 
#  Created: 09/26/2017, 22:08
#   Author: Bernie Roesler
#
"""  
    Description: Configuration file for ipython.
"""
#==============================================================================

from IPython.terminal.prompts import Prompts, Token

# import importlib

c = get_config()

#------------------------------------------------------------------------------ 
#        Set prompt
#------------------------------------------------------------------------------
# Set the prompt 
class MyPrompt(Prompts):
    def in_prompt_tokens(self, cli=None):
        return [
            (Token.Prompt, '['),
            (Token.PromptNum, str(self.shell.execution_count)),
            (Token.Prompt, ']>>> '),
        ]

    def out_prompt_tokens(self):
        return [
            (Token.OutPrompt, '['),
            (Token.OutPromptNum, str(self.shell.execution_count)),
            (Token.OutPrompt, ']=== '),
        ]

# Prompts, ClassicPrompts, MyPrompt
c.TerminalInteractiveShell.prompts_class = MyPrompt

#------------------------------------------------------------------------------ 
#        Aliases
#------------------------------------------------------------------------------
c.AliasManager.user_aliases = [
    ('lc', 'ls -hlpG --color=auto'),
]

#------------------------------------------------------------------------------
#       InteractiveShellApp(Configurable) configuration
#------------------------------------------------------------------------------
c.InteractiveShellApp.code_to_run = ''
#c.InteractiveShellApp.exec_files = []
c.InteractiveShellApp.extensions = [
    'autoreload',
]

c.InteractiveShellApp.exec_lines = [
    '%autoreload 2',
    'import sys',
    'import os',
    'import pandas as pd',
    'import numpy as np',
    'import matplotlib.pyplot as plt',
    'from matplotlib.gridspec import GridSpec',
    'import seaborn as sns'
]

#c.InteractiveShellApp.extra_extension = ''
#c.InteractiveShellApp.file_to_run = ''

## Should variables loaded at startup (by startup files, exec_lines, etc.) be
#  hidden from tools like %who?
c.InteractiveShellApp.hide_initial_ns = True

## Configure matplotlib for interactive use with the default matplotlib backend.
c.InteractiveShellApp.matplotlib = 'auto'

## Run the module as a script.
#c.InteractiveShellApp.module_to_run = ''

#------------------------------------------------------------------------------
#       TerminalIPythonApp(BaseIPythonApplication,InteractiveShellApp) configuration
#------------------------------------------------------------------------------
## Whether to display a banner upon starting IPython.
c.TerminalIPythonApp.display_banner = True

## If a command or file is given via the command-line, e.g. 'ipython foo.py',
#  start an interactive shell after executing the file or command.
c.TerminalIPythonApp.force_interact = False

## Start IPython quickly by skipping the loading of config files.
#c.TerminalIPythonApp.quick = False

#------------------------------------------------------------------------------
#       InteractiveShell(SingletonConfigurable) configuration
#------------------------------------------------------------------------------
## An enhanced, interactive shell for Python.

## Make IPython automatically call any callable object even if you didn't type
#  explicit parentheses. 
#c.InteractiveShell.autocall = 0
c.InteractiveShell.autoindent = True
#c.InteractiveShell.automagic = True
c.InteractiveShell.color_info = True
c.InteractiveShell.colors = 'Linux' ## (NoColor, Neutral, Linux, or LightBG).
#c.InteractiveShell.disable_failing_post_execute = False
c.InteractiveShell.enable_html_pager = True
#c.InteractiveShell.pdb = False
c.InteractiveShell.separate_in = '' ## Do not include blank lines before prompt
#c.InteractiveShell.show_rewritten_input = True
c.InteractiveShell.sphinxify_docstring = True
#c.InteractiveShell.wildcards_case_sensitive = True
c.InteractiveShell.xmode = 'Context'

#------------------------------------------------------------------------------
#       TerminalInteractiveShell(InteractiveShell) configuration
#------------------------------------------------------------------------------
## Set to confirm when you try to exit IPython with an EOF (Control-D in Unix,
#  Control-Z/Enter in Windows). By typing 'exit' or 'quit', you can force a
#  direct exit without any confirmation.
c.TerminalInteractiveShell.confirm_exit = False

##  'column', 'multicolumn', 'readlinelike'
c.TerminalInteractiveShell.display_completions = 'multicolumn'
c.TerminalInteractiveShell.editing_mode = 'vi'
c.TerminalInteractiveShell.editor = 'vim'

## Enable vi (v) or Emacs (C-X C-E) shortcuts to open an external editor. This is
#  in addition to the F2 binding, which is always enabled.
c.TerminalInteractiveShell.extra_open_editor_shortcuts = True

## The name or class of a Pygments style to use for syntax
#         highlighting: 
#  default, emacs, friendly, colorful, autumn, murphy, manni, monokai, perldoc,
#  pastie, borland, trac, native, fruity, bw, vim, vs, tango, rrt, xcode, igor,
#  paraiso-light, paraiso-dark, lovelace, algol, algol_nu, arduino,
#  rainbow_dash, abap
c.TerminalInteractiveShell.highlighting_style = 'native'
# See <http://chriskempson.com/projects/base16/> for preview of themes
# theme = importlib.import_module('base16.base16-ocean')
# c.TerminalInteractiveShell.highlighting_style = theme.Base16Style
# c.TerminalInteractiveShell.highlighting_style_overrides = theme.overrides

#------------------------------------------------------------------------------
#       StoreMagics(Magics) configuration
#------------------------------------------------------------------------------
#c.StoreMagics.autorestore = False

#==============================================================================
#==============================================================================
