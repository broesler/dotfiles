"=============================================================================
"     File: cpp.vim
"  Created: 05/07/2018, 15:44
"   Author: Bernie Roesler
"
"  Description: Hack to treat C++ header files differently from C files.
"
"=============================================================================

runtime after/ftplugin/c.vim  " apply C settings

augroup cpp_cmds
    autocmd!
    " Load types file
    autocmd BufRead,BufNewFile *.[ch]pp call util#HighlightTypes()
augroup END

"=============================================================================
"=============================================================================
