# Interactive Shell Settings 
# ==========================
# If you login to bash/zsh using an xterm/iterm/putty etc, then 
# the session is both a login shell and an interactive one. 
# If you then type 'bash | zsh' while logged in or run a shell script, it starts 
# an interactive shell, but it is not a login shell.
# So, the .zshrc/.bashrc files are also run every time you request a new 
# interactive shell. Normally variables, aliases or functions are put in .zshrc.
# using the setopt and unsetopt commands. 
#
# So, a login shell only differs from any other shell (interactive shell) by the 
# fact that one or more initial setup scripts (resources) are loaded on 
# startup, typically named with "profile" in their name (.zprofile). 
# In '.zprofile' are basic settings that are are dervied to subsequently opened 
# shells (so they only need to be defined once).

# After modifications reload by sourcing this file with:
# source ~/.zshrc

# Make sure zplug is installed
if [[ ! -d ~/.zplug ]]; then
    echo "cloning zplug"
    git clone https://github.com/zplug/zplug ~/.zplug && \
        source ~/.zplug/init.zsh && \
        zplug update
else
    source ~/.zplug/init.zsh
fi

# zsh-autosuggestions
if [[ ! -d ~/.zsh/zsh-autosuggestions ]]; then
    echo "cloning zsh-autosuggestions"
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
fi
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh


##############################################################
## begin zplug ##
##############################################################
zplug "zplug/zplug"

# Theme
zplug "spaceship-prompt/spaceship-prompt", use:spaceship.zsh, from:github, as:theme
# Theme - https://denysdovhan.com/spaceship-prompt/
#zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme

zplug "zsh-users/zsh-completions"   
# Set the priority when loading
# e.g., zsh-syntax-highlighting must be loaded
# after executing compinit command and sourcing other plugins
# (If the defer tag is given 2 or above, run after compinit command)
zplug "zsh-users/zsh-syntax-highlighting", defer:2


# oh-my-zsh features 
# Load completion library for those sweet [tab] squares
zplug "lib/completion", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh

# softmoth's vim zsh key bindings
# Add vars to .zshrc, before this plugin is loaded.
# Use another key instead of Esc to switch to NORMAL mode, other option is '^D' (control D)
#VIM_MODE_VICMD_KEY="jj"
#MODE_CURSOR_VIINS="#00ff00 blinking bar"
#MODE_CURSOR_REPLACE="$MODE_CURSOR_VIINS #ff0000"
#MODE_CURSOR_VICMD="green block"
#MODE_CURSOR_SEARCH="#ff00ff steady underline"
#MODE_CURSOR_VISUAL="$MODE_CURSOR_VICMD steady bar"
#MODE_CURSOR_VLINE="$MODE_CURSOR_VISUAL #00ffff"
# To avoid conflicts, need to load after: zsh-autosuggestions, zsh-syntax-highlighting
#zplug "softmoth/zsh-vim-mode"

# Alternative vim mode plugin for zsh
# Only changing the escape key to `jj` in insert mode, we still
# keep using the default keybindings Esc and `^[` in other modes
ZVM_VI_INSERT_ESCAPE_BINDKEY=jj
zplug "jeffreytse/zsh-vi-mode"

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


SPACESHIP_PROMPT_ORDER=(
#  time          # Time stamps section
  user          # Username section
  dir           # Current directory section
#  host          # Hostname section
  git           # Git section (git_branch + git_status)
#  hg            # Mercurial section (hg_branch  + hg_status)
  package       # Package version
#  node          # Node.js section
#  ruby          # Ruby section
#  elixir        # Elixir section
#  xcode         # Xcode section
#  swift         # Swift section
#  golang        # Go section
#  php           # PHP section
#  rust          # Rust section
#  haskell       # Haskell Stack section
#  julia         # Julia section
#  docker        # Docker section
#  aws           # Amazon Web Services section
#  venv          # virtualenv section
#  conda         # conda virtualenv section
  pyenv         # Pyenv section
  # dotnet        # .NET section
  # ember         # Ember.js section
#  kubectl       # Kubectl context section
#  terraform     # Terraform workspace section
#  exec_time     # Execution time
  line_sep      # Line break
  # battery       # Battery level and status
  vi_mode       # Vi-mode indicator
  #jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)
# below spaceship default configs true
SPACESHIP_PROMPT_ADD_NEWLINE=true
SPACESHIP_PROMPT_SEPARATE_LINE=true
#SPACESHIP_BATTERY_THRESHOLD=50

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8
# Java Testcontainers lib can use podman instead of docker, but you need 
# to disable RYUK which is podman specific (is used to clean up containers)
export TESTCONTAINERS_RYUK_DISABLED="true"


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
alias ls="ls -FG --color=auto"
alias gitadog="git log --all --decorate --oneline --graph"
# use 'unalias docker' to unset
#alias docker="podman"

# JAVA_HOME and jdk (deprecated by sdkman)
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
#PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:${PATH}"
#export PATH

# Cheatsheet https://github.com/chubin/cheat.sh#usage
#PATH="$HOME/myprogs/cheatsheet:${PATH}"
#export PATH



# ===========================
# Pyenv & Pyenv-virtualenv:
# ===========================
# https://github.com/pyenv/
# https://github.com/pyenv/pyenv-virtualenv to allow easy venv with pyenv
#
# Pyenv 
# ========
# used to manage multiple python versions and correctly simlink pip/pip3 depending on py version
# $ brew upgrade pyenv
# $ brew upgrade pyenv-virtualenv 
# For useful guide see: https://realpython.com/intro-to-pyenv/
#
# Pyenv useful commands: 
#  $ which python
#  $ /Users/davidmeredith/.pyenv/shims/python
# $ pyenv install --list 
# $ pyenv install <version>
# $ pyenv versions
# $ pyenv version
# $ pyenv global <version> 
# $ pyenv virtualenv-delete <env>
#
# Pyenv Virtualenv
# # ==============
# Virtualenv used to create isolated project-based environments for installing
# project deps and using pyenv to manage the python version for the project. 
#
# List existing virtualenvs:
#    $ pyenv virtualenvs 
#
# Create new virtualenv for your project with the specified pyenv py version: 
#    $ pyenv virtualenv <pyenv_py_version> <project_venv_folder>
#    e.g. 'pyenv virtualenv 3.7.1 venv3_7_1_myProject'
#
# Create new virtualenv with the current pyenv py version: 
#   $ pyenv virtualenv <new_pyenv_name>
#
# Actviate and Deactivate virtualenv manually:
#    $ pyenv activate <virtualenv_name>
#    $ pyenv deactivate
#  
#    If eval "$(pyenv virtualenv-init -)" is configured in your shell, pyenv-virtualenv 
#    will automatically activate/deactivate virtualenvs on entering/leaving 
#    directories which contain a .python-version file that contains the name of 
#    a valid virtual environment as shown in the output of pyenv virtualenvs 
#    The .python-version files are used by pyenv to denote local Python 
#    versions and can be created and deleted with the pyenv local command.
#
#    $ pyenv local <virtualenv_name>
#
# To check which pyenv python:
#    $ pyenv which python
#    /Users/davidmeredith/.pyenv/versions/energy_vectors/bin/python
#    (energy_vectors)
#
# To check which pip:
#    $ pyenv which pip
#    /Users/davidmeredith/.pyenv/versions/energy_vectors/bin/pip
#    (energy_vectors)

# To delete a pyenv venv:
# you have to manually delete its folder, e.g.  
#   rm -rf /Users/davidmeredith/.pyenv/versions/<pyVersion> 
#     or 
#   rm -rf /Users/davidmeredith/.pyenv/versions/<pyVersion>/envs/myVenv 
#       (myVenv was created from a particular version)
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
#  Source this file and pass 'enablePyEnv' arg to init pyenv 
#if [[ "$1" == "enablepyenv" ]] 
if [[ "$*" == *"enablepyenv"* ]]
then
    echo "Enabling PyEnv"
    if command -v pyenv 1>/dev/null 2>&1; then
      eval "$(pyenv init -)"
      # used to set the pyenv virtualenv from '.python-version' file:
      eval "$(pyenv virtualenv-init -)"
    fi
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
export HISTFILE=~/.zsh_history
export HISTSIZE=500000
export SAVEHIST=$HISTSIZE
# While searching with Ctrl+R, Stepping through the history with UP and DOWN keys 
# becomes a bit annoying if the same command comes up again and again. A better 
# option is to skip duplicates and show each command only once
setopt HIST_FIND_NO_DUPS
# do not write duplicates to the history file  
setopt HIST_IGNORE_ALL_DUPS
# Immediate append - Setting the inc_append_history option ensures that 
# commands are added to the history immediately (otherwise, this would happen 
# only when the shell exits, and you could lose history upon unexpected/unclean 
# termination of the shell)
setopt INC_APPEND_HISTORY
# Add timestamp to history
export HISTTIMEFORMAT="[%F %T] "
setopt EXTENDED_HISTORY


# Highlighting rules
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE=fg=240
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff,bg=cyan,bold,underline"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff"

# ==================================
# set vi keybindings
# ==================================
#bindkey -v

# Ctrl+r for search backward - must come after 'bindkey -v'
# https://unix.stackexchange.com/questions/30168/how-to-enable-reverse-search-in-zsh
bindkey '^R' history-incremental-search-backward


#source "$HOME/.aliases"

# iterm2 shell integration tools 
# Install using iterm's 'Install Shell Integration' menu item
# and then source the 'iterm2_shell_integration.zsh' script.  
# see https://iterm2.com/documentation-shell-integration.html
#
# - [Marks]: Use Cmd-Shift-Up and Down arrows to navigate marks. 
# - [Download with scp]: You can right-click on a filename (e.g., in the output 
#   of ls) and select Download with scp from hostname**, and iTerm2 will 
#   download the file for you.
# - [Upload with scp]: If you drop a file (e.g., from Finder) into iTerm2 
#   while holding the option key, iTerm2 will offer to upload the file via 
#   scp to the remote host into the directory you were in on the line you 
#   dropped the file on.
# - [Cmd history popup] - Shift-Cmd-;
# - [Recent dir popup] - Cmd-Opt-/
#
# You will also have these commands:
#   imgcat filename - Displays the image inline.
#   imgls - Shows a directory listing with image thumbnails.
#   it2api - Command-line utility to manipulate iTerm2.
#   it2attention start|stop|fireworks - Gets your attention.
#   it2check - Checks if the terminal is iTerm2.
#   it2copy [filename] - Copies to the pasteboard.
#   it2dl filename - Downloads the specified file, saving it in your Downloads folder.
#   it2setcolor ... - Changes individual color settings or loads a color preset.
#   it2setkeylabel ... - Changes Touch Bar function key labels.
#   it2tip - iTerm2 usage tips
#   it2ul - Uploads a file.
#   it2universion - Sets the current unicode version.
#   it2profile - Change iTerm2 session profile on the fly.
#
#if [[ "$OSTYPE" == "darwin"* ]]; then
#  test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
#fi



# Fuzzy file search: https://github.com/junegunn/fzf
# Allows you to call 'fzf' or 'vim $(fzf)' or 'vim `FZF`' on the CLI
# see: https://github.com/junegunn/fzf#using-the-finder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#if [[ "$*" == *"enablesdkman"* ]]
#then
#    echo "Enabling sdkman"
    #THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
    export SDKMAN_DIR="${HOME}/.sdkman"
    [[ -s "${HOME}/.sdkman/bin/sdkman-init.sh" ]] && source "${HOME}/.sdkman/bin/sdkman-init.sh"
#fi


### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/david.meredith/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
