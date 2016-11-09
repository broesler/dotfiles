"------------------------------------------------------------------------------
"       Text file settings
"------------------------------------------------------------------------------
setlocal tabstop=8       " tabs every 4 spaces
setlocal softtabstop=0   " set to 4 to let backspace delete indent with expandtab
setlocal shiftwidth=8    " use >>, << for line shifting
setlocal noexpandtab     " use spaces instead of tab character

setlocal textwidth=80
setlocal fo-=l           " wrap text while writing

setlocal iskeyword+=_

setlocal comments+=:#
setlocal commentstring=#%s

" Make line into a comment header with dashes
let @h='O#79a-jI#8a o#79a-k$'
