"
" Native Vim Color Scheme
" =======================
"
" author:   Armin Ronacher <armin.ronacher@active-4.com>
"
set background=dark

hi clear
if exists("syntax_on")
    syntax reset
endif

let colors_name = "native"

" Default Colors
hi Normal       ctermfg=#f2f2f2 ctermbg=#222222
hi NonText      ctermfg=#444444 ctermbg=#111111
hi Cursor       ctermbg=#aaaaaa
hi lCursor      ctermbg=#aaaaaa

" Search
hi Search	    ctermbg=peru ctermfg=wheat
hi IncSearch	cterm=NONE ctermfg=yellow ctermbg=green
hi Search	cterm=NONE ctermfg=grey ctermbg=blue

" Window Elements
hi StatusLine   ctermfg=white ctermbg=#8090a0 gui=bold
hi StatusLineNC ctermfg=#506070 ctermbg=#a0b0c0
hi VertSplit    ctermfg=#a0b0c0 ctermbg=#a0b0c0
hi Folded       ctermfg=#111111 ctermbg=#8090a0
hi IncSearch	ctermfg=slategrey ctermbg=khaki

" Specials
hi Todo         ctermfg=#e50808 ctermbg=#520000 gui=bold
hi Title        ctermfg=#ffffff gui=bold

" Strings
hi String       ctermfg=#ed9d13
hi Constant     ctermfg=#ed9d13

" Syntax
hi Number       ctermfg=#3677a9
hi Statement    ctermfg=#6ab825 gui=bold
hi Function     ctermfg=#447fcf
hi PreProc      ctermfg=#cd2828 gui=bold
hi Comment      ctermfg=#999999 gui=italic
hi Type         ctermfg=#bbbbbb gui=bold

" Diff
hi DiffAdd	    ctermbg=4
hi DiffChange	ctermbg=5
hi DiffDelete	cterm=bold ctermfg=4 ctermbg=6
hi DiffText	    cterm=bold ctermbg=1
