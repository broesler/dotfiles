## Installation:

```shell
git clone git@bitbucket.org:broesler/dotfiles.git .dotfiles
```

## Create symlinks in home directory:

```shell
chmod +x symlink_dotfiles.sh
./symlink_dotfiles.sh
```

## Switch to the `~/.vim` directory, and fetch submodules:

```shell
cd ~/.vim
git submodule update --init
```

## To update plugins

```shell
cd ~/.vim/bundle
git submodule foreach git pull origin master
```

