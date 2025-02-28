"===============================================================================
"    File: ~/.vim/after/syntax/matlab.vim
" Created: 2025-02-28 10:30
"  Author: Bernie Roesler
"
" Description: Additions to the matlab syntax highlighting
"===============================================================================

" Add keywords missing from $VIMRUNTIME/syntax/matlab.vim
syn keyword matlabConditional   true false
syn keyword matlabExceptions    throw rethrow
syn keyword matlabFunction      function warning error eval 
syn keyword matlabImplicit      close clc clf clr
syn keyword matlabRepeat        parfor 
syn keyword matlabStatement     continue
syn keyword matlabOperator      load

" Highlight callouts in comments
syn clear matlabTodo
syn match matlabTodo display    "\(TODO\|NOTE\|FIXME\)\="   contained containedin=matlabComment

syn match matlabCommentTitle    '%\s*\%([sS]:\|\h\w*#\)\=\u\w*\(\s\+\u\w*\)*:'hs=s+1  contained contains=matlabTodo containedin=matlabComment

" NOTE: To match block comments '%{' and '%}' must start lines by themselves,
"+  with no other non-spaces before or after them
syn region matlabMultilineComment start=/^\s*%{\s*$/ end=/^\s*%}\s*$/ contains=matlabTodo

syn match matlabContinueLine  display "\.\{3}"

" FIXME Field names are preceded by a dot
" Do not match keywords preceded by a dot '.', these are structure field names
" syn match DotKeyStart '\.' nextgroup=DotKeys
" To highlight structure field names, use i.e.
"+ syn keyword DotKeys contained Keyword1 Keyword2
syn match matlabFieldName       "\.\I\i*" transparent

" Control sequences
syn match   matlabCtrlSeq	"\\\d\d\d\|\\[abcfnrtv0]"			contained containedin=matlabString
syn match	matlabFormat	display "%\(\d\+\$\)\=[-+' #0*]*\(\d*\|\*\|\*\d\+\$\)\(\.\(\d*\|\*\|\*\d\+\$\)\)\=\([hlL]\|ll\)\=\([bdiuoxXDOUfeEgGcCsSpn]\|\[\^\=.[^]]*\]\)" contained containedin=matlabString

" Optional highlighting from $VIMRUNTIME/syntax/matlab.vim
" syn match matlabIdentifier      "\<\a\w*\>"

"------------------------------------------------------------------------------
"       Link highlights to colors  {{{
"------------------------------------------------------------------------------
hi def link matlabCommentTitle          PreProc
hi def link matlabCtrlSeq               Special
hi def link matlabFormat                SpecialChar
hi def link matlabContinueLine          matlabStatement

" hi def link matlabIdentifier            Identifier
hi def link matlabTab                   Error
"}}}

" Make sure block comments synchronize properly, but syntax isn't super slow
" if we have a really long file
syn sync minlines=200

"===============================================================================
"===============================================================================
