#!/usr/bin/env bash

set -xeuo pipefail

if [[ $# -eq 0 ]]; then
    echo "Usage: $0 [--weekly|--monthly]"
    exit 1
fi

COLS="5"
ROWS="3"
PERIOD="1month"
WEEKLY=0
MONTHLY=1

while [[ $# -gt 0 ]]; do
    case "$1" in
        -w|--weekly)
            COLS="3"
            ROWS="1"
            PERIOD="7day"
            WEEKLY=1
            MONTHLY=0
            shift
            ;;
        -m|--monthly)
            shift
            ;;
    esac
done

if [[ ! -f $HOME/.local/bin/lastfm ]]; then
    echo "Executable 'lastfm' not found." >&2
    exit 1
fi

# Create temporary file to hold the collage
file="$(mktemp "/tmp/lastfm-$PERIOD-XXXXX.png")"
file_compressed="${file/%.png/.jpg}"

# Generate collage
$HOME/.local/bin/lastfm collage \
    --period "$PERIOD" \
    --columns "$COLS" \
    --rows "$ROWS" \
    --name \
    --count \
    -o "$file" \
    laranjadinho

# Compress image before posting
magick "${file}" -define jpeg:extent=900kb "${file_compressed}"

if [[ "$PERIOD" == "1month" ]]; then
    text="mês #lastfm"
else
    text="semaninha #lastfm"
fi

# Post to Bluesky
$HOME/.local/bin/uv run --with atproto \
    $HOME/.local/bin/scripts/bluesky-upload.py "${file_compressed}" "${text}"

if [[ "$PERIOD" == "1month" ]]; then
    message="Monthly collage posted!"
else
    message="Weekly collage posted!"
fi

notify-send Last.fm "${message}"
