"=============================================================================
"   File: ~/.vim/after/ftplugin/tex.vim
" Created: 10/12/2016, 13:46
"  Author: Bernie Roesler
"
"  Description: vim settings for LaTeX filetype
"=============================================================================
" Buffer-local settings {{{
let g:tex_stylish=1
setlocal textwidth=80
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal formatoptions+=t     " wrap text to an actual new code line

" Take these OFF of wildignore, so we can complete filenames for figures
set wildignore-=*.jpg,*.bmp,*.gif,*.png,*.jpeg

" : is included as keyword for fig: eqn: etc.,
setlocal iskeyword+=:,_

" setlocal foldmethod=manual
setlocal foldmethod=syntax
setlocal foldnestmax=3          " allow folds down to subsections
setlocal foldminlines=4         " only fold 4+ lines
let g:tex_fold_enabled=1

" Change default SuperTabs completion to context (or try <C-x><C-o>)
let g:SuperTabDefaultCompletionType="context"

" Compiler options. Use ':make mydocument' to compile
let b:tex_flavor="latex"
let b:tex_ignore_makefile=1       " ignore any makefiles in the tex dir

" Call latexmk to build tex files properly. See ~/.latexmkrc for options
"  include %:S to use shell-escaped current filename as main latex file
setlocal makeprg=latexmk\ \-pdf\ '%'

" Errors as produced by pdflatex
let efm_errors="%E!\ LaTeX\ Error:\ %m,\%E!\ %m,%E!pdfTeX Error:\ %m"

" Warmings output by latexmk script
let efm_warnings="%W%.%#Citation\ %m on\ input\ line\ %l,"
             \ . "%W%.%#Reference\ %m on\ input\ line\ %l"

" " For use with normal pdflatex output (i.e. not via latexmk):
" let efm_warnings="%WLaTeX\ Warning:\ Citation\ %m\ on\ input\ line\ %l%.%#,"
"                \."%WPackage\ natbib\ Warning:\ Citation %m on\ input\ line\ %l%.%#,"
"                \."%WPackage\ %.%#Warning:\ Citation %m,%C %m on input line %l%.%#,"
"                \."%WLaTeX\ Warning:\ Reference %m on\ input\ line\ %l%.%#,"
"                \."%WLaTeX\ %.%#Warning:\ Reference %m,%C %m on input line %l%.%#"

let &l:errorformat="%f:%l:%m," . efm_errors . "," . efm_warnings

"}}}--------------------------------------------------------------------------
"       LaTeX-specific functions {{{
"-----------------------------------------------------------------------------
function! JumpToSkim() "{{{
  let linen = line('.')
  let filen = expand("%:r").".pdf"
  write
  execute "!/Applications/Skim.app/Contents/SharedSupport/displayline " . linen . " " . filen
  redraw!
endfunction
"}}}
function! LatexMakeLatexmk() "{{{
  if (&ft != "tex")
    echoe "File ". expand("%") . " is not a .tex file! Not compiling."
  else
    write
    lcd %:p:h
    silent! make! %
    redraw!
    lcd -
  endif
endfunction
"}}}
function! LatexMakeOnce() "{{{
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
"}}}
function! LatexMakeFull() "{{{
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
"}}}
function! LatexMakeBib() "{{{
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
"}}}
"}}}--------------------------------------------------------------------------
"       Keymaps {{{
"-----------------------------------------------------------------------------
" nnoremap <buffer> <Leader>M :silent call LatexMakeLatexmk()<CR>
"
" Build pdf using LaTeX-Box built-in function (calls latexmk)
nnoremap <buffer> <LocalLeader>M :Latexmk<CR>

" Find spot in pdf corresponding to source code 
"   (use cmd+shift+click to go back)
nnoremap <buffer> ,r :silent! call JumpToSkim()<CR>

" wrap \left( \right) around visually selected text
vnoremap <buffer> sp "zdi\left(<C-R>z\right)<Esc> 

"}}}--------------------------------------------------------------------------
"       Macros {{{
"-----------------------------------------------------------------------------
" Short macros {{{
" Align macro
let @a='i\begin{align}\end{align}k'

" bar matrix macro
let @b='a\begin{bmatrix} \end{bmatrix}Bh'

" Equation macro
let @e='i\begin{equation}\end{equation}k'

" gather macro
let @g='i\begin{gather}\end{gather}k'
"}}}
" Figure macro "{{{
let @f="\\begin{figure}[h!]\n"
      \ . "  \\centering\n"
      \ . "  \\includegraphics[width=0.75\\textwidth]{myfilename.pdf}\n"
      \ . "  \\caption{My caption goes here.}\n"
      \ . "  \\label{fig:label}\n"
      \ . "\\end{figure}""
"}}}
" Subfigure macro {{{
let @s="\\begin{figure}[h!]\n"
      \ . "  \\centering\n"
      \ . "    \\begin{subfigure}[c]{0.48\\textwidth}\n"
      \ . "  \\centering\n"
      \ . "  \\includegraphics[width=\\textwidth]{myfilename_a.pdf}\n"
      \ . "  \\caption{My caption for subfigure (a).}\n"
      \ . "  \\end{subfigure}\n"
      \ . "    \\hspace{0.01cm}\n"
      \ . "    \\begin{subfigure}[c]{0.48\\textwidth}\n"
      \ . "  \\centering\n"
      \ . "  \\includegraphics[width=\\textwidth]{myfilename_b.pdf}\n"
      \ . "  \\caption{My caption for subfigure (b).}\n"
      \ . "  \\end{subfigure}\n"
      \ . "    \\caption{My caption for the entire figure.}\n"
      \ . "  \\label{fig:whole_figure}\n"
      \ . "\\end{figure}\n"
"}}}
" Table macro {{{
let @t="\begin{table}[h!]\n"
      \ . "  \\setlength{\\tabcolsep}{8pt}\n"
      \ . "  \\def\\arraystretch{1.1}\n"
      \ . "  \\caption{My table caption.}\n"
      \ . "  \\label{tab:tab}\n"
      \ . "    \\begin{center}\n"
      \ . "    \\begin{tabular}{l r r}\n"
      \ . "      \\firsthline\n"
      \ . "      \\multicolumn{1}{c}{case} & \\multicolumn{1}{c}{$\\Upsilon_T$} & \\multicolumn{1}{c}{$\\Upsilon_S$} \\\\ \\hline\n"
      \ . "      single foil         &    1.0800  &    4.8324  \\\\\n"
      \ . "        $\\phi =   0\\deg$  &    0.9593  &    4.4851  \\\\\n"
      \ . "        $\\phi =  90\\deg$  &    1.4826  &    5.7911  \\\\\n"
      \ . "        $\\phi = 180\\deg$  &    1.0644  &    5.7090  \\\\\n"
      \ . "      \\lasthline\n"
      \ . "      \\end{tabular}\n"
      \ . "    \\end{center}\n"
      \ . "  \\end{table}\n"
"}}}
"}}}
"=============================================================================
"=============================================================================
