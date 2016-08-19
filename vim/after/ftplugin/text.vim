"------------------------------------------------------------------------------
"       Text file settings
"------------------------------------------------------------------------------
setlocal tabstop=4       " tabs every 4 spaces
setlocal softtabstop=0   " set to 4 to let backspace delete indent with expandtab
setlocal shiftwidth=4    " use >>, << for line shifting
setlocal expandtab       " use spaces instead of tab character (need for Fortran)

setlocal fo-=l                " wrap text while writing

setlocal iskeyword+=_

setlocal comments+=:#
setlocal commentstring="#%s"
