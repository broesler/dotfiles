"===============================================================================
"     File: util_functions.vim
"  Created: 12/06/2015, 13:20
"   Author: Bernie Roesler
"
" Last Modified: 12/10/2015, 00:05
"
"  Description: Custom utility functions called from .vimrc autocmds, etc.
"==============================================================================

"------------------------------------------------------------------------------
" Set terminal title the hard way (SLOW), use only 80 chars
"------------------------------------------------------------------------------
function! SetTermTitle()
    let filename = expand("%:p")
    let length = strlen(filename)
    let cols = &columns - 20          " terminal window size
    if (length < cols)                " show entire path
        let tstr = filename
    else                              " not going to use window < 82 cols
        let tstr = strpart(filename,0,32) . "..." . strpart(filename, length-50)
    endif
    " Set terminal title
    silent execute "!echo -n -e " . "\"\033]0;" . tstr . "\007\""
endfunction

" Change title when switching between files
autocmd VimEnter,WinEnter,TabEnter,BufEnter * silent! call SetTermTitle()

"------------------------------------------------------------------------------
"       Return string of visual selection
"------------------------------------------------------------------------------
function! GetVisualSelection()
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines, "\n")
endfunction

"------------------------------------------------------------------------------
" Auto-update tags file
"------------------------------------------------------------------------------
" function! UpdateTags()
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
" endfunction

"------------------------------------------------------------------------------
" Make template for code file
"------------------------------------------------------------------------------
function! MakeTemplate(filename)
  execute 'source' a:filename
  execute "1,10s@File:.*@File: " . expand("%:t")
  execute "1,10s@Created:.*@Created: " . strftime("%m/%d/%Y, %H:%M")
endfunction

"------------------------------------------------------------------------------
" If buffer modified, update any 'Last modified: ' in the first 20 lines.
" Restores cursor and window position using save_cursor variable.
"------------------------------------------------------------------------------
function! LastModified()
  if &modified
    let save_cursor = getpos(".")
    " Only check maximum of 20 lines, or to the end of the file (if < 20)
    let n = min([20, line("$")])
    " Update line without moving cursor, do not report errors
    keepjumps exe '1,' . n . 's#\(Last Modified:\|Last Updated:\).*#\1 '
                \ . strftime("%m/%d/%Y, %H:%M") . '#ie'

    " Remove update from cmd history
    call histdel('search', -1)      

    " These commands are suggested in the help, but do not seem to work when
    "+  using an undo history file... need to find a way to delete this change
    "+  from the undo history file.
    " let old_undolevels = &undolevels
    " set undolevels=&undolevels-1
    " exe "normal a \<BS>\<Esc>"
    " let &undolevels = old_undolevels
    " unlet old_undolevels

    call setpos('.', save_cursor)
  endif
endfun

"------------------------------------------------------------------------------
" Incr increments numbers in a column (i.e. in Visual Block mode)
"   To use: highlight in Visual Block, and press <C-a>
"------------------------------------------------------------------------------
function! Incr()
    let a = line('.') - line("'<")
    let c = virtcol("'<")
    if a > 0
        execute 'normal! '.c.'|'.a."\<C-a>"
    endif
    normal `<
endfunction

vnoremap <C-a> :call Incr()<CR>

"------------------------------------------------------------------------------
" Jump from html class/id tag to definition in linked CSS file
    " use <Leader>] to execute
"------------------------------------------------------------------------------
function! JumpToCSS()
    let id_pos = searchpos("id", "nb", line('.'))[1]
    let class_pos = searchpos("class", "nb", line('.'))[1]

    if class_pos > 0 || id_pos > 0
        if class_pos < id_pos
            execute ":vim '#".expand('<cword>')."' **/*.css"
        elseif class_pos > id_pos
            execute ":vim '.".expand('<cword>')."' **/*.css"
        endif
    endif
endfunction

nnoremap <Leader>] :call JumpToCSS()<CR>

"===============================================================================
"===============================================================================
