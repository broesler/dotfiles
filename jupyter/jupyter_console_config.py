#==============================================================================
#     File: ~/.jupyter/jupyter_console_config.py
#  Created: 02/13/2018, 23:11
#   Author: Bernie Roesler
#
""" 
  Description: Configuration file for jupyter-console.
"""
#==============================================================================

#------------------------------------------------------------------------------
# JupyterConsoleApp(ConnectionFileMixin) configuration
#------------------------------------------------------------------------------

## Set to display confirmation dialog on exit. You can always use 'exit' or
#  'quit', to force a direct exit without any confirmation.
c.JupyterConsoleApp.confirm_exit = False

#------------------------------------------------------------------------------
# ZMQTerminalInteractiveShell(SingletonConfigurable) configuration
#------------------------------------------------------------------------------

## Shortcut style to use at the prompt. 'vi' or 'emacs'.
c.ZMQTerminalInteractiveShell.editing_mode = 'vi'

## Whether to include output from clients other than this one sharing the same
#  kernel.
#  Outputs are not displayed until enter is pressed.
c.ZMQTerminalInteractiveShell.include_other_output = True

## Prefix to add to outputs coming from clients other than this one.
#  Only relevant if include_other_output is True.
c.ZMQTerminalInteractiveShell.other_output_prefix = ''

## Do not block incoming output from other clients
#  Only relevant if include_other_output is True. 'False' ignores statement
#  that 'outputs are not displayed until enter is pressed.'
# c.ZMQTerminalInteractiveShell.is_blocking_kernel = False

#==============================================================================
#==============================================================================
