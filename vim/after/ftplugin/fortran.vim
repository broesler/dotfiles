"------------------------------------------------------------------------------
"       Fortran settings
"------------------------------------------------------------------------------
setlocal expandtab
setlocal iskeyword+=_

setlocal tabstop=4       " tabs every 4 spaces
setlocal softtabstop=4   " let backspace delete indent
setlocal shiftwidth=4    " lines >> 2 spaces, use >>. for 4, etc.

let b:fortran_free_source=1   " Enable free format
let b:fortran_more_precise=1  " more precise syntax
let b:fortran_do_enddo=1    " indent do loops

" highlight tabs in fortran files, need to make spaces
hi link fortranTab ctermbg=darkred

