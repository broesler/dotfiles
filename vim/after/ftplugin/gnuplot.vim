"=============================================================================
"     File: gnuplot.vim
"  Created: 08/16/2016, 23:11
"   Author: Bernie Roesler
"
"  Description: gnuplot script settings
"
"=============================================================================
" Buffer-local settings {{{
setlocal tabstop=4            " tabs every 4 spaces
setlocal softtabstop=4        " let backspace delete indent
setlocal shiftwidth=4
setlocal textwidth=80
setlocal iskeyword-=:         " colon is NOT part of keywords
setlocal formatoptions-=t     " do not auto-wrap code, only comments

setlocal comments=:#
setlocal commentstring=#%s

setlocal foldmethod=indent
setlocal foldnestmax=4
setlocal foldignore=
setlocal foldminlines=3

setlocal nowrap

"}}}--------------------------------------------------------------------------

function! RunGnuplotScript()
    let &l:makeprg="ts -t right \"load ".shellescape(expand("%"))."\""
    " save changes made to the file so Matlab gets the most recent version
    update | silent! make! | redraw!
endfunction
command! RunGnuplotScript :call RunGnuplotScript()

"-----------------------------------------------------------------------------
"       Keymaps
"-----------------------------------------------------------------------------
" nnoremap <Leader>M   :update<bar>silent! make!<bar>redraw!<CR>
nnoremap <Leader>M   :RunGnuplotScript<CR>
"=============================================================================
"=============================================================================
