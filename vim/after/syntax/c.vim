"=============================================================================
"     File: c.vim
"  Created: 03/28/2017, 11:12
"   Author: Bernie Roesler
"
"  Description: Extra highlighting for C files 
"
"=============================================================================
syn keyword	cTodo		contained NOTE WARNING
syn match   cCommentTitle '%\s*\%([sS]:\|\h\w*#\)\=\u\w*\(\s\+\u\w*\)*:'hs=s+1 containedin=cComment

hi def link cCommentTitle          PreProc
