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
  let lnr = line('.')
  let mcom = "dbstop in ".expand("%")." at ".lnr
  call system('ts -t '''.g:matlab_pane.''' '.mcom)
  " place sign at dbstop current line, use lnr as ID
  exe ":silent sign place ".lnr." line=".lnr." name=dbstop file=".expand("%:p")
endfunction

"-------------------------------------------------------------------------------
"       Clear debugging stop on specific line
"-------------------------------------------------------------------------------
function! Dbclear()
  let mcom = "dbclear in " . expand("%") . " at " . line(".")
  call system('ts -t '''.g:matlab_pane.''' '.mcom)
  silent! sign unplace
endfunction

"-------------------------------------------------------------------------------
"       Clear all debugging stops in all files
"-------------------------------------------------------------------------------
function! Dbclearall()
  call system('ts -t '''.g:matlab_pane.''' dbclear all')
  silent! sign unplace *
endfunction

"-------------------------------------------------------------------------------
"       Quit debugging mode
"-------------------------------------------------------------------------------
function! Dbquit()
  call system('ts -t '''.g:matlab_pane.''' dbquit')
  " Remove debugging cursor marker
  silent! sign unplace 1
  " Make file modifiable again
  set ma
endfunction

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
  exe ":silent sign place 1 line=".lnr." name=piet file=".expand("%:p")
endfunction

"-------------------------------------------------------------------------------
"       Evaluate current selection (Cmd+Opt+Enter in MATLAB)
"       Following function/command/map do NOT seem to work properly:
"-------------------------------------------------------------------------------
function! EvaluateSelection()
  let mcom = getline('.')
  " Remove trailing newline, but not interior newlines
  let mcom = substitute(mcom, "\n$", '', 'g')
  " Only need to escape ; if there is no space after it (not sure why?)
  let mcom = substitute(mcom, ';', '; ', 'g')
  " Need to escape `%' so vim doesn't insert filename
  let mcom = substitute(mcom, '%', '\%', 'g')
  echom mcom

  " call system('ts -t '''.g:matlab_pane.''' '.mcom)
endfunction
command! -range EvaluateSelection <line1>,<line2>call EvaluateSelection()

" Attempt at passing one LOOOOONG string to ts for faster MATLAB interpretation
" function! EvaluateSelection()
"     let mcom = @"
"     " Remove trailing newline, but not interior newlines
"     let mcom = substitute(mcom, '\n$', "", "g")
"     " Need to escape `;' for tmux
"     let mcom = substitute(mcom, '[;%]', '\\&', "g")
"     exe "silent !ts \"" . mcom . "\""
" endfunction
" vnoremap <Leader>e y:call EvaluateSelection()<CR>
" " vnoremap <Leader>e y:call EvaluateSelection()<CR>:redraw!<CR>


"-------------------------------------------------------------------------------
"       Keymaps
"-------------------------------------------------------------------------------
" Evaluate Current selection
" vnoremap <Leader>e :EvaluateSelection<CR>:redraw!<CR>
vnoremap <Leader>e :EvaluateSelection<CR>

" Debugging
nnoremap <Leader>s :w <bar> call Dbstop()<CR>
nnoremap <Leader>S :call system('ts -t '''.g:matlab_pane.''' dbstatus')<CR>
nnoremap <Leader>c :w <bar> call Dbclear()<CR>
nnoremap <Leader>C :w <bar> call Dbclearall()<CR>
nnoremap <Leader>q :call Dbquit()<CR>
nnoremap <Leader>n :call Dbstep()<CR>
nnoremap <Leader>r :w <bar> call system('ts -t '''.g:matlab_pane.''' dbcont')<CR>

" Call Matlab help on current word, or whos on variable
nnoremap <Leader>h :w <bar> call system('ts -t '''.g:matlab_pane.''' "help <C-R><C-W>"')<CR>
nnoremap <Leader>w :w <bar> call system('ts -t '''.g:matlab_pane.''' "whos <C-R><C-W>"')<CR>

"==============================================================================
"==============================================================================
