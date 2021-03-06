#!/bin/bash

# Modified from Drew Silcock, with thanks

create_symlink() {
    echo "... $1"

    if [ $# -eq 2 ]
    then
        ln -s -f -F ~/.dotfiles/$1 ~/$2
    else
        ln -s -f -F ~/.dotfiles/$1 ~/$1
    fi
}

echo "[1/2] Creating configuration symlinks..."
create_symlink .vimrc
#create_symlink .aliases
rm -rf ~/.vim && create_symlink vim .vim

create_symlink .zshrc
# Install zsh_machine symlink if it exists.
# test -e .zsh_machine && create_symlink .zsh_machine
echo "[1/2] Done."


echo "[2/2] Setting up vim and plugins..."
vim +PlugInstall +qall
#cd vim/plugged/YouCompleteMe
#./install.py --all
cd -
echo "[2/2] Done."

echo
echo "Finished installing dotfiles. You may need to restart your shell for changes to take effect."


