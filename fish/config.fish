### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
set --export --prepend PATH "/Users/david.meredith/.rd/bin"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

fish_vi_key_bindings
# Emulates vim's cursor shape behavior
# Set the normal and visual mode cursors to a block
set fish_cursor_default block
# Set the insert mode cursor to a line
set fish_cursor_insert line
# Set the replace mode cursor to an underscore
set fish_cursor_replace_one underscore
# The following variable can be used to configure cursor shape in
# visual mode, but due to fish_cursor_default, is redundant here
set fish_cursor_visual block


alias ic="ibmcloud"
alias ls="ls -FG --color=auto"
alias gitadog="git log --all --decorate --oneline --graph"
alias vim="nvim"
#alias fzf='fzf --layout=reverse --height=40% --border'

if type -q fd
  set -gx FZF_DEFAULT_COMMAND "fd --type f --exclude .git"
end

# Java Testcontainers lib can use podman instead of docker, but you need
# to disable RYUK which is podman specific (is used to clean up containers)
set --export TESTCONTAINERS_RYUK_DISABLED true

if test -d "$HOME/.local/bin"
  set PATH "$HOME/.local/bin" $PATH
end

if test -e "/home/linuxbrew/.linuxbrew/bin/brew"
  eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
else if test -e "/opt/homebrew/bin/brew"
  eval (/opt/homebrew/bin/brew shellenv)
end

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

# install starship
starship init fish | source




