"=============================================================================
"     File: settings.vim
"  Created: 10/29/2016, 08:27
"   Author: Bernie Roesler
"
"  Description: Matlab filetype settings
"
"=============================================================================
" Buffer-local settings {{{
setlocal textwidth=80
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal expandtab
setlocal iskeyword-=:         " colon is NOT part of keywords

setlocal comments=:%
setlocal commentstring=%%%s

setlocal foldlevelstart=1     " all folds open to start
setlocal foldmethod=indent

setlocal nowrap
"}}}
