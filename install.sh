#!/bin/bash


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
    echo "Installing zsh ..."
    apt -y install build-essential unzip zip zsh
    # Don't change default shell in this script as we use bash later on
    #chsh -s $(which zsh) 
fi

if [ -x "$(command -v apt-get)" ]; then
    curl -s "https://get.sdkman.io" | bash
fi


echo "Creating configuration symlinks..."
#create_symlink .aliases

# vim (neovim config actually)
create_symlink .vimrc
rm -rf ~/.vim && create_symlink vim .vim
mkdir -p ~/.config/nvim
ln -s ~/.dotfiles/.vimrc ~/.config/nvim/init.vim

# zsh
create_symlink .zshrc
create_symlink .profile
# Install zsh_machine symlink if it exists.
# test -e .zsh_machine && create_symlink .zsh_machine

# zim 
# https://zimfw.sh/#install
create_symlink .zimrc

# tmux
# ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf
create_symlink .tmux.conf

# ideavim
# ln -s ~/.dotfiles/.ideavimrc ~/.ideavimrc
create_symlink .ideavimrc

# fish (don't use anymore)
#mv ~/.config/fish ~/.config/fish_backup 2> /dev/null || true
#create symlink fish .config/fish
#if [[ "$OSTYPE" == "darwin"* ]]; then
#    # macOS
#    curl -L https://iterm2.com/shell_integration/fish \
#    -o ~/.iterm2_shell_integration.fish
#    # For tmux powerline, you need to ensure 'Use built-in powerline glyphs' is 
#    # checked in iterm preferences | Profiles | Text
#fi

echo "Done."
echo "Installing tools..."

# Prefer not to use linuxbrew anymore
# install brew if not not available (eg on debian) 
#if ! [ -x "$(command -v brew)" ]; then
#    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
#
#    # Homebrew post-installation steps.
#    if test -e /home/linuxbrew/.linuxbrew/bin/brew; then
#        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
#    else
#        eval "$(/opt/homebrew/bin/brew shellenv)"
#    fi
#fi

# Mac via brew 
if [[ "$OSTYPE" == "darwin"* ]]; then
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
fi

#sh -c "$(curl -fsSL https://starship.rs/install.sh)"

# Ubuntu via apt
if [ -x "$(command -v apt-get)" ]; then
    curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
    apt install neovim fzf ripgrep jq bat hexyl 
fi 

echo "Done."



echo "Setting up vim and plugins..."
vim +PlugInstall +qall
#cd vim/plugged/YouCompleteMe
#./install.py --all
cd -
echo "Done."


echo
echo "Finished installing dotfiles. Restart your shell for changes to take effect."


