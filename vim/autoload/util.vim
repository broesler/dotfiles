"=============================================================================
"     File: ~/.vim/autoload/util.vim
"  Created: 12/06/2015, 13:20
"   Author: Bernie Roesler
"
" Last Modified: 05/16/2016, 10:28
"
"  Description: Custom utility functions called from .vimrc autocmds, etc.
"=============================================================================
"       Functions  {{{
"-----------------------------------------------------------------------------
function! util#CommentBlock(...) "{{{
    " don't let vim insert comment characters automatically
    let l:save_fo = &formatoptions
    set formatoptions-=ro

    " Move cursor to first non-blank character on line
    execute 'normal! ^'

    " Get commentstring based on filetype
    let l:idx = match(&commentstring, '%s')
    let l:comm_default = &commentstring[0:l:idx-1]
    let l:comm_default = substitute(l:comm_default, '%%', '%', 'g')

    " Create a comment block such as the header above
    let l:intro = (a:0 >= 1) ? a:1 : l:comm_default
    let l:boxch = (a:0 >= 2) ? a:2 : '-'
    let l:width = (a:0 >= 3) ? a:3 : &textwidth - col('.') - strlen(l:intro) + 1

    " If we don't have a textwidth for some reason, just set a width
    if l:width <= 0
        let l:width = 79 - strlen(l:intro)
    endif

    echom "intro: " . l:intro . ", boxch: " . l:boxch . ", width: " . width
    " Build the comment box and put the comment inside it
    let l:border = l:intro . repeat(l:boxch,l:width) 
    let l:title  = l:intro . repeat(" ",8) 

    " Make header and leave cursor at end of line
    execute 'normal! i' . l:border "\<CR>" . l:title . "o" . l:border
    execute 'normal! k$'

    let &formatoptions = l:save_fo
endfunction
"}}}
function! util#EnsureDirExists() "{{{
    let required_dir = expand("%:h")
    if !isdirectory(required_dir)
        " Alert user of error and prompt to create directory
        let l:msg = "Directory '" . required_dir . "' doesn't exist."
        let l:opt = "&Create it?\n&Open buffer anyway?"
        let l:confirm = util#AskQuit(l:msg, l:opt)

        if l:confirm == 1
            try " to make the directory
                call mkdir( required_dir, 'p' )
            catch
                let l:msg = "Can't create '" . required_dir . "'"
                let l:opt = "&Continue anyway?"
                call util#AskQuit(l:msg, l:opt)
            endtry
        endif
        " if confirm == 0 (user pressed <ESC> or <C-c>), 
        " or confirm == 2 (user wants to open buffer without a directory)
        " just return and open the file without a directory
    endif
endfunction
"}}}
function! util#AskQuit(msg, proposed_action) "{{{
    " Confirm returns "1" if Quit is selected via pressing [q] or <CR>
    let l:conf = confirm(a:msg, "&Quit?\n" . a:proposed_action)
    if l:conf == 1
        exit
    else 
        return l:conf
    endif
endfunction
"}}}
function! util#FollowSymlink() "{{{
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
function! util#LastModified() "{{{
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
        " and turn it back on after the change so it is not recorded:
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
function! util#MakeTemplate(filename) "{{{
    execute 'source' a:filename
    execute "%s@File:.*@File: " . expand("%:t")
    execute "%s@Created:.*@Created: " . strftime("%m/%d/%Y, %H:%M")
endfunction
"}}}
" FIXME function! util#UpdateTags() " {{{
"   TODO search along same path that vim searches for tags files
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
function! s:Incr() "{{{
    let a = line('.') - line("'<")
    let c = virtcol("'<")
    if a > 0
        execute 'normal! '.c.'|'.a."\<C-a>"
    endif
    normal `<
endfunction
"}}}
function! s:SetTermTitle() "{{{
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
"}}}--------------------------------------------------------------------------
"       Mappings {{{
"-----------------------------------------------------------------------------
" Change terminal title when switching between files
augroup AGSetTermTitle
    autocmd!
    autocmd VimEnter,WinEnter,TabEnter,BufEnter * silent! call <SID>SetTermTitle()
augroup END

" Comment block command
command! -nargs=* MyCommentBlock call util#CommentBlock(<f-args>)

" Increment numbers in block visual mode
noremap <silent> <Plug>UtilIncr :call <SID>Incr()<CR>
"}}}
