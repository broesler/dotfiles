"===============================================================================
"    File: ~/.vim/syntax/matlab.vim
"  Author: Bernie Roesler
" Credits: Michael Kruszec <mkruszec@interia.pl>
"          Preben "Peppe" Guldberg <c928400@student.dtu.dk>
"          Original author: Mario Eusebio
"
" Last Updated: 02/23/2016, 19:04
"===============================================================================

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

" Do not match keywords preceded by a dot '.', these are structure field names
" syn match DotKeyStart '\.' nextgroup=DotKeys
" To highlight structure field names, use i.e.
"+ syn keyword DotKeys contained Keyword1 Keyword2

syn keyword matlabConditional           if else elseif end otherwise true false
syn keyword matlabExceptions            try catch throw rethrow
syn keyword matlabFunction              function warning error eval 
syn keyword matlabImplicit              clear clc clf clr
syn keyword matlabLabel                 case switch
syn keyword matlabOO                    classdef properties events methods
syn keyword matlabRepeat                for while parfor 
syn keyword matlabScope                 global persistent
syn keyword matlabStatement             return break continue

syn match matlabArithmeticOperator      display "[-+]"
syn match matlabArithmeticOperator      display "\.\=[*/\\^]"
syn match matlabRelationalOperator      display "[=~]="
syn match matlabRelationalOperator      display "[<>]=\="
syn match matlabLogicalOperator         display "[&|~]"

" Highlight callouts in comments
syn match matlabTodo contained "\(TODO\|NOTE\|FIXME\):\="
syn match matlabTab display "\t"

syn match matlabComment display "%.*$" contains=matlabTodo,matlabTab,matlabCommentTitle
syn match matlabComment display "\.\.\..*$" contains=matlabTodo,matlabCommentTitle
syn match matlabCommentTitle '%\s*\%([sS]:\|\h\w*#\)\=\u\w*\(\s\+\u\w*\)*:'hs=s+1 contained contains=matlabTodo

" NOTE: To match block comments '%{' and '%}' must start lines by themselves,
"+  with no other non-spaces before or after them
syn region matlabMultilineComment start=/^\s*%{\s*$/ end=/^\s*%}\s*$/ contains=matlabTodo

syn match matlabContinueLine  display "\.\{3}"

syn region matlabString display start=+'+ end=+'+ oneline skip=+''+     contains=matlabCtrlSeq,matlabFormat

" Standard numbers
syn match matlabNumber   "\<\d\+[ij]\=\>"
syn match matlabFloat    "\<\d\+\(\.\d*\)\=\([edED][-+]\=\d\+\)\=[ij]\=\>"
syn match matlabFloat    "\.\d\+\([edED][-+]\=\d\+\)\=[ij]\=\>"

" Transpose character and delimiters: Either use just [...] or (...) as well
syn match matlabDelimiter          "[][]"
syn match matlabTransposeOperator  display "\([])a-zA-Z0-9.]\)\@<='"
syn match matlabSemicolon          display ";"

" FIXME Field names are preceded by a dot
syn match matlabFieldName       "\.\I\i*" transparent

" Match 
syn match matlabError   "-\=\<\d\+\.\d\+\.[^*/\\^]"
syn match matlabError   "-\=\<\d\+\.\d\+[eEdD][-+]\=\d\+\.\([^*/\\^]\)"

" Control sequences
syn match   matlabCtrlSeq	"\\\d\d\d\|\\[abcfnrtv0]"			contained
syn match	matlabFormat	display "%\(\d\+\$\)\=[-+' #0*]*\(\d*\|\*\|\*\d\+\$\)\(\.\(\d*\|\*\|\*\d\+\$\)\)\=\([hlL]\|ll\)\=\([bdiuoxXDOUfeEgGcCsSpn]\|\[\^\=.[^]]*\]\)" contained

"------------------------------------------------------------------------------
"       Link highlights to colors  {{{
"------------------------------------------------------------------------------
if !exists("did_matlab_syntax_inits")
  hi def link matlabArithmeticOperator    matlabOperator
  hi def link matlabComment               Comment
  hi def link matlabCommentTitle          PreProc
  hi def link matlabConditional           Conditional
  hi def link matlabCtrlSeq               Special
  hi def link matlabDelimiter             Identifier
  hi def link matlabError                 Error
  hi def link matlabExceptions            Conditional
  hi def link matlabFloat                 Float
  hi def link matlabFormat                SpecialChar
  hi def link matlabFunction              Function
  hi def link matlabImplicit              Statement
  hi def link matlabLabel                 Label
  hi def link matlabContinueLine          matlabStatement
  hi def link matlabLogicalOperator       matlabOperator
  hi def link matlabMultilineComment      Comment
  hi def link matlabNumber                Number
  hi def link matlabOO                    Statement
  hi def link matlabOperator              Operator
  hi def link matlabRelationalOperator    matlabOperator
  hi def link matlabRepeat                matlabOperator
  hi def link matlabScope                 Type
  hi def link matlabSemicolon             Statement
  " hi def link matlabStatement             Statement
  hi def link matlabStatement             Function
  hi def link matlabString                String
  hi def link matlabTodo                  Todo
  hi def link matlabTransposeOperator     matlabOperator
  hi def link matlabTransposeOther        Identifier

  " Use magenta like in actual MATLAB instead of standard blue
  " hi matlabString                         ctermfg=125

  " optional highlighting
  hi def link matlabIdentifier            Identifier
  hi def link matlabTab                   Error

endif
"}}}

" Make sure block comments synchronize properly, but syntax isn't super slow
" if we have a really long file
syn sync minlines=200

" Set syntax file for current buffer
let b:current_syntax = "matlab"

"===============================================================================
"===============================================================================
