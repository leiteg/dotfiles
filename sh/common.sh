# --------------------------------------------------------------------
#                                                           __
#        _________  ____ ___  ____ ___  ____  ____    _____/ /_
#       / ___/ __ \/ __ `__ \/ __ `__ \/ __ \/ __ \  / ___/ __ \
#      / /__/ /_/ / / / / / / / / / / / /_/ / / / / (__  ) / / /
#      \___/\____/_/ /_/ /_/_/ /_/ /_/\____/_/ /_(_)____/_/ /_/
#
#             Gustavo Leite <gustavoleite.ti@gmail.com>
#
# --------------------------------------------------------------------

# FUNCTIONS {{{1
# --------------------------------------------------------------------

# Try to alias the first to the second, if this exists.
function try_alias {
    if command -v $2 &>/dev/null; then
        alias $1=$2
    fi
}

# Try to source a file, if it exists.
function try_source {
    if [ -f "$1" ]; then
        source $1
    fi
}

# Connect to a server using SSH an automatically attach/create session
function tsh {
    host=$1
    session=${2:=main}
    ssh $host -t "tmux attach -t $session || tmux new -s $session";
    #          |
    #          `--> Execute the following command and quit.
}

# ALIASES {{{1
# --------------------------------------------------------------------

alias quit="exit"

try_alias ls    exa
try_alias cat   bat
try_alias find  fd
try_alias vim   nvim
try_alias grep  rg
try_alias tb    taskbook
try_alias tm    tmux
try_alias t     tmuxinator

# VARIABLES {{{1
# --------------------------------------------------------------------

# User environment variables
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$HOME/.cargo/bin:$PATH"

# Where the configuration files should live
export XDG_CONFIG_HOME="$HOME/.config"

# Remove annoyng 'Entering directory' messages from make
export MAKEFLAGS=--no-print-directory

# Choose default editor
if command -v nvim &>/dev/null; then
    export EDITOR=nvim
else
    export EDITOR=vim
fi

# CONFIGURATION {{{1
# --------------------------------------------------------------------

# Load os-specific config
try_source ~/dotfiles/sh/$(uname | tr '[:upper:]' '[:lower:]').sh

# Load machine-specific config
try_source ~/dotfiles/sh/local.sh

# }}}
