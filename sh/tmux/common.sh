#!/usr/bin/env bash

CURR_BG="colour0"
CURR_FG="colour59"

function command_exists {
    command -v $1 &>/dev/null
}

function add_section_left() {
    local content="$@"
    printf "#[bg=colour%s] %s #[bg=colour%s,fg=colour%s]" \
        "$BG" "$content" "$FG" "$BG"
    CURR_FG="$FG"
}

function add_section_right() {
    local content="$@"
    printf "#[bg=%s,fg=%s]#[bg=%s,fg=%s] %s " \
        "$CURR_FG" "$BG" "$BG" "$FG" "$content"
    CURR_FG="$BG"
}
