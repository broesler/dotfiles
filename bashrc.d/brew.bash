# Override "brew" command to get around anaconda issues
brew ()
{
    # Remove anaconda from path, run brew command, add anaconda to path
    save_path="$PATH"
    export PATH="$(command brew --prefix)/bin:/usr/bin:/bin:/usr/sbin:/sbin"
    command brew "$@"
    export PATH="$save_path"
}
export -f brew
