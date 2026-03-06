#!/usr/bin/env bash

set -euo pipefail

declare -A configs=(
    ["nvim"]="nvim"
    ["tmux"]="tmux"
    ["git"]="git"
    ["zsh"]="zsh"
    ["atuin"]="atuin"
    ["bat"]="bat"
    ["gdb"]="gdb"
    ["alacritty"]="alacritty"
    ["kitty"]="kitty"
    ["systemctl"]="systemd"
)


for program in "${!configs[@]}"; do
    if command -v "${program}" &>/dev/null; then
        dir="${configs[$program]}"
        echo ln -sfn $PWD/$dir $HOME/.config/$dir
    else
        echo "Skipping '${program}', not installed."
    fi
done
