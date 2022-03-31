
# See Pyenv installation at: https://github.com/pyenv/pyenv
#
# set env var that points to the pyenv dir
export PYENV_ROOT="$HOME/.pyenv"
# put pyenv first in your search path so that the OS will find pyenv's python before any other pythons
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
