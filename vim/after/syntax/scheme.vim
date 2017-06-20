"=============================================================================
"     File: scheme.vim
"  Created: 06/19/2017, 21:27
"   Author: Bernie Roesler
"
"  Description: Syntax highlighting tweaks for scheme language
"
"=============================================================================

syn region schemeBlockComment start=/^\s*#|\s*$/ end=/^\s*|#\s*$/ contains=schemeTodo

syn match schemeTodo "\(TODO\|NOTE\|FIXME\):\=" containedin=schemeComment,schemeBlockComment

hi def link schemeBlockComment  Comment
hi def link schemeTodo          Todo
