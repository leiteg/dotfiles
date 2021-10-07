#!/usr/bin/env bash

. $HOME/dotfiles/sh/tmux/common.sh

BG=colour215 FG=colour0 add_section_right $USER
BG=colour212 FG=colour0 add_section_right $HOSTNAME
BG=colour141 FG=colour0 add_section_right "◴ $(date +"%a %b %d %H:%M")"
