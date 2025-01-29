"=============================================================================
"     File: after/ftplugin/c.vim
"  Created: 03/27/2015 02:17:57
"   Author: Bernie Roesler
"
"  Description: vim C filetype settings beyond defaults
"
"=============================================================================
setlocal cindent                " smarter indenting for C

setlocal textwidth=80

setlocal foldmethod=syntax
setlocal foldminlines=4         " ignore 3-line comment headers
setlocal foldlevelstart=99      " don't start with all lines folded

setlocal keywordprg=:Man\ 3     " use section 3 for C Library functions

"-----------------------------------------------------------------------------
"       Functions 
"-----------------------------------------------------------------------------
function! s:CMakeThisFile(...) abort "
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

    " i.e. "clang ... -o myfile myfile.c"
    let l:debug = " -DLOGSTATUS -g -ggdb "
    let &makeprg="clang -Wall -pedantic -std=c99 "
                \ . l:debug
                \ . " -I'../include/' "
                \ . " -o " . l:exe . " " . l:source

    " Write and compile
    echo "Running: " . &makeprg
    update | silent make! | redraw!

    " Return makeprg to original state
    let &makeprg = save_makeprg
endfunction 

"-----------------------------------------------------------------------------
"       Local autocmds 
"-----------------------------------------------------------------------------
" augroup c_cmds
    " autocmd!
    " Update tags file automatically
    " autocmd BufWritePost,FileWritePost <buffer> silent call UpdateTags()
" augroup END

"-----------------------------------------------------------------------------
"       Keymaps and macros 
"-----------------------------------------------------------------------------
command! -buffer -bar -nargs=? -complete=file CMakeThisFile call <SID>CMakeThisFile(<f-args>)
" TODO make CCommentBlock a function
command! -buffer CCommentBlock
            \ :set nocindent
            \ | set fo+=o
            \ | exe "norm! o/*78a-o76a-A*/ko \t\t"
            \ | set fo-=o
            \ | set cindent

nnoremap <buffer> <LocalLeader>m :CMakeThisFile<CR>
" nnoremap <buffer> <LocalLeader>M :silent make! <bar> redraw!<CR>
" nnoremap <buffer> <LocalLeader>D :silent make! debug <bar> redraw!<CR>
" nnoremap <buffer> <LocalLeader>C :silent make! clean <bar> redraw!<CR>
nnoremap <buffer> <LocalLeader>M :Make<CR>
nnoremap <buffer> <LocalLeader>D :Make debug<CR>
nnoremap <buffer> <LocalLeader>C :Make clean<CR>

" Open header/source file corresponding to current source/header
nnoremap <buffer> <LocalLeader>c :execute 'find ' . expand('%:t:r') . '.c*'<CR>
nnoremap <buffer> <LocalLeader>h :execute 'find ' . expand('%:t:r') . '.h'<CR>

nnoremap <buffer> <Leader>h :CCommentBlock<CR>

" Create CScope mappings
call util#MapCScope()

"=============================================================================
"=============================================================================
