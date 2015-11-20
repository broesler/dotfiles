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
nnoremap <Leader>M :silent! make<bar>:redraw!<CR>

" Run current file with \M
set makeprg=run_matlab_tmux\ %:r

" Debugging stop
function! Dbstop()
    let mcom = "dbstop in " . expand("%:r") . " at " . line(".")
    " call command (ts already has carriage return built-in
    execute "silent !ts \"" . mcom . "\""
endfunction

" Clear debugging stop on specific line
function! Dbclear()
    let mcom = "dbclear in " . expand("%:r") . " at " . line(".")
    " call command (ts already has carriage return built-in
    execute "silent !ts \"" . mcom . "\""
endfunction

" Evaluate current selection (Cmd+Opt+Enter in MATLAB)
" Following function/command/map do NOT seem to work properly:
function! EvaluateSelection()
    let mcom = getline(".")
    " Remove trailing newline, but not interior newlines
    let mcom = substitute(mcom, '\n$', "", "g")
    " Need to escape `;' and `%' for tmux
    let mcom = substitute(mcom, '[;%]', '\\&', "g")
    exe "silent !ts \"" . mcom . "\""
endfunction
command! -range EvaluateSelection <line1>,<line2>call EvaluateSelection()

" Evaluate current selection
vnoremap <Leader>r :EvaluateSelection<C-M><bar>:redraw!<C-M>

" function! EvaluateSelection()
"     let mcom = @"
"     " Remove trailing newline, but not interior newlines
"     let mcom = substitute(mcom, '\n$', "", "g")
"     " Need to escape `;' for tmux
"     let mcom = substitute(mcom, '[;%]', '\\&', "g")
"     exe "silent !ts \"" . mcom . "\""
" endfunction
" vnoremap <Leader>r y:call EvaluateSelection()<CR>
" " vnoremap <Leader>r y:call EvaluateSelection()<CR>:redraw!<CR>

" Debuggine maps
nnoremap <Leader>d :w <bar> call Dbstop()  <bar> redraw!<CR>
nnoremap <Leader>c :w <bar> call Dbclear() <bar> redraw!<CR>
nnoremap <Leader>C :execute 'silent !ts "dbclear all"' <bar> redraw!<CR>
nnoremap <Leader>n :execute 'silent !ts "dbstep"' <bar> redraw!<CR>
nnoremap <Leader>q :execute 'silent !ts "dbquit"' <bar> redraw!<CR>
nnoremap <Leader>r :execute 'silent !ts "dbcont"' <bar> redraw!<CR>

"==============================================================================
"==============================================================================
