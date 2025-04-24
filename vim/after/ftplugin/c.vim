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
augroup c_cmds
    autocmd!
    " Update tags file automatically
    " autocmd BufWritePost,FileWritePost <buffer> silent call UpdateTags()

    " Load types file
    autocmd BufRead,BufNewFile *.[ch] call util#HighlightTypes()

augroup END

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

" Create maps for using CScope {{{
" See:
"   * :help cscope
"   * Vim/Cscope tutorial:
"     <http://cscope.sourceforge.net/cscope_vim_tutorial.html>
" Search for a cscope tag independently of the normal tags <C-]>
map <C-\> :cstag <C-R>=expand("<cword>")<CR><CR>

" Search globally for all functions calling this function, or all
" occurrences of this symbol
" map g<C-]> :cs find c <C-R>=expand("<cword>")<CR><CR>
" map g<C-\> :cs find s <C-R>=expand("<cword>")<CR><CR>

nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-_>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>a :cs find a <C-R>=expand("<cword>")<CR><CR>

" Using 'CTRL-spacebar' then a search type makes the vim window
" split horizontally, with search result displayed in
" the new window.

nmap <C-Space>s :scs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>g :scs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>c :scs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>t :scs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>e :scs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-Space>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-Space>d :scs find d <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>a :scs find a <C-R>=expand("<cword>")<CR><CR>

" Hitting CTRL-space *twice* before the search type does a vertical
" split instead of a horizontal one

nmap <C-Space><C-Space>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-Space><C-Space>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>a :vert scs find a <C-R>=expand("<cword>")<CR><CR>
"}}}
"}}}

"=============================================================================
"=============================================================================
