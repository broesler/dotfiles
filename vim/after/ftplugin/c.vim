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
setlocal foldlevelstart=20      " don't start with all lines folded

"-----------------------------------------------------------------------------
"       Local autocmds
"-----------------------------------------------------------------------------
augroup c_cmds
    autocmd!
    " Update tags file automatically
    " autocmd BufWritePost,FileWritePost <buffer> silent call UpdateTags()

    " Make comment header with dashes
    " autocmd BufReadPost *.c let @h="o/*" . &textwidth-col('.')-1 . "a-o" . &textwidth-col('.')-3 . "a-A*/ko \t\t"
    autocmd BufEnter *.c let @h="o/*78a-o76a-A*/ko \t\t"
augroup END

"-----------------------------------------------------------------------------
"       Keymaps and macros
"-----------------------------------------------------------------------------
command! -bar -nargs=? -complete=file CMakeThisFile call <SID>CMakeThisFile(<f-args>)

nnoremap <LocalLeader>m :CMakeThisFile<CR>
nnoremap <LocalLeader>M :silent make! <bar> :redraw!<CR>

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

    let save_makeprg = &makeprg

    " i.e. "gcc ... -o myfile myfile.c"
    let &makeprg="gcc -Wall -pedantic -std=c99 -o " . l:exe . " " . l:source

    " Write and compile
    echo "Running: " . &makeprg
    update | silent make! | redraw!

    " Return makeprg to original state
    let &makeprg = save_makeprg
endfunction 
"}}}
"=============================================================================
"=============================================================================
