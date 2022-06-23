# colors.
_GREEN="\e[32m"
_YELLOW="\e[33m"
_RED="\e[31m"
_RESET="\e[0m"

# format bash prompt.
export PS1="${_GREEN}\u${_RESET}@${_YELLOW}%%NODE_ALPINE_VERSION%%${_RESET} $(pwd) ${_RED}\$ ${_RESET}"
