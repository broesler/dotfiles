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
" Keymaps {{{
" Global search for lines containing variable under cursor
" TODO extend to insert any filetype comment character for '%'
" TODO put into function + command :FindVariable <C-R><C-W>
nnoremap <LocalLeader>g :g/\C\(%.*\)\@<!\<<C-R><C-W>\>/p<CR>
" }}}
