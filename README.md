##Installation:

    ```bash
    git clone git://github.com/nelstrom/dotvim.git ~/.vim
    ```

##Create symlinks in home directory:

    ```bash
    chmod +x symlink_dotfiles.sh
    ./symlink_dotfiles.sh
    ```

##Switch to the `~/.vim` directory, and fetch submodules:

    ```bash
    cd ~/.vim
    git submodule init
    git submodule update
    ```
