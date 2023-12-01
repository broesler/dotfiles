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
        width=try(as.integer(system("tput cols", intern=TRUE)), silent=TRUE),
        repos=structure(c(CRAN="http://cran.r-project.org"))
        )

cmdstanr::set_cmdstan_path("~/miniconda3/envs/stats311/bin/cmdstan/")

.Last <- function(){
    if (interactive()) {
        hist_file <- Sys.getenv("R_HISTFILE")
        if (hist_file == "") {
            hist_file <- file.path(Sys.getenv("HOME", ".Rhistory"))
        savehistory(hist_file)
    }
}

#==============================================================================
#==============================================================================
# vim: ft=r
