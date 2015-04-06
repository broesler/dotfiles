"------------------------------------------------------------------------------
"       help.vim commands
"------------------------------------------------------------------------------

" Navigation mappings:

" jump to topic under cursor
nnoremap <buffer> <CR> <C-]>              

" return from last jump
nnoremap <buffer> <BS> <C-T>              

" o to find next     option
nnoremap <buffer> o /'\l\{2,\}'<CR>       

" O to find previous option
nnoremap <buffer> O ?'\l\{2,\}'<CR>       

" s to find next     subject
nnoremap <buffer> s /\|\zs\S\+\ze\|<CR>   

" S to find previous subject
nnoremap <buffer> S ?\|\zs\S\+\ze\|<CR>   
