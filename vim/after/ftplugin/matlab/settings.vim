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

setlocal foldlevelstart=99
setlocal foldmethod=indent

setlocal nowrap
"}}}
" Keymaps {{{
" Global search for lines containing variable under cursor
" TODO extend to insert any filetype comment character for '%'
" TODO put into function + command :FindVariable <C-R><C-W>
" FIXME DOES NOT work for variables in printf statements following '%s', i.e.
nnoremap <LocalLeader>g :g/\C\(%.*\)\@<!\<<C-R><C-W>\>/p<CR>
" }}}
