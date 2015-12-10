"===============================================================================
"       MATLAB filetype settings
"==============================================================================
setlocal tabstop=4            " tabs every 4 spaces
setlocal softtabstop=4        " let backspace delete indent
setlocal shiftwidth=4

"-------------------------------------------------------------------------------
"       Macros for running MATLAB in tmux (LEFT PANE ONLY!!)
"-------------------------------------------------------------------------------

let g:matlab_pane = ""
augroup update
    au! 
    " Save global variable of which pane matlab is running in
    au BufEnter     *.m let g:matlab_pane = substitute(system('tpg /Applications/MATLAB'), "\n",'','g')
    au BufWritePost *.m let g:matlab_pane = substitute(system('tpg /Applications/MATLAB'), "\n",'','g')
augroup END

" Map \M to make in background
nnoremap <Leader>M :w <bar> silent! make<bar>redraw!<CR>

" Run current file with \M
setlocal makeprg=rmt\ \-p\ %:r

" Declare signs to mark debugging stops, and cursor
hi clear SignColumn
hi default DebugStopHL ctermfg=red
hi link DebugCursorHL Search
sign define dbstop text=$$ texthl=DebugStopHL
sign define piet   text=>> texthl=DebugCursorHL

"-------------------------------------------------------------------------------
"       Debugging stop
"-------------------------------------------------------------------------------
function! Dbstop()
  write %
  let lnr = line('.')
  let mcom = "dbstop in ".expand("%")." at ".lnr
  call system('ts -t '''.g:matlab_pane.''' '.mcom)
  " place sign at dbstop current line, use lnr as ID
  exe ":silent sign place ".lnr." line=".lnr." name=dbstop file=".expand("%:p")
endfunction
command! Dbstop :call Dbstop()

"-------------------------------------------------------------------------------
"       Clear debugging stop on specific line
"-------------------------------------------------------------------------------
function! Dbclear()
  let mcom = "dbclear in " . expand("%") . " at " . line(".")
  call system('ts -t '''.g:matlab_pane.''' '.mcom)
  silent! sign unplace
endfunction
command! Dbclear :call Dbclear()

"-------------------------------------------------------------------------------
"       Clear all debugging stops in all files
"-------------------------------------------------------------------------------
function! Dbclearall()
  call system('ts -t '''.g:matlab_pane.''' dbclear all')
  silent! sign unplace *
endfunction
command! Dbclearall :call Dbclearall()

"-------------------------------------------------------------------------------
"       Quit debugging mode
"-------------------------------------------------------------------------------
function! Dbquit()
  " Send dbquit to matlab
  call system('ts -t '''.g:matlab_pane.''' dbquit')

  " Remove debugging cursor marker
  silent! sign unplace 1

  " Make file modifiable again
  set ma
endfunction
command! Dbquit :call Dbquit()

"-------------------------------------------------------------------------------
"       Dbstep and move cursor to next line of executable code
"-------------------------------------------------------------------------------
function! Dbstep()
  " keep file from being modified during debugging (TEMPORARY!!)
  set noma

  " Unplace sign at current cursor position
  silent! sign unplace 1

  " Make debugging step
  call system('ts -t '''.g:matlab_pane.''' dbstep')

  " Return line on which debugger has stopped
  "+   Read MATLAB window debugger output i.e.:
  "+     37      f1 = f(z(:,:,i));
  "+     K>> dbstep
  "+     38      f2 = f(z(:,:,i)+(h/2)*f1);
  "+     K>>
  "+   and grep for lines starting with numbers, then read last number
  let lnr = system('tmux capture-pane -p -t '''.g:matlab_pane.''' | grep -o "^\<[0-9]\+\>" | tail -n 1')

  " " move cursor to next line, first column with non-whitespace character
  " call cursor(lnr,0) | norm! ^
  exe ":silent! sign place 1 line=".lnr." name=piet file=".expand("%:p")
endfunction
command! Dbstep :call Dbstep()

"-------------------------------------------------------------------------------
"       Evaluate current selection (Cmd+Opt+Enter in MATLAB)
"       Following! function/command/map do NOT seem to work properly:
"-------------------------------------------------------------------------------
function! EvaluateSelection()
  let mcom = s:GetVisualSelection()
  " Only need to escape ; if there is no space after it (not sure why?)
  let mcom = substitute(mcom, ';', '; ', 'g')
  " Need to escape `%' so vim doesn't insert filename
  let mcom = substitute(mcom, '%', '\%', 'g')
  " Change newlines to literal carriage return so shellescape() does not
  "+ escape them (sends literal \ to tmux send-keys)
  let mcom = substitute(mcom, "\n", '', 'g')

  " Call shellescape() for proper treatment of string characters
  call system('ts -t '''.g:matlab_pane.''' '.shellescape(mcom))
endfunction
command! -range EvaluateSelection :call EvaluateSelection()

"------------------------------------------------------------------------------
"       Return string of visual selection
"------------------------------------------------------------------------------
function! s:GetVisualSelection()
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines, "\n")
endfunction

"-------------------------------------------------------------------------------
"       Keymaps
"-------------------------------------------------------------------------------
" Evaluate Current selection
vnoremap <Leader>e :EvaluateSelection<CR>

" Debugging
nnoremap <Leader>s :Dbstop<CR>
nnoremap <Leader>S :call system('ts -t '''.g:matlab_pane.''' dbstatus')<CR>
nnoremap <Leader>c :Dbclear<CR>
nnoremap <Leader>C :Dbclearall<CR>
nnoremap <Leader>q :Dbquit<CR>
nnoremap <Leader>n :Dbstep<CR>
nnoremap <Leader>r :call system('ts -t '''.g:matlab_pane.''' dbcont')<CR>

" Call Matlab help on current word, or whos on variable
nnoremap <Leader>h :call system('ts -t '''.g:matlab_pane.''' "help <C-R><C-W>"')<CR>
nnoremap <Leader>w :call system('ts -t '''.g:matlab_pane.''' "whos <C-R><C-W>"')<CR>

"==============================================================================
"==============================================================================
