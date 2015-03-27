"------------------------------------------------------------------------------
"       CSS Settings
"------------------------------------------------------------------------------
" Treat <li> and <p> tags like the block tags they are
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2

" Allow stylesheets to autocomplete hyphenated words
setlocal iskeyword+=-,_
setlocal iskeyword-=:

" Correct auto-completion
setlocal omnifunc=csscomplete#CompleteCSS
