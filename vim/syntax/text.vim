"------------------------------------------------------------------------------
"       Text file syntax
"------------------------------------------------------------------------------
" 208 == orange
" 6 == cyan

syn match Braces display '[{}()\[\]]'
hi Braces ctermfg=darkred

syn match Quotes display '[\'\`\"]'
hi Quotes ctermfg=6

syn match Stars display '[\*]'
hi def link Stars Operator

syn match textComments display '#.*$'
hi def link textComments Comment

syn match Important display 'NOTE:'
hi def link Important PreProc
