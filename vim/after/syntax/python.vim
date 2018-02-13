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

hi def link pythonDecoratorName		Preproc
