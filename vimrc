"==============================================================================
"    File: ~/.vimrc
" Created: 04/16/2015
"  Author: Bernie Roesler
"
" Description: Bernie's vimrc file
"==============================================================================

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Run pathogen
execute pathogen#infect()
execute pathogen#helptags()

" Set path to recursively include all directories below the current one for
" quick searching, filename completion, etc.
set path=.,/usr/include/,**

" Set interactive shell so :! behaves like bash prompt
if &diff == 'nodiff'
  set shellcmdflag=-ic
endif

" Ensure filetypes taken into account
filetype plugin indent on              

"------------------------------------------------------------------------------
" Settings
"------------------------------------------------------------------------------
set autoread        " Auto-read changes made outside of vim
set autowrite       " Auto-write changes when switching buffers

" load man plugin so manual pages can be read in a vim window
runtime! ftplugin/man.vim

" shorten delay switching to normal mode
set ttimeoutlen=10
set timeoutlen=1000

" keep undo history between files/saves/sessions
set undofile
set undodir=~/.vim/undodir/ " directory MUST already exist
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo

" Enable syntax highlighting
syntax on           

" Enable Omnicompletion
set omnifunc=syntaxcomplete#Complete
set complete=.,w,b,u,t,i
" set complete+=k                         " Include dictionary search
set dictionary=/usr/share/dict/words
set tags=./tags;    " read local tag file first, then search for others


set wildmenu        " Enable tab to show all menu options
set wildignorecase  " ignore case when tab completing
set wildmode=list:full,full

set number          " Turn on line numbers
set ttyfast         " fast connection allows smoother scrolling
set scrolloff=1     " cursor will never reach bottom of window
set title           " Show the filename in the titlebar
set history=1000    " Keep command history
set showcmd         " Show partial commands
set hls             " highlight all search terms
set incsearch       " highlight search as it's typed
set ignorecase      " ignore case in searches
set smartcase       " case-sensitive if capital in search

set tabstop=4       " tabs every 4 spaces
set softtabstop=4   " let backspace delete indent
set shiftwidth=2    " lines >> 2 spaces, use >>. for 4, etc.
set expandtab       " use spaces instead of tab character (need for Fortran)
set autoindent      " indent based on filetype

" set line length marker
if exists('+colorcolumn')
  set colorcolumn=80
endif

let g:loaded_matchparen=0       " Do not highlight matching parens if == 1
set showmatch                   " Show matching parens
set matchtime=3                 " Highlight for 3 miliseconds
set tw=0 wrap linebreak         " Do not break words mid-word
set backspace=indent,eol,start  " allow backspacing over everything in insert mode

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
                  \ | wincmd p | diffthis
endif

" Use mouse if it exists
" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Auto-correct list
iab THe The



"------------------------------------------------------------------------------
" FileType and Plugin options (autocommands)
"------------------------------------------------------------------------------
" set local directory of each buffer to the buffer's directory
" autocmd BufEnter * silent! lcd %:p:h

" automatically make and load view on document open/close
autocmd BufWinLeave *.* silent mkview
autocmd BufWinEnter *.* silent loadview

"--------------------------------------- HTML/CSS
" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'
autocmd FileType html,css setlocal shiftwidth=2 tabstop=2

" Allow stylesheets to autocomplete hyphenated words
autocmd FileType css,scss,sass,html setlocal iskeyword+=-,_
autocmd FileType css,scss,sass      setlocal omnifunc=csscomplete#CompleteCSS

"--------------------------------------- plain text
autocmd FileType text syn match Braces display '[{}\[\]]'
autocmd FileType text hi Braces ctermfg=darkred

autocmd FileType text syn match Quotes display '[\'\`\"]'
autocmd FileType text hi Quotes ctermfg=6
" 21 == light blue

autocmd FileType text syn match Stars display '[\*]'
autocmd FileType text hi Stars ctermfg=208


"--------------------------------------- LaTeX
let g:tex_stylish=1

" wrap \left( \right) around visually selected text
vmap sp "zdi\left(<C-R>z\right)<Esc> 

" " Declare latex language for ctags, taglist.vim usage
" let tlist_tex_settings   = 'latex;s:sections;g:graphics;l:labels'
" let tlist_bib_settings   = 'bibtex;s:BiBTeX_strings;e:BibTeX-Entries;a:BibTeX-Authors;t:BibTeX-Titles'
" let tlist_make_settings  = 'make;m:macros;t:targets'

" : is included as keyword for fig: eqn: etc.,
autocmd BufRead,BufNewFile *.tex set iskeyword+=_
autocmd FileType tex,matlab,c,f95,sh,markdown set iskeyword+=_

" Turn off matching paren highlighting for LaTeX files
" Doesn't work...
let g:LatexBox_loaded_matchparen=1

" Change default SuperTabs completion to context (or try <C-x><C-o>)
let g:SuperTabDefaultCompletionType="context"


"--------------------------------------- C
autocmd FileType c setlocal iskeyword+=_
autocmd FileType c set cindent


"--------------------------------------- TAGS options
nnoremap ,t :TagbarToggle<CR>


"--------------------------------------- YankRing.vim Options
" Use \yr 2 to get YankRing element 2, for example
nnoremap <silent> <Leader>yr :YRGetElem<CR>
let g:yankring_history_dir='~/.vim'


"--------------------------------------- Fortran options
autocmd FileType fortran setlocal iskeyword+=_

let fortran_free_source=1                               " Enable free format
au! BufRead,BufNewFile *.f9? let b:fortran_do_enddo=1   " indent do loops

" Do not highlight tabs in fortran files
hi link fortranTab NONE



"------------------------------------------------------------------------------
" Functions
"------------------------------------------------------------------------------
" Incr increments numbers in a column (i.e. in Visual Block mode)
"   To use: highlight in Visual Block, and press <C-a>
function! Incr()
  let a = line('.') - line("'<")
  let c = virtcol("'<")
  if a > 0
    execute 'normal! '.c.'|'.a."\<C-a>"
  endif
  normal `<
endfunction
vnoremap <C-a> :call Incr()<CR>

" " Jump from html class/id tag to definition in linked CSS file
" " use <leader>] to execute
" function! JumpToCSS()
"   let id_pos = searchpos("id", "nb", line('.'))[1]
"   let class_pos = searchpos("class", "nb", line('.'))[1]
"
"   if class_pos > 0 || id_pos > 0
"     if class_pos < id_pos
"       execute ":vim '#".expand('<cword>')."' **/*.css"
"     elseif class_pos > id_pos
"       execute ":vim '.".expand('<cword>')."' **/*.css"
"     endif
"   endif
" endfunction
"
" nnoremap <leader>] :call JumpToCSS()<CR>


"------------------------------------------------------------------------------
" Key Mappings
"------------------------------------------------------------------------------
" <Leader> is \ by default, so those commands can be invoked by doing \v and \s
nmap <Leader>s :source $MYVIMRC<CR>

" opens $MYVIMRC for editing, or use :tabedit $MYVIMRC
nmap <Leader>v :e $MYVIMRC<CR>

" unmap Q from entering Ex mode
nnoremap Q <nop>

" Map Ctrl-s to save file
nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>

" Map ,b to change to next buffer
nnoremap ,b :bn!<CR>
nnoremap ,v :bp!<CR>

" Type gp to select the last changed (or pasted) text
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" Toggle spell checking on and off with `,s`
nmap <silent> ,s :set spell!<CR>

" Turn off highlight search
nmap <silent> ,/ :nohls<CR>

" Search/Replace current word
nnoremap <Leader>* :%s/\<<C-r><C-w>\>/

" Wrapped lines goes down/up to next row, rather than next line in file.
nnoremap j gj
nnoremap k gk

" Make Y consistent with C and D
nnoremap Y y$

" Toggle relative numbers with \n
nnoremap <silent>,n :set relativenumber!<cr>


"------------------------------------------------------------------------------
" Colorscheme
"------------------------------------------------------------------------------
" Use solarized colorscheme
set t_Co=256
let g:solarized_termcolors=256
set background=dark
colorscheme solarized

"*** UNCOMMENT 'hi' lines for default colorscheme
" Green comments
" hi Comment ctermfg=darkgreen
" Dodgerblue Types (i.e. real*8)
" hi Type ctermfg=33

" hi  WildMenu ctermfg=yellow ctermbg=darkgrey

" Spell check options -- need to be set AFTER colorscheme to work properly.
hi clear SpellBad
hi SpellBad term=standout ctermfg=1 term=underline cterm=underline
hi clear SpellCap
hi SpellCap term=underline cterm=underline
hi clear SpellRare
hi SpellRare term=underline cterm=underline
hi clear SpellLocal
hi SpellLocal term=underline cterm=underline


"-----------  Set status-line color based on mode
" first, enable status line always
" Status Line {  
set laststatus=2                             " always show statusbar  
set statusline=                              " clear default status line
set statusline+=%-10.3n\                     " buffer number  
"set statusline+=%{fugitive#statusline()}     " Fugitive will put current branch name in status line
set statusline+=\ \ \                        " Separator
set statusline+=%t\                          " tail of filename   
set statusline+=%h%m%r%w                     " status flags  
set statusline+=\[%{strlen(&ft)?&ft:'none'}] " file type  
set statusline+=%=                           " right align remainder  
set statusline+=0x%-8B                       " character value  
set statusline+=%-14(%l,%c%V%)               " line, character  
set statusline+=%<%P                         " file position  
"} 
" hi StatusLine ctermfg=none ctermbg=none

" now set it up to change the status line based on mode
if version >= 700
  au InsertEnter * hi StatusLine term=reverse ctermfg=green ctermbg=black
  au InsertLeave * hi StatusLine term=none    ctermfg=none  ctermbg=none
endif



"==============================================================================
"==============================================================================
