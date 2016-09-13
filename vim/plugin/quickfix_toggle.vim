"=============================================================================
"     File: quickfix_toggle.vim
"  Created: 09/12/2016, 19:04
"   Author: Bernie Roesler
"
"  Description: toggle the quickfix window on and off
"
"=============================================================================
nnoremap <Leader>q : call QuickfixToggle()<CR>

let g:quickfix_is_open = 0

function! QuickfixToggle()
  if g:quickfix_is_open
    cclose
    let g:quickfix_is_open = 0
    execute g:quickfix_return_to_window . "wincmd w"
  else
    let g:quickfix_return_to_window = winnr()
    copen
    let g:quickfix_is_open = 1
  endif
endfunction
