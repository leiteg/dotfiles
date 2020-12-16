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

# Aliases
alias quit="exit"
alias tb="taskbook"
alias tm="tmux"
alias t="tmuxinator"

# Use nvim instead of vim if available
if command -v nvim &>/dev/null; then
    alias vim=nvim
    export EDITOR=nvim
else
    export EDITOR=vim
fi

# User environment variables
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/.local/bin"

# Remove annoyng 'Entering directory' messages from make
export MAKEFLAGS=--no-print-directory

# Connect to a server using SSH an automatically attach/create session
function tsh {
    host=$1
    session=$2
    if [[ -z "$session" ]]; then
        ssh $host -t "tmux attach || tmux new -s main";
    else
        ssh $host -t "tmux attach -t $session || tmux new -s $session";
    fi
}

# Load OS-specific configs
if [[ "$(uname)" = "Darwin" ]]; then
    source ~/dotfiles/sh/macos.sh
else
    source ~/dotfiles/sh/linux.sh
fi

if [ -f ~/dotfiles/sh/local.sh ]; then
    source ~/dotfiles/sh/local.sh
fi
