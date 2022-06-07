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
## Should variables loaded at startup (by startup files, exec_lines, etc.) be
#  hidden from tools like %who?
c.InteractiveShellApp.hide_initial_ns = True

## Configure matplotlib for interactive use with the default matplotlib backend.
c.InteractiveShellApp.matplotlib = 'auto'

#------------------------------------------------------------------------------
#       TerminalIPythonApp(BaseIPythonApplication,InteractiveShellApp) configuration
#------------------------------------------------------------------------------
## Whether to display a banner upon starting IPython.
c.TerminalIPythonApp.display_banner = True

#------------------------------------------------------------------------------
#       InteractiveShell(SingletonConfigurable) configuration
#------------------------------------------------------------------------------
## An enhanced, interactive shell for Python.

## Make IPython automatically call any callable object even if you didn't type
#  explicit parentheses.
#c.InteractiveShell.autocall = 0     # 0 (off), 1, 2 (full)
c.InteractiveShell.autoindent = False
c.InteractiveShell.automagic = False
c.InteractiveShell.color_info = True
c.InteractiveShell.colors = 'Neutral'  # (NoColor, Neutral, Linux, or LightBG).
c.InteractiveShell.enable_html_pager = True
c.InteractiveShell.separate_in = ''  # no newlines before prompt, default: '\\n'
c.InteractiveShell.sphinxify_docstring = True
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

## The name or class of a Pygments style to use for syntax highlighting:
#    default, emacs, friendly, colorful, autumn, murphy, manni, monokai,
#    perldoc, pastie, borland, trac, native, fruity, bw, vim, vs, tango, rrt,
#    xcode, igor, paraiso-light, paraiso-dark, lovelace, algol, algol_nu,
#    arduino, rainbow_dash, abap
c.TerminalInteractiveShell.highlighting_style = 'tango'

#==============================================================================
#==============================================================================
