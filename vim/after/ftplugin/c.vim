"=============================================================================
"       C settings
"=============================================================================
setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal expandtab

setlocal textwidth=80

setlocal iskeyword+=_
setlocal cindent        " smarter indenting for C

setlocal foldmethod=syntax
setlocal foldminlines=4         " ignore 3-line comment headers
setlocal foldlevelstart=20      " don't start with all lines folded

" " Show directory of file in errorlist?
" set errorformat+=%D%f
" set errorformat+=%DEntering\ dir\ '%f',%XLeaving\ dir

" let &makeprg="gcc -Wall -pedantic -std=c99 -o " 
"                 \ . expand("%:r") . " " . expand("%")
let &makeprg="make debug"

"-----------------------------------------------------------------------------
"       Local autocmds
"-----------------------------------------------------------------------------
" Update tags file automatically
" autocmd BufWritePost,FileWritePost <buffer> silent call UpdateTags()
" augroup c_cmds
"     autocmd!
"     autocmd BufEnter *.c let &makeprg="gcc -Wall -pedantic -std=c99 -o " 
"                 \ . expand("%:r") . " " . expand("%")
" augroup END

"-----------------------------------------------------------------------------
"       Keymaps and macros
"-----------------------------------------------------------------------------
nnoremap <LocalLeader>M :silent make! <bar> :redraw!<CR>

" Make comment header with dashes
let @h="o/*78a-o76a-A*/ko"

"=============================================================================
"=============================================================================
