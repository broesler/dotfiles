"==============================================================================
"       C settings
"==============================================================================
setlocal iskeyword+=_
setlocal cindent        " smarter indenting for C
setlocal expandtab
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4

" Map \M to make in background
nnoremap <Leader>M :silent! make | redraw!

" " Show directory of file in errorlist?
" set errorformat+=%D%f
" set errorformat+=%DEntering\ dir\ '%f',%XLeaving\ dir

"------------------------------------------------------------------------------
"       Local autocmds
"------------------------------------------------------------------------------
" Update tags file automatically
" autocmd BufWritePost,FileWritePost <buffer> silent call UpdateTags()

"==============================================================================
"==============================================================================
