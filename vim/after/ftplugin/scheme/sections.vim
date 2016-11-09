"=============================================================================
"     File: sections.vim
"  Created: 10/28/2016, 00:57
"   Author: Bernie Roesler
"
"  Description: Control section movements in scheme files
"
"=============================================================================
function! s:NextSection(type, backwards, visual)
    if a:visual
        normal! gv
    endif

    if a:type == 1
        " In scheme use (define, or beginning of file
        let pattern ='\v(^\s*\(define|%^|%$)'
        let flags = ''     " 'e' move to end of pattern
    elseif a:type == 2
        " Could define a second pattern here
        let pattern ='\v(^\s*\(define|%^|%$)'
        let flags = ''
    endif

    if a:backwards
        let dir = '?'
    else
        let dir = '/'
    endif

    execute 'silent normal! ' . dir . pattern . dir . flags . "\r"
endfunction

" Maps that work as movements and motions
noremap <script> <buffer> <silent> ]] :call <SID>NextSection(1, 0, 0)<CR>
noremap <script> <buffer> <silent> [[ :call <SID>NextSection(1, 1, 0)<CR>
noremap <script> <buffer> <silent> ][ :call <SID>NextSection(2, 0, 0)<CR>
noremap <script> <buffer> <silent> [] :call <SID>NextSection(2, 1, 0)<CR>

" Visual mappings
vnoremap <script> <buffer> <silent> ]] :<C-u>call <SID>NextSection(1, 0, 1)<CR>
vnoremap <script> <buffer> <silent> [[ :<C-u>call <SID>NextSection(1, 1, 1)<CR>
vnoremap <script> <buffer> <silent> ][ :<C-u>call <SID>NextSection(2, 0, 1)<CR>
vnoremap <script> <buffer> <silent> [] :<C-u>call <SID>NextSection(2, 1, 1)<CR>
"=============================================================================
"=============================================================================
