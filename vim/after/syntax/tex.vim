"=============================================================================
"     File: tex.vim
"  Created: 10/14/2017, 12:14
"   Author: Bernie Roesler
"
"  Description: 
"
"=============================================================================

syn match texTodo contained "\(WARNING\|TODO\|NOTE\|FIXME\):\=" 

" Copy block from $VIMRUNTIME/syntax/tex.vim, add line for "emph"
" particular support for bold and italic {{{1
syn region texItalStyle	matchgroup=texTypeStyle start="\\emph\s*{" matchgroup=texTypeStyle  end="}" concealends contains=@texItalGroup,@Spell

hi def link texTodo     Todo

"=============================================================================
"=============================================================================
