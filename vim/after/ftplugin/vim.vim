"=============================================================================
"     File: vim.vim
"  Created: 09/15/2016, 19:45
"   Author: Bernie Roesler
"
"  Description: vimscript buffer local settings
"
"=============================================================================
"
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4

setlocal keywordprg=:help

augroup vimscript
  au!
  " Make line into a comment header with dashes
  autocmd BufEnter *.vim let @h='O"77a-jI"8a oC"77a-k$'
augroup END

"=============================================================================
"=============================================================================
