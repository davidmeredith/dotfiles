# Start configuration added by Zim install {{{
#
# User configuration sourced by interactive shells
#

# -----------------
# Zsh configuration
# -----------------


#
# History
#

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

#
# Input/output
#

# Set zsh VI mode - emacs (`-e`) or vi (`-v`)
#bindkey -v

# Prompt for spelling correction of commands.
#setopt CORRECT

# Customize spelling correction prompt.
#SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}




# -----------------
# Zim configuration
# -----------------

# Use degit instead of git as the default tool to install and update modules.
#zstyle ':zim:zmodule' use 'degit'

# --------------------
# Module configuration
# --------------------

#
# git
#

# Set a custom prefix for the generated aliases. The default prefix is 'G'.
#zstyle ':zim:git' aliases-prefix 'g'

#
# input
#

# Append `../` to your input for each `.` you type after an initial `..`
#zstyle ':zim:input' double-dot-expand yes

#
# termtitle
#

# Set a custom terminal title format using prompt expansion escape sequences.
# See http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Simple-Prompt-Escapes
# If none is provided, the default '%n@%m: %~' is used.
#zstyle ':zim:termtitle' format '%1~'

#
# zsh-autosuggestions
#

# Disable automatic widget re-binding on each precmd. This can be set when
# zsh-users/zsh-autosuggestions is the last module in your ~/.zimrc.
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# Customize the style that the suggestions are shown with.
# See https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

#
# zsh-syntax-highlighting
#

# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Customize the main highlighter styles.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md#how-to-tweak-it
#typeset -A ZSH_HIGHLIGHT_STYLES
#ZSH_HIGHLIGHT_STYLES[comment]='fg=242'

# ------------------
# Initialize modules
# ------------------

ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  if (( ${+commands[curl]} )); then
    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  else
    mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  fi
fi
# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
# Initialize modules.
source ${ZIM_HOME}/init.zsh

# ------------------------------
# Post-init module configuration
# ------------------------------

#
# zsh-history-substring-search
#

zmodload -F zsh/terminfo +p:terminfo
# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
for key ('^[[A' '^P' ${terminfo[kcuu1]}) bindkey ${key} history-substring-search-up
for key ('^[[B' '^N' ${terminfo[kcud1]}) bindkey ${key} history-substring-search-down
# you have to manually delete its folder, e.g.  
for key ('k') bindkey -M vicmd ${key} history-substring-search-up
for key ('j') bindkey -M vicmd ${key} history-substring-search-down
unset key
# }}} End configuration added by Zim install






# -----------------
# Custom zsh config
# -----------------

# You may need to manually set your language environment
export LANG=en_US.UTF-8
# Java Testcontainers lib can use podman instead of docker, but you need 
# to disable RYUK which is podman specific (is used to clean up containers)
export TESTCONTAINERS_RYUK_DISABLED="true"
alias vim="nvim"
alias gitlogadog="git log --all --decorate --oneline --graph"
alias aptup="sudo apt update && sudo apt upgrade"

# ===========================
# Pyenv & Pyenv-virtualenv:
# ===========================
# https://github.com/pyenv/
# https://github.com/pyenv/pyenv-virtualenv to allow easy venv with pyenv
#
# Pyenv 
# ========
# used to manage multiple python versions and correctly simlink pip/pip3 depending on py version
# Basic flow is:
#   * install pyenv-installer from (also installs pyenv-virtualenv): https://github.com/pyenv/pyenv-installer
#   * configure your environment and path to init pyenv and virtualenv
#   * list available versions of python
#   * install required version of python 
#   * check pyenv python has been installed and is first in your path: `which python`
#   * create a new virtualenv for your project
#   * activate your virtualenv 
#
# ```
#  pyenv install --list | grep '3.8'
#  pyenv install 3.8.16
#  which python
#  /home/ubuntu/.pyenv/shims/python  
#
#  pyenv virtualenv 3.8.16 .venv
#  pyenv virtualenvs
#  pyenv activate .venv
#  which python
#  /home/ubuntu/.pyenv/shims/python  
#  (.venv)
# ```
#
# Install
# =======
# For useful guide see: https://realpython.com/intro-to-pyenv/
# $ brew upgrade pyenv
# $ brew upgrade pyenv-virtualenv 
#
# Useful commands
# ================
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
#    Could also use '~/.zprofile' for PATH edits: 
     export PYENV_ROOT="$HOME/.pyenv"
#     # Put pyenv first in your search path so that the OS will find 
#     # pyenv's python before any other pythons
     export PATH="$PYENV_ROOT/bin:$PATH"
#     eval "$(pyenv init --path)"
#
#  Source this file and pass 'enablePyEnv' arg to init pyenv:
#if [[ "$*" == *"enablepyenv"* ]]
#then
#    echo "Enabling PyEnv"
    if command -v pyenv 1>/dev/null 2>&1; then
      eval "$(pyenv init -)"
      # used to set the pyenv virtualenv from '.python-version' file:
      eval "$(pyenv virtualenv-init -)"
    fi
#fi
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


# Open chrome tabs from CLI to simplify following example:
# open --new -a "Google Chrome" --args "duckduckgo.com"
chrome_open_tab() {
  open --new -a "Google Chrome" --args $@
}

chrome_open_window() {
  open --new -a "Google Chrome" --args --new-window $@
}


#if [[ "$*" == *"enablesdkman"* ]]
##then
##    echo "Enabling sdkman"
    #THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
        export SDKMAN_DIR="${HOME}/.sdkman"
            [[ -s "${HOME}/.sdkman/bin/sdkman-init.sh" ]] && source "${HOME}/.sdkman/bin/sdkman-init.sh"
#fi


# OpenShift cli tooling
if [[ "$OSTYPE" == "darwin"* ]]; then
  export PATH="$HOME/bin/oc-4.10.20-macosx:$PATH"
fi


### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/david.meredith/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

