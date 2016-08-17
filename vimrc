"=============================================================================
"    File: ~/.vimrc
" Created: 04/16/2015
"  Author: Bernie Roesler
"
" Last Modified: 05/26/2016, 11:31

" Description: Settings for vim. Source with \s while in vim. Functions called
"   by autocommands are located in ~/.vim/plugin/util_functions.vim
"=============================================================================
" Fix occasional tmux error opening temp files '/var/folders/...'
" set shell=/bin/sh

"-----------------------------------------------------------------------------
"       Preamble                                                         "{{{
"-----------------------------------------------------------------------------
" Run pathogen to load plugins (ignore errors on Linux machines)
silent! call pathogen#infect()
silent! call pathogen#helptags()

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" '**' recursively includes all directories below the current one
set path=.,/usr/include/,/usr/local/include,**

" Do not need following lines if we `export' required functions in .bashrc!
" Set vim's environment to load my .bashrc so functions/aliases are available
" let $BASH_ENV="~/.bashrc"


" Ensure filetypes taken into account
filetype plugin indent on

" Enable matchit plugin
packadd! matchit

"}}}--------------------------------------------------------------------------
"       Global Settings                                                  "{{{
"-----------------------------------------------------------------------------
set autoread        " Auto-read changes made outside of vim
set autowrite       " Auto-write changes when switching buffers
" set hidden        " Allow hidden buffers without prompt to write
set encoding=utf-8  " Ensure files are universally readable

" load man plugin so man pages can be read in a vim window (:Man or <Leader>K)
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
set completeopt=longest,menuone,preview     " make like bash completion
set complete=.,w,b,u,t,kspell
set dictionary=/usr/share/dict/words
set thesaurus=/usr/share/thes/mthesaur.txt  " use <C-X><C-T>
" set thesaurus+=/usr/share/thes/roget13a.txt   " slow search comment out

" read local tag file first, then look up the tree from current file ';', then
" search in specified directories
set tags=./tags,tags;,~/.dotfiles/tags,~/Documents/MATLAB/tags

set wildmenu            " Enable tab to show all menu options
set nofileignorecase    " no == do NOT ignore case when completing filenames
set wildmode=longest,list,full  " like bash completion

set title           " show filename in title bar
set number          " turn on line numbers
set ttyfast         " fast connection allows smoother scrolling
set scrolloff=1     " cursor will never reach bottom of window
set history=10000   " keep long command history
set showcmd         " show partial commands
set hls             " highlight all search terms
set incsearch       " highlight search as it's typed
set ignorecase      " ignore case when searching
set smartcase       " case-sensitive if capital in search

set tabstop=4       " tabs every 4 spaces
set softtabstop=0   " set to 4 to let backspace delete indent with expandtab
set shiftwidth=4    " use >>, << for line shifting
set shiftround      " shift to round # of tabstops
set expandtab       " use spaces instead of tab character (need for Fortran)
set autoindent      " indent based on filetype
set nojoinspaces    " use one space, not two, after punctuation
set modelines=20    " check 20 lines down for a modeline

set nosplitbelow    " split new windows to top   of current one
set splitright      " split new windows to right of current one

" let g:LatexBox_loaded_matchparen=0
let g:loaded_matchparen=0       " Do not highlight matching parens if == 1
set showmatch                   " Show matching parens
set matchtime=3                 " Highlight for 3 miliseconds

set textwidth=0                 " set to 0 for no auto-newlines
set colorcolumn=80              " default is 80, autocmd changes for filetype
set wrap                        " autowrap text to screen
set linebreak                   " Do not break words mid-word
set backspace=indent,eol,start  " allow backspacing over everything

" Don't save settings from session, usually we want to reset these to defaults
" when closing/reopening a bunch of files
set sessionoptions=blank,buffers,curdir,folds,help,resize,winsize
set formatoptions+=lrn1j        " tcq default
set foldmethod=marker           " auto-fold code
set foldcolumn=0                " show locations of folds in left-most column
set foldlevelstart=20           " 0 == all folds closed, 99 == all folds open
set printoptions=paper:letter

" Toggle "set list" or "set nolist" to view special characters
set listchars=eol:$,tab:>-,trail:*,extends:+,precedes:<,nbsp:~

" Setup netrw for smoother operations
let g:netrw_banner=0        " 0 == no banner
let g:netrw_browse_split=0  " 1 == open files in horizontal split

" Use mouse if it exists -- mouse is weird in ssh
if has('mouse') && !exists("$SSH_TTY")
    set mouse=a
    " tmux knows the extended mouse mode
    if &term =~ '^screen'
        set ttymouse=xterm2
    endif
endif

" Use the_silver_searcher if available
if executable('ag')
    set grepprg=command\ ag\ --vimgrep\ $*
    set grepformat=%f:%l:%c:%m

    " Create :Ag command for using silver searcher in subwindow
    if !exists(':Ag')
        command -nargs=+ -complete=file -bar 
                    \ Ag silent! grep! <args> <bar> cwindow
    endif
endif

" Use system clipboard properly with +X11 and +clientserver
if (strlen(v:servername) > 0) || (strlen($TMUX) > 0)
    set clipboard=autoselectplus,exclude:cons\|linux
else
    set clipboard=unnamed,exclude:cons\|linux
endif

" Settings for vimdiff mode
" if &diff
    " windo set wrap
    set diffopt+=iwhite,vertical   " ignore trailing whitespace
" endif

" Allow italics (reset terminal escape codes)
"   test: $ echo -e "\e[3m foo \e[23m"
set t_ZH=[3m
set t_ZR=[23m


"}}}--------------------------------------------------------------------------
"       Autocommands                                                     "{{{
"-----------------------------------------------------------------------------
augroup quickfix_window
    au!
    " Automatically open, but do not go to (if there are errors) the quickfix
    " / location list window, or close it when is has become empty.
    " Note: Must allow nesting of autocmds to enable any customizations for
    " quickfix buffers.
    " Note: Normally, :cwindow jumps to the quickfix window if the command
    " opens it (but not if it's already open); however, as part of the
    " autocmd, this doesn't seem to happen.
    au QuickFixCmdPost [^l]* nested botright cwindow
    au QuickFixCmdPost    l* nested botright lwindow

    " Quickly open/close quickfix and location list
    au BufWinEnter quickfix nnoremap <silent> <buffer> q :cclose<CR>:lclose<CR>
augroup END

augroup misc_cmds
    au!
    au FileType matlab,sh,markdown,vim,perl,gitcommit setlocal iskeyword+=_

    " Use K to search vim help for word under cursor only in vim files
    au FileType vim setlocal keywordprg=:help

    " Treat buffers from stdin (i.e. echo foo | vim -) as scratch buffers
    au StdinReadPost * :set buftype=nofile

    " Follow symlinks to actual files
    au BufRead * call FollowSymlink()

    " Adjust colorcolumn to textwidth for every filetype
    au BufEnter * if &textwidth == 0 | set colorcolumn=80 | else | set colorcolumn=+0 | endif
augroup END

augroup code_cmds
    au!
    " Create template for new files
    au BufNewFile *.c   call MakeTemplate("$HOME/.vim/header/c_header")
    au BufNewFile *.m   call MakeTemplate("$HOME/.vim/header/m_header")
    au BufNewFile *.f95 call MakeTemplate("$HOME/.vim/header/f_header")
    au BufNewFile *.py  call MakeTemplate("$HOME/.vim/header/py_header")
    au BufNewFile *.sh  call MakeTemplate("$HOME/.vim/header/sh_header")
    au BufNewFile *.vim call MakeTemplate("$HOME/.vim/header/vim_header")

    au FileType perl :compiler perl

    au VimEnter,BufEnter *.gp set ft=gnuplot | set syn=gnuplot 
    " Update 'Last Modified:' line in code files
    " au FileType c,cpp,python,matlab,fortran,vim,sh,perl 
        " \ au BufWritePre <buffer> call LastModified()
augroup END

"}}}--------------------------------------------------------------------------
"       Key Mappings                                                     "{{{
"-----------------------------------------------------------------------------
" Command line mappings
cnoremap <C-A> <Home>
cnoremap <C-L> <Right>
cnoremap <C-H> <Left>
cnoremap <C-B> <S-Left>
cnoremap <C-W> <S-Right>
cnoremap <C-J> <Down>
cnoremap <C-K> <Up>

" Quick access .vimrc and functions
" nnoremap <Leader>s :source $MYVIMRC<CR>
nnoremap <Leader>v :e $MYVIMRC<CR>
nnoremap <Leader>s :so $MYVIMRC<CR>
nnoremap <Leader>f :e $HOME/.vim/plugin/util_functions.vim<CR>

" Open URL's in browswer
nnoremap <Leader>U :silent !open "<C-R><C-F>"<CR><bar>:redraw!<CR><CR>

" Change vim's directory to that of current file (':cd -' changes back)
" Use '%%/...' on command line to open files in directory of current file
nnoremap <Leader>D :cd %:p:h<CR>:pwd<CR>
cabbr <expr> %% expand("%:p:h")

" unmap Q from entering Ex mode to avoid hitting it by accident
nnoremap Q <nop>

" Save file
nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>

" Change between buffers quickly
" nnoremap ,b :bn!<CR>
" nnoremap ,v :bp!<CR>

" Quickfix list movement
" nnoremap ,c :cn!<CR>
" nnoremap ,p :cp!<CR>

" Toggle spell checking
nmap <silent> ,s :set spell!<CR>

" Turn off highlight search
nnoremap <silent> ,/ :nohls<CR>

" Search/Replace current word (vs just * for search)
nnoremap <Leader>* *<C-o>:%s/\<<C-r><C-w>\>/

" Wrapped lines goes down/up to next row, rather than next line in file
" nnoremap j gj
" nnoremap k gk

" Make Y consistent with C and D -- doesn't always work??
nnoremap Y y$

" Toggle relative numbers
nnoremap <silent>,n :set relativenumber!<CR>

" Shift-tab backs up one tab stop
inoremap <S-Tab> <C-d>

" Swap word under cursor with next word, including linebreaks, turn off search
" and return cursor to previous position
nnoremap <Leader>t mx:s/\v(<\S*%#\S*>)(\_.{-})(<\S+>)/\3\2\1/<CR>:nohls<CR>`x

" Completion in insert mode
inoremap <C-f> <C-X><C-F>
inoremap <C-]> <C-X><C-]>
inoremap <C-l> <C-X><C-L>

" Jump between tmux and vim windows with <C-[hjkl]>
if (exists('$TMUX') || exists('$SSH_IN_TMUX'))
    function! TmuxOrSplitSwitch(wincmd, tmuxdir)
        let previous_winnr = winnr()
        silent! execute "wincmd ".a:wincmd
        " If we didn't change vim windows, we must want to change tmux panes
        if previous_winnr == winnr()
          call system("tmux select-pane -".a:tmuxdir)
          redraw!
        endif
    endfunction

    let previous_title = substitute(system("tmux display-message -p '#{pane_title}'"), '\n', '', '')
    let &t_ti = "\<Esc>]2;vim\<Esc>\\".&t_ti
    let &t_te = "\<Esc>]2;".previous_title."\<Esc>\\".&t_te

    " autocmd BufReadPost,FileReadPost,BufNewFile * call system("tmux rename-window %")
    " autocmd BufEnter * let &titlestring=' '.expand("%:p")

    nnoremap <silent> <C-h> :call TmuxOrSplitSwitch('h', 'L')<CR>
    nnoremap <silent> <C-j> :call TmuxOrSplitSwitch('j', 'D')<CR>
    nnoremap <silent> <C-k> :call TmuxOrSplitSwitch('k', 'U')<CR>
    nnoremap <silent> <C-l> :call TmuxOrSplitSwitch('l', 'R')<CR>
else
    nnoremap <C-h> <C-w>h
    nnoremap <C-j> <C-w>j
    nnoremap <C-k> <C-w>k
    nnoremap <C-l> <C-w>l
endif

" Close buffer without closing split (# is 'alternate file')
" NOTE: Does NOT work twice in a row!!
nnoremap <C-q> :bp<bar>bd #<CR>

" Move to top of page when jumping to tag (like less)
nnoremap <C-]> <C-]>zt

" Open explorer in new window
nmap <Leader>E :Hexplore!<CR>

" Timestamp in format %y%m%d, %H:%M
nnoremap <Leader>T "=strftime("%m/%d/%Y, %H:%M")<CR>p

" Use spacebar to open/close folds
nnoremap <space> za

" Use \l to redraw the screen
nnoremap <Leader>l :redraw!<CR>

" " Run :make
" nnoremap <Leader>M :make<bar>redraw!<CR>

" " YankRing.vim map
" let g:yankring_history_dir='~/.vim/'
" nnoremap <Leader>yr :YRGetElem<CR>

"}}}--------------------------------------------------------------------------
"       Colorscheme and statusline                                       "{{{
"-----------------------------------------------------------------------------
" Use solarized colorscheme
set t_Co=256
set background=dark

" option name default optional
"----------------------------------------------
let g:solarized_termcolors = 256        " 256 | 16
let g:solarized_termtrans  = 0          " 0 | 1  transparency
let g:solarized_degrade    = 0          " 0 | 1
let g:solarized_bold       = 1          " 1 | 0
let g:solarized_underline  = 1          " 1 | 0
let g:solarized_italic     = 1          " 0 | 1  Italics not supported in Terminal
let g:solarized_contrast   = "normal"   " 'normal' | 'high' | 'low'
let g:solarized_visibility = "normal"   " 'normal' | 'high' | 'low' = show extra chars
colorscheme solarized

" NOTE: UNCOMMENT 'hi' lines for default colorscheme
" hi Comment ctermfg=darkgreen
" hi Type ctermfg=33
" hi StatusLine ctermfg=none ctermbg=none
" hi WildMenu ctermfg=yellow ctermbg=darkgrey

" Spell check options -- need to be set AFTER colorscheme to work properly.
hi clear SpellBad
hi SpellBad term=standout ctermfg=1 term=underline cterm=underline
hi clear SpellCap
hi SpellCap term=underline cterm=underline
hi clear SpellRare
hi SpellRare term=underline cterm=underline
hi clear SpellLocal
hi SpellLocal term=underline cterm=underline

" Make comments italics
hi Comment cterm=italic

" Do not highlight cursor line number in relative number mode
hi clear CursorLineNr
" hi def link CursorLineNr Comment
hi CursorLineNr ctermfg=239 ctermbg=235 cterm=italic

" Status Line
set laststatus=2                             " always show statusbar
set statusline=                              " clear default status line
set statusline+=%-4.3n\                      " buffer number
set statusline+=%{exists('g:loaded_fugitive')?fugitive#statusline():''}
set statusline+=\ \                          " Separator
set statusline+=%f\                          " %t filename, %F entire path
set statusline+=%h%m%r%w                     " status flags
set statusline+=\[%{strlen(&ft)?&ft:'none'}] " file type
set statusline+=%=                           " right align remainder
set statusline+=0x%-5B                       " character value under cursor
set statusline+=%-10(%l,%c%V%)               " line, character
set statusline+=%<%P                         " file position

" now set it up to change the status line based on mode
if version >= 700
    au InsertEnter * hi StatusLine term=reverse ctermfg=green ctermbg=black
    au InsertLeave * hi StatusLine term=none    ctermfg=none  ctermbg=none
endif
"}}}

"=============================================================================
"=============================================================================
