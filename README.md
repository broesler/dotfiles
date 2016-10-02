##Installation:
    ```
    git clone git@bitbucket.org:broesler/dotfiles.git .dotfiles
    ```
##Create symlinks in home directory:
    ```
    chmod +x symlink_dotfiles.sh
    ./symlink_dotfiles.sh
    ```
##Switch to the `~/.vim` directory, and fetch submodules:
    ```
    cd ~/.vim
    git submodule update --init
    ```
##To update plugins
    ```
    cd ~/.vim/bundle
    git submodule foreach git pull origin master
    ```
