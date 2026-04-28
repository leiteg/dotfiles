#!/usr/bin/env bash

set -euo pipefail

dconf load /org/gnome/settings-daemon/plugins/media-keys/ < media-keys.conf
dconf load /org/gnome/desktop/wm/keybindings/ < keybindings.conf
dconf load /org/gnome/shell/extension/forge/ < forge.conf
