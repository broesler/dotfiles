"=============================================================================
"     File: muttrc.vim
"  Created: 10/17/2017, 09:26
"   Author: Bernie Roesler
"
"  Description: 
"
"=============================================================================
"
" Make the foreground of colorXXX keywords match the color they represent.
" Darker colors have their background set to white.
for s:i in range(0, 255)
    let s:bg = (!s:i || s:i == 16 || (s:i > 231 && s:i < 235)) ? 15 : "none"
    exec "syn match muttrcColor" . s:i . " /\\<color" . s:i . "\\>/ display"
\     " | highlight muttrcColor" . s:i . " ctermfg=" . s:i . " ctermbg=" . s:bg
endfor


