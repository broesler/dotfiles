"-----------------------------------------------------------------------------
"       Text file syntax
"-----------------------------------------------------------------------------
" 208 == orange
" 6 == cyan
syn match textTodo display "\(TODO\|NOTE\|FIXME\):\=" contained
syn match Braces display '[{}()\[\]]'
syn match Quotes display '[\'\`\"]'
syn match Stars display '[\*]'
syn match textComments display '#.*$' contains=textTodo
syn match Important display 'NOTE:'

hi Braces ctermfg=darkred
hi Quotes ctermfg=6
hi def link textTodo        Todo
hi def link Stars           Operator
hi def link textComments    Comment
hi def link Important       PreProc
