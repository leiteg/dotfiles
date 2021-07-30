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

unsetopt autocd

# Load common settings
[ -f ~/dotfiles/sh/common.sh ] && source ~/dotfiles/sh/common.sh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
