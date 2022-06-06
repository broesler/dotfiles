"=============================================================================
"     File: rust.vim
"  Created: 2019-04-29 10:47
"   Author: Bernie Roesler
"
"  Description: Rust settings
"
"=============================================================================

setlocal formatoptions-=o       " do not open comment header on newline
setlocal foldmethod=syntax
setlocal foldminlines=4         " ignore 3-line comment headers

set makeprg=cargo\ build  " build the current project

nnoremap <buffer> <LocalLeader>M :silent make! <bar> redraw!<CR>
nnoremap <buffer> <LocalLeader>T :Ctest<CR>
