#==============================================================================
#    File: ~/.Rprofile
# Created: 2020-06-05 09:00
#  Author: Bernie Roesler
#
# Description: Contains aliases and settings for use with R
#==============================================================================

options(prompt="R> ",
        continue="... ",
        digits=4,
        show.signif.stars=FALSE,
        useFancyQuotes=FALSE,
        max=10,
        max.print=100L,
        width=as.integer(system("tput cols", intern=TRUE)),
        repos=structure(c(CRAN="http://cran.r-project.org"))
        )

.Last <- function(){
  if(interactive()){
    hist_file <- Sys.getenv("R_HISTFILE")
    if(hist_file=="") hist_file <- "~/.RHistory"
    savehistory(hist_file)
  }
}

#==============================================================================
#==============================================================================
# vim: ft=r
