# ------------------------------------------------------------------------------
#                                                                __
#             _________  ____ ___  ____ ___  ____  ____    _____/ /_
#            / ___/ __ \/ __ `__ \/ __ `__ \/ __ \/ __ \  / ___/ __ \
#           / /__/ /_/ / / / / / / / / / / / /_/ / / / / (__  ) / / /
#           \___/\____/_/ /_/ /_/_/ /_/ /_/\____/_/ /_(_)____/_/ /_/
#
#                  Gustavo Leite <gustavoleite.ti@gmail.com>
#
# ------------------------------------------------------------------------------

# FUNCTIONS --------------------------------------------------------------- {{{1

# Check if command exists in the system.
function command_exists {
    command -v $1 &>/dev/null
    #        ┯
    #        ╰──⮞ Echo a string with the pathname that will be used.
}

# Create and alias to a command only if it exists.
function try_alias {
    if command_exists $2; then
        alias $1=$2
    fi
}

# Source a file only if it exists.
function try_source {
    if [ -f "$1" ]; then
        source $1
    fi
}

# Connect to a server using SSH an automatically attach/create session
function tsh {
    host=$1
    session=${2:-main}

    # Sanitization
    [[ -z "$1" ]] && echo "usage: tsh <host> [<session>]" >&2 && return
    [[ -n "$2" ]] && flags="-t $session"

    # Connect with ssh and spins tmux
    ssh $host -t "tmux attach $flags || tmux new -s $session"
    #             ━━━━━━━━┯━━━━━━━━━    ━━━━━━━━━━┯━━━━━━━━━
    #                    (1)                     (2)
    #
    # (1) Attach to a session if it exists (or attach to last session if empty).
    # (2) If attach fails, create a new session.
}

# Setup tmux sessions using tmuxinator
function tsetup {
    for project in $HOME/dotfiles/tmuxinator/*.yml; do
        tmuxinator start --no-attach $(basename $project .yml)
        #          ━━┯━━ ━━━━━┯━━━━━
        #            │        │
        #            │        ╰──⮞ Do not attach automatically.
        #            ╰──⮞ Start new tmux session from config file.
    done
    tmux attach -t main
    #            ┯
    #            ╰──⮞ Target session.
}

# Create a reverse tunnel to localhost through some machine
function create-tunnel {
    host=${1:=lsc}
    port=${2:=23440}
    ssh -f -N -R $port\:localhost:22 $host
    #    ┯  ┯  ┯
    #    │  │  ╰──⮞ Forward a remote port to localhost:22.
    #    │  ╰──⮞ Do not execute a remote command.
    #    ╰──⮞ Go to background just before command execution.
}

# Download video from URL in the clipboard.
function dlvideo {
    file=${1:-video.mp4}
    url=${2:-$(xsel -ob)}
    youtube-dl -q -o - $url | ffmpeg -i pipe: -async 1 $file
    #           ┯  ━┯━                ┯
    #           │   │                 ╰──⮞ Read video stream from stdin.
    #           │   ╰──⮞ Output video stream to stdout.
    #           ╰──⮞ Run in quiet mod.
}

# Convert dot file to PDF and open in viewer
function dotshow {
    for file in "$@"; do
        if [[ ! -f "$file" ]]; then
            echo "Error: no such file: '$file'" >&2
            continue
        fi
        dot -Tpdf $file | zathura - & disown
    done
}

# Activate Python virtualenv
function activate {
    # Directories to attempt
    directories=("$1" "venv" ".venv")

    for directory in ${directories[@]}; do
        if [ -d "$directory" ]; then
            source "$directory/bin/activate"
            return $?
        fi
    done

    echo "Error: no virtualenv found in the current directory." >&2
    return 1
}

# Display Clang AST for a file
function clang-ast-dump {
    clang++ -Xclang -ast-dump -fsyntax-only $@
    #       ━━━┯━━━ ━━━━┯━━━━ ━━━━━━┯━━━━━━
    #          │        │           │
    #          │        │           ╰──⮞ Stop after obtaining AST.
    #          │        ╰──⮞ Dump AST to stdout.
    #          ╰──⮞ Pass options to the compiler front-end.
}

# Show which package owns an executable
function pacown {
    which $@ | xargs pacman -Qqo | xargs pacman -Qi
    #                ━━━━━┯━━━━━         ━━━━┯━━━━━
    #                     │                  │
    #                     │                  ╰──⮞ (Q)uery, (i)nfo.
    #                     ╰──⮞ (Q)uery, (q)uiet, (o)wns.
}

# List explicitly installed packages and pipe through FZF
function pacls {
    pacman -Qq $1 | fzf -m --preview='pacman -Qi {+}'
    #       ━┯━          ┯           ━━━━━━━┯━━━━━━━━
    #        │           │                  │
    #        │           │                  ╰──⮞ Content of preview window.
    #        │           ╰──⮞ Multi line selection.
    #        ╰──⮞ (Q)uery, (q)uiet, (e)xplicit.
}

# Uninstall Pacman packages with FZF
function pacrs {
    pacman -Qq $1 | fzf -m --preview='pacman -Qi {+}' --bind='enter:execute(sudo pacman -Rs {})'
}

# Run ripgrep and open in vim quickfix
function vimgrep {
    nvim -q <(rg --vimgrep $@)
}

# Dump PATH variable in a legible manner
function showpath {
    echo "$PATH" | tr ':' '\n'
}

# ALIASES ----------------------------------------------------------------- {{{1

alias quit="exit"

try_alias ls    eza
try_alias cat   bat
try_alias vim   nvim
try_alias vi    nvim
try_alias v     nvim
try_alias grep  rg
try_alias t     tmux

if command_exists yt-dlp; then
    alias yt="yt-dlp --cookies-from-browser firefox"
fi

if command_exists git; then
    alias gd="git diff"
    alias gr="git diff --staged"
    alias gs="git status --short"
    alias gl="git ls"
    alias ga="git add"
    alias gc="git commit"
    alias gds="git diff --stat"
    alias gri="git rebase --interactive"
    alias gra="git rebase --abort"
    alias grc="git rebase --continue"
fi

if command_exists tmux; then
    alias ta="tmux attach"
    alias tn="tmux new"
    alias tl="tmux list-sessions"
fi

# VARIABLES --------------------------------------------------------------- {{{1

# Where Cargo installs packages
export CARGO_HOME="$HOME/.local/cargo"
export RUSTUP_HOME="$HOME/.local/rustup"

# Where the configuration files should live
export XDG_CONFIG_HOME="$HOME/.config"

# Remove annoyng 'Entering directory' messages from make
export MAKEFLAGS=--no-print-directory

# Less default options
export LESS="-FIRX"
#             ┯┯┯┯
#             │││╰──⮞ X: Do not clear screen on exit.
#             ││╰───⮞ R: Raw control characters, preservers color.
#             │╰────⮞ I: Ignore case on searches.
#             ╰─────⮞ F: Quit if output occupies less than one screen.

# Choose default editor
if command_exists nvim; then
    export EDITOR=nvim
else
    export EDITOR=vim
fi

# Use clang as default compiler only if it exists.
if command_exists clang; then
    export CC=clang
    export CXX=clang++
fi

if command_exists bat; then
    if [[ -f "$XDG_CONFIG_HOME/bat/themes/tokyonight.tmTheme" ]]; then
        export BAT_THEME="tokyonight"
    else
        export BAT_THEME="dracula"
    fi
fi

# Local variables
readonly shellname="${SHELL##*/}"
readonly osname="$(uname | tr '[:upper:]' '[:lower:]')"
readonly hostname="$(uname -n | tr '[:upper:]' '[:lower:]')"

# PATH -------------------------------------------------------------------- {{{1

# Fragments to be inserted in PATH. Inserted in reverse order.
fragments=(
    $CARGO_HOME/bin
    $HOME/.local/bin
)

for fragment in "${fragments[@]}"; do
    PATH="$fragment:$PATH"
done

# Remove duplicate paths and cleanup variable
PATH="$(echo "$PATH" | awk -v RS=':' '!a[$1]++' | command paste -sd:)"
PATH="${PATH#:}"
PATH="${PATH%:}"

export PATH

# CONFIGURATION ----------------------------------------------------------- {{{1

# Load os-specific config
try_source ~/dotfiles/sh/os/$osname.sh
# Load host-specific config
try_source ~/dotfiles/sh/host/$hostname.sh
# Load machine-specific config
try_source ~/dotfiles/sh/local.sh

# FZF --------------------------------------------------------------------- {{{2

if command_exists fzf; then
    source <(fzf --"$shellname")
fi

# ZOXIDE ------------------------------------------------------------------ {{{2

if command_exists zoxide; then
    source <(zoxide init --cmd "cd" "$shellname")
fi

# ATUIN ------------------------------------------------------------------- {{{2

if command_exists atuin; then
    source <(atuin init "$shellname" --disable-up-arrow)
fi

# PYENV ------------------------------------------------------------------- {{{2

if [[ -d "$HOME/.local/pyenv" ]];  then

    export PYENV_ROOT="$HOME/.local/pyenv"
    export PYENV_PYTHON="$PYENV_ROOT/shims/python"
    export PATH="$PYENV_ROOT/bin:$PATH"
    export PYENV_VIRTUAL_ENV_DISABLE_PROMPT=1

    source <(pyenv init -)
    source <(pyenv init --path)
    source <(pyenv virtualenv-init -)

fi
