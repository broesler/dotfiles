"------------------------------------------------------------------------------
"       Text file settings
"------------------------------------------------------------------------------
setlocal iskeyword+=_
setlocal tabstop=4       " tabs every 4 spaces
setlocal softtabstop=0   " set to 4 to let backspace delete indent with expandtab
setlocal shiftwidth=4    " use >>, << for line shifting
setlocal expandtab       " use spaces instead of tab character (need for Fortran)

" set complete to include dictionary for text or latex files
" setlocal complete+=k

setlocal commentstring="#%s"
