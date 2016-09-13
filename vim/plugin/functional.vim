"=============================================================================
"     File: functional.vim
"  Created: 09/12/2016, 19:12
"   Author: Bernie Roesler
"
"  Description: Functional programming helpers
"
"=============================================================================

function! s:Sorted(l)
  let new_list = deepcopy(a:l)
  call sort(new_list)
  return new_list
endfunction

function! s:Reversed(l)
  let new_list = deepcopy(a:l)
  call reverse(new_list)
  return new_list
endfunction

function! s:Append(l, val)
  let new_list = deepcopy(a:l)
  call add(new_list, a:val)
  return new_list
endfunction

function! s:Assoc(l, i, val)
  let new_list = deepcopy(a:l)
  let new_list[a:i] = a:val
  return new_list
endfunction

function! s:Pop(l, i)
  let new_list = deepcopy(a:l)
  call remove(new_list, a:i)
  return new_list
endfunction

function! s:Mapped(fn, l)
  let new_list = deepcopy(a:l)
  call map(new_list, string(a:fn) . '(v:val)')
  return new_list
endfunction

function! s:Filtered(fn, l)
  let new_list = deepcopy(a:l)
  call filter(new_list, string(a:fn) . '(v:val)')
  return new_list
endfunction

function! s:Removed(fn, l)
  let new_list = deepcopy(a:l)
  call filter(new_list, '!' . string(a:fn) . '(v:val)')
  return new_list
endfunction
