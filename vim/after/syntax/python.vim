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

hi def link pythonArithmeticOperator    pythonOperator
hi def link pythonRelationalOperator    pythonOperator
hi def link pythonLogicalOperator       pythonOperator
hi def link pythonOperator              Operator
hi def link pythonDecoratorName		    Preproc
