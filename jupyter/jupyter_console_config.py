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

## Connect to an already running kernel
#c.JupyterConsoleApp.existing = ''

## The name of the default kernel to start.
#c.JupyterConsoleApp.kernel_name = 'python'

## Path to the ssh key to use for logging in to the ssh server.
#c.JupyterConsoleApp.sshkey = ''

## The SSH server to use to connect to the kernel.
#c.JupyterConsoleApp.sshserver = ''

#------------------------------------------------------------------------------
# JupyterApp(Application) configuration
#------------------------------------------------------------------------------

## Base class for Jupyter applications

## Answer yes to any prompts.
#c.JupyterApp.answer_yes = False

## Full path of a config file.
#c.JupyterApp.config_file = ''

## Specify a config file to load.
#c.JupyterApp.config_file_name = ''

## Generate default config file.
#c.JupyterApp.generate_config = False

#------------------------------------------------------------------------------
# ZMQTerminalInteractiveShell(SingletonConfigurable) configuration
#------------------------------------------------------------------------------

## Text to display before the first prompt. Will be formatted with variables
#  {version} and {kernel_banner}.
#c.ZMQTerminalInteractiveShell.banner = 'Jupyter console {version}\n\n{kernel_banner}'

## Callable object called via 'callable' image handler with one argument, `data`,
#  which is `msg["content"]["data"]` where `msg` is the message from iopub
#  channel.  For example, you can find base64 encoded PNG data as
#  `data['image/png']`. If your function can't handle the data supplied, it
#  should return `False` to indicate this.
#c.ZMQTerminalInteractiveShell.callable_image_handler = None

## Shortcut style to use at the prompt. 'vi' or 'emacs'.
c.ZMQTerminalInteractiveShell.editing_mode = 'vi'

## The name of a Pygments style to use for syntax highlighting
c.ZMQTerminalInteractiveShell.highlighting_style = ''

## Override highlighting format for specific tokens
#c.ZMQTerminalInteractiveShell.highlighting_style_overrides = {}

## How many history items to load into memory
#c.ZMQTerminalInteractiveShell.history_load_length = 1000

## Handler for image type output.  This is useful, for example, when connecting
#  to the kernel in which pylab inline backend is activated.  There are four
#  handlers defined.  'PIL': Use Python Imaging Library to popup image; 'stream':
#  Use an external program to show the image.  Image will be fed into the STDIN
#  of the program.  You will need to configure `stream_image_handler`;
#  'tempfile': Use an external program to show the image.  Image will be saved in
#  a temporally file and the program is called with the temporally file.  You
#  will need to configure `tempfile_image_handler`; 'callable': You can set any
#  Python callable which is called with the image data.  You will need to
#  configure `callable_image_handler`.
# c.ZMQTerminalInteractiveShell.image_handler = 'PIL'

## Whether to include output from clients other than this one sharing the same
#  kernel.
#  
#  Outputs are not displayed until enter is pressed.
c.ZMQTerminalInteractiveShell.include_other_output = True

## Prefix to add to outputs coming from clients other than this one.
#  
#  Only relevant if include_other_output is True.
c.ZMQTerminalInteractiveShell.other_output_prefix = ''

## Do not block incoming output from other clients
#
#  Only relevant if include_other_output is True. 'False' ignores statement
#  that 'outputs are not displayed until enter is pressed.'
c.ZMQTerminalInteractiveShell.is_blocking_kernel = False

## Timeout (in seconds) for giving up on a kernel's is_complete response.
#  
#  If the kernel does not respond at any point within this time, the kernel will
#  no longer be asked if code is complete, and the console will default to the
#  built-in is_complete test.
#c.ZMQTerminalInteractiveShell.kernel_is_complete_timeout = 1

## Timeout for giving up on a kernel (in seconds).
#  
#  On first connect and restart, the console tests whether the kernel is running
#  and responsive by sending kernel_info_requests. This sets the timeout in
#  seconds for how long the kernel can take before being presumed dead.
#c.ZMQTerminalInteractiveShell.kernel_timeout = 60

## Preferred object representation MIME type in order.  First matched MIME type
#  will be used.
#c.ZMQTerminalInteractiveShell.mime_preference = ['image/png', 'image/jpeg', 'image/svg+xml']

## Use simple fallback prompt. Features may be limited.
#c.ZMQTerminalInteractiveShell.simple_prompt = False

## Command to invoke an image viewer program when you are using 'stream' image
#  handler.  This option is a list of string where the first element is the
#  command itself and reminders are the options for the command.  Raw image data
#  is given as STDIN to the program.
#c.ZMQTerminalInteractiveShell.stream_image_handler = []

## Command to invoke an image viewer program when you are using 'tempfile' image
#  handler.  This option is a list of string where the first element is the
#  command itself and reminders are the options for the command.  You can use
#  {file} and {format} in the string to represent the location of the generated
#  image file and image format.
#c.ZMQTerminalInteractiveShell.tempfile_image_handler = []

## Use 24bit colors instead of 256 colors in prompt highlighting. If your
#  terminal supports true color, the following command should print 'TRUECOLOR'
#  in orange: printf "\x1b[38;2;255;100;0mTRUECOLOR\x1b[0m\n"
c.ZMQTerminalInteractiveShell.true_color = True

## Whether to use the kernel's is_complete message handling. If False, then the
#  frontend will use its own is_complete handler.
#c.ZMQTerminalInteractiveShell.use_kernel_is_complete = True

