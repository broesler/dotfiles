# Attach to existing tmux session rather than create a new one if possible
function tmuxx() 
{
    # Force tmux to use 256 colors with -2 option (get solarized right)
    TMUX_CMD="command tmux -2"

    # If given any arguments, just use them as they are
    if (($#)) ; then
        args="$@"
    elif command tmux has-session 2>/dev/null ; then
        args="attach-session -d"
    else
        args="new-session -s \"${TMUX_SESSION:-default}\""
    fi

    $TMUX_CMD $args
}
export -f tmuxx
