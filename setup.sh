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

if command -v "dconf" &>/dev/null; then
    dconf load /org/gnome/settings-daemon/plugins/media-keys/ < dconf/media-keys.conf
    dconf load /org/gnome/desktop/wm/keybindings/             < dconf/keybindings.conf
    dconf load /org/gnome/shell/extension/forge/              < dconf/forge.conf
fi
