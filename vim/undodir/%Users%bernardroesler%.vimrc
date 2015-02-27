Vim�UnDo� �����XX��]4-�k��.�s[�>���c+�3  [   ':nnoremap <Leader>* :%s/\<<C-r><C-w>\>/            A       A   A   A    T�n'   I _�                            ����                                                                                                                                                                                                                                                                                                                                                            T�"�     �        R      O"------------------------------------------------------------------------------    �        R       �        Q    5�_�                          ����                                                                                                                                                                                                                                                                                                                                                            T�"�    �        R       �        Q    5�_�                    �       ����                                                                                                                                                                                                                                                                                                                                                            T�/�    �   �   �  T      6autocmd FileType css,scss,sass setlocal iskeyword+=-,_5�_�                    �       ����                                                                                                                                                                                                                                                                                                                                                            T�/�    �   �   �  T      Hautocmd FileType css,scss,sass setlocal omnifunc=csscomplete#CompleteCSS5�_�                    �       ����                                                                                                                                                                                                                                                                                                                                                            T�/�    �   �   �  T      Hautocmd FileType css,scss,sass setlocal omnifunc=csscomplete#CompleteCSS5�_�                    �        ����                                                                                                                                                                                                                                                                                                                           �   
       �           V   
    T�/�    �   �   �          2" Underscore _ is considered part of a word ALWAYS   setglobal iskeyword+=_    5�_�      	              B       ����                                                                                                                                                                                                                                                                                                                           �   
       �           V   
    T�/�     �   B   F  Q    �   B   C  Q    5�_�      
           	   B        ����                                                                                                                                                                                                                                                                                                                           �   
       �           V   
    T�/�    �   B   D  T    5�_�   	              
   F        ����                                                                                                                                                                                                                                                                                                                           �   
       �           V   
    T�/�    �   E   F           5�_�   
                 ]        ����                                                                                                                                                                                                                                                                                                                                                            T�e�    �   ]   _  U       �   ]   _  T    5�_�      )              ^       ����                                                                                                                                                                                                                                                                                                                                                            T�e�   . �   ]   _  U      set autoread5�_�      *          )   ^        ����                                                                                                                                                                                                                                                                                                                           ^           _           V        T�l�     �   ]   ^          ;set autoread        " Auto-read changes made outside of vim   ?set autowrite       " Auto-write changes when switching buffers5�_�   )   +           *   ?        ����                                                                                                                                                                                                                                                                                                                           ^           ^           V        T�l�   / �   ?   B  S    �   ?   @  S    5�_�   *   ,           +   A        ����                                                                                                                                                                                                                                                                                                                           `           `           V        T�l�   0 �   A   C  U    5�_�   +   -           ,   C        ����                                                                                                                                                                                                                                                                                                                           C           F           V        T�l�     �   B   C          9" automatically make and load view on document open/close   autocmd BufWinLeave *.* mkview   'autocmd BufWinEnter *.* silent loadview    5�_�   ,   .           -   �        ����                                                                                                                                                                                                                                                                                                                           C           C           V        T�l�   1 �   �   �  R    �   �   �  R    5�_�   -   /           .   �       ����                                                                                                                                                                                                                                                                                                                           C           C           V        T�l�   2 �   �   �  V      " FileType and Plugin options5�_�   .   0           /   �        ����                                                                                                                                                                                                                                                                                                                           C           C           V        T�l�   3 �   �   �  �   2   O"------------------------------------------------------------------------------   " Colorscheme   O"------------------------------------------------------------------------------   " Use solarized colorscheme   let g:solarized_termcolors=256   set background=dark   colorscheme solarized       1"*** UNCOMMENT 'hi' lines for default colorscheme   " Green comments   " hi Comment ctermfg=darkgreen    " Dodgerblue Types (i.e. real*8)   " hi Type ctermfg=33       ." hi  WildMenu ctermfg=yellow ctermbg=darkgrey       K" Spell check options -- need to be set AFTER colorscheme to work properly.   hi clear SpellBad   Bhi SpellBad term=standout ctermfg=1 term=underline cterm=underline   hi clear SpellCap   *hi SpellCap term=underline cterm=underline   hi clear SpellRare   +hi SpellRare term=underline cterm=underline   hi clear SpellLocal   ,hi SpellLocal term=underline cterm=underline           1"-----------  Set status-line color based on mode   "" first, enable status line always   " Status Line {     Fset laststatus=2                             " always show statusbar     Hset statusline=                              " clear default status line   >set statusline+=%-10.3n\                     " buffer number     cset statusline+=%{fugitive#statusline()}     " Fugitive will put current branch name in status line   8set statusline+=\ \ \                        " Separator   Bset statusline+=%t\                          " tail of filename      =set statusline+=%h%m%r%w                     " status flags     :set statusline+=\[%{strlen(&ft)?&ft:'none'}] " file type     Fset statusline+=%=                           " right align remainder     @set statusline+=0x%-8B                       " character value     @set statusline+=%-14(%l,%c%V%)               " line, character     >set statusline+=%<%P                         " file position     "}    )" hi StatusLine ctermfg=none ctermbg=none       7" now set it up to change the status line based on mode   if version >= 700   I  au InsertEnter * hi StatusLine term=reverse ctermfg=green ctermbg=black   H  au InsertLeave * hi StatusLine term=none    ctermfg=none  ctermbg=none   endif�  V            5�_�   /   1           0  #        ����                                                                                                                                                                                                                                                                                                                          #          $           V        T�l�   4 �  "  #  X      O"==============================================================================   O"==============================================================================�  V            5�_�   0   2           1  T        ����                                                                                                                                                                                                                                                                                                                          U          V           V        T�l�   5 �  T  V  V    5�_�   1   3           2  !        ����                                                                                                                                                                                                                                                                                                                          V          W           V        T�l�   6 �  !  #  W    5�_�   2   4           3  %       ����                                                                                                                                                                                                                                                                                                                          W          X           V        T�l�   7 �  $  &  X      " Colorscheme5�_�   3   5           4  %       ����                                                                                                                                                                                                                                                                                                                          W          X           V        T�l�     �  $  &  Y      " Colorscheme {{{1    �  %  '  Y       �  %  '  X    5�_�   4   6           5  U        ����                                                                                                                                                                                                                                                                                                                          W          X           V        T�l�   8 �  U  W  Y       �  U  W  X    5�_�   5   7           6  V       ����                                                                                                                                                                                                                                                                                                                          X          Y           V        T�l�   9 �  U  W  Y      "}}}15�_�   6   8           7  U       ����                                                                                                                                                                                                                                                                                                                          X          Y           V        T�l�   ; �  U  W  Y    5�_�   7   9           8  W        ����                                                                                                                                                                                                                                                                                                                          Y          Z           V        T�l�   < �  V  X  Z      " }}}15�_�   8   :           9  %       ����                                                                                                                                                                                                                                                                                                                          Y          Z           V        T�l�   = �  $  &  Z      " Colorscheme {{{15�_�   9   ;           :           ����                                                                                                                                                                                                                                                                                                                                      <           V        T�l�     �             *   O"------------------------------------------------------------------------------   " Key Mappings   O"------------------------------------------------------------------------------   O" <Leader> is \ by default, so those commands can be invoked by doing \v and \s   #nmap <Leader>s :source $MYVIMRC<CR>       6" opens $MYVIMRC for editing, or use :tabedit $MYVIMRC   nmap <Leader>v :e $MYVIMRC<CR>       " unmap Q from entering Ex mode   nnoremap Q <nop>       " Map Ctrl-s to save file   nnoremap <C-s> :w<CR>   inoremap <C-s> <Esc>:w<CR>       !" Map ,b to change to next buffer   nnoremap ,b :bn!<CR>   nnoremap ,v :bp!<CR>       5" Type gp to select the last changed (or pasted) text   <nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'       ," Toggle spell checking on and off with `,s`    nmap <silent> ,s :set spell!<CR>       " Turn off highlight search   nmap <silent> ,/ :nohls<CR>       " Search/Replace current word   ':nnoremap <Leader>* :%s/\<<C-r><C-w>\>/       H" Wrapped lines goes down/up to next row, rather than next line in file.   nnoremap j gj   nnoremap k gk        " Make Y consistent with C and D   nnoremap Y y$       !" Toggle relative numbers with \n   ,nnoremap <silent>,n :set relativenumber!<cr>    5�_�   :   <           ;   �        ����                                                                                                                                                                                                                                                                                                                                                 V        T�l�   > �   �  $  0    �   �   �  0    5�_�   ;   =           <   �        ����                                                                                                                                                                                                                                                                                                                                                 V        T�l�     �   �   �          (nnoremap <leader>] :call JumpToCSS()<CR>5�_�   <   >           =  "        ����                                                                                                                                                                                                                                                                                                                                                 V        T�l�   ? �  "  $  Y    �  "  #  Y    5�_�   =   ?           >  #        ����                                                                                                                                                                                                                                                                                                                                                 V        T�l�   D �  #  %  Z    5�_�   >   @           ?  #        ����                                                                                                                                                                                                                                                                                                                                                 V        T�n     �  "  #          (nnoremap <leader>] :call JumpToCSS()<CR>5�_�   ?   A           @   �        ����                                                                                                                                                                                                                                                                                                                                                 V        T�n   F �   �   �  Z    �   �   �  Z    5�_�   @               A          ����                                                                                                                                                                                                                                                                                                                                                 V        T�n&   I �      [      ':nnoremap <Leader>* :%s/\<<C-r><C-w>\>/5�_�             )      ^        ����                                                                                                                                                                                                                                                                                                                           ^   :       t   .       V   :    T�kr     �   t   u  U                  .set autoindent      " indent based on filetype   ;set autoread        " Auto-read changes made outside of vim   ?set autowrite       " Auto-write changes when switching buffers   Lset expandtab       " use spaces instead of tab character (need for Fortran)   *set history=100     " Keep command history   0set hls             " highlight all search terms   -set ignorecase      " ignore case in searches   4set incsearch       " highlight search as it's typed   *set number          " Turn on line numbers   >set scrolloff=5     " cursor will never reach bottom of window   <set shiftwidth=2    " lines >> 2 spaces, use >>. for 4, etc.   +set showcmd         " Show partial commands   9set smartcase       " case-sensitive if capital in search   1set softtabstop=4   " let backspace delete indent   )set tabstop=4       " tabs every 4 spaces   7set title           " Show the filename in the titlebar   ?set ttyfast         " fast connection allows smoother scrolling   5set wildignorecase  " ignore case when tab completing   9set wildmenu        " Enable tab to show all menu options   set wildmode=list:full�   ]   u        5�_�                    ]        ����                                                                                                                                                                                                                                                                                                                           ]   :       p   .       V   :    T�ky     �   \   a        5�_�                    \        ����                                                                                                                                                                                                                                                                                                                           ^   :       q   .       V   :    T�kz    �   \   ]  Q       5�_�                    `        ����                                                                                                                                                                                                                                                                                                                           ^   :       q   .       V   :    T�k~    �   `   a  R       �   `   b  S       �   _   b  S      ?set autowrite       " Auto-write changes when switching buffers5�_�                    \        ����                                                                                                                                                                                                                                                                                                                           ]   :       p   .       V   :    T�k�     �   [   ]        5�_�                    _        ����                                                                                                                                                                                                                                                                                                                           Z           [           V        T�k�    �   _   `  Q    �   _   `  Q      $set dictionary=/usr/share/dict/words5�_�                   Z        ����                                                                                                                                                                                                                                                                                                                           Z           Z           V        T�k�     �   Y   \        5�_�                    ]        ����                                                                                                                                                                                                                                                                                                                           Z           Z           V        T�k�    �   ]   ^  P    �   ]   ^  P      set complete=.,w,b,u,t,i   E" set complete+=k                         " Include dictionary search5�_�                    T        ����                                                                                                                                                                                                                                                                                                                           R           O           V        T�k�    �   S   U        5�_�                    O        ����                                                                                                                                                                                                                                                                                                                           O           R           V        T�k�     �   R   S  Q      :set undodir=~/.vim/undodir/ " directory MUST already exist   set undofile   ,set undolevels=1000         " How many undos   >set undoreload=10000        " number of lines to save for undo�   N   S        5�_�                   O        ����                                                                                                                                                                                                                                                                                                                           j           m           V        T�k�    �   m   n  Q      :set undodir=~/.vim/undodir/ " directory MUST already exist   set undofile   ,set undolevels=1000         " How many undos   >set undoreload=10000        " number of lines to save for undo�   N   S  U    5�_�                    k       ����                                                                                                                                                                                                                                                                                                                           j           m           V        T�k�    �   j   l  Q      @set undofile                " keep undo history between sessions5�_�                    k   ?    ����                                                                                                                                                                                                                                                                                                                           j           m           V        T�k�     �   h   i  Q      set ttimeoutlen=10   set timeoutlen=1000�   J   M  S    5�_�                    g        ����                                                                                                                                                                                                                                                                                                                           i           l           V        T�k�     �   f   h        5�_�                    g        ����                                                                                                                                                                                                                                                                                                                           j           m           V        T�k�    �   g   h  P    �   g   h  P      set ttimeoutlen=105�_�                     h       ����                                                                                                                                                                                                                                                                                                                           j           m           V        T�k�     �   g   i  Q      %set ttimeoutlen=10  " make ESC faster5�_�      !               g       ����                                                                                                                                                                                                                                                                                                                           J           M           V        T�k�    �   f   h  Q      *set timeoutlen=1000 " keep time for macros5�_�       "           !   J        ����                                                                                                                                                                                                                                                                                                                           J           J           V        T�k�   ! �   I   N        5�_�   !   #           "   E       ����                                                                                                                                                                                                                                                                                                                           J           J           V        T�k�   " �   D   F  M      set iskeyword+=_5�_�   "   %           #   D        ����                                                                                                                                                                                                                                                                                                                           I           I           V        T�l   # �   C   E        5�_�   #   &   $       %   D        ����                                                                                                                                                                                                                                                                                                                           H           H           V        T�l   % �   Y   Z  L      set iskeyword+=_�   C   E  M    5�_�   %   '           &   [       ����                                                                                                                                                                                                                                                                                                                           H           H           V        T�l1   ' �   Z   \  L      >set scrolloff=1     " cursor will never reach bottom of window5�_�   &   (           '   >   
    ����                                                                                                                                                                                                                                                                                                                           H           H           V        T�lS   ) �   =   ?  L      " Settings {{{15�_�   '               (   Y       ����                                                                                                                                                                                                                                                                                                                           H           H           V        T�ln   - �   X   Z  L      setglobal iskeyword+=_5�_�   #           %   $   D        ����                                                                                                                                                                                                                                                                                                                           H           H           V        T�l     �   C   E        5�_�                   O        ����                                                                                                                                                                                                                                                                                                                           O           O           V        T�k�     �   N   S        5�_�                     i        ����                                                                                                                                                                                                                                                                                                                           O           O           V        T�k�    �   i   j  M    �   i   j  M      :set undodir=~/.vim/undodir/ " directory MUST already exist   set undofile   ,set undolevels=1000         " How many undos   >set undoreload=10000        " number of lines to save for undo5�_�                    [        ����                                                                                                                                                                                                                                                                                                                           \   :       p   .       V   :    T�k�     �   Z   \        5�_�                       5    ����                                                                                                                                                                                                                                                                                                                                                            T�"�     �        Q       5��