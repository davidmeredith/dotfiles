#!/bin/bash

echo "Check zsh is the default shell first before running"
# see: https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH

create_symlink() {
	echo "... $1"

	if [ $# -eq 2 ]; then
		ln -s -f -F ~/.dotfiles/$1 ~/$2
	else
		ln -s -f -F ~/.dotfiles/$1 ~/$1
	fi
}

echo "Creating configuration symlinks..."
#create_symlink .aliases

# neovim (a recent version is needed, >0.7)
#create_symlink .vimrc
#rm -rf ~/.vim && create_symlink vim .vim
mkdir -p $HOME/.config/nvim
#ln -s ~/.dotfiles/.vimrc ~/.config/nvim/init.vim
#ln -s ~/.dotfiles/nvim/init.lua ~/.config/nvim/init.lua

# Cheat
mkdir -p $HOME/.config/cheat
ln -s ~/.dotfiles/cheat/conf.yml ~/.config/cheat/conf.yml

# zsh
create_symlink .zshrc
create_symlink .zprofile
# Install zsh_machine symlink if it exists.
# test -e .zsh_machine && create_symlink .zsh_machine

# Zim
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
		eza \
		cheat \
		starship \
		jq \
		bat \
		fzf \
		hexyl \
		tmux \
		ripgrep \
		hyperfine \
		git-delta \
		go-task/tap/go-task \
		tealdeer

	$(brew --prefix)/opt/fzf/install
fi

#sh -c "$(curl -fsSL https://starship.rs/install.sh)"

# Ubuntu via apt
# default version of neovim is not adequate on ubuntu
if [ -x "$(command -v apt-get)" ]; then
	sudo apt -y install build-essential unzip zip zsh
	curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
	sudo apt install fzf ripgrep jq bat hexyl tmux
	curl -s "https://get.sdkman.io" | zsh
	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
	chmod u+x nvim.appimage
	sudo mv nvim.appimage /usr/bin/nvim
fi

# Vim-pane & tmux-split integration
# https://github.com/christoomey/vim-tmux-navigator
#git clone git@github.com:christoomey/vim-tmux-navigator.git ~/.vim/pack/plugins/start/vim-tmux-navigator

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

# TODO replace this with lazy
echo "Cloning kickstart into ~/.config/nvim"
git clone https://github.com/davidmeredith/kickstart.nvim.git ~/.config/nvim

echo "Done"
echo "Required actions:"
echo "   - Install tmux plugins with 'tmux-prefix + I' (capital i, as in Install, tmux prefix is likely Ctrl-a)."
echo "   - Install vim plugins within vim with :Lazy"
echo "Finished. Restart your shell for changes to take effect."
