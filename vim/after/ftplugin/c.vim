"=============================================================================
"       C settings
"=============================================================================
setlocal textwidth=80
setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal expandtab

setlocal iskeyword+=_
setlocal cindent                " smarter indenting for C

setlocal foldmethod=syntax
setlocal foldminlines=4         " ignore 3-line comment headers
setlocal foldlevelstart=99      " don't start with all lines folded
setlocal foldlevel=99

"-----------------------------------------------------------------------------
"       Local autocmds
"-----------------------------------------------------------------------------
augroup c_cmds
    autocmd!
    " Update tags file automatically
    " autocmd BufWritePost,FileWritePost <buffer> silent call UpdateTags()

    " Make comment header with dashes (turn off auto-indenting temporarily)
    " TODO compact command into mapping only?
    autocmd BufEnter *.c let @h=":CCommentBlock"
augroup END

"-----------------------------------------------------------------------------
"       Keymaps and macros
"-----------------------------------------------------------------------------
command! -bar -nargs=? -complete=file CMakeThisFile call <SID>CMakeThisFile(<f-args>)
command! CCommentBlock :set nocindent | exe "norm! o/*78a-o76a-A*/ko \t\t" | set cindent

nnoremap <LocalLeader>m :CMakeThisFile<CR>
nnoremap <LocalLeader>M :silent make! <bar> :redraw!<CR>

" Open header/source file corresponding to current source/header
nnoremap <LocalLeader>c :execute "find " . expand("%:t:r") . ".c"<CR>
nnoremap <LocalLeader>h :execute "find " . expand("%:t:r") . ".h"<CR>

"-----------------------------------------------------------------------------
"       Functions 
"-----------------------------------------------------------------------------
function! s:CMakeThisFile(...) abort "{{{
    " if we have an argument, it is the filename
    if a:0 
        let l:source = fnameescape(a:1)
        let l:exe    = fnameescape(fnamemodify(a:1, ":r"))
    else
        let l:source = fnameescape(expand("%"))
        let l:exe    = fnameescape(expand("%:r"))
    endif

    if l:source ==# l:exe
        echo "Source and executable have the same name!! Abort."
        return
    endif

    let save_makeprg = &makeprg

    " Remove original executable
    execute "silent !rm " . l:exe

    " i.e. "gcc ... -o myfile myfile.c"
    let l:debug = " -DLOGSTATUS -g -ggdb "
    let &makeprg="gcc -Wall -pedantic -std=c99 "
                \ . l:debug
                \ . " -I'../include/' "
                \ . " -o " . l:exe . " " . l:source

    " Write and compile
    echo "Running: " . &makeprg
    update | silent make! | redraw!

    " Return makeprg to original state
    let &makeprg = save_makeprg
endfunction 
"}}}
"=============================================================================
"=============================================================================
