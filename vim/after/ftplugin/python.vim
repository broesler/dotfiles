"=============================================================================
"     File: ~/.vim/after/ftplugin/python.vim
"  Created: 02/26/2016, 19:21
"   Author: Bernie Roesler
"
" Last Modified: 05/18/2016, 20:22
"
"  Description: Python filetype settings
"
"=============================================================================

"-----------------------------------------------------------------------------
"       Buffer local settings
"-----------------------------------------------------------------------------
setlocal textwidth=79    " PEP-8 standard
setlocal iskeyword+=_
setlocal iskeyword-=:

setlocal commentstring=#\ %s

setlocal foldmethod=syntax
setlocal foldignore=
setlocal foldlevelstart=99

let g:python_highlight_all = 1

"-----------------------------------------------------------------------------
"       Functions to lint + make code 
"-----------------------------------------------------------------------------
" Set up syntax error checking (requires vim-flake8)
if exists("*Flake8")
    command! -buffer PythonFlake8 :call Flake8()
endif

function! PythonRunScript()
  setlocal makeprg=python\ %

  " This errorformat puts EVERY step of the trace in the stack. The user can
  " use :cnext to step down the stack or :cprev to step up. 
  setlocal efm=%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
  update | silent make! | redraw!
endfunction
command! -buffer PythonRunScript :call PythonRunScript()

function! s:PythonCom2Doc() range abort
    " Convert comment into docstring
    let l:reg_save = @q
    let @q='f#cw"""'   " Replace comment with triple double quotes
    if a:firstline == a:lastline
        " Single line comment
        normal! @q
        normal! A"""
    else
        " Multiple lines to change
        let l:cur_save = getpos('.')
        execute (a:firstline+1) . ',' . a:lastline . 's/#\+\s*//'
        execute a:firstline . ':normal! @q'
        execute a:lastline . ':normal! o"""'
        call cursor(l:cur_save)
    endif
    let @q = l:reg_save
endfunction
command! -buffer -range PythonCom2Doc <line1>,<line2>call <SID>PythonCom2Doc()

function! s:PythonSelectDocstring(is_inside) abort
    let the_pat = "[\"']\\{3}"
    let l:flags = a:is_inside ? "e" : ""
    execute 'normal! ?' . the_pat . '?' . l:flags . "\r"
    normal! v
    let l:flags = a:is_inside ? "b-1" : "e;/" . the_pat . "/e"
    execute 'normal! /' . the_pat . '/' . l:flags . "\r"
endfunction

"-----------------------------------------------------------------------------
"        Keymaps
"-----------------------------------------------------------------------------
nnoremap <buffer> <LocalLeader>L :PythonFlake8<CR>
nnoremap <buffer> <LocalLeader>M :PythonRunScript<CR>

nnoremap <buffer> <LocalLeader>i :PythonStandardImport<CR>

" Make in-line comment into it's own line above
nnoremap <Leader>j f#DOpj:s/\s\+$//

" Edit ipython profile
" nnoremap <buffer> <LocalLeader>ie :split ~/.ipython/profile_default/ipython_config.py<CR>
" nnoremap <buffer> <LocalLeader>ij :split ~/.jupyter/jupyter_console_config.py<CR>

" Docstring objects
onoremap <buffer> ad :<C-u>call <SID>PythonSelectDocstring(0)<CR>
onoremap <buffer> id :<C-u>call <SID>PythonSelectDocstring(1)<CR>
vnoremap <buffer> ad :<C-u>call <SID>PythonSelectDocstring(0)<CR>
vnoremap <buffer> id :<C-u>call <SID>PythonSelectDocstring(1)<CR>

" Docstring template macro (use <quote>dp)
let @d = "\n"
     \ . "    Parameters\n"
     \ . "    ----------\n"
     \ . "    x : (M, N) array_like\n"
     \ . "        Matrix of M vectors in K dimensions\n\n"
     \ . "    Returns\n"
     \ . "    -------\n"
     \ . "    result : (M, N) ndarray\n"
     \ . "        Matrix of M vectors in K dimensions\n"
     \ . '    """'

" Standard import
let @i = "import matplotlib.pyplot as plt\n"
     \ . "import numpy as np\n"
     \ . "import pandas as pd\n"
     \ . "import seaborn as sns\n\n"
     \ . "from matplotlib.gridspec import GridSpec\n\n"

" Matplotlib figure set-up
let @f = "fig = plt.figure(1, clear=True)\n"
     \ . "ax = fig.add_subplot()\n"
     \ . "ax.plot()\n"
     \ . "ax.set(xlabel='',\n"
     \ . "       ylabel='')\n"

let @s = "fig = plt.figure(1, clear=True)\n"
     \ . "gs = GridSpec(nrows=1, ncols=2)\n"
     \ . "ax1 = fig.add_subplot(gs[0])  # left side plot\n"
     \ . "ax2 = fig.add_subplot(gs[1])  # right side plot\n"
     \ . "ax1.plot(x, y1, label='label1')\n"
     \ . "ax2.plot(x, y2, label='label2')\n"

"=============================================================================
"=============================================================================
