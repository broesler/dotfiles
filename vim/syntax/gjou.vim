"===============================================================================
"     File: ~/.vim/syntax/gjou.vim
"  Created: 02/17/2016, 15:42
"   Author: Bernie Roesler
"
" Last Modified: 02/18/2016, 01:16
"
"  Description: Syntax highlighting for Gambit journal files
"
"==============================================================================
" Quit when a (custom) syntax file was already loaded
if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif

" Keywords
syn keyword myKeywords create delete add subtract modify mesh attach set select
syn keyword myKeywords IF COND ELSE ENDIF
syn keyword myKeywords DO PARA COND INCR ENDDO
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
" syn keyword myImportant WARNING TODO NOTE contained 
syn match myImportant '\(WARNING\|TODO\|NOTE\):\=' contained 

" Comments are lines starting with '/'
syn match myComments display "^\s*//.*$" contains=myImportant
syn match myComments display "^\s*/.*$" contains=myImportant

" Map syntax groups to colors
hi myBraces ctermfg=208
hi def link myKeywords      Keyword
hi def link myVariables     Special
hi def link myString        String
hi def link myConst         Constant
hi def link myOperators     Operator
hi def link myImportant     Todo
hi def link myComments      Comment

" Set syntax file for current buffer
let b:current_syntax = "gjou"
"==============================================================================
"==============================================================================
