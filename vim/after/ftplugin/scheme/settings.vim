"=============================================================================
"     File: settings.vim
"  Created: 10/29/2016, 08:34
"   Author: Bernie Roesler
"
"  Description: 
"
"=============================================================================
" Buffer-local settings {{{
setlocal tabstop=2            " tabs every 2 spaces
setlocal softtabstop=2        " let backspace delete indent
setlocal shiftwidth=2
setlocal textwidth=80
setlocal iskeyword-=:         " colon is NOT part of keywords

setlocal comments=n:;
setlocal commentstring=;%s

setlocal foldmethod=indent
setlocal foldignore=

setlocal nowrap
"}}}
" Highlighting edits {{{
" Make extra parens easier to see (not orange vs red)
hi schemeError ctermfg=none ctermbg=darkred
"}}}
" Macros {{{
" Add (printval ...) around current expression
let @p='I(printval f(%a)'
" Add '; Value: ' at end of current line
let @v='A ; Value: '
"}}}
"=============================================================================
"=============================================================================
