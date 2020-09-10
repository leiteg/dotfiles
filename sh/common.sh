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

# User environment variables
export PATH="$PATH:$HOME/bin"

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
