# Login Shell Settings 
# =====================
# If you login to bash/zsh using an xterm/iterm/putty etc, then 
# the session is both a login shell and an interactive one. 
# If you then type 'bash|zsh' while logged in or run a shell script, it starts 
# an interactive shell, but it is not a login shell.
# So, the .zshrc/.bashrc files are also run every time you request a new 
# interactive shell. Normally variables, aliases or functions are put in .zshrc.
#
# A login shell only differs from any other shell (interactive shell) by the 
# fact that one or more initial setup scripts (resources) are loaded on 
# startup, typically named with "profile" in their name (.zprofile). 
# In this file are basic settings that are are dervied to subsequently opened 
# shells (so they only need to be defined once).
#
eval "$(/opt/homebrew/bin/brew shellenv)"

export PYENV_ROOT="$HOME/.pyenv"
# Put pyenv first in your search path so that the OS will find 
# pyenv's python before any other pythons
export PATH="$PYENV_ROOT/bin:$PATH"
#eval "$(pyenv init --path)"

# OpenShift cli tooling
export PATH="$HOME/bin/oc-4.10.20-macosx:$PATH"


