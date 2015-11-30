"===============================================================================
"       MATLAB filetype settings
"==============================================================================
setlocal tabstop=4            " tabs every 4 spaces
setlocal softtabstop=4        " let backspace delete indent
setlocal shiftwidth=4

"-------------------------------------------------------------------------------
" Macros for running MATLAB in tmux (LEFT PANE ONLY!!)
"-------------------------------------------------------------------------------
" Map \M to make in background
nnoremap <Leader>M :w <bar> silent! make<bar>:redraw!<CR>

" Run current file with \M
setlocal makeprg=run_matlab_tmux\ %:r

" Debugging stop
function! Dbstop()
  let mcom = "dbstop in ".expand("%")." at ".line(".")
  " call command (ts already has carriage return built-in)
  call system('ts "'.mcom.'"')
endfunction

" Clear debugging stop on specific line
function! Dbclear()
  let mcom = "dbclear in " . expand("%") . " at " . line(".")
  " call command (ts already has carriage return built-in)
  call system('ts "'.mcom.'"')
endfunction

" Dbstep and move cursor to next line of executable code
function! Dbstep()
  " Make debugging step
  call system('ts dbstep')

  " Return line on which debugger has stopped
  "   Read MATLAB window debugger output i.e.:
  "     37      f1 = f(z(:,:,i));
  "     K>> dbstep
  "     38      f2 = f(z(:,:,i)+(h/2)*f1);
  "     K>>
  "
  "   and grep for lines starting with numbers, then read last number
  let ln = system('tmux capture-pane -t bottom-left -p | command grep -o "^\<\d\+\>" | tail -n 1')

  " move cursor to next line, first column with non-whitespace character
  call cursor(ln,0) | norm! ^
endfunction

" Evaluate current selection (Cmd+Opt+Enter in MATLAB)
" Following function/command/map do NOT seem to work properly:
function! EvaluateSelection()
  let mcom = getline('.')
  " Remove trailing newline, but not interior newlines
  let mcom = substitute(mcom, "\n$", '', 'g')
  " Only need to escape ; if there is no space after it (not sure why?)
  let mcom = substitute(mcom, ';', '; ', 'g')
  " Need to escape `%' so vim doesn't insert filename
  let mcom = substitute(mcom, '%', '\%', 'g')

  " NOTE: Need to double-quote argument to ts so single-quoted MATLAB strings 
  " are interpreted correctly!!
  " exe 'silent !ts "'.mcom.'"'
  call system('ts "'.mcom.'"')
endfunction
command! -range EvaluateSelection <line1>,<line2>call EvaluateSelection()

" Evaluate current selection
vnoremap <Leader>e :EvaluateSelection<CR>:redraw!<CR>

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


" Debugging maps
nnoremap <Leader>s :w <bar> call Dbstop()<CR>
nnoremap <Leader>c :w <bar> call Dbclear()<CR>
nnoremap <Leader>C :call system('ts "dbclear all"')<CR>
nnoremap <Leader>q :call system('ts "dbquit"')<CR>
nnoremap <Leader>n :call Dbstep()<CR>
nnoremap <Leader>r :call system('ts "dbcont"')<CR>

" Call Matlab help on current word, or whos on variable
nnoremap <Leader>h :call system('ts ''help <C-R><C-W>''')<CR>
nnoremap <Leader>w :call system('ts ''whos <C-R><C-W>''')<CR>

"==============================================================================
"==============================================================================
