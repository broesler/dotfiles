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
setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal iskeyword+=_
setlocal iskeyword-=:

setlocal commentstring=#%s

setlocal foldmethod=indent
setlocal foldnestmax=2
setlocal foldignore=
setlocal foldlevelstart=99

let python_highlight_all = 1

"-----------------------------------------------------------------------------
"       Functions to lint + make code 
"-----------------------------------------------------------------------------
" Set up syntax error checking
function! PythonLint()
  let &makeprg="pylint --reports=n --output-format=parseable %:p"
  let &efm="%W%f:%l: [%*[CRW]%.%#] %m,%Z%p^^,"
              \ . "%E%f:%l: [%*[EF]%.%#] %m,%Z%p^^,%-G%.%#"
  update | silent make! | redraw!
endfunction
command! PythonLint :call PythonLint()

function! PythonRunScript()
  setlocal makeprg=python\ %

  " This errorformat puts EVERY step of the trace in the stack. The user can
  " use :cnext to step down the stack or :cprev to step up. 
  setlocal efm=%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
  update | silent make! | redraw!
endfunction
command! PythonRunScript :call PythonRunScript()

"-----------------------------------------------------------------------------
"        Keymaps
"-----------------------------------------------------------------------------
nnoremap <LocalLeader>L :PythonLint<CR>
nnoremap <LocalLeader>M :PythonRunScript<CR>

" Edit ipython profile
nnoremap <LocalLeader>ie :split ~/.ipython/profile_default/ipython_config.py<CR>

" Make comment header with dashes
let @h='o#78a-yypO#8a '

"=============================================================================
"=============================================================================
