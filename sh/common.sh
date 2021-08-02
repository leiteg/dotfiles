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

# Check if command exists in the system.
function command_exists {
    command -v $1 &>/dev/null
}

# Create and alias to a command only if it exists.
function try_alias {
    if command_exists $2; then
        alias $1=$2
    fi
}

# Source a file only if it exists.
function try_source {
    if [ -f "$1" ]; then
        source $1
    fi
}

# Connect to a server using SSH an automatically attach/create session
function tsh {
    host=$1
    session=${2:=main}
    ssh $host -t "tmux new -A -s $session"
    #          |            |  |
    #          |            |  `--> Session name.
    #          |            `--> Attach if already exists.
    #          `--> Execute the following command and quit.
}

# Setup tmux sessions using tmuxinator
function tsetup {
    for project in $HOME/dotfiles/tmuxinator/*.yml; do
        tmuxinator start --no-attach $(basename $project .yml)
        #          [>-<] [>-------<]
        #            |        |
        #            |        `--> Do not attach automatically.
        #            `--> Start new tmux session from config file.
    done
    tmux attach -t main
    #            |
    #            `-> Target session.
}

# Create a reverse tunnel to localhost through some machine
function create-tunnel {
    host=${1:=lsc}
    port=${2:=23440}
    ssh -f -N -R $port\:localhost:22 $host
    #    |  |  |
    #    |  |  `--> Forward a remote port to localhost:22.
    #    |  `--> Do not execute a remote command.
    #    `--> Go to background just before command execution.
}

# Download video from URL in the clipboard.
function dlvideo {
    file=${1:-video.mp4}
    url=${2:-$(xsel -ob)}
    youtube-dl -q -o - $url | ffmpeg -i pipe: -async 1 $file
    #           |  |                  |
    #           |  |                  `--> Read from stdin
    #           |  `--> Output to stdout
    #           `--> Quiet mode
}

# Convert dot file to PDF and open in viewer
function dotshow {
    for file in "$@"; do
        if [[ ! -f $file ]]; then
            echo "Error: no such file: '$file'" >&2
            continue
        fi
        dot -Tpdf $file | zathura - & disown
    done
}

# Activate Python virtualenv
function activate {
    source venv/bin/activate
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
if command_exists nvim; then
    export EDITOR=nvim
else
    export EDITOR=vim
fi

# Use clang as default compiler only if it exists.
if command_exists clang; then
    export CC=clang
    export CXX=clang++
fi

if command_exists bat; then
    export BAT_THEME="Dracula"
fi

# CONFIGURATION {{{1
# --------------------------------------------------------------------

# Load os-specific config
try_source ~/dotfiles/sh/$(uname | tr '[:upper:]' '[:lower:]').sh

# Load machine-specific config
try_source ~/dotfiles/sh/local.sh
