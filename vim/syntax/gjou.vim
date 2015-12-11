"------------------------------------------------------------------------------
"       Gambit journal file syntax
"------------------------------------------------------------------------------
" Keywords
syn keyword myKeywords create delete add subtract modify mesh attach set select
syn keyword myKeywords COS SIN TAN ACOS ASIN ATAN

" All braces
syn match myBraces display '[{}()\[\]]'

" Variable names
syn match myVariables display '\$\<[_a-zA-Z0-9]\+\>'

" Strings
syn region myString start=+'+ end=+'+
syn region myString start=+"+ end=+"+

" Constants
"  Negative lookbehind to not include numbers in variable names or commands
syn match myConst display '\([a-zA-Z]\)\@<!\d\+'
syn match myConst display '\([a-zA-Z]\)\@<!\d\+\.\d*'
syn match myConst display '\([a-zA-Z]\)\@<![-+]\d\+\.\d*'
syn match myConst display '\([a-zA-Z]\)\@<!\d\+[eE][-+]\=\d\+'
syn match myConst display '\([a-zA-Z]\)\@<!\d\+\.\d\+[eE][-+]\=\d\+'
syn match myConst display '\<PI\>'

" Operators
syn match myOperators display '[\*\=\+-/]'

" Important callouts in notes
syn keyword myImportant TODO: NOTE: contained 

" Comments are lines starting with '/'
syn match myComments display "^//.*$" contains=myImportant
syn match myComments display "^/.*$" contains=myImportant

" Map syntax groups to colors
hi myBraces ctermfg=208
hi def link myKeywords      Keyword
hi def link myVariables     Special
hi def link myString        String
hi def link myConst         Constant
hi def link myOperators     Operator
hi def link myImportant     PreProc
hi def link myComments      Comment
