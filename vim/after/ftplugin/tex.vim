"------------------------------------------------------------------------------
"       LaTeX Filetype Settings
"------------------------------------------------------------------------------
let g:tex_stylish=1

" wrap \left( \right) around visually selected text
vmap <buffer> sp "zdi\left(<C-R>z\right)<Esc> 

" " Declare latex language for ctags, taglist.vim usage
" let tlist_tex_settings   = 'latex;s:sections;g:graphics;l:labels'
" let tlist_bib_settings   = 'bibtex;s:BiBTeX_strings;e:BibTeX-Entries;a:BibTeX-Authors;t:BibTeX-Titles'
" let tlist_make_settings  = 'make;m:macros;t:targets'

" : is included as keyword for fig: eqn: etc.,
setlocal iskeyword+=_

" dictionary search (for writing)
setlocal complete+=k

" Turn off matching paren highlighting for LaTeX files
" Doesn't work...
let g:LatexBox_loaded_matchparen=1

" Change default SuperTabs completion to context (or try <C-x><C-o>)
let g:SuperTabDefaultCompletionType="context"

"------------------------------------------------------------------------------
"       Macros
"------------------------------------------------------------------------------
" Align macro
let @a='i\begin{align}\end{align}k'

" bar matrix macro
let @b='a\begin{m€kbbmatrix} \end{bmatrix}Bh'

" Equation macro
let @e='i\begin{equation}\end{equation}k'

" Figure macro
let @f='o\begin{figure}[h!]
      \\centering
      \\includegraphics[width=\textwidth]{pinned_bar_modes.pdf}
      \\caption{First few vibrational mode shapes of a pinned-pinned bar.}
      \\label{fig:modeshapes}
      \0i\end{figure}'

" Subfigure macro
let @s='o\begin{figure}[h!]
      \\centering
      \  \begin{subfigure}[c]{0.45\textwidth}
      \\centering
      \\includegraphics[width=\textwidth]{state_errorr.pdf}
      \\caption{Linear error vs.\ time plot.}
      \\end{subfigure}
      \0i  \hspace{0.1cm}
      \  \begin{subfigure}[c]{0.45\textwidth}
      \\centering
      \\includegraphics[width=\textwidth]{state_errorr_semilog.pdf}
      \\caption{Semilog error vs.\ time plot.}
      \\end{subfigure}
      \0i  \caption{Two error plots to compare linear and semilog plot. The semilog plot shows $|e(k)|$ for ease of determining the order of convergence.}
      \\label{fig:error_r1}
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

"------------------------------------------------------------------------------
"       Local key mappings
"------------------------------------------------------------------------------
imap <buffer> [[ \begin{
imap <buffer> ]] <Plug>LatexCloseCurEnv

"------------------------------------------------------------------------------
"       LaTeX-specific Functions
"------------------------------------------------------------------------------
" make current .tex file
function! LatexMakeOnce()
  let fileext = expand("%:e")
  if (fileext ==# "tex")
    write                               " save file
    lcd %:p:h                           " cd to that of tex file
    let fileroot = expand("%:r")
    silent execute "!pdflatex " . fileroot
  else
    echom "FileType is NOT .tex! Aborted pdflatex."
  endif
endfunction

nnoremap <buffer> <Leader>T :call LatexMakeOnce()<CR>

" make current .tex file properly
function! LatexMakeFull()
  let fileext = expand("%:e")
  if (fileext ==# "tex")
    write
    lcd %:p:h
    let fileroot = expand("%:r")
    silent execute "!makepdf " . fileroot
  else
    echom "FileType is NOT .tex! Aborted pdflatex."
  endif
endfunction

nnoremap <buffer> <Leader>F :call LatexMakeFull()<CR>

" make current .tex file properly
function! LatexMakeBib()
  let fileext = expand("%:e")
  if (fileext ==# "tex")
    write
    lcd %:p:h
    let fileroot = expand("%:r")
    silent execute "!makepdfbib " . fileroot
  else
    echom "FileType is NOT .tex! Aborted pdflatex."
  endif
endfunction

nnoremap <buffer> <Leader>B :call LatexMakeBib()<CR>
