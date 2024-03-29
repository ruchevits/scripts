#!/bin/zsh

function print_line_blue() {
    printf "\033[34;1m$1\033[0m\n"
}

function print_line_green() {
    printf "\033[32;1m$1\033[0m\n"
}

function print_line_red() {
    printf "\033[33;1m$1\033[0m\n"
}

function print_line_pink() {
    printf "\033[35;1m$1\033[0m\n"
}

function print_intro() {
    print_line_blue "   ____                   _                      _   _           "
    print_line_blue "  |  _ \   _   _    ___  | |__     ___  __   __ (_) | |_   ___   "
    print_line_blue "  | |_) | | | | |  / __| | '_ \   / _ \ \ \ / / | | | __| / __|  "
    print_line_blue "  |  _ <  | |_| | | (__  | | | | |  __/  \ V /  | | | |_  \__ \  "
    print_line_blue "  |_| \_\  \__,_|  \___| |_| |_|  \___|   \_/   |_|  \__| |___/  "
    print_line_blue "                                                                 "
    print_line_blue "-----------------------------------------------------------------"
    print_line_blue ""
    print_line_blue "This script will:"
    print_line_blue "- Install XCode developer tools"
    print_line_blue "- Install and update Homebrew"
    print_line_blue "- Install 1Password"
    print_line_blue "- Install Git with some useful utilities"
    print_line_blue "- Install fonts"
    print_line_blue "- Install utilities"
    print_line_blue "- Install Volta"
    print_line_blue "- Install Node and PNPM via Volta"
    print_line_blue "- Install Oh My Zsh with powerline10k theme and plugins"
    print_line_blue "- Install iTerm2"
    print_line_blue "- Install applications"
    print_line_blue "- Install VSCode extensions"
    print_line_blue "- Install Mackup"
    print_line_blue "- Fetch Mackup configuration"
}

function print_step_info() {
    print_line_blue "                                                                 "
    print_line_blue "-----------------------------------------------------------------"
    print_line_blue "                                                                 "
    if [ ! -z "$2" ]; then
        print_line_green "$2\n"
    fi
    # read -s -k $'?Press any key to continue\n\n'
    $1
}

function print_manual_action_required() {
    print_line_red "\nManual action required:"
    instructions=("$@")
    for i in "${instructions[@]}"; do
        print_line_red "- $i"
    done
    while true; do
        print_line_pink "\nType 'done' when you are ready to proceed\n"
        read "yn?> "
        case $yn in
        done)
            break
            ;;
        esac
    done
}

function print_done() {
    print_line_blue "                                                                 "
    print_line_blue "-----------------------------------------------------------------"
    print_line_blue "   ____                                                          "
    print_line_blue "  |  _ \  ___  _ __   ___                                        "
    print_line_blue "  | | | |/ _ \| '_ \ / _ \                                       "
    print_line_blue "  | |_| | (_) | | | |  __/                                       "
    print_line_blue "  |____/ \___/|_| |_|\___|                                       "
    print_line_blue "                                                                 "
}
