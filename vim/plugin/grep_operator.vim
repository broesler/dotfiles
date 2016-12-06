"=============================================================================
"     File: grep_operator.vim
"  Created: 09/12/2016, 16:02
"   Author: Bernie Roesler
"
"  Description: vim grep operator, i.e. <Leader>giw
"
"=============================================================================
function! s:GrepOperator(type)
    let save_reg = @@

    " copy motion for type
    if a:type ==# 'v'
        execute "normal! `<v`>y"
    elseif a:type ==# 'char'
        execute "normal! `[v`]y"
    else
        " ignore linewise-visual 'V' and block-visual '' because grep doesn't
        " use newline characters
        return
    endif

    " Grep for literal string
    silent execute "grep! -R -F " . shellescape(@@) . " ."
    copen

    let @@ = save_reg
endfunction

nnoremap <silent> <Leader>g :set operatorfunc=<SID>GrepOperator<CR>g@
vnoremap <silent> <Leader>g :<C-u>call <SID>GrepOperator(visualmode())<CR>

"=============================================================================
"=============================================================================
