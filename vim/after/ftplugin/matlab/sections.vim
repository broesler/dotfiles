"=============================================================================
"     File: sections.vim
"  Created: 10/02/2016, 19:17
"   Author: Bernie Roesler
"
"  Description: Control section movements in matlab files
"
"=============================================================================
function! s:NextSection(type, backwards, visual)
    if a:visual
        normal! gv
    endif

    if a:type == 1
        " In Matlab %% gives a 'section' header. 
        " Look for beginning of section, or the beginning of the file
        let pattern ='\v(^\s*\%\%(\s|$)|^\s*<(for|if|switch)>|%^)'
        let flags = ''     " 'e' move to end of pattern
    elseif a:type == 2
        " Look for end of section, or the end of the file
        let pattern ='\v(\n^\s*\%\%(\s|$)|^\s*<end>|%$)'
        let flags = ''
    endif

    if a:backwards
        let dir = '?'
    else
        let dir = '/'
    endif

    " let save_wrapscan = &wrapscan
    " set nowrapscan
    execute 'silent normal! ' . dir . pattern . dir . flags . "\r"
    " let &wrapscan = save_wrapscan
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
