# --------------------------------------------------------------------
#                   ___                         __
#                  / (_)___  __  ___  __  _____/ /_
#                 / / / __ \/ / / / |/_/ / ___/ __ \
#                / / / / / / /_/ />  <_ (__  ) / / /
#               /_/_/_/ /_/\__,_/_/|_(_)____/_/ /_/
#
#             Gustavo Leite <gustavoleite.ti@gmail.com>
#
# --------------------------------------------------------------------

if command_exists "xdg-open"; then
    alias open="xdg-open"
fi

if command_exists xsel; then
    alias copy="xsel -ib"
    alias paste="xsel -ob"
fi
