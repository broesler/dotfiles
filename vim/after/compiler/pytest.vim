"=============================================================================
"     File: pytest.vim
"  Created: 2021-03-19 16:48
"   Author: Bernie Roesler
"
"  Description: vim compiler options for pytest + Dispatch.vim
"
"=============================================================================
if exists("current_compiler")
  finish
endif
let current_compiler = "pytest"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=pytest\ --tb=short\ -q\ $*\ %
CompilerSet errorformat=
      \%-G=%#\ ERRORS\ =%#,
      \%-G=%#\ FAILURES\ =%#,
      \%-G%\\s%\\*%\\d%\\+\ tests\ deselected%.%#,
      \ERROR:\ %m,
      \%E_%\\+\ %m\ _%\\+,
      \%Cfile\ %f\\,\ line\ %l,
      \%CE\ %#%m,
      \%EE\ \ \ \ \ File\ \"%f\"\\,\ line\ %l,
      \%ZE\ \ \ %[%^\ ]%\\@=%m,
      \%Z%f:%l:\ %m,
      \%Z%f:%l,
      \%C%.%#,
      \%-G%.%#\ seconds,
      \%-G%.%#
