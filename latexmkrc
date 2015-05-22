# ~/.latexmkrc
# vim: ft=perl syntax=perl
#==============================================================================
#    File: ~/.latexmkrc
# Created: 04/01/15
#  Author: Bernie Roesler
#
# Description: Preferences (in Perl) for latexmk
#==============================================================================

# Set pdf viewer to Skim
$pdf_previewer = "open -a /Applications/Skim.app";

# Set pdflatex to sync with tex file, report errors as %f:%l:%m, do not stop for errors
$pdflatex = "pdflatex -shell-escape -synctex=1 -file-line-error -interaction=nonstopmode %O %S";

# Extensions of files to clean
$clean_ext = "paux lox pdfsync";

#==============================================================================
#==============================================================================
