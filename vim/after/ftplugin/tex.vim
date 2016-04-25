"==============================================================================
"       LaTeX Filetype Settings
"==============================================================================
let g:tex_stylish=1
setlocal textwidth=80         " no auto-newlines
setlocal tabstop=2            " tabs every 2 spaces
setlocal softtabstop=2        " let backspace delete indent
setlocal shiftwidth=2
setlocal foldmethod=marker    " fold between {{{ }}} comments
setlocal fo-=t                " only wrap comments, not text

" : is included as keyword for fig: eqn: etc.,
setlocal iskeyword+=_

" Change default SuperTabs completion to context (or try <C-x><C-o>)
let g:SuperTabDefaultCompletionType="context"

" Compiler options. Use ':make mydocument' to compile
let b:tex_flavor="pdflatex"
let b:tex_ignore_makefile=1       " ignore any makefiles in the tex dir

" Call latexmk to build tex files properly. See ~/.latexmkrc for options
"  include %:S to use shell-escaped current filename as main latex file
setlocal makeprg=latexmk\ \-pdf\ '%'

" Errors as produced by pdflatex
let efm_errors="%E!\ LaTeX\ Error:\ %m,\%E!\ %m,%E!pdfTeX Error:\ %m"

" Warmings output by latexmk script
let efm_warnings="%W%.%#Citation\ %m on\ input\ line\ %l,"
               \."%W%.%#Reference\ %m on\ input\ line\ %l"

" " For use with normal pdflatex output (i.e. not via latexmk):
" let efm_warnings="%WLaTeX\ Warning:\ Citation\ %m\ on\ input\ line\ %l%.%#,"
"                \."%WPackage\ natbib\ Warning:\ Citation %m on\ input\ line\ %l%.%#,"
"                \."%WPackage\ %.%#Warning:\ Citation %m,%C %m on input line %l%.%#,"
"                \."%WLaTeX\ Warning:\ Reference %m on\ input\ line\ %l%.%#,"
"                \."%WLaTeX\ %.%#Warning:\ Reference %m,%C %m on input line %l%.%#"

let &l:errorformat="%f:%l:%m".",".efm_errors.",".efm_warnings

"------------------------------------------------------------------------------
"       Local autocmds
"------------------------------------------------------------------------------
" autocmd BufWritePost,FileWritePost <buffer> silent! call UpdateTags()

"------------------------------------------------------------------------------
"       LaTeX-specific functions
"------------------------------------------------------------------------------
" Make LaTeX file using latexmk (see .latexmkrc, and above makeprg)
function! LatexMakeLatexmk()
  if (&ft != "tex")
    echoe "File ". expand("%") . " is not a .tex file! Not compiling."
  else
    write
    lcd %:p:h
    silent! make %
    redraw!
    lcd -
  endif
endfunction

" Jump to PDF in Skim (for LaTeX files with synctex)
function! JumpToSkim()
  let linen = line('.')
  let filen = expand("%:r").".pdf"
  write
  execute "!/Applications/Skim.app/Contents/SharedSupport/displayline " . linen . " " . filen
  redraw!
endfunction

" make current .tex file
function! LatexMakeOnce()
  let fileext = expand("%:e")
  if (fileext ==# "tex")
    write                               " save file
    lcd %:p:h                           " cd to that of tex file
    let fileroot = expand("%:r")
    execute "!pdflatex " . fileroot
  else
    echom "FileType is NOT .tex! Aborted pdflatex."
  endif
endfunction

" make current .tex file with 2 latex runs
function! LatexMakeFull()
  let fileext = expand("%:e")
  if (fileext ==# "tex")
    write
    lcd %:p:h
    let fileroot = expand("%:r")
    execute "!makepdf " . fileroot
  else
    echom "FileType is NOT .tex! Aborted pdflatex."
  endif
endfunction

" make current .tex file with 2 latex runs + bibtex + latex
function! LatexMakeBib()
  let fileext = expand("%:e")
  if (fileext ==# "tex")
    write
    lcd %:p:h
    let fileroot = expand("%:r")
    execute "!makepdfbib " . fileroot
  else
    echom "FileType is NOT .tex! Aborted pdflatex."
  endif
endfunction

"-------------------------------------------------------------------------------
"       Keymaps
"-------------------------------------------------------------------------------
nnoremap <buffer> <Leader>M :silent call LatexMakeLatexmk()<CR>
nnoremap <buffer>        ,r :silent! call JumpToSkim()<CR>
nnoremap <buffer> <Leader>F :call LatexMakeFull()<CR>
nnoremap <buffer> <Leader>T :call LatexMakeOnce()<CR>
nnoremap <buffer> <Leader>B :call LatexMakeBib()<CR>

" wrap \left( \right) around visually selected text
vnoremap <buffer> sp "zdi\left(<C-R>z\right)<Esc> 

"------------------------------------------------------------------------------
"       Macros -- All special characters are intentional
"------------------------------------------------------------------------------
" Align macro
let @a='i\begin{align}\end{align}k'

" bar matrix macro
let @b='a\begin{m€kbbmatrix} \end{bmatrix}Bh'

" Equation macro
let @e='i\begin{equation}\end{equation}k'

" gather macro
let @g='i\begin{gather}\end{gather}k'

" Figure macro
let @f='o\begin{figure}[h!]
      \\centering
      \\includegraphics[width=0.75\textwidth]{myfilename.pdf}
      \\caption{My caption goes here.}
      \\label{fig:label}
      \0i\end{figure}'

" Subfigure macro
let @s='o\begin{figure}[h!]
      \\centering
      \  \begin{subfigure}[c]{0.48\textwidth}
      \\centering
      \\includegraphics[width=\textwidth]{myfilename_a.pdf}
      \\caption{My caption for subfigure (a).}
      \\end{subfigure}
      \0i  \hspace{0.01cm}
      \  \begin{subfigure}[c]{0.48\textwidth}
      \\centering
      \\includegraphics[width=\textwidth]{myfilename_b.pdf}
      \\caption{My caption for subfigure (b).}
      \\end{subfigure}
      \0i  \caption{My caption for the entire figure.}
      \\label{fig:whole_figure}
      \0i\end{figure}'

" Table macro
let @t='o\begin{table}[h!]
      \\setlength{\tabcolsep}{8pt}
      \\def\arraystretch{1.1}
      \\caption{Coefficient of variation of thrust and side force for the data presented in \citet{Broering2012c}}
      \\label{tab:broering}
      \\begin{center}
      \  \begin{tabular}{l r r}
      \\firsthline
      \\multicolumn{1}{c}{case} & \multicolumn{1}{c}{$\Upsilon_T$} & \multicolumn{1}{c}{$\Upsilon_S$} \\ \hline
      \single foil         &    1.0800  &    4.8324  \\
      \  $\phi =   0\deg$  &    0.9593  &    4.4851  \\
      \  $\phi =  90\deg$  &    1.4826  &    5.7911  \\
      \  $\phi = 180\deg$  &    1.0644  &    5.7090  \\
      \\lasthline
      \0i\end{tabular}
      \0i  \end{center}
      \0i\end{table}'

" Make comment header with equals signs
let @h="o%79a=yypO%"

"==============================================================================
"==============================================================================
