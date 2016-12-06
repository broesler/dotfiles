"=============================================================================
"     File: settings.vim
"  Created: 10/29/2016, 08:31
"   Author: Bernie Roesler
"
"  Description: 
"
"=============================================================================
" Buffer-local settings {{{
setlocal tabstop=4            " tabs every 4 spaces
setlocal softtabstop=4        " let backspace delete indent
setlocal shiftwidth=4
setlocal textwidth=80
setlocal iskeyword-=:         " colon is NOT part of keywords

setlocal comments=:#
setlocal commentstring=#%s

setlocal foldmethod=indent
setlocal foldignore=

setlocal nowrap
"}}}
"=============================================================================
"=============================================================================
