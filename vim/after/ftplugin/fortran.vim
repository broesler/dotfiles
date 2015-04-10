"==============================================================================
"       Fortran settings
"==============================================================================
setlocal expandtab
setlocal iskeyword+=_

setlocal tabstop=4            " tabs every 4 spaces
setlocal softtabstop=4        " let backspace delete indent
setlocal shiftwidth=4         " lines >> 2 spaces, use >>. for 4, etc.

let b:fortran_more_precise=1  " more precise syntax
let b:fortran_do_enddo=1      " indent do loops

" highlight tabs in fortran files, need to make spaces
hi link fortranTab Error

" Enable free format or fixed depending on file type
let s:extfname = expand("%:e")
if s:extfname ==? "f"
  let b:fortran_fixed_source=1
  unlet! fortran_free_source
  set textwidth=72
  set colorcolumn=72
else
  let b:fortran_free_source=1
  unlet! fortran_fixed_source
  set textwidth=80
  set colorcolumn=80
endif

"------------------------------------------------------------------------------
"       Local autocmds
"------------------------------------------------------------------------------
" autocmd BufWritePost,FileWritePost <buffer> silent call UpdateTags()

"------------------------------------------------------------------------------
"       Compiling options
"------------------------------------------------------------------------------
" Map \M to make in background
nnoremap <Leader>M :silent! make <bar> redraw!<CR>

" Report warnings as well as errors
set errorformat=%A%f:%l.%c:,%A%f:%l:,%C,%C%p%*[0123456789^],%Z%trror:\ %m,%Z%tarning:\ %m,%C%.%#

"==============================================================================
"==============================================================================
