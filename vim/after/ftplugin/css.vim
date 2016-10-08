"=============================================================================
"     File: ~/.vim/after/ftplugin/css.vim
"  Created: 12/06/2015, 13:20
"   Author: Bernie Roesler
"
" Last Modified: 10/07/2016, 23:41
"
"  Description: CSS settings
"=============================================================================

"-----------------------------------------------------------------------------
"       Local Settings
"-----------------------------------------------------------------------------
" Treat <li> and <p> tags like the block tags they are
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2

" Allow stylesheets to autocomplete hyphenated words
setlocal iskeyword+=-,_
setlocal iskeyword-=:

" Correct auto-completion
setlocal omnifunc=csscomplete#CompleteCSS

"-----------------------------------------------------------------------------
"       Functions 
"-----------------------------------------------------------------------------
function! JumpToCSS() "{{{
    let id_pos = searchpos("id", "nb", line('.'))[1]
    let class_pos = searchpos("class", "nb", line('.'))[1]
    if class_pos > 0 || id_pos > 0
        if class_pos < id_pos
            execute ":vimgrep '#".expand('<cword>')."' **/*.css"
        elseif class_pos > id_pos
            execute ":vimgrep '.".expand('<cword>')."' **/*.css"
        endif
    endif
endfunction
"}}}

"-----------------------------------------------------------------------------
"       Mappings 
"-----------------------------------------------------------------------------
nnoremap <Leader>] :call JumpToCSS()<CR>

"=============================================================================
"=============================================================================
