#!/bin/bash

var=$(printf 'a\0b')

printf '%s\n' "$var" | od -c

# function print_line_blue() {
#     printf "\033[34;1m$1\033[0m\n"
# }

# function print_line_green() {
#     printf "\033[32;1m$1\033[0m\n"
# }

# function print_line_red() {
#     printf "\033[33;1m$1\033[0m\n"
# }

# function print_line_pink() {
#     printf "\033[35;1m$1\033[0m\n"
# }

# pink:  \033[35;
# yellow:   \033[33;
# green: \033[32;
# blue:  \033[34;

# TODO: delete unnecessary apps
# https://macpaw.com/how-to/delete-mail-app-mac

# if [[ $# < 1 ]]; then
# 	usage
# fi

# https://stackoverflow.com/questions/314675/how-to-redirect-output-of-an-entire-shell-script-within-the-script-itself
# exec > >(tee -a "setup.log") 2>&1

{
    echo "foobar"
} &>/dev/null

function write_zshrc() {
    echo \\nWriting to .zshrc:
    echo "" >>~/.zshrc
    instructions=("$@")
    for i in "${instructions[@]}"; do
        echo "$i" >>~/.zshrc
        touch ~/.zshrc
    done
}
