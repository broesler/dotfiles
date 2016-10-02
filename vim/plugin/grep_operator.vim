"=============================================================================
"     File: grep_operator.vim
"  Created: 09/12/2016, 16:02
"   Author: Bernie Roesler
"
"  Description: vim grep operator, i.e. <Leader>giw
"
"=============================================================================
nnoremap <Leader>g :set operatorfunc=<SID>GrepOperator<CR>g@
vnoremap <Leader>g :<C-u>call <SID>GrepOperator(visualmode())<CR>

function! s:GrepOperator(type)
    let save_unnamed_register = @@

    if a:type ==# 'v'
        execute "normal! `<v`>y"
    elseif a:type ==# 'char'
        execute "normal! `[v`]y"
    else
        " ignore linewise-visual 'V' and block-visual '' because grep doesn't
        " use newline characters
        return
    endif

    silent execute "grep! -R " . shellescape(@@) . " ."
    copen

    let @@ = save_unnamed_register
endfunction

"=============================================================================
"=============================================================================
