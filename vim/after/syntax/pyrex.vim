"=============================================================================
"     File: pyrex.vim
"  Created: 2025-11-12 10:03
"   Author: Bernie Roesler
"
"  Description: Filetype plugin for Cython files (.pyx, .pxd, .pxi)
"
"=============================================================================

" These lines are present in $VIMRUNTIME/syntax/python.vim, but don't have the
" word boundaries, so things like "_ndarray_from_cholmod" get highlighted.
" Override these lines here.
syn clear   pythonInclude
syn keyword pythonInclude     import
syn match   pythonInclude     "\<from\>"

" Add some common keywords for clarity
syn keyword pyrexType        bint int32_t int64_t uintptr_t size_t
syn keyword pyrexType        const inline
