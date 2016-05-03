"=============================================================================
"     File: ~/.vim/after/ftplugin/python.vim
"  Created: 02/26/2016, 19:21
"   Author: Bernie Roesler
"
" Last Modified: 03/01/2016, 16:48
"
"  Description: Python filetype settings
"
"=============================================================================

setlocal textwidth=79    " PEP-8 standard
setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=0
setlocal iskeyword+=_
setlocal iskeyword-=:

" Highlight trailing whitespace
hi TrailingWhitespace ctermbg=red ctermfg=red
syn match TrailingWhitespace /\s\+$/ containedin=ALL

" Set up syntax error checking
setlocal makeprg=pylint\ --reports=n\ --output-format=parseable\ %:p
setlocal efm=%W%f:%l:\ [C%.%#]\ %m,%Z%p^^
setlocal efm+=%E%f:%l:\ [E%.%#]\ %m,%Z%p^^,%-G%.%#

" Keymaps
nnoremap <Leader>M :silent! make <bar> redraw!<CR>

"=============================================================================
"=============================================================================
