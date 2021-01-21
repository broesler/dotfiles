#!/usr/bin/bash
function wopen ()
{
    cmd.exe /C start "$@"  # open a file with the default application
}
export -f wopen
