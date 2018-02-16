"==============================================================================
"    File: ~/.vim/ftplugin/help.vim
"  Author: Bernie Roesler
" Created: 02/19/2016, 13:39 
"
" Description: keymaps for vim help window
"==============================================================================

" Navigation mappings:

" Navigate topics (quick tag jumps)
nnoremap <buffer> <CR> <C-]>              
nnoremap <buffer> <BS> <C-T>              

" [oO] to find option
nnoremap <buffer> o /'\l\{2,\}'<CR>       
nnoremap <buffer> O ?'\l\{2,\}'<CR>       

" [sS] to find subject
nnoremap <buffer> s /\|\zs\S\+\ze\|<CR>   
nnoremap <buffer> S ?\|\zs\S\+\ze\|<CR>   

" q to close window
nnoremap <buffer> q <C-w>q

" TODO function! ToggleEditHelp() to turn off these mappings and set ft=text
"==============================================================================
"==============================================================================
