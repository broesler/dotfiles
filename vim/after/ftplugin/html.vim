"------------------------------------------------------------------------------
"       HTML Settings
"------------------------------------------------------------------------------
" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2

" Allow stylesheets to autocomplete hyphenated words
setlocal iskeyword+=-,_
setlocal iskeyword-=:
