"=============================================================================
"     File: ~/.vim/after/syntax/sh.vim
"  Created: 02/22/2016, 20:51
"   Author: Bernie Roesler
"
"  Description: Additional syntax highlighting for shell scripts
"
"=============================================================================

syn match shTodo contained "\(TODO\|NOTE\|FIXME\):\=" 

" Control sequences
syn match	shFormat	display "%\(\d\+\$\)\=[-+' #0*]*\(\d*\|\*\|\*\d\+\$\)\(\.\(\d*\|\*\|\*\d\+\$\)\)\=\([hlL]\|ll\)\=\([bdiuoxXDOUfeEgGcCsSpn]\|\[\^\=.[^]]*\]\)" containedin=shDoubleQuote,shSingleQuote

hi def link shFormat   SpecialChar
hi def link shTodo     Todo

"=============================================================================
"=============================================================================
