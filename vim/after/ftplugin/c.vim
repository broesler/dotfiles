"=============================================================================
"       C settings
"=============================================================================
setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2

setlocal textwidth=80

setlocal iskeyword+=_
setlocal cindent        " smarter indenting for C
setlocal expandtab

setlocal foldmethod=syntax
setlocal foldminlines=4         " ignore 3-line comment headers

" " Show directory of file in errorlist?
" set errorformat+=%D%f
" set errorformat+=%DEntering\ dir\ '%f',%XLeaving\ dir

"-----------------------------------------------------------------------------
"       Local autocmds
"-----------------------------------------------------------------------------
" Update tags file automatically
" autocmd BufWritePost,FileWritePost <buffer> silent call UpdateTags()

"-----------------------------------------------------------------------------
"       Keymaps and macros
"-----------------------------------------------------------------------------
nnoremap <Leader>M :silent! make <bar> :redraw!<CR>

" Make comment header with dashes
let @h="o/*78a-o76a-A*/ko"

"=============================================================================
"=============================================================================
