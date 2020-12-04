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
plugins=(git tmuxinator)

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

# Load common settings
if [[ -f ~/dotfiles/sh/common.sh ]]; then
    source ~/dotfiles/sh/common.sh
fi

# Load OS-specific configs
if [[ "$(uname)" = "Darwin" ]]; then
    source ~/dotfiles/sh/macos.sh
else
    source ~/dotfiles/sh/linux.sh
fi

# Aliases
alias vim=nvim

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
