"==============================================================================
"    File: ~/.vimrc
" Created: 04/16/2015
"  Author: Bernie Roesler
"
" Description: Settings for vim. Source with \s while in vim
"==============================================================================

" Run pathogen
call pathogen#infect()
call pathogen#helptags()

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

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

set tags=./tags;    " read local tag file first, then search for others

set wildmenu        " Enable tab to show all menu options
set nofileignorecase  " do NOT ignore case when tab completing
" set nowildignorecase  " do NOT ignore case when tab completing
set wildmode=longest,list,full  " like bash completion

" autocmd BufEnter * let titlestring = expand("%:p")
set title           " Show filename in title bar
set number          " Turn on line numbers
set ttyfast         " fast connection allows smoother scrolling
set scrolloff=1     " cursor will never reach bottom of window
set history=10000   " Keep command history
set showcmd         " Show partial commands
set hls             " highlight all search terms
set incsearch       " highlight search as it's typed
set ignorecase      " ignore case when searching
set smartcase       " case-sensitive if capital in search

set tabstop=4       " tabs every 4 spaces
set softtabstop=0   " set to 4 to let backspace delete indent with expandtab
set shiftwidth=4    " use >>, << for line shifting
set expandtab       " use spaces instead of tab character (need for Fortran)
set autoindent      " indent based on filetype

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
if (strlen(v:servername) > 0)
  set clipboard=unnamedplus,unnamed
else
  set clipboard=autoselectplus,exclude:cons\|linux
endif

"------------------------------------------------------------------------------
"       Autocommands
"------------------------------------------------------------------------------
" set local directory of each buffer to the buffer's directory
" autocmd BufEnter * silent! lcd %:p:h

" automatically make and load view on document open/close
" mkview saves local current directory, and consequently reloads it. If a
" file is opened from another directory, it will no longer have the correct
" directory when the view is reloaded. Disable options in viewoptions to only
" save folds and cursor position
" set viewoptions=folds,cursor    " NOT 'options'
" autocmd BufWinLeave ?* silent mkview
" autocmd BufWinEnter ?* silent loadview

augroup quickfix_window
  au!
  " Automatically open, but do not go to (if there are errors) the quickfix /
  " location list window, or close it when is has become empty.
  " Note: Must allow nesting of autocmds to enable any customizations for quickfix
  " buffers.
  " Note: Normally, :cwindow jumps to the quickfix window if the command opens it
  " (but not if it's already open). However, as part of the autocmd, this doesn't
  " seem to happen.
  autocmd QuickFixCmdPost [^l]* nested cwindow
  autocmd QuickFixCmdPost    l* nested lwindow

  " Quickly open/close quickfix and location list
  au! BufWinEnter quickfix nnoremap <silent> <buffer> q :cclose<cr>:lclose<cr>
augroup END
nnoremap <silent> <leader>q :botright copen 10<cr>

augroup misc_cmds
  au!
  autocmd FileType matlab,sh,markdown set iskeyword+=_

  " Use K to search vim help for word under cursor only in vim files
  autocmd FileType vim setlocal keywordprg=:help
augroup END

"--------------------------------------- YankRing.vim Options
let g:yankring_history_dir='~/.vim'
nnoremap <silent> <Leader>yr :YRGetElem<CR>

"------------------------------------------------------------------------------
"       Functions
"------------------------------------------------------------------------------
" Set terminal title the hard way (SLOW), use only 80 chars
function! SetTermTitle()
  let filename = expand("%:p")
  let length = strlen(filename)
  let cols = &columns - 20          " terminal window size
  if (length < cols)                " show entire path
      let tstr = filename
  else                              " not going to use window < 82 cols
      let tstr = strpart(filename,0,32) . "..." . strpart(filename, length-50)
  endif
  " Set terminal title
  silent execute "!echo -n -e " . "\"\033]0;" . tstr . "\007\""
endfunction
autocmd BufEnter,VimEnter * silent! call SetTermTitle()

" Reset title on vim exit (not needed apparently?)
" function! ResetTermTitle()
"     " disable vim's ability to set the title
"     silent execute "set title t_ts='' t_fs=''"
"
"     " and restore it to 'bash'
"     silent execute "!echo -n -e \"\033]0;bash\007\""
" endfunction
" autocmd VimLeave * silent call ResetTermTitle()

"------------------------------------------------------------------------------
" Auto-update tags file
function! UpdateTags()
  let alltagfiles = tagfiles()
  if (len(alltagfiles) == 0)            " create new tags file
      let tagsfile = './tags'           
      exe 'silent !ctags -af ' . tagsfile . ' ' . expand("%")
  else                                  " use first tags file found
      let tagsfile = alltagfiles[0]    
      exe 'silent !sed -i -e "\@' . expand("%") . '@d" ' . tagsfile . 
                  \' && ctags -af ' . tagsfile . ' ' . expand("%")
  endif
  " -e on Mac causes backup tags file to be generated
  exe 'silent !rm -rf ' . tagsfile . '-e'
endfunction


"------------------------------------------------------------------------------
" Open explorer in new window
function! MyExplore() 
  new 
  Explore
endfunction 

nmap <Leader>E :silent! call MyExplore()<CR> 

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

"------------------------------------------------------------------------------
" Jump from html class/id tag to definition in linked CSS file
" use <Leader>] to execute
function! JumpToCSS()
  let id_pos = searchpos("id", "nb", line('.'))[1]
  let class_pos = searchpos("class", "nb", line('.'))[1]

  if class_pos > 0 || id_pos > 0
    if class_pos < id_pos
      execute ":vim '#".expand('<cword>')."' **/*.css"
    elseif class_pos > id_pos
      execute ":vim '.".expand('<cword>')."' **/*.css"
    endif
  endif
endfunction

nnoremap <Leader>] :call JumpToCSS()<CR>


"------------------------------------------------------------------------------
"       Key Mappings
"------------------------------------------------------------------------------
" Quick access .vimrc
nnoremap <Leader>s :source $MYVIMRC<CR>
nnoremap <Leader>v :e $MYVIMRC<CR>

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

" Wrapped lines goes down/up to next row, rather than next line in file.
nnoremap j gj
nnoremap k gk

" Make Y consistent with C and D
nnoremap Y y$

" Toggle relative numbers
nnoremap <silent>,n :set relativenumber!<CR>

" Shift-tab backs up one tab stop
inoremap <S-Tab> <C-d>


"------------------------------------------------------------------------------
"       Plugin specific maps
"------------------------------------------------------------------------------
" Tagbar toggle (RHS default)
nnoremap ,t :TagbarToggle<CR>


"------------------------------------------------------------------------------
"       Colorscheme
"------------------------------------------------------------------------------
" Use solarized colorscheme
set t_Co=256
let g:solarized_termcolors=256
set background=dark
colorscheme solarized

"*** UNCOMMENT 'hi' lines for default colorscheme
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
