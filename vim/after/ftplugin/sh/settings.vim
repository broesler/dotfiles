"=============================================================================
"     File: ~/.vim/after/ftplugin/sh.vim
"  Created: 02/21/2016, 14:05
"   Author: Bernie Roesler
"
" Last Modified: 02/22/2016, 21:55
"
"  Description: Vim settings for shell scripts
"
"=============================================================================
" Buffer-local settings {{{
setlocal tabstop=4            " tabs every 4 spaces
setlocal softtabstop=4        " let backspace delete indent
setlocal shiftwidth=4
setlocal textwidth=80
setlocal iskeyword-=:         " colon is NOT part of keywords

setlocal comments=:#
setlocal commentstring=#%s

setlocal foldmethod=indent
setlocal foldignore=          
" empty foldignore to NOT ignore lines starting with '#' (default)

setlocal nowrap
"}}}

" Make comment header with dashes
let @h='o#79a-yypO#8a '

"=============================================================================
"=============================================================================
