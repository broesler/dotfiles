"============================================================================
"     File: ~/.vim/plugin/util_functions.vim
"  Created: 12/06/2015, 13:20
"   Author: Bernie Roesler
"
" Last Modified: 05/16/2016, 10:28
"
"  Description: Custom utility functions called from .vimrc autocmds, etc.
"============================================================================

"-----------------------------------------------------------------------------
"       Functions 
"-----------------------------------------------------------------------------
function! CommentBlock(comment, ...) "{{{
    " don't let vim insert comment characters automatically
    let l:save_fo = &formatoptions
    set formatoptions-=ro

    " Create a comment block such as the header above
    let l:intro = a:0 >= 1 ? a:1 : "#"
    let l:box   = a:0 >= 2 ? a:2 : "-"
    let l:width = a:0 >= 3 ? a:3 : &textwidth-col('.')

    " Build the comment box and put the comment inside it
    execute "normal i" . l:intro . repeat(l:box,l:width) . "\n" 
                     \ . l:intro . " \t\t" . a:comment   . "\n" 
                     \ . l:intro . repeat(l:box,l:width) . "\n"

    let &formatoptions = l:save_fo
endfunction
"}}}
function! FollowSymlink() "{{{
    " Follow symlinks when opening files
    " Copied from here:
    "   <http://inlehmansterms.net/2014/09/04/sane-vim-working-directories/>
    let current_file = expand('%:p')
    " check if file type is a symlink
    if getftype(current_file) == 'link'
        " resolve to the actual file path and open the actual file
        let actual_file = resolve(current_file)
        silent! execute 'file ' . actual_file
    end
endfunction
"}}}
function! Incr() "{{{
    let a = line('.') - line("'<")
    let c = virtcol("'<")
    if a > 0
        execute 'normal! '.c.'|'.a."\<C-a>"
    endif
    normal `<
endfunction
"}}}
function! LastModified() "{{{
    if &modified
        let save_cursor = getpos(".")
        " Only check maximum of 50 lines, or to the end of the file (if < 20)
        let n = min([50, line("$")])
        " Update line without moving cursor, do not report errors
        keepjumps exe '1,' . n . 's#\(Last Modified:\|Last Updated:\).*#\1 '
                    \ . strftime("%m/%d/%Y, %H:%M") . '#ie'
        " Remove update from cmd history
        call histdel('search', -1)      
        " These commands are suggested in the help to remove the last chnage
        " from the undo history/tree. We turn off 'undofile' before the change
        " and turn it back on after the change so it is not recorded
        " let old_undolevels = &undolevels
        " set undolevels=&undolevels-1
        " exe "normal a \<BS>\<Esc>"
        " let &undolevels = old_undolevels
        " unlet old_undolevels
        call setpos('.', save_cursor)
        " Keep other changes in undofile
        " set undofile
    endif
endfunction
"}}}
function! MakeTemplate(filename) "{{{
    execute 'source' a:filename
    execute "%s@File:.*@File: " . expand("%:t")
    execute "%s@Created:.*@Created: " . strftime("%m/%d/%Y, %H:%M")
endfunction
"}}}
function! SetTermTitle() "{{{
    let filename = expand("%:p")
    let length = strlen(filename)
    let cols = &columns - 20          " terminal window size
    if (length < cols)                " show entire path
        let tstr = filename
    else                              " not going to use window < 82 cols
        let tstr = strpart(filename,0,32) . "..." . strpart(filename, length-50)
    endif
    " Set terminal title
    silent execute "!echo -ne " . "\"\033]0;" . tstr . "\007\""
endfunction
"}}}
" FIXME function! UpdateTags() " {{{
"   let alltagfiles = tagfiles()
"   if (len(alltagfiles) == 0)            " create new tags file
"     let tagsfile = './tags'           
"     silent! exe '!ctags -af ' . tagsfile . ' ' . expand("%:t")
"   else
"     " for each tags file, remove old tags from current buffer
"     for ff in alltagfiles
"       silent! exe '!sed -i -e "\@' . expand("%:t") . '@d" ' . ff
"     endfor
"     " Refresh nearest tag file with most up-to-date tags
"     silent! exe '!ctags -af ' . alltagfiles[0] . ' ' . expand("%")
"     " -e on Mac causes backup tags file to be generated, remove it
"     silent! exe '!rm -rf ' . alltagfiles[0] . '-e'
"   endif
" endfunction "}}}

"-----------------------------------------------------------------------------
"       Mappings 
"-----------------------------------------------------------------------------
" Change terminal title when switching between files
augroup AGSetTermTitle
    autocmd!
    autocmd VimEnter,WinEnter,TabEnter,BufEnter * silent! call SetTermTitle()
augroup END

vnoremap <C-a> :call Incr()<CR>
"============================================================================
"============================================================================
