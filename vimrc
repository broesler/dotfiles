"=========================================================================={{{
"    File: ~/.vimrc
" Created: 04/16/2015
"  Author: Bernie Roesler
"
" Description: Settings for vim. Source with \s while in vim. Functions called
"   by autocommands are located in ~/.vim/autoload/util.vim
"=============================================================================

"}}}--------------------------------------------------------------------------
"       Preamble                                                         "{{{
"-----------------------------------------------------------------------------
" Optional packages:
" packadd jupyter-vim
" packadd vimtex

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Ensure filetypes taken into account
filetype plugin indent on

" Enable matchit plugin
if version > 800
    packadd! matchit
else
    runtime! macros/matchit.vim
endif

" load man plugin so man pages can be read in a vim window (:Man or <Leader>K)
runtime! ftplugin/man.vim
set keywordprg=:Man

" Setting the path:
" ./** : recursively search below directory of current *file*
" **   : recursively search below directory of current *vim* working directory
" include;  : look upward for "include"
" ../../../ : no more than 3 directories from current file
" /usr(/local)?/include : standard c header locations
"
set path=./**,**,include;../../../,/usr/local/include,/usr/include/
" Allow fzf use within vim
set rtp+=/opt/homebrew/opt/fzf

" Allow shell to run as login shell (and load .zprofile or .bash_profile)
set shellcmdflag=-cl

"}}}--------------------------------------------------------------------------
"       Global Settings                                                  "{{{
"-----------------------------------------------------------------------------
" Enable syntax highlighting
syntax on

set title           " show filename in title bar
set number          " turn on line numbers
set history=10000   " keep long command history
set showcmd         " show partial commands

set encoding=utf-8  " Ensure files are universally readable
scriptencoding utf-8

set nrformats-=octal  " don't treat numbers that start with '0' as octal

" It's not about the money, it's all about the timing {{{
set notimeout           " Only timeout on key codes, not mappings
set ttimeout
set ttimeoutlen=10
set lazyredraw          " don't redraw during macros etc.
"}}}
" Backups {{{
set backup
set noswapfile
set autoread                " Auto-read changes made outside of vim
set hidden                  " Allow hidden buffers without prompt to write
set undofile
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo

set undodir=~/.vim/tmp/undo/       " directory MUST already exist
set backupdir=~/.vim/tmp/backup/
set directory=~/.vim/tmp/swap/
"}}}
" Omnicompletion {{{
set omnifunc=syntaxcomplete#Complete
set completeopt=longest,menuone,preview     " make like bash completion
set complete=.,w,b,u,t,kspell
set dictionary=/usr/share/dict/words
set thesaurus=/usr/share/thes/mthesaur.txt  " use <C-X><C-T>
" set thesaurus+=/usr/share/thes/roget13a.txt   " slow search comment out
"}}}
" Wildmenu completion {{{
set wildmenu            " Enable tab to show all menu options
set wildmode=longest,list,full  " like bash completion
set nofileignorecase    " no == do NOT ignore case when completing filenames

set wildignore+=.git  " Version control
set wildignore+=*.aux,*.bbl,*.blg,*.log,*.out,*.toc,*.fls " LaTex aux files
set wildignore+=*.fdb_latexmk,*.synctex*.gz
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg  " binary images
set wildignore+=*.mat,*.pkl                     " MATLAB and python binaries
set wildignore+=*.mp4                           " videos
set wildignore+=*.o,*.dll,*.pyc                 " compiled object files
set wildignore+=*.sw?                           " Vim swap files
set wildignore+=*.DS_Store                      " OSX garbage
"}}}
" Searching {{{
set hlsearch        " highlight all search terms
set incsearch       " highlight search as it's typed
set ignorecase      " ignore case when searching
set smartcase       " case-sensitive if capital in search
"}}}
" Tabs vs spaces {{{
set tabstop=4       " tabs every 4 spaces
set softtabstop=4   " set to 4 to let backspace delete indent with expandtab
set shiftwidth=4    " use >>, << for line shifting
set expandtab       " use spaces instead of tab character (need for Fortran)
set shiftround      " shift to round # of tabstops
set nojoinspaces    " use one space, not two, after punctuation
set backspace=indent,eol,start  " allow backspacing over everything
"}}}
" Parens {{{
set showmatch                   " Show matching parens
set matchtime=3                 " Highlight for 3 miliseconds
"}}}
" Formatting {{{
set nowrap                      " do not autowrap text to screen
set linebreak                   " Do not break words mid-word
set autoindent                  " indent based on filetype
set formatoptions=cqr2l1j       " tcq default, :help fo-table
set colorcolumn=80              " default is 80, autocmd changes for filetype
set diffopt+=iwhite             " ignore whitespace in diff windows
"}}}
" Folding {{{
set foldlevelstart=99           " start with folds open
set foldmethod=marker           " auto-fold code
set foldminlines=3
let g:vimsyn_folding = 'aflmpPr' " fold vimscript syntactically
"}}}
" Windows {{{
set scrolloff=1     " cursor will never reach bottom of window
set sidescroll=5    " cursor will never reach edge of screen
set switchbuf=useopen " with :bn, etc. if buffer is in a window, jump to it
"}}}
" mouse {{{
if has('mouse') && !exists("$SSH_TTY")
    set mouse=a
    " tmux knows the extended mouse mode
    if &term =~ '^screen'
        set ttymouse=xterm2
    endif
endif
"}}}
" clipboard {{{
set clipboard=autoselectplus,exclude:cons\|linux
"}}}
" vimdiff {{{
if &diff
    windo set wrap
    set diffopt+=iwhite   " ignore trailing whitespace
endif
"}}}
" italics  {{{
"   test: $ echo -e "\e[3m foo \e[23m"
"   (reset terminal escape codes)
set t_ZH=[3m
set t_ZR=[23m
"}}}
" tags & cscope {{{ 
" read local tag file first, then look up the tree from current file ';', then
" search in specified directories
set tags=./tags,tags;,~/.dotfiles/tags,~/Documents/MATLAB/tags
set tags+=~/src/SuiteSparse-7.7.0/CSparse/tags

if has("cscope") && executable("/opt/homebrew/bin/cscope")
    set csprg=/opt/homebrew/bin/cscope
    set csto=0
    set cst
    set nocsverb
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    elseif $CSCOPE_DB != ""
        " add database pointed to by environment
        cs add $CSCOPE_DB
    endif
    set csverb
endif
"}}}
" session lischars options {{{
" Don't save settings from session, usually we want to reset these to defaults
" when closing/reopening a bunch of files
set sessionoptions-=options

" Toggle "set list" or "set nolist" to view special characters
if has("patch-7.4.710")
    set listchars=eol:¬,tab:→\ ,trail:·,extends:»,precedes:«,nbsp:~,space:·
else
    set listchars=eol:¬,tab:→\ ,trail:·,extends:»,precedes:«,nbsp:~
endif
"}}}
" grep {{{
" Use ripgrep if available
if executable('rg')
    set grepprg=rg\ --vimgrep
    set grepformat=%f:%l:%c:%m
endif
" }}}
"}}}--------------------------------------------------------------------------
"       Autocommands                                                     "{{{
"-----------------------------------------------------------------------------
augroup code_cmds "{{{
    autocmd!
    autocmd FileType c,cpp,matlab,sh,markdown,vim,perl,gitcommit setlocal iskeyword+=_

    " Create template for new files
    " TODO merge all headers into one command that does not require a header
    " file... just insert desired text and use CommentBlock to make header!
    for the_ext in ['c', 'cpp', 'h', 'f95', 'm', 'py', 'scm', 'sh', 'vim']
        let filename = '$HOME/.vim/header/' . the_ext . '_header'
        execute 'autocmd BufNewFile *.' . the_ext .
                    \ ' call util#MakeTemplate("' . filename . '")'
    endfor

    autocmd FileType conf source $HOME/.vim/after/ftplugin/sh/sections.vim

    autocmd FileType css,scss,sass setlocal iskeyword+=-
augroup END
"}}}
augroup misc_cmds "{{{
    autocmd!
    " Treat buffers from stdin (i.e. echo foo | vim -) as scratch buffers
    autocmd StdinReadPost * set buftype=nofile

    " Follow symlinks to actual files
    autocmd BufRead * call util#FollowSymlink()

    " Prompt to create new directory if it doesn't exist
    autocmd BufNewFile * call util#EnsureDirExists()

    " Adjust colorcolumn to textwidth for every filetype
    autocmd BufEnter * if &textwidth == 0 | set colorcolumn=80 | else | set colorcolumn=+1 | endif

    " Turn off folding while in insert mode (speeds up syntax), see:
    "   <http://vim.wikia.com/wiki/Keep_folds_closed_while_inserting_text>
    " autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
    " autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif
augroup END
"}}}
augroup quickfix_window "{{{
    autocmd!
    " Automatically open, but do not go to (if there are errors) the quickfix
    " / location list window, or close it when is has become empty.
    " Note: Must allow nesting of autocmds to enable any customizations for
    " quickfix buffers.
    " Note: Normally, :cwindow jumps to the quickfix window if the command
    " opens it (but not if it's already open); however, as part of the
    " autocmd, this doesn't seem to happen.
    autocmd QuickFixCmdPost [^l]* nested botright cwindow
    autocmd QuickFixCmdPost    l* nested botright lwindow

    " Quickly close quickfix and location list
    autocmd BufWinEnter quickfix nnoremap <silent> <buffer> q :cclose<CR>:lclose<CR>
augroup END
"}}}
augroup todo "{{{
    au!
    au Syntax * syn match myTodo /\v<(TODO|NOTE|FIXME):\=/
                \ display contained containedin=.*Comment,vimCommentTitle
    au Syntax * hi def link myTodo Todo
augroup END
"}}}
augroup CursorLineOnlyInActiveWindow "{{{
    au!
    au VimEnter,WinEnter,BufWinEnter * silent setlocal cursorline
    au WinLeave * silent setlocal nocursorline
augroup END
"}}}
augroup xelatex_cmds "{{{
    autocmd!
    " set compiler options to use xelatex
    autocmd BufRead,BufNewFile *.xtx set ft=tex
    autocmd BufRead,BufNewFile *.xtx let g:LatexBox_latexmk_options = "-file-line-error -synctex=1 -pdf -xelatex"
    autocmd BufRead,BufNewFile *.xtx setlocal makeprg=latexmk\ \-interaction=nonstopmode\ \-pdf\ \-xelatex\ '%'
augroup END
"}}}
augroup fugitive_au "{{{
    autocmd!
    autocmd FileType fugitive resize 20
    autocmd FileType fugitive setlocal winfixheight
augroup END
"}}}
"}}}--------------------------------------------------------------------------
"       Key Mappings                                                     "{{{
"-----------------------------------------------------------------------------
let mapleader="\\"
let maplocalleader=","

" Quick access .vimrc and functions {{{
nnoremap <Leader>ve :edit $MYVIMRC<CR>
nnoremap <Leader>vs :source $MYVIMRC<CR>
nnoremap <Leader>fe :edit $HOME/.vim/autoload/util.vim<CR>
" Open settings for current filetype
" TODO add path to other ftplugin locations (turn into function...)
nnoremap <Leader>ft :execute "split $HOME/.vim/after/ftplugin/" . &filetype . ".vim"<CR>
"}}}
" Command line mappings {{{
" cnoremap <C-A> <Home>
cnoremap <C-H> <Left>
cnoremap <C-J> <Down>
cnoremap <C-K> <Up>
cnoremap <C-L> <Right>
cnoremap <C-B> <S-Left>
cnoremap <C-W> <S-Right>
" Use '%%/...' on command line to open files in directory of current file
cabbr <expr> %% expand("%:p:h")
"}}}
" Searching/Replacing maps {{{
" Visual Mode */# from Scrooloose
function! s:VSetSearch()
  let temp = @@
  norm! gvy
  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  let @@ = temp
endfunction

vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR><C-o>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR><C-o>

" Fix */# to not jump to next match
nnoremap * *<C-o>
nnoremap # #<C-o>

" Search/Replace current word/selection (vs just * for search)
vnoremap <Leader>* :<C-u>call <SID>VSetSearch()<CR>:%s/<C-r>//
nnoremap <Leader>* *<C-o>:%s/\<<C-r><C-w>\>/
" Repeat last substitution, including flags, with &.
nnoremap & :&&<CR>
xnoremap & :&&<CR>
" }}}
" Maps to functions in ~/.vim/autoload/util.vim {{{
" Increment numbers in a column (no "nore" here to use <Plug>)
vmap <C-a> <Plug>UtilIncr

" Make comment into a block/header (use default values)
nnoremap <Leader>h :CommentBlock<CR>

" Diff 2 open windows
nnoremap <Leader>D :DiffToggle<CR>

" Get highlighting tag of mapping under cursor
nnoremap <Leader>H :GetHighlight<CR>
"}}}

" Open URL's in browser
nnoremap <Leader>U :silent execute '!open ' . fnameescape("<C-R><C-F>")<CR><bar>:redraw!<CR><CR>

" Change vim directory to that of current file (':cd -' changes back)
nnoremap <Leader>c :lcd %:p:h<CR>:pwd<CR>
nnoremap <Leader>C :cd %:p:h<CR>:pwd<CR>

" unmap Q from entering Ex mode to avoid hitting it by accident
nnoremap Q <nop>

" Save file if changed
" NOTE: MUST HAVE 'stty -ixon' in ~/.bashrc to disable flow control
nnoremap <silent> <C-s> :update<CR>
inoremap <silent> <C-s> <Esc>:update<CR>

" Toggle spell checking
noremap <silent> <Leader>s :set spell!<CR>

" Turn off highlighting of last search
nnoremap <silent> <LocalLeader>/ :nohls<CR>

" Make Y consistent with C and D -- doesn't always work??
nnoremap Y y$

" Toggle relative numbers
nnoremap <silent> <Leader>n :set relativenumber!<CR>

" Swap word under cursor with next word, including linebreaks
nnoremap <Leader>t mx:s/\v(<\S*%#\S*>)(\_.{-})(<\S+>)/\3\2\1/<CR>:nohls<CR>`x

" echo full path to current file
nnoremap <Leader>p :echo expand('%:p')<CR>

" Completion in insert mode {{{
inoremap <C-f> <C-X><C-F>
inoremap <C-]> <C-X><C-]>
inoremap <C-l> <C-X><C-L>
"}}}
" Tmux jumps {{{
" Jump between tmux and vim windows with <C-[hjkl]>
if (exists('$TMUX') || exists('$SSH_IN_TMUX'))
    function! TmuxOrSplitSwitch(wincmd, tmuxdir)
        let previous_winnr = winnr()
        execute "wincmd " . a:wincmd
        " If we didn't change vim windows, we must want to change tmux panes
        if previous_winnr == winnr()
          call system("tmux select-pane -" . a:tmuxdir)
          redraw!
        endif
    endfunction

    let s:previous_title = ''  " initialize to empty

    autocmd VimEnter * let s:previous_title = substitute(
        \   system("tmux display-message -p '#{pane_title}'"), '\n', '', ''
        \ )
        \ | let &t_ti = "\<Esc>]2;vim\<Esc>\\" . &t_ti
        \ | let &t_te = "\<Esc>]2;" . s:previous_title . "\<Esc>\\" . &t_te

    autocmd VimLeave * let &t_te = "\<Esc>]2;" . s:previous_title . "\<Esc>\\" . &t_te

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
"}}}

" Close buffer without closing split (# is 'alternate file')
" NOTE: Does NOT work twice in a row!!
nnoremap <C-q> :bp<bar>bd #<CR>

" Move to top of page when jumping to tag (like less)
nnoremap <C-]> <C-]>zt

" Open explorer in new window
noremap <Leader>E :Hexplore!<CR>

" Timestamp
nnoremap <Leader>T "=strftime("%Y-%m-%d %H:%M")<CR>p

" Use spacebar to open/close folds
nnoremap <space> za

" Use \l to redraw the screen (since <C-l> is used by window switching)
nnoremap <Leader>l :syntax sync fromstart<CR>:redraw!<CR>

" Move 'title' comment to end of next line
" nnoremap <Leader>J 0Dj$pkdd
" Better to do opposite of J, append line above current line to current line
nnoremap <Leader>J ddkPJ

" Custom text objects "{{{
" inside/around next/last parens/curly brackets
onoremap in( :<C-U>normal! f(vi(<CR>
onoremap il( :<C-U>normal! F)vi(<CR>
onoremap an( :<C-U>normal! f(va(<CR>
onoremap al( :<C-U>normal! F)va(<CR>

onoremap in{ :<C-U>normal! f{vi{<CR>
onoremap il{ :<C-U>normal! F}vi{<CR>
onoremap an{ :<C-U>normal! f{va{<CR>
onoremap al{ :<C-U>normal! F}va{<CR>
"}}}
" Tabular mappings {{{
if exists(":Tabularize")
    " TODO write as function that accepts as input the character on which to align
    nnoremap <Leader>a= :Tabularize /=<CR>
    vnoremap <Leader>a= :Tabularize /=<CR>
    nnoremap <Leader>a, :Tabularize /, \zs<CR>
    vnoremap <Leader>a, :Tabularize /, \zs<CR>
    nnoremap <Leader>a# :Tabularize / #<CR>
    vnoremap <Leader>a# :Tabularize / #<CR>
    nnoremap <Leader>a% :Tabularize / %<CR>
    vnoremap <Leader>a% :Tabularize / %<CR>
    nnoremap <Leader>a/ :Tabularize / \/\/<CR>
    vnoremap <Leader>a/ :Tabularize / \/\/<CR>
endif
"}}}

"}}}--------------------------------------------------------------------------
"       Plugin Settings                                                   "{{{
"-----------------------------------------------------------------------------
" BReptile {{{
let g:breptile_bash_pane = 'bottom-left'
let g:breptile_tpgrep_pat_python = 'ipython'
" let g:breptile_tpgrep_pat_matlab = '[r]lwrap.*matlab'
let g:breptile_tpgrep_pat_matlab = '\(matlab\|octave\)'
let g:breptile_tpgrep_pat_scheme = '[r]lwrap.*scheme'
let g:breptile_python_interp = 2    " expect ipython
let g:breptile_python_pytestops = '-v'  " verbose testing output
" }}}
" LatexBox {{{
let g:LatexBox_latexmk_async = 0    " 1 == run latexmk asynchronously (not really, requires vim server, no channels yet)
let g:LatexBox_Folding = 1          " 1 == use LatexBox folding instead of vim folding
let g:LatexBox_quickfix = 2         " 2 == open quickfix but do not jump to error
let g:LatexBox_output_type = 'pdf'  " output to pdf
let g:LatexBox_show_warnings = 0    " 0 == do not show warnings (default on)
let g:LatexBox_viewer = 'skim'      " use Skim.app as the pdf viewer.
"}}}
" Jedi-Vim {{{
let g:jedi#goto_command = "<localleader>f"
let g:jedi#goto_assignments_command = "<localleader>a"
let g:jedi#rename_command = "<localleader>r"
let g:jedi#usages_command = "<localleader>g"
let g:jedi#auto_vim_configuration = 0   " do not change 'completeopt'
let g:jedi#popup_on_dot = 0             " only complete if we press the key
let g:jedi#show_call_signatures = 0     " do not show call signatures (SLOW AND BUGGY)
"}}}
"}}}--------------------------------------------------------------------------
"       Colorscheme                                                       "{{{
"-----------------------------------------------------------------------------
" Select colorscheme {{{
" Quick colorscheme swaps (includes entire iTerm + tmux scheme!)
nnoremap <Leader>vd :ITermProf SolarizedDark<CR>
nnoremap <Leader>vl :ITermProf SolarizedLight<CR>
nnoremap <Leader>v2 :ITermProf LaterThisEvening<CR>

" Use vim-colors-solarized
let color_file = "~/.vimrc_solarized"

if filereadable(expand(color_file))
    execute 'source' color_file
else
    echom 'Could not find: ' . color_file . '. Using default colorscheme...'
    colorscheme default
    hi Comment ctermfg=darkgreen
    hi Type ctermfg=33
    hi StatusLine ctermfg=none ctermbg=none
    hi WildMenu ctermfg=yellow ctermbg=darkgrey
endif
unlet color_file

"}}}
" Spell check {{{
" NOTE: need to be set AFTER colorscheme to work properly.
hi clear SpellBad
hi SpellBad term=standout ctermfg=124 term=underline cterm=underline
hi clear SpellCap
hi SpellCap term=underline cterm=underline
hi clear SpellRare
hi SpellRare term=underline cterm=underline
hi clear SpellLocal
hi SpellLocal term=underline cterm=underline
"}}}
" Highlighting {{{
" Make comments italics
hi Comment cterm=italic

" Do not highlight cursor line number
hi clear CursorLineNr
hi def link CursorLineNr Comment
set cursorline " highlight line cursor is on for easy finding
"}}}
"}}}--------------------------------------------------------------------------
"       Status Line                                                       "{{{
"-----------------------------------------------------------------------------
set laststatus=2                             " always show statusbar

set statusline=                              " clear default status line
set statusline+=%-3.3n\                      " buffer number
set statusline+=%h%m%r%w                     " status flags
set statusline+=\                            " separator
set statusline+=%{exists('g:loaded_fugitive')?fugitive#statusline():''}
set statusline+=\                            " separator
set statusline+=%f\                          " %t filename, %f relative path
set statusline+=\[%{strlen(&ft)?&ft:'none'}] " file type
set statusline+=\                            " separator
set statusline+=%=                           " right align remainder
" set statusline+=%8.20{util#GetHighlight()}   " show highlighting tag
" set statusline+=\ \
set statusline+=0x%-5B                       " character value under cursor
set statusline+=%-15(%l,%c%V%)               " line, character
set statusline+=%<%P                         " file position (percentage)

" now set it up to change the status line based on mode
if version >= 700
    autocmd InsertEnter * hi StatusLine term=reverse ctermfg=darkgreen ctermbg=none
    autocmd InsertLeave * hi StatusLine term=none    ctermfg=none  ctermbg=none
endif
"}}}
" vim:fdm=marker:
