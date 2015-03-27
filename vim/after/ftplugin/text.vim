"------------------------------------------------------------------------------
"       Text file settings
"------------------------------------------------------------------------------
" Basic syntax
syn match Braces display '[{}\[\]]'
hi Braces ctermfg=darkred

syn match Quotes display '[\'\`\"]'
hi Quotes ctermfg=6

syn match Stars display '[\*]'
hi Stars ctermfg=208
" 208 == orange

" set complete to include dictionary for text or latex files
setlocal complete+=k
