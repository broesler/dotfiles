"==============================================================================
"    File: ~/.vimrc
" Created: 04/16/2015
"  Author: Bernie Roesler
"
" Last Modified: 06/19/2015, 11:26

" Description: Settings for vim. Source with \s while in vim. Functions called
"   by autocommands are located in ~/.vim/plugin/util_functions.vim
"==============================================================================

" Run pathogen to load plugins
call pathogen#infect()
call pathogen#helptags()

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" '**' recursively includes all directories below the current one
set path=.,/usr/include/,/usr/local/include,**

" Set interactive shell so :! behaves like bash prompt
if &diff == 'nodiff'
    set shellcmdflag=-ic
endif

" Ensure files are universally readable
set encoding=utf-8

" Ensure filetypes taken into account
filetype plugin indent on              

"------------------------------------------------------------------------------
"       Global Settings
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
set completeopt=longest,menu,preview        " make like bash completion
set complete=.,w,b,u,t,i
set dictionary=/usr/share/dict/words
set thesaurus=/usr/share/thes/mthesaur.txt  " use <C-X><C-T>
" set thesaurus+=/usr/share/thes/roget13a.txt

set tags=./tags;    " read local tag file first, then search for others ';'

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
set expandtab       " use spaces instead of tab character (need for Fortran)
set autoindent      " indent based on filetype
set modelines=20    " check 20 lines down for a modeline

" set line length marker
if exists('+colorcolumn')
    set colorcolumn=80
endif

let g:loaded_matchparen=0       " Do not highlight matching parens if == 1
set showmatch                   " Show matching parens
set matchtime=3                 " Highlight for 3 miliseconds
set textwidth=0 wrap linebreak  " Do not break words mid-word
set backspace=indent,eol,start  " allow backspacing over everything in insert mode

" Use mouse if it exists
" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
    set mouse=a
    " tmux knows the extended mouse mode
    if &term =~ '^screen'
        set ttymouse=xterm2
    endif
endif

" Use the_silver_searcher if available
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
    set grepformat=%f:%l:%m
endif

" Create :Ag command for using silver searcher in subwindow
if !exists(':Ag')
    command -nargs=+ -complete=file -bar Ag silent! grep! <args> | cwindow
endif

" Use system clipboard properly with +X11 and +clientserver
" if (strlen(v:servername) > 0)
    set clipboard=unnamedplus,unnamed,exclude:cons\|linux
" else
"     set clipboard=autoselectplus,exclude:cons\|linux
" endif

" Settings for vimdiff mode
if &diff
    windo set wrap
    set diffopt+=iwhite   " ignore trailing whitespace
endif


"------------------------------------------------------------------------------
"       Autocommands
"------------------------------------------------------------------------------
augroup quickfix_window
    au!
    " Automatically open, but do not go to (if there are errors) the quickfix /
    " location list window, or close it when is has become empty.
    " Note: Must allow nesting of autocmds to enable any customizations for quickfix
    " buffers.
    " Note: Normally, :cwindow jumps to the quickfix window if the command opens it
    " (but not if it's already open). However, as part of the autocmd, this doesn't
    " seem to happen.
    au QuickFixCmdPost [^l]* nested cwindow
    au QuickFixCmdPost    l* nested lwindow

    " Quickly open/close quickfix and location list
    au! BufWinEnter quickfix nnoremap <silent> <buffer> q :cclose<cr>:lclose<cr>
augroup END

augroup misc_cmds
    au!
    au FileType matlab,sh,markdown setlocal iskeyword+=_

    " Use K to search vim help for word under cursor only in vim files
    au FileType vim setlocal keywordprg=:help
augroup END

augroup code_cmds
  au!
  " Create template for new files
  au BufNewFile *.c   call MakeTemplate("$HOME/.vim/header/c_header")
  au BufNewFile *.m   call MakeTemplate("$HOME/.vim/header/m_header")
  au BufNewFile *.f95 call MakeTemplate("$HOME/.vim/header/f_header")
  au BufNewFile *.sh  call MakeTemplate("$HOME/.vim/header/sh_header")
  au BufNewFile *.vim call MakeTemplate("$HOME/.vim/header/vim_header")

  " Update 'Last Modified:' line in code files
  au BufWritePre *.c,*.m,*.f95,*.vim,$MYVIMRC,.*,*.sh call LastModified()
augroup END

"------------------------------------------------------------------------------
"       Key Mappings
"------------------------------------------------------------------------------
" Command line mappings
cnoremap <C-A> <Home>
cnoremap <C-L> <Right>
cnoremap <C-H> <Left>
cnoremap <C-B> <S-Left>
cnoremap <C-W> <S-Right>
cnoremap <C-J> <Down>
cnoremap <C-K> <Up>

" Quick access .vimrc and functions
nnoremap <Leader>s :source $MYVIMRC<CR>
nnoremap <Leader>v :e $MYVIMRC<CR>
nnoremap <Leader>f :e $HOME/.vim/plugin/util_functions.vim<CR>

" unmap Q from entering Ex mode (batch isn't useful)
nnoremap Q <nop>

" Save file
nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>

" Change between buffers quickly
nnoremap ,b :bn!<CR>
nnoremap ,v :bp!<CR>

" Quickfix list movement
nnoremap ,c :cn!<CR>
nnoremap ,p :cp!<CR>

" Select the last changed (or pasted) text
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" Toggle spell checking 
nmap <silent> ,s :set spell!<CR>

" Turn off highlight search
nnoremap <silent> ,/ :nohls<CR>

" Search/Replace current word (vs just * for search)
nnoremap <Leader>* :%s/\<<C-r><C-w>\>/

" Wrapped lines goes down/up to next row, rather than next line in file
nnoremap j gj
nnoremap k gk

" Make Y consistent with C and D
nnoremap Y y$

" Toggle relative numbers
nnoremap <silent>,n :set relativenumber!<CR>

" Shift-tab backs up one tab stop
inoremap <S-Tab> <C-d>

" With new window mappings <C-l> no longer redraws...
nmap <C-q> :redraw!<CR>

" Jump between tmux and vim windows with <C-[hjkl]>
if exists('$TMUX')
    function! TmuxOrSplitSwitch(wincmd, tmuxdir)
        let previous_winnr = winnr()
        silent! execute "wincmd " . a:wincmd
        if previous_winnr == winnr()
            call system("tmux select-pane -" . a:tmuxdir)
            redraw!
        endif
    endfunction

    let previous_title = substitute(system("tmux display-message -p '#{pane_title}'"), '\n', '', '')
    let &t_ti = "\<Esc>]2;vim\<Esc>\\" . &t_ti
    let &t_te = "\<Esc>]2;". previous_title . "\<Esc>\\" . &t_te

    nnoremap <silent> <C-h> :call TmuxOrSplitSwitch('h', 'L')<cr>
    nnoremap <silent> <C-j> :call TmuxOrSplitSwitch('j', 'D')<cr>
    nnoremap <silent> <C-k> :call TmuxOrSplitSwitch('k', 'U')<cr>
    nnoremap <silent> <C-l> :call TmuxOrSplitSwitch('l', 'R')<cr>
else
    map <C-h> <C-w>h
    map <C-j> <C-w>j
    map <C-k> <C-w>k
    map <C-l> <C-w>l
endif

" Open/close quickfix window
nnoremap <silent> <leader>q :copen 10<CR>
nnoremap <silent> <leader>c :cclose<CR>

" Close buffer without closing split (# is 'alternate file')
" NOTE: Does NOT work twice in a row!!
nnoremap <silent> <C-c> :bp\|bd #<CR>

" Move to middle of page when jumping to tag (easier viewing)
nnoremap <silent> <C-]> <C-]>zz

" Open explorer in new window
nmap <silent> <Leader>E :Hexplore!<CR>

" Timestamp in format %y%m%d, %H:%M
nnoremap <leader>t     "=strftime("%m/%d/%Y, %H:%M")<CR>P

" YankRing.vim map
let g:yankring_history_dir='~/.vim/'
nnoremap <silent> <Leader>yr :YRGetElem<CR>

"------------------------------------------------------------------------------
"       Colorscheme
"------------------------------------------------------------------------------
" Use solarized colorscheme
set t_Co=256
let g:solarized_termcolors=256
set background=dark
colorscheme solarized

" NOTE: UNCOMMENT 'hi' lines for default colorscheme
" hi Comment ctermfg=darkgreen
" hi Type ctermfg=33
" hi StatusLine ctermfg=none ctermbg=none
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
" Status Line
set laststatus=2                             " always show statusbar  
set statusline=                              " clear default status line
set statusline+=%-4.3n\                      " buffer number  
set statusline+=%{fugitive#statusline()}     " brance name (NEEDS FUGITIVE)
set statusline+=\ \                          " Separator
set statusline+=%t\                          " %F is entire path
set statusline+=%h%m%r%w                     " status flags  
set statusline+=\[%{strlen(&ft)?&ft:'none'}] " file type  
set statusline+=%=                           " right align remainder  
set statusline+=0x%-5B                       " character value  
set statusline+=%-10(%l,%c%V%)               " line, character  
set statusline+=%<%P                         " file position  

" now set it up to change the status line based on mode
if version >= 700
    au InsertEnter * hi StatusLine term=reverse ctermfg=green ctermbg=black
    au InsertLeave * hi StatusLine term=none    ctermfg=none  ctermbg=none
endif

"==============================================================================
"==============================================================================
