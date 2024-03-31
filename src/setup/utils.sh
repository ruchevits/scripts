#!/bin/zsh

terminalWidth=$(tput cols)

function clear_last_line() {
    tput cuu 1 && tput el
}

function ensure_fns_available() {
    some_fns_unavailable=0
    for fn in $@; do
        declare -f -F $fn >/dev/null
        is_fn_available=$?
        some_fns_unavailable=$((some_fns_unavailable | $is_fn_available))
        if [[ $is_fn_available == 1 ]]; then
            printf "\033[31;1m%s\033[0m\n" "Required function not available: $fn"
        fi
    done
    if [[ $some_fns_unavailable == 1 ]]; then
        exit 1
    fi
}

function printf_separator() {
    printf "\n\033[34;1m"
    for i in $(eval echo {1..$terminalWidth}); do
        printf "-"
    done
    printf "\033[0m\n\n"
}

function print_intro() {
    asciiArtPrintFmt="\033[34;1m%s\033[0m\n"
    scriptDescriptionPrintFmt="\033[34;1m%s\033[0m\n"
    blueLinesListPrintFmt="\033[34;1mx %s\033[0m\n"

    printf $asciiArtPrintFmt \
        "   ____                   _                      _   _           " \
        "  |  _ \   _   _    ___  | |__     ___  __   __ (_) | |_   ___   " \
        "  | |_) | | | | |  / __| | '_ \   / _ \ \ \ / / | | | __| / __|  " \
        "  |  _ <  | |_| | | (__  | | | | |  __/  \ V /  | | | |_  \__ \  " \
        "  |_| \_\  \__,_|  \___| |_| |_|  \___|   \_/   |_|  \__| |___/  "

    printf_separator

    printf $scriptDescriptionPrintFmt \
        "This is a MacOS environment setup and configuration script."

    # printf $blueLinesListPrintFmt \
    #     "Install XCode developer tools" \
    #     "Install and update Homebrew" \
    #     "Install 1Password" \
    #     "Install Git with some useful utilities" \
    #     "Install fonts" \
    #     "Install utilities" \
    #     "Install Volta" \
    #     "Install Node and PNPM via Volta" \
    #     "Install Oh My Zsh with powerline10k theme and plugins" \
    #     "Install iTerm2" \
    #     "Install applications" \
    #     "Install VSCode extensions" \
    #     "Install Mackup" \
    #     "Fetch Mackup configuration"
}

function print_step_info() {
    printf_separator
    if [ ! -z "$1" ]; then
        printf "\033[32;1m%s\033[0m\n\n" $1
    fi
    # read -s -k $'?Press any key to continue\n\n'
}

function require_manual_action() {
    manualActionWarningPrintFmt="\n\033[33;1m%s\033[0m\n"
    manualActionListPrintFmt="\033[33;1mx %s\033[0m\n"
    manualActionPromptPrintFmt="\n\033[35;1m%s\033[0m\n\n"

    printf $manualActionWarningPrintFmt "Manual action required:"
    printf $manualActionListPrintFmt $@

    printf $manualActionPromptPrintFmt "Type 'done' when you are ready to proceed"
    while true; do
        clear_last_line
        read "yn?> "
        case $yn in
        done)
            break
            ;;
        esac
    done
}

function print_done() {
    donePrintFmt="\033[34;1m%s\033[0m\n"
    printf_separator
    printf $donePrintFmt "MacOS environment setup completed!"
}
