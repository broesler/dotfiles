"=============================================================================
"     File: ~/.vim/after/ftplugin/fortran.vim
"  Created: 10/29/2016, 08:27
"   Author: Bernie Roesler
"
"  Description: Fortran filetype settings
"
"=============================================================================
" Buffer-local settings {{{
setlocal expandtab
setlocal iskeyword+=_
setlocal nowrap

setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4

setlocal comments=n:!
setlocal commentstring=!%s

setlocal foldlevelstart=20
setlocal foldmethod=indent

let b:fortran_more_precise=1  " more precise syntax
let b:fortran_do_enddo=1      " indent do loops

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
  set textwidth=80       " no specific fixed width necessary, but it's nice
  set colorcolumn=80
endif
"}}}
" Syntax highlighting {{{
" highlight tabs in fortran files, need to make spaces
hi link fortranTab Error

" Syntax highlight 'NOTE:' in comments for clarity
syn match Notes display '(NOTE|TODO|FIXME)'
hi link Notes PreProc

"}}}
" Compiling options {{{
" Map \M to make in background
nnoremap <Leader>M :silent! make <bar> :redraw!<CR>
set makeprg=make

" Report warnings as well as errors
set errorformat=%A%f:%l:%c:,%A%f:%l:,%C,%C%p%*[0123456789^],%Z%trror:\ %m,%Z%tarning:\ %m,%C%.%#
"}}}
