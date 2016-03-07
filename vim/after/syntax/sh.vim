"===============================================================================
"     File: ~/.vim/after/syntax/sh.vim
"  Created: 02/22/2016, 20:51
"   Author: Bernie Roesler
"
" Last Modified: 02/22/2016, 20:55
"
"  Description: Additional syntax highlighting for shell scripts
"
"==============================================================================

syn match shTodo contained "\(TODO\|NOTE\|FIXME\):\=" 

hi def link shTodo Todo

"==============================================================================
"==============================================================================
