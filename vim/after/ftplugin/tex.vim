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
setlocal formatoptions+=t   " wrap text to an actual new code line for speed
setlocal wrap               " wrap long lines to screen width

" Take these OFF of wildignore, so we can complete filenames for figures
set wildignore-=*.jpg,*.bmp,*.gif,*.png,*.jpeg

" : is included as keyword for fig: eqn: etc.,
setlocal iskeyword+=:,_

setlocal foldmethod=marker
setlocal foldnestmax=3          " allow folds down to subsections
setlocal foldminlines=4         " only fold 4+ lines
" setlocal foldlevel=99
setlocal foldlevelstart=99
let g:tex_fold_enabled=0

" Change default SuperTabs completion to context (or try <C-x><C-o>)
let g:SuperTabDefaultCompletionType="context"

" Compiler options. Use ':make mydocument' to compile
let b:tex_flavor="latex"
let b:tex_ignore_makefile=1       " ignore any makefiles in the tex dir

" Call latexmk to build tex files properly. See ~/.latexmkrc for options
"  include %:S to use shell-escaped current filename as main latex file
setlocal makeprg=latexmk\ \-pdf\ '%'

" vimtex options {{{
let g:vimtex_view_automatic = 0
let g:vimtex_view_method = 'skim'

let g:vimtex_compiler_latexmk = {
    \ 'backend' : 'jobs',
    \ 'background' : 1,
    \ 'build_dir' : '',
    \ 'callback' : 1,
    \ 'continuous' : 0,
    \ 'executable' : 'latexmk',
    \ 'options' : [
    \   '-pdf',
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \ ],
    \}
"}}}

"----------------------------------------------------------------------------- 
"        Override LaTeX-Box efm:
"-----------------------------------------------------------------------------
" Errors as produced by pdflatex
setlocal efm=%f:%l:%m
setlocal efm+=%E!\ LaTeX\ Error:\ %m
setlocal efm+=%E!\ %m

" More info
setlocal efm+=%-C<%m>
setlocal efm+=%-C%p}
setlocal efm+=%Cl.%l\ %m

" Warnings for citations only
setlocal efm+=%W%.%#Citation\ %m\ on\ input\ line\ %l
setlocal efm+=%W%.%#Reference\ %m\ on\ input\ line\ %l

" Ignore unmatched lines -- don't include this line to show full error message
" setlocal efm+=%-G%.%#

"}}}--------------------------------------------------------------------------
"       LaTeX-specific functions {{{
"-----------------------------------------------------------------------------
" TODO allow line number input
function! s:JumpToSkim() "{{{
    let l:linen = line('.')
    let l:texname = fnameescape(expand('%:t'))
    if exists("*LatexBox_GetMainTexFile")
        " Get main tex filename and change extension to pdf (could be
        " different than the current file)
        let l:mainroot = fnameescape(fnamemodify(LatexBox_GetMainTexFile(), ':t:r'))
        let l:pdfname = l:mainroot . ".pdf"
    else
        " No LatexBox, assume same name as current tex file
        let l:pdfname = fnamemodify(l:texname, ':r') . ".pdf"
    endif
    echom "Jumping to line " . l:linen . " in file '" . l:pdfname . "'"
    " Call Skim app $ displayline [-rbg] line pdf [tex]
    silent execute "!/Applications/Skim.app/Contents/SharedSupport/displayline -b " 
                \ . l:linen . " " . l:pdfname . " " . l:texname
    redraw!
endfunction
"}}}
"}}}--------------------------------------------------------------------------
"       Commands and Keymaps {{{
"-----------------------------------------------------------------------------
command! JumpToSkim call <SID>JumpToSkim()

" Build pdf using LaTeX-Box built-in function
" :Latexmk[!] does as many runs as necessary to compile the tex, and also
" properly parses the output to *only* get warnings/errors from the final run
nnoremap <buffer> <LocalLeader>M :update<bar>:Latexmk<CR>
" nnoremap <buffer> <LocalLeader>M :VimtexCompileSS<CR>

" Find spot in pdf corresponding to source code 
"   (use cmd+shift+click to go back)
nnoremap <buffer> <silent> ,r :JumpToSkim<CR>

" wrap \left( \right) around visually selected text
vnoremap <buffer> sp "zdi\left(<C-R>z\right)<Esc> 

"}}}--------------------------------------------------------------------------
"       Macros {{{
"-----------------------------------------------------------------------------
" Short macros (use @a) {{{
" Align macro
let @a='i\begin{align}\end{align}k'

" bar matrix macro
let @b='a\begin{bmatrix} \end{bmatrix}Bh'

" Equation macro
let @e='i\begin{equation}\end{equation}k'

" gather macro
let @g='i\begin{gather}\end{gather}k'
"}}}
" Figure macro (use <quote>fp) "{{{
let @f="\\begin{figure}[!h]\n"
            \ . "  \\centering\n"
            \ . "  \\includegraphics[width=0.75\\textwidth]{myfilename.pdf}\n"
            \ . "  \\caption{My caption goes here.}\n"
            \ . "  \\label{fig:label}\n"
            \ . "\\end{figure}""
"}}}
" Subfigure macro {{{
let @s="\\begin{figure}[!h]\n"
            \ . "  \\centering\n"
            \ . "  \\begin{subfigure}[c]{0.48\\textwidth}\n"
            \ . "     \\centering\n"
            \ . "     \\includegraphics[width=\\textwidth]{myfilename_a.pdf}\n"
            \ . "     \\caption{My caption for subfigure (a).}\n"
            \ . "     \\label{fig:label_a}\n"
            \ . "  \\end{subfigure}\n"
            \ . "  \\hspace{0.01cm}\n"
            \ . "  \\begin{subfigure}[c]{0.48\\textwidth}\n"
            \ . "     \\centering\n"
            \ . "     \\includegraphics[width=\\textwidth]{myfilename_b.pdf}\n"
            \ . "     \\caption{My caption for subfigure (b).}\n"
            \ . "     \\label{fig:label_b}\n"
            \ . "  \\end{subfigure}\n"
            \ . "  \\caption{My caption for the entire figure.}\n"
            \ . "  \\label{fig:whole_figure}\n"
            \ . "\\end{figure}\n"
"}}}
" Table macro {{{
let @t="\\begin{table}[!h]\n"
            \ . "  \\setlength{\\tabcolsep}{8pt}\n"
            \ . "  \\def\\arraystretch{1.1}\n"
            \ . "  \\caption{My table caption.}\n"
            \ . "  \\label{tab:tab}\n"
            \ . "    \\centering\n"
            \ . "    \\begin{tabular}{l r r}\n"
            \ . "      \\firsthline\n"
            \ . "      \\multicolumn{1}{c}{case} & \\multicolumn{1}{c}{$\\Upsilon_T$} & \\multicolumn{1}{c}{$\\Upsilon_S$} \\\\ \\hline\n"
            \ . "      single foil         &    1.0800  &    4.8324  \\\\\n"
            \ . "        $\\phi =   0\\deg$  &    0.9593  &    4.4851  \\\\\n"
            \ . "        $\\phi =  90\\deg$  &    1.4826  &    5.7911  \\\\\n"
            \ . "        $\\phi = 180\\deg$  &    1.0644  &    5.7090  \\\\\n"
            \ . "      \\lasthline\n"
            \ . "    \\end{tabular}\n"
            \ . "\\end{table}\n"
"}}}
"}}}--------------------------------------------------------------------------
"       Highlighting {{{
"-----------------------------------------------------------------------------
" make errors stand out a bit more
hi texMathError ctermfg=none ctermbg=darkred
"}}}
