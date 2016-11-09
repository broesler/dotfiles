"------------------------------------------------------------------------------
"       Fluent journal file syntax
"------------------------------------------------------------------------------
" Keywords
syn keyword myKeywords yes no
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
syn match myConst display '\<\d\+\>'
syn match myConst display '\<\d\+\.\d*\>'
syn match myConst display '[-+]\=\d\+\>'
syn match myConst display '[-+]\=\d\+\.\d*\>'
syn match myConst display '\<\d\+[eE][-+]\=\d\+\>'
syn match myConst display '\<\d\+\.\d\+[eE][-+]\=\d\+\>'
syn match myConst display '\<PI\>'


" Operators
syn match myOperators display '[\*\=\+-/]'

" Important callouts in notes
syn keyword myImportant TODO NOTE FIXME contained 

" Comments are lines starting with '/'
syn match myComments display "^;.*$" contains=myImportant
syn match myComments display ";.*$" contains=myImportant

" Highlight empty lines as warning (false CR in journal file)
syn match myEmptyLine display "^\s*$" containedin=ALL

" Map syntax groups to colors
" hi myBraces ctermfg=208
hi def link myBraces        PreProc
hi def link myKeywords      Keyword
hi def link myVariables     Special
hi def link myString        String
hi def link myConst         Constant
hi def link myOperators     Operator
hi def link myImportant     Todo
hi def link myComments      Comment
hi def link myEmptyLine     Error
