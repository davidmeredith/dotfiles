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
# TODO add customisations to cheat
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
		lazygit \
		go-task/tap/go-task \
		tealdeer

	$(brew --prefix)/opt/fzf/install

	#zim
	curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
fi

#sh -c "$(curl -fsSL https://starship.rs/install.sh)"

# Ubuntu via apt
# distro package version of neovim is not adequate on ubuntu
if [ -x "$(command -v apt-get)" ]; then
	sudo apt -y install build-essential unzip zip zsh libfuse2 zlib1g-dev
	curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
	sudo apt install fzf ripgrep jq bat hexyl tmux fd-find
	curl -s "https://get.sdkman.io" | bash

	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
	chmod u+x nvim.appimage
	sudo mv nvim.appimage /usr/bin/nvim
	#nvim.appimage

	# lazygit
	LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
	curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
	tar xf lazygit.tar.gz lazygit
	sudo install lazygit /usr/local/bin
	rm lazygit.tar.gz lazygit

	sudo snap install dust

	# Change shell to zsh
	# chsh might not work (had issues on ubuntu), so change the shell to /bin/zsh in /etc/passwd
	#chsh -s $(which zsh)
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

# Nvim config (used to use kickstart, now use my fork of lazyvim)
#echo "Cloning kickstart into ~/.config/nvim"
#git clone https://github.com/davidmeredith/kickstart.nvim.git ~/.config/nvim
git clone https://github.com/davidmeredith/lazyvim.git ~/.config/nvim

echo "Done"
echo "Required actions:"
echo "   - Install tmux plugins with 'tmux-prefix + I' (capital i, as in Install, default tmux prefix is Ctrl-b)."
echo "   - Install vim plugins within vim with :Lazy"
if [ -x "$(command -v apt-get)" ]; then
	echo "Shell is: " $SHELL
	echo "IF above isn't /bin/zsh, update your default shell: 'sudo /etc/passwd' and change to /bin/zsh"
fi
echo "Finished. Restart your shell for changes to take effect."
