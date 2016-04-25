"=============================================================================
"     File: ~/.vim/after/ftplugin/python.vim
"  Created: 02/26/2016, 19:21
"   Author: Bernie Roesler
"
" Last Modified: 04/11/2016, 17:31
"
"  Description: Python filetype settings
"
"=============================================================================

"-----------------------------------------------------------------------------
"       Buffer local settings
"-----------------------------------------------------------------------------
setlocal textwidth=79    " PEP-8 standard
setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=0
setlocal iskeyword+=_
setlocal iskeyword-=:

setlocal foldmethod=indent
setlocal foldnestmax=1
setlocal foldignore=

let python_highlight_all = 1

"-----------------------------------------------------------------------------
"       Functions to lint + make code 
"-----------------------------------------------------------------------------
" Set up syntax error checking
function! PythonLint()
  setlocal makeprg=pylint\ --reports=n\ --output-format=parseable\ %:p
  setlocal efm=%W%f:%l:\ [C%.%#]\ %m,%Z%p^^
  setlocal efm+=%E%f:%l:\ [E%.%#]\ %m,%Z%p^^,%-G%.%#
  write | silent! make | redraw!
endfunction
command! PythonLint :call PythonLint()

function! PythonRunScript()
  " The following makeprg does not seem to work properly:
  " setlocal makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"

  " Use the simplest makeprg until something else is needed:
  setlocal makeprg=python\ %

  " This errorformat only takes the most parent function of the error:
  " setlocal efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
  
  " This errorformat puts EVERY step of the trace in the stack. The user can
  " use :cnext to step down the stack or :cprev to step up. 
  setlocal efm=%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
  write | silent! make | redraw!
endfunction
command! PythonRunScript :call PythonRunScript()

"-----------------------------------------------------------------------------
"        Keymaps
"-----------------------------------------------------------------------------
nnoremap <Leader>L :PythonLint<CR>
nnoremap <Leader>M :PythonRunScript<CR>

" Make comment header with dashes
let @h='o#78a-yypO#8a '

"=============================================================================
"=============================================================================
