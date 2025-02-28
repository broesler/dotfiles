"===============================================================================
"    File: ~/.vim/syntax/matlab.vim
"  Author: Bernie Roesler
" Credits: Michael Kruszec <mkruszec@interia.pl>
"          Preben "Peppe" Guldberg <c928400@student.dtu.dk>
"          Original author: Mario Eusebio
"
" Last Updated: 02/23/2016, 19:04
"===============================================================================

" Add keywords missing from $VIMRUNTIME/syntax/matlab.vim
syn keyword matlabConditional   true false
syn keyword matlabExceptions    throw rethrow
syn keyword matlabFunction      function warning error eval 
syn keyword matlabImplicit      clc clf clr
syn keyword matlabRepeat        parfor 
syn keyword matlabStatement     continue
syn keyword matlabOperator      load

" Highlight callouts in comments
syn match matlabTodo display containedin=matlabComment "\(TODO\|NOTE\|FIXME\)\="

syn match matlabCommentTitle '%\s*\%([sS]:\|\h\w*#\)\=\u\w*\(\s\+\u\w*\)*:'hs=s+1 contained contains=matlabTodo
syn cluster matlabComment add=MatlabCommentTitle

" NOTE: To match block comments '%{' and '%}' must start lines by themselves,
"+  with no other non-spaces before or after them
syn region matlabMultilineComment start=/^\s*%{\s*$/ end=/^\s*%}\s*$/ contains=matlabTodo

syn match matlabContinueLine  display "\.\{3}"

syn cluster matlabString add=matlabCtrlSeq,matlabFormat

" FIXME Field names are preceded by a dot
" Do not match keywords preceded by a dot '.', these are structure field names
" syn match DotKeyStart '\.' nextgroup=DotKeys
" To highlight structure field names, use i.e.
"+ syn keyword DotKeys contained Keyword1 Keyword2
syn match matlabFieldName       "\.\I\i*" transparent

" Control sequences
syn match   matlabCtrlSeq	"\\\d\d\d\|\\[abcfnrtv0]"			contained
syn match	matlabFormat	display "%\(\d\+\$\)\=[-+' #0*]*\(\d*\|\*\|\*\d\+\$\)\(\.\(\d*\|\*\|\*\d\+\$\)\)\=\([hlL]\|ll\)\=\([bdiuoxXDOUfeEgGcCsSpn]\|\[\^\=.[^]]*\]\)" contained

" Optional highlighting from $VIMRUNTIME/syntax/matlab.vim
syn match matlabIdentifier      "\<\a\w*\>"

"------------------------------------------------------------------------------
"       Link highlights to colors  {{{
"------------------------------------------------------------------------------
hi def link matlabCommentTitle          PreProc
hi def link matlabCtrlSeq               Special
hi def link matlabFormat                SpecialChar
hi def link matlabContinueLine          matlabStatement

hi def link matlabIdentifier            Identifier
hi def link matlabTab                   Error
"}}}

" Make sure block comments synchronize properly, but syntax isn't super slow
" if we have a really long file
syn sync minlines=200

"===============================================================================
"===============================================================================
