"------------------------------------------------------------------------------
"       Gambit journal file syntax
"------------------------------------------------------------------------------
" Use sh syntax, then add some custom options
" runtime! syntax/sh.vim

" All braces
syn match Braces display '[{}()\[\]]'

" Variable names
syn match Variables display '\$\<\w\{-}\>'

" Strings
syn region myString start=+'+ end=+'+
syn region myString start=+"+ end=+"+

" Constants
syn match myConst display '\<\d\+\>'
syn match myConst display '\<\d\+\.\d*\>'

" Operators
syn match myOperators display '[\*\=\+-/]'

" Important callouts in notes
syn keyword Important TODO: NOTE: contained 

" Comments are lines starting with '/'
syn match myComments display "^//.*$" contains=Important

" Map syntax groups to colors
hi Braces ctermfg=208
hi def link Variables       Special
hi def link myString        String
hi def link myConst         Constant
hi def link myOperators     Operator
hi def link Important       PreProc
hi def link myComments    Comment
