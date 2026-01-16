"=============================================================================
"     File: pyrex.vim
"  Created: 2025-08-15 21:18
"   Author: Bernie Roesler
"
"  Description:  Filetype plugin for Cython files (.pyx, .pxd, .pxi)
"
"=============================================================================

setlocal textwidth=87  " 79 is PEP8 standard, 87 is numpy/scipy style
setlocal makeprg=cython-lint\ %:p

" These lines are copied from python.vim and add the Cython "cdef" and "cpdef"
let b:next_toplevel='\v%$\|^(class\|def\|async def\|cdef\|cpdef)>'
let b:prev_toplevel='\v^(class\|def\|async def\|cdef\|cpdef)>'
let b:next_endtoplevel='\v%$\|\S.*\n+(def\|class\|cdef\|cpdef)'
let b:prev_endtoplevel='\v\S.*\n+(def\|class\|cdef\|cpdef)'
let b:next='\v%$\|^\s*(class\|def\|async def\|cdef\|cpdef)>'
let b:prev='\v^\s*(class\|def\|async def\|cdef\|cpdef)>'
let b:next_end='\v\S\n*(%$\|^(\s*\n*)*(class\|def\|async def\|cdef\|cpdef)\|^\S)'
let b:prev_end='\v\S\n*(^(\s*\n*)*(class\|def\|async def\|cdef\|cpdef)\|^\S)'

if !exists('g:no_plugin_maps') && !exists('g:no_python_maps')
    execute "nnoremap <silent> <buffer> ]] :<C-U>call <SID>Python_jump('n', '". b:next_toplevel."', 'W', v:count1)<cr>"
    execute "nnoremap <silent> <buffer> [[ :<C-U>call <SID>Python_jump('n', '". b:prev_toplevel."', 'Wb', v:count1)<cr>"
    execute "nnoremap <silent> <buffer> ][ :<C-U>call <SID>Python_jump('n', '". b:next_endtoplevel."', 'W', v:count1, 0)<cr>"
    execute "nnoremap <silent> <buffer> [] :<C-U>call <SID>Python_jump('n', '". b:prev_endtoplevel."', 'Wb', v:count1, 0)<cr>"
    execute "nnoremap <silent> <buffer> ]m :<C-U>call <SID>Python_jump('n', '". b:next."', 'W', v:count1)<cr>"
    execute "nnoremap <silent> <buffer> [m :<C-U>call <SID>Python_jump('n', '". b:prev."', 'Wb', v:count1)<cr>"
    execute "nnoremap <silent> <buffer> ]M :<C-U>call <SID>Python_jump('n', '". b:next_end."', 'W', v:count1, 0)<cr>"
    execute "nnoremap <silent> <buffer> [M :<C-U>call <SID>Python_jump('n', '". b:prev_end."', 'Wb', v:count1, 0)<cr>"

    execute "onoremap <silent> <buffer> ]] :call <SID>Python_jump('o', '". b:next_toplevel."', 'W', v:count1)<cr>"
    execute "onoremap <silent> <buffer> [[ :call <SID>Python_jump('o', '". b:prev_toplevel."', 'Wb', v:count1)<cr>"
    execute "onoremap <silent> <buffer> ][ :call <SID>Python_jump('o', '". b:next_endtoplevel."', 'W', v:count1, 0)<cr>"
    execute "onoremap <silent> <buffer> [] :call <SID>Python_jump('o', '". b:prev_endtoplevel."', 'Wb', v:count1, 0)<cr>"
    execute "onoremap <silent> <buffer> ]m :call <SID>Python_jump('o', '". b:next."', 'W', v:count1)<cr>"
    execute "onoremap <silent> <buffer> [m :call <SID>Python_jump('o', '". b:prev."', 'Wb', v:count1)<cr>"
    execute "onoremap <silent> <buffer> ]M :call <SID>Python_jump('o', '". b:next_end."', 'W', v:count1, 0)<cr>"
    execute "onoremap <silent> <buffer> [M :call <SID>Python_jump('o', '". b:prev_end."', 'Wb', v:count1, 0)<cr>"

    execute "xnoremap <silent> <buffer> ]] :call <SID>Python_jump('x', '". b:next_toplevel."', 'W', v:count1)<cr>"
    execute "xnoremap <silent> <buffer> [[ :call <SID>Python_jump('x', '". b:prev_toplevel."', 'Wb', v:count1)<cr>"
    execute "xnoremap <silent> <buffer> ][ :call <SID>Python_jump('x', '". b:next_endtoplevel."', 'W', v:count1, 0)<cr>"
    execute "xnoremap <silent> <buffer> [] :call <SID>Python_jump('x', '". b:prev_endtoplevel."', 'Wb', v:count1, 0)<cr>"
    execute "xnoremap <silent> <buffer> ]m :call <SID>Python_jump('x', '". b:next."', 'W', v:count1)<cr>"
    execute "xnoremap <silent> <buffer> [m :call <SID>Python_jump('x', '". b:prev."', 'Wb', v:count1)<cr>"
    execute "xnoremap <silent> <buffer> ]M :call <SID>Python_jump('x', '". b:next_end."', 'W', v:count1, 0)<cr>"
    execute "xnoremap <silent> <buffer> [M :call <SID>Python_jump('x', '". b:prev_end."', 'Wb', v:count1, 0)<cr>"
endif

" Directly copied from python.vim
if !exists('*<SID>Python_jump')
  fun! <SID>Python_jump(mode, motion, flags, count, ...) range
      let l:startofline = (a:0 >= 1) ? a:1 : 1

      if a:mode == 'x'
          normal! gv
      endif

      if l:startofline == 1
          normal! 0
      endif

      let cnt = a:count
      mark '
      while cnt > 0
          call search(a:motion, a:flags)
          let cnt = cnt - 1
      endwhile

      if l:startofline == 1
          normal! ^
      endif
  endfun
endif

