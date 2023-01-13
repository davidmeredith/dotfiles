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



echo "Creating configuration symlinks..."
#create_symlink .aliases

# neovim 
#create_symlink .vimrc
#rm -rf ~/.vim && create_symlink vim .vim
mkdir -p ~/.config/nvim
#ln -s ~/.dotfiles/.vimrc ~/.config/nvim/init.vim
ln -s ~/.dotfiles/init.lua ~/.config/nvim/init.lua

# zsh
create_symlink .zshrc
create_symlink .zprofile
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
    sudo apt -y install build-essential unzip zip zsh
    curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
    sudo apt install neovim fzf ripgrep jq bat hexyl tmux 
    sudo curl -s "https://get.sdkman.io" | zsh 
fi 

echo "Done."


echo "Setting up vim plugins..."
vim +PlugInstall +qall
#cd vim/plugged/YouCompleteMe
#./install.py --all
cd -
echo "Done."

echo "Setting up tmux plugins"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source ~/.tmux.conf
echo "Done - remember to Press prefix + I (capital i, as in Install) to install tmux plugins."

echo
echo "Finished installing dotfiles. Restart your shell for changes to take effect."


