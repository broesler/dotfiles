"=============================================================================
"     File: markdown.vim
"  Created: 2025-02-25 16:12
"   Author: Bernie Roesler
"
"  Description: Settings for markdown files.
"
"=============================================================================

set tw=80
set fo+=t

" Keymaps in and around headers
onoremap ih :<C-u>exe "norm! ?^==\\+$\r:nohls\rkvg_"<CR>
onoremap ah :<C-u>exe "norm! ?^==\\+$\r:nohls\rg_vk0"<CR>

"=============================================================================
"=============================================================================
