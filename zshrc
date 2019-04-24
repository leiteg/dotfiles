# --------------------------------------------------------------------
#                                 __
#                     ____  _____/ /_  __________
#                    /_  / / ___/ __ \/ ___/ ___/
#                   _ / /_(__  ) / / / /  / /__
#                  (_)___/____/_/ /_/_/   \___/
#
#             Gustavo Leite <gustavoleite.ti@gmail.com>
#
# --------------------------------------------------------------------

export ZSH=$HOME/.oh-my-zsh

# Shell configuration
ZSH_THEME="agnoster-vim"
HYPHEN_INSENSITIVE="true"

# Oh My Zsh plugins
plugins=(git)

# Source relevant files
source $ZSH/oh-my-zsh.sh

# Ignore some patterns in autocomplete
zstyle ':completion:*:*:vim:*:*files' \
    ignored-patterns '*.o' '*.aux' '*.bbl' '*.blg' '*.fdb_latexmk' '*.fls' '*.synctex.gz' '*.log' '*.pdf'

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

# Load OS-specific configs
if test "$(uname)" = "Darwin" ; then
    source ~/dotfiles/sh/macos.sh
else
    source ~/dotfiles/sh/linux.sh
fi

# User environment variables
export PATH="$PATH:$HOME/bin"
