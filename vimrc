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
" Ignore list of plugins
let g:pathogen_disabled = ['vimtex', 'jupyter-vim']
call add(g:pathogen_disabled, 'vim-badplugin')
" Run pathogen to load plugins (ignore errors on Linux machines)
silent! call pathogen#infect()
silent! call pathogen#helptags()

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

" ./** : recursively search below directory of current *file* 
" **   : recursively search below directory of current *vim* working directory
" include;  : look upward for "include"
" ../../../ : no more than 3 directories from current file
" /usr(/local)?/include : standard c header locations
"
set path=./**,**,include;../../../,/usr/local/include,/usr/include/

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

set modelines=20    " check 20 lines down for a modeline

" It's not about the money, it's all about the timing {{{
set notimeout           " Only timeout on key codes, not mappings
set ttimeout
set ttimeoutlen=10
set ttyfast             " fast connection allows smoother scrolling
set lazyredraw           " don't redraw during macros etc.
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

set wildignore+=.git                            " Version control
set wildignore+=*.aux,*.bbl,*.blg,*.log         " LaTeX aux files
set wildignore+=*.out,*.toc,*.fls
set wildignore+=*.fdb_latexmk,*.synctex*.gz
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg  " binary images
set wildignore+=*.o,*.dll,*.pyc                 " compiled object files
set wildignore+=*.sw?                           " Vim swap files
set wildignore+=*.DS_Store                      " OSX bullshit
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
" let g:loaded_matchparen = 0     " Do not highlight matching parens if == 1
set showmatch                   " Show matching parens
set matchtime=3                 " Highlight for 3 miliseconds
"}}}
" Formatting {{{
set nowrap                      " do not autowrap text to screen
set linebreak                   " Do not break words mid-word
set autoindent                  " indent based on filetype
set formatoptions=cqr2l1j       " tcq default, :help fo-table
set textwidth=0                 " set to 0 by default, set by filetype
set colorcolumn=80              " default is 80, autocmd changes for filetype
set diffopt+=iwhite             " ignore whitespace in diff windows
"}}}
" Folding {{{
set foldcolumn=0                " show locations of folds in left-most column
set foldmethod=marker           " auto-fold code
set foldnestmax=4
set foldminlines=3
let g:vimsyn_folding = 'aflmpPr' " fold vimscript syntactically
"}}}
" Windows {{{
set scrolloff=1     " cursor will never reach bottom of window
set sidescroll=5    " cursor will never reach edge of screen
set nosplitbelow    " split new windows       above current one
set splitright      " split new windows to right of current one
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
    set clipboard=unnamed,exclude:cons\|linux
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
" tags session lischars options {{{
" read local tag file first, then look up the tree from current file ';', then
" search in specified directories
set tags=./tags,tags;,~/.dotfiles/tags,~/Documents/MATLAB/tags

" Don't save settings from session, usually we want to reset these to defaults
" when closing/reopening a bunch of files
set sessionoptions=blank,buffers,curdir,folds,help,resize,winsize

" Toggle "set list" or "set nolist" to view special characters
if has("patch-7.4.710")
    set listchars=eol:¬,tab:→\ ,trail:·,extends:»,precedes:«,nbsp:~,space:·
else
    set listchars=eol:¬,tab:→\ ,trail:·,extends:»,precedes:«,nbsp:~
endif
"}}}
"}}}--------------------------------------------------------------------------
"       Autocommands                                                     "{{{
"-----------------------------------------------------------------------------
augroup code_cmds "{{{
    autocmd!
    autocmd FileType matlab,sh,markdown,vim,perl,gitcommit setlocal iskeyword+=_

    " Create template for new files
    " TODO merge all headers into one command that does not require a header
    " file... just insert desired text and use CommentBlock to make header!
    for the_ext in ['c', 'm', 'f95', 'py', 'scm', 'sh', 'vim']
        let filename = '$HOME/.vim/header/' . the_ext . '_header'
        execute 'autocmd BufNewFile *.' . the_ext . 
                    \ ' call util#MakeTemplate("' . filename . '")'
    endfor

    autocmd FileType perl :compiler perl

    autocmd FileType conf source $HOME/.vim/after/ftplugin/sh/sections.vim

    " Load .types.vim highlighting file:
    " FIXME Move to function/ftplugin/etc.
    autocmd BufRead,BufNewFile *.[ch] let fname = expand('<afile>:p:h') . '/.types.vim'
    autocmd BufRead,BufNewFile *.[ch] if filereadable(fname)
    autocmd BufRead,BufNewFile *.[ch]   exe 'so ' . fname
    autocmd BufRead,BufNewFile *.[ch] endif

    " TODO figure out how to break undo and jump sequence for this operation
    " Update 'Last Modified:' line in code files
    " autocmd FileType c,cpp,python,matlab,fortran,vim,sh,perl 
        " \ autocmd BufWritePre <buffer> call util#LastModified()
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
                \ containedin=.*Comment,vimCommentTitle
    au Syntax * hi def link myTodo Todo
augroup END
"}}}
augroup CursorLineOnlyInActiveWindow "{{{
    au!
    au VimEnter,WinEnter,BufWinEnter * silent setlocal cursorline
    au WinLeave * silent setlocal nocursorline
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
cabbr %ip% /Users/bernardroesler/anaconda3/lib/python3.6/site-packages/IPython/
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
nnoremap <Leader>d :cd %:p:h<CR>:pwd<CR>

" unmap Q from entering Ex mode to avoid hitting it by accident
nnoremap Q <nop>

" Save file if changed 
" NOTE: MUST HAVE 'stty -ixon' in ~/.bashrc to disable flow control
nnoremap <silent> <C-s> :update<CR>
inoremap <silent> <C-s> <Esc>:update<CR>

" Toggle spell checking
noremap <silent> <Leader>s :set spell!<CR>

" Turn off highlighting of last search
nnoremap <silent> ,/ :nohls<CR>

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
          " execute "silent !sh -c 'sleep 0.01; tmux select-pane -" . a:tmuxdir . "' &"
          call system("tmux select-pane -" . a:tmuxdir)
          redraw!
        endif
    endfunction

    let previous_title = substitute(system("tmux display-message -p '#{pane_title}'"), '\n', '', '')
    let &t_ti = "\<Esc>]2;vim\<Esc>\\" . &t_ti
    let &t_te = "\<Esc>]2;" . previous_title . "\<Esc>\\" . &t_te

    " autocmd BufReadPost,FileReadPost,BufNewFile * call system("tmux rename-window %")
    " autocmd BufEnter * let &titlestring=' ' . expand("%:p")

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
nnoremap <Leader>T "=strftime("%m/%d/%Y, %H:%M")<CR>p

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
augroup filetype_markdown "{{{
    autocmd!
    " Handy operator remaps
    autocmd FileType markdown onoremap ih :<C-u>exe "norm! ?^==\\+$\r:nohls\rkvg_"<CR>
    autocmd FileType markdown onoremap ah :<C-u>exe "norm! ?^==\\+$\r:nohls\rg_vk0"<CR>
augroup END
"}}}

"}}}--------------------------------------------------------------------------
"       Plugin Settings                                                   "{{{
"-----------------------------------------------------------------------------
" Ack {{{
if executable('ag')
    " nnoremap <leader>a :Ack!<space>
    let g:ackprg = 'ag --smart-case --nogroup --nocolor --column'
endif
"}}}
" BReptile {{{
let g:breptile_mapkeys = 1              " 1 == map generic keys
let g:breptile_usetpgrep = 1            " 1 == use tpgrep to find program
" let g:breptile_defaultpane = 'top-left' " default tmux pane to use
let g:breptile_bash_pane = 'bottom-left'   
let g:breptile_tpgrep_pat_gnuplot = '[g]nuplot'
let g:breptile_mapkeys_matlab = 1       " 1 == map keys for matlab files
let g:breptile_tpgrep_pat_matlab = '[r]lwrap.*matlab'
let g:breptile_tpgrep_pat_scheme = '[r]lwrap.*scheme'
let g:breptile_mapkeys_python = 1       " 1 == map keys for python files
let g:breptile_python_useinterp = 1     " expect python interpreter
" }}}
" LatexBox {{{
let g:LatexBox_latexmk_async = 1    " 1 == run latexmk asynchronously (not really, requires vim server, no channels yet)
let g:LatexBox_Folding = 0          " 1 == use LatexBox folding instead of vim folding
let g:LatexBox_quickfix = 2         " 2 == open quickfix but do not jump to error
let g:LatexBox_output_type = '-pdf' " output to pdf
let g:LatexBox_show_warnings = 0    " 0 == do not show warnings (default on)
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

let g:use_base16_colors = get(g:, 'use_base16_colors', 0)

if g:use_base16_colors
    " Use base16 colors as dictated by terminal colors
    let base16colorspace = 256
    let color_file = "~/.vimrc_background"
else
    " Use vim-colors-solarized
    let color_file = "~/.vimrc_solarized"
endif

if filereadable(expand(color_file))
    execute 'source' color_file
else
    colorscheme default
    hi Comment ctermfg=darkgreen
    hi Type ctermfg=33
    hi StatusLine ctermfg=none ctermbg=none
    hi WildMenu ctermfg=yellow ctermbg=darkgrey
endif

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

" Do not highlight cursor line number in relative number mode
hi clear CursorLineNr
hi def link CursorLineNr Comment

set cursorline " highlight line cursor is on for easy finding
"}}}
" Highlight NOTE etc {{{
syn match myTodo "\(TODO\|NOTE\|FIXME\):\=" containedin=Comment
hi def link myTodo Todo
"}}}

"}}}--------------------------------------------------------------------------
"       Status Line                                                       "{{{
"-----------------------------------------------------------------------------
set laststatus=2                             " always show statusbar

set statusline=                              " clear default status line
set statusline+=%-4.3n\                      " buffer number
set statusline+=%h%m%r%w                     " status flags
set statusline+=\                            " separator
set statusline+=%{exists('g:loaded_fugitive')?fugitive#statusline():''}
set statusline+=\ \                          " separator
set statusline+=%f\                          " %t filename, %f relative path
set statusline+=\[%{strlen(&ft)?&ft:'none'}] " file type
set statusline+=\ \             
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
