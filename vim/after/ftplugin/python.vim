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

setlocal diffopt-=iwhite  " do not ignore whitespace in diffs!

compiler pytest  " Dispatch.vim, see `.vim/after/compiler/pytest.vim`

let g:python_highlight_all = 1
let g:python_highlight_func_calls = 0

"-----------------------------------------------------------------------------
"       Functions to lint + make code 
"-----------------------------------------------------------------------------
function! PythonRuffCheckAll()
    let &l:makeprg = g:ale_python_ruff_executable . ' check'
    let &l:errorformat = '%f:%l:%c: %m'
    update | silent make! | redraw!
endfunction
command! -buffer PythonRuffCheckAll :call PythonRuffCheckAll()

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
    if a:firstline == a:lastline
        " Single line comment, replace comment with triple double quotes
        normal! 0f#cw"""
        normal! A"""
    else
        " Multiple lines to change
        let l:cur_save = getpos('.')
        execute a:firstline . 's/#/"""/'
        execute (a:firstline+1) . ',' . a:lastline . 's/#\+\s*//'
        execute a:lastline . ':normal! o"""'
        call cursor(l:cur_save)
    endif
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
" Use the vim-flake8 built-in command
nnoremap <buffer> <LocalLeader>L :ALELint<CR>
" nnoremap <buffer> <LocalLeader>L :Flake<CR>
" nnoremap <buffer> <LocalLeader>L :PythonFlake8<CR>
" nnoremap <buffer> <LocalLeader>M :PythonRunScript<CR>
nnoremap <buffer> <LocalLeader>M :Make<CR>

" nnoremap <buffer> <LocalLeader>i :PythonStandardImport<CR>

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
let @d = "\n\n"
     \ . "    Parameters\n"
     \ . "    ----------\n"
     \ . "    x : (M, N) array_like\n"
     \ . "        Matrix of M vectors in N dimensions\n\n"
     \ . "    Returns\n"
     \ . "    -------\n"
     \ . "    result : (M, N) ndarray\n"
     \ . "        Matrix of M vectors in N dimensions\n"
     \ . '    """'

" Standard import
let @i = "import matplotlib.pyplot as plt\n"
     \ . "import numpy as np\n"
     \ . "import scipy.linalg as la\n\n"
     \ . "from scipy import sparse\n"
     \ . "from scipy.sparse import linalg as spla\n\n"
     " \ . "import pandas as pd\n"
     " \ . "import seaborn as sns\n\n"

" Matplotlib figure set-up
let @f = "fig, ax = plt.subplots(num=1, clear=True)\n"
     \ . "ax.plot()\n"
     \ . "ax.set(\n"
     \ . "    xlabel='x',\n"
     \ . "    ylabel='y',\n"
     \ . ")\n"

let @s = "fig, axs = plt.subplots(num=1, nrows=1, ncols=2, clear=True)\n"
     \ . "ax = axs[0]\n"
     \ . "ax.plot(x, y1, label='label1')\n"
     \ . "ax.set(\n"
     \ . "    xlabel='x',\n"
     \ . "    ylabel='y',\n"
     \ . ")\n"
     \ . "ax = axs[1]\n"
     \ . "ax.plot(x, y2, label='label2')\n"
     \ . "ax.set(\n"
     \ . "    xlabel='x',\n"
     \ . "    ylabel='y',\n"
     \ . ")\n"

"=============================================================================
"=============================================================================
