"==============================================================================
"    File: ~/.vim/ftplugin/help.vim
"  Author: Bernie Roesler
" Created: 02/19/2016, 13:39 
"
" Description: keymaps for vim help window
"==============================================================================

setlocal nohlsearch

" Navigation mappings:

" Navigate topics (quick tag jumps)
nnoremap <buffer> <CR> <C-]>              
nnoremap <buffer> <BS> <C-T>              

" Find option
nnoremap <buffer> o /'\l\{2,\}'<CR>       
nnoremap <buffer> O ?'\l\{2,\}'<CR>       

" Find subject
nnoremap <buffer> <Tab>   /\|\zs\S\+\ze\|<CR>   
nnoremap <buffer> <S-Tab> ?\|\zs\S\+\ze\|<CR>   

" q to close window
nnoremap <buffer> q <C-w>q

" TODO function! ToggleEditHelp() to turn off these mappings and set ft=text
"==============================================================================
"==============================================================================
