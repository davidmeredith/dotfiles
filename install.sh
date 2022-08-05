#!/bin/bash

# Inspired from Drew Silcock, with thanks.

create_symlink() {
    echo "... $1"

    if [ $# -eq 2 ]
    then
        ln -s -f -F ~/.dotfiles/$1 ~/$2
    else
        ln -s -f -F ~/.dotfiles/$1 ~/$1
    fi
}

# install zsh if on debian (zsh now default on mac)
if [ -x "$(command -v apt-get)" ]; then
    echo "[0/3] Installing zsh ..."
    sudo apt-get install build-essential
    sudo apt install zsh
    # Don't bother chaning default shell in this script as we use bash later on
    #chsh -s $(which zsh) 
fi

echo "[1/3] Creating configuration symlinks..."
create_symlink .vimrc
#create_symlink .aliases
rm -rf ~/.vim && create_symlink vim .vim

mkdir -p ~/.config/nvim
ln -s ~/.dotfiles/.vimrc ~/.config/nvim/init.vim

create_symlink .zshrc
create_symlink .profile
# Install zsh_machine symlink if it exists.
# test -e .zsh_machine && create_symlink .zsh_machine

# zim 
# https://zimfw.sh/#install
create_symlink .zimrc
curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh


# Create link for tmux:
# ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf
create_symlink .tmux.conf

# ln -s ~/.dotfiles/.vimrc ~/.ideavimrc
create_symlink .ideavimrc

mv ~/.config/fish ~/.config/fish_backup 2> /dev/null || true
create symlink fish .config/fish

if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    curl -L https://iterm2.com/shell_integration/fish \
    -o ~/.iterm2_shell_integration.fish
    # For tmux powerline, you need to ensure 'Use built-in powerline glyphs' is 
    # checked in iterm preferences | Profiles | Text
fi

echo "[1/3] Done."
echo "[2/3] Installing tools..."


# install brew if not not available (eg on debian) 
if ! [ -x "$(command -v brew)" ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Homebrew post-installation steps.
    if test -e /home/linuxbrew/.linuxbrew/bin/brew; then
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    else
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
fi


# Now install tools using brew 
brew install \
    fish \
    neovim \
    exa \
    starship \
    jq \
    bat \
    fzf \
    hexyl \
    tmux \
    ripgrep \
    git-delta \
    go-task/tap/go-task \
    tealdeer
    
$(brew --prefix)/opt/fzf/install

#sh -c "$(curl -fsSL https://starship.rs/install.sh)"

echo "[2/3] Done."

#echo "[3/3] Setting up neovim..."
#nvim +'hi NormalFloat guibg=#1e222a' +PackerSync
#echo "[3/3] Done."




echo "[3/3] Setting up vim and plugins..."
vim +PlugInstall +qall
#cd vim/plugged/YouCompleteMe
#./install.py --all
cd -
echo "[3/3] Done."



echo
echo "Finished installing dotfiles. You may need to restart your shell for changes to take effect."


