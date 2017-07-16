#!/bin/bash
function skim ()
{
    open -a /Applications/Skim.app "$@"
}
export -f skim
