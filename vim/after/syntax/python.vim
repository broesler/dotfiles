"=============================================================================
"     File: python.vim
"  Created: 08/02/2017, 14:22
"   Author: Bernie Roesler
"
"  Description: Additional syntax highlighting for python files
"
"=============================================================================
"
syn keyword pythonStatement	self
syn match pythonExceptions	'warnings\..*warn\w*\((\)\@='

syn match pythonArithmeticOperator      display "[-+]"
syn match pythonArithmeticOperator      display "[*/%]"
syn match pythonRelationalOperator      display "[=!]="
syn match pythonRelationalOperator      display "[<>]=\="
syn match pythonLogicalOperator         display "[|^&~]"

" Include "fold" capability
" Triple-quoted strings can contain doctests.
syn region  pythonString matchgroup=pythonTripleQuotes
      \ start=+[uU]\=\z('''\|"""\)+ end="\z1" keepend fold
      \ contains=pythonEscape,pythonSpaceError,pythonDoctest,@Spell
syn region  pythonRawString matchgroup=pythonTripleQuotes
      \ start=+[uU]\=[rR]\z('''\|"""\)+ end="\z1" keepend fold
      \ contains=pythonSpaceError,pythonDoctest,@Spell

hi def link pythonArithmeticOperator    pythonOperator
hi def link pythonRelationalOperator    pythonOperator
hi def link pythonLogicalOperator       pythonOperator
hi def link pythonOperator              Operator
hi def link pythonDecoratorName		    Preproc
