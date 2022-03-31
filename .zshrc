
# Make sure zplug is installed
if [[ ! -d ~/.zplug ]]; then
    git clone https://github.com/zplug/zplug ~/.zplug && \
        source ~/.zplug/init.zsh && \
        zplug update
else
    source ~/.zplug/init.zsh
fi

## begin zplug ##
zplug "zplug/zplug"

# Theme - https://denysdovhan.com/spaceship-prompt/
zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme

zplug "zsh-users/zsh-completions"   
# Set the priority when loading
# e.g., zsh-syntax-highlighting must be loaded
# after executing compinit command and sourcing other plugins
# (If the defer tag is given 2 or above, run after compinit command)
zplug "zsh-users/zsh-syntax-highlighting", defer:2


# oh-my-zsh features 
# Load completion library for those sweet [tab] squares
zplug "lib/completion", from:oh-my-zsh
zplug "plugins/git",   from:oh-my-zsh

# softmoth's vim zsh key bindings
# To avoid conflicts, need to load after: zsh-autosuggestions, zsh-syntax-highlighting
#zplug "softmoth/zsh-vim-mode"

# Pretty, minimal and fast ZSH prompt https://github.com/sindresorhus/pure
#zplug mafredri/zsh-async, from:github
#zplug sindresorhus/pure, use:pure.zsh, from:github, as:theme

# Install plugins that are not installed
if ! zplug check --verbose; then
     zplug install
fi

# Then, source plugins and add commands to $PATH
#zplug load --verbose
zplug load
## end zplug ##

# softmouth's vim zsh terminal cursor customisation
#MODE_CURSOR_VIINS="#00ff00 blinking bar"
#MODE_CURSOR_REPLACE="$MODE_CURSOR_VIINS #ff0000"
#MODE_CURSOR_VICMD="green block"
#MODE_CURSOR_SEARCH="#ff00ff steady underline"
#MODE_CURSOR_VISUAL="$MODE_CURSOR_VICMD steady bar"
#MODE_CURSOR_VLINE="$MODE_CURSOR_VISUAL #00ffff"

SPACESHIP_PROMPT_ORDER=(
  time          # Time stamps section
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
#  hg            # Mercurial section (hg_branch  + hg_status)
  package       # Package version
  node          # Node.js section
  ruby          # Ruby section
#  elixir        # Elixir section
#  xcode         # Xcode section
#  swift         # Swift section
  golang        # Go section
#  php           # PHP section
  rust          # Rust section
#  haskell       # Haskell Stack section
#  julia         # Julia section
  docker        # Docker section
  aws           # Amazon Web Services section
  venv          # virtualenv section
  conda         # conda virtualenv section
  pyenv         # Pyenv section
  dotnet        # .NET section
  ember         # Ember.js section
  kubectl       # Kubectl context section
  terraform     # Terraform workspace section
  exec_time     # Execution time
  line_sep      # Line break
  battery       # Battery level and status
  vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)
# below spaceship default configs true
SPACESHIP_PROMPT_ADD_NEWLINE=true
SPACESHIP_PROMPT_SEPARATE_LINE=true


# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8



# Preferred editor for local and remote sessions
#if [[ -n $SSH_CONNECTION ]]; then
#  export EDITOR='vim'
#else
#  export EDITOR='mvim'
#fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias ic="ibmcloud"
alias ls="ls -FG"

# JAVA_HOME and jdk
# http://www.mkyong.com/java/how-to-set-java_home-environment-variable-on-mac-os-x/
# to see which jdk is installed:
# /usr/libexec/java_home -V
# I want java version 1.6 (DM: this don't work for me? assuming its installed)
# /usr/libexec/java_home -v 1.6

# for latest/preferred according to the JVMs in the Java Preferences application:
#export JAVA_HOME=$(/usr/libexec/java_home)
# to manually specify:
#export JAVA_HOME=/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home
#export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_152.jdk/Contents/Home
#export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-9.0.1.jdk/Contents/Home
#export JAVA_HOME=/Library/Java/JavaVirtualMachines/adoptopenjdk-14.jdk/Contents/Home

# DM manual modifications to path, mvn, sass, macvim, vscode, ngrok
#export PATH="$HOME/bin:/usr/local/bin:$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin:/Applications/MacVim.app/Contents/bin:/usr/local/sass/dart-sass"

# PostgressApp 
PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:${PATH}"
export PATH

# Cheatsheet https://github.com/chubin/cheat.sh#usage
PATH="$HOME/myprogs/cheatsheet:${PATH}"
export PATH


# Deprecated by pyenv - Setting PATH for Python 3.8
# The original version is saved in .bash_profile.pysave
#PATH="/Library/Frameworks/Python.framework/Versions/3.8/bin:${PATH}"
#export PATH


# ===========================
# Pyenv & Pyenv-virtualenv:
# ===========================
# https://github.com/pyenv/
# https://github.com/pyenv/pyenv-virtualenv to allow easy venv with pyenv
# Manage multiple python versions with pyenv and correctly simlink pip/pip3 depending on py version
# $ brew upgrade pyenv
# $ brew upgrade pyenv-virtualenv 
#
# Pyenv useful commands: 
#  $ which python
#  $ /Users/davidmeredith/.pyenv/shims/python
# $ pyenv install --list 
# $ pyenv install <version>
# $ pyenv versions
# $ pyenv version
# $ pyenv global <version> 
#
# Pyenv Virtualenv useful commands:
# List pyenvs:
#    $ pyenv virtualenvs 
#
# Create new pyenv with specified version: 
#    $ pyenv virtualenv <py_version> <project_venv_folder>
#      e.g. 'pyenv virtualenv 3.7.1 venv3_7_1'
#
# Create new pyenv with current version: 
#   $ pyenv version
#   $ ...
#   $ pyenv virtualenv myvenv
#
# Actviate and Deactivate the pyenv:
# $ pyenv activate <pyenv_name>
# $ pyenv deactivate
#
# To delete a pyenv venv, you have to manually delete its folder, e.g.  
#   'rm -rf /Users/davidmeredith/.pyenv/versions/<pyVersion>' or 
#   'rm -rf /Users/davidmeredith/.pyenv/versions/<pyVersion>/envs/myVenv' 
#       (in last eg, myVenv was created from a particular version)
# 
# Pyenv config:
# ===============
# See '~/.zprofile' that has the following, note PATH prefix: 
#     # Set env var that points to the pyenv dir
#     export PYENV_ROOT="$HOME/.pyenv"
#     # Put pyenv first in your search path so that the OS will find 
#     # pyenv's python before any other pythons
#     export PATH="$PYENV_ROOT/bin:$PATH"
#     eval "$(pyenv init --path)"
#
#  In .zsch - init pyenv each time you open a terminal:
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi
#
# After creating a new venv, 'pip list' should show an empty list of packages 
# with just pip and setup tools. 
#
# nvim and pyenv:
# ================
# Each Python interpreter that is used with Neovim will require the neovim package.
# System wide:
#   pip3 install --user neovim
# Pyenv with Virutalenv:
#   pyenv activate <name>
#   pip install neovim
# See: https://github.com/deoplete-plugins/deoplete-jedi/wiki/Setting-up-Python-for-Neovim  

# nvim
# =========
# use brew install version of nvim:
alias vim="nvim"
# for latested nvim 0.5 build uncomment below:
#if [[ -d "${HOME}/myprogs/nvim-osx64/bin" ]]
#then
#    PATH="${HOME}/myprogs/nvim-osx64/bin:${PATH}"
#    export PATH
#fi
#if type nvim > /dev/null 2>&1; then
#  alias vim='nvim'
#fi


# Misc zsh config
HISTFILE=~/.zsh_history
HISTSIZE=2000
SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups

# Highlighting rules
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE=fg=240

# set vi keybindings
#bindkey -v

# Ctrl+r for search backward - must come after 'bindkey -v'
# https://unix.stackexchange.com/questions/30168/how-to-enable-reverse-search-in-zsh
bindkey '^R' history-incremental-search-backward


#source "$HOME/.aliases"
#
if [[ "$OSTYPE" == "darwin"* ]]
then
  # Use MacVim for terminal vim
  #alias vim="mvim"

  test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
fi



# Fuzzy file search: https://github.com/junegunn/fzf
# Allows you to call 'FZF' or 'vim `FZF`' on the CLI
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/davidmeredith/.sdkman"
[[ -s "/Users/davidmeredith/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/davidmeredith/.sdkman/bin/sdkman-init.sh"


