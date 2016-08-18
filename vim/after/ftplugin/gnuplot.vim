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
"       RunGnuplotScript in interactive window {{{
"-----------------------------------------------------------------------------
function! RunGnuplotScript()
    let &l:makeprg="ts -t left \"load ".shellescape(expand("%"))."\""
    " save changes made to the file so Matlab gets the most recent version
    update | silent! make! | redraw!
endfunction
command! RunGnuplotScript :call RunGnuplotScript()
"}}}--------------------------------------------------------------------------
"       Evaluate current selection {{{
"-----------------------------------------------------------------------------
function! EvaluateSelection()
    " let mcom = s:GetVisualSelection()
    let mcom = GetVisualSelection()
    " Only need to escape ; if there is no space after it (not sure why?)
    let mcom = substitute(mcom, ';', '; ', 'g')
    " Need to escape `%' so vim doesn't insert filename
    let mcom = substitute(mcom, '%', '\%', 'g')
    " Change newlines to literal carriage return so shellescape() does not
    " escape them (sends literal \ to tmux send-keys)
    let mcom = substitute(mcom, "\n", '\\\\', 'g')
    " Call shellescape() for proper treatment of string characters
    " call system('ts -t '''.g:tmux_pane.''' '.shellescape(mcom))
    call system('ts -t left '.shellescape(mcom))
endfunction
command! -range EvaluateSelection :call EvaluateSelection()

"}}}--------------------------------------------------------------------------
"       Keymaps
"-----------------------------------------------------------------------------
" nnoremap <Leader>M   :update<bar>silent! make!<bar>redraw!<CR>
nnoremap <Leader>M   :RunGnuplotScript<CR>

" Evaluate Current selection
vnoremap <Leader>e :EvaluateSelection<CR>

"=============================================================================
"=============================================================================
