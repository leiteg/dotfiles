# --------------------------------------------------------------------
#                                                      __
#              ____ ___  ____ __________  _____  _____/ /_
#             / __ `__ \/ __ `/ ___/ __ \/ ___/ / ___/ __ \
#            / / / / / / /_/ / /__/ /_/ (__  ) (__  ) / / /
#           /_/ /_/ /_/\__,_/\___/\____/____(_)____/_/ /_/
#
#             Gustavo Leite <gustavoleite.ti@gmail.com>
#
# --------------------------------------------------------------------

if command_exists pbcopy; then
    alias copy="pbcopy"
fi

if command_exists pbpaste; then
    alias paste="pbpaste"
fi

export LC_ALL=en_US.UTF-8
export PATH="/usr/local/opt/llvm/bin:$PATH"
