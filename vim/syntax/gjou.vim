"------------------------------------------------------------------------------
"       Gambit journal file syntax
"------------------------------------------------------------------------------
" Use sh syntax, then add some custom options
" runtime! syntax/sh.vim

" Keywords
syn keyword myKeywords create delete add subtract modify mesh

" All braces
syn match myBraces display '[{}()\[\]]'

" Variable names
syn match myVariables display '\$\<\w\{-}\>'

" Strings
syn region myString start=+'+ end=+'+
syn region myString start=+"+ end=+"+

" Constants
syn match myConst display '\<\d\+\>'
syn match myConst display '\<\d\+\.\d*\>'

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
