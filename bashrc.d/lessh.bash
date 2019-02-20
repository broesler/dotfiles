# Syntax highlighting for less
function lessh()
{
    hilight=$(which highlight)
    if [ $? -eq 0 ]; then
        LESSOPEN="| $hilight %s "
        LESSOPEN+="--out-format xterm256 --quiet --force --style solarized-dark"
    fi
    command less -RM "$@"
}
export -f lessh
