"=============================================================================
"     File: ~/.vim/syntax/fjou.vim
"  Created: unknown
"   Author: Bernie Roesler
" 
"   Description: Fluent journal file syntax
"=============================================================================
if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif

" Borrow most things from scheme syntax
source $VIMRUNTIME/syntax/scheme.vim
unlet b:current_syntax

" Keywords
syn keyword fjouKeywords yes no

" Variable names
" syn match fjouVariables display '\$\<[_a-zA-Z0-9]\+\>'
" syn match fjouVariables display '\((define\s\+\)\@<=\<[?!-_a-zA-Z0-9]\+\>'

" Important callouts in notes
syn keyword fjouImportant TODO NOTE FIXME WARNING containedin=schemeComment

" Highlight empty lines as warning (false CR in journal file)
syn match fjouEmptyLine display "^\s*$" containedin=ALL

" Map syntax groups to colors
" hi def link schemeDelimiter   PreProc " doesn't work??
hi def link fjouKeywords      Keyword
hi def link fjouVariables     Special
hi def link fjouImportant     Todo
hi fjouEmptyLine ctermbg=darkred

" finish
let b:current_syntax = "fjou"
"=============================================================================
"=============================================================================
