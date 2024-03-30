#!/bin/zsh

function clear_last_line() {
    tput cuu 1 && tput el
}

terminalWidth=$(tput cols)
function printf_separator() {
    printf "\n\033[34;1m"
    for i in $(eval echo {1..$terminalWidth}); do
        printf "-"
    done
    printf "\033[0m\n\n"
}

function print_intro() {
    asciiArtPrintFmt="\033[34;1m%s\033[0m\n"
    scriptDescriptionPrintFmt="\033[34;1m%s\033[0m\n\n"
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

    printf $blueLinesListPrintFmt \
        "Install XCode developer tools" \
        "Install and update Homebrew" \
        "Install 1Password" \
        "Install Git with some useful utilities" \
        "Install fonts" \
        "Install utilities" \
        "Install Volta" \
        "Install Node and PNPM via Volta" \
        "Install Oh My Zsh with powerline10k theme and plugins" \
        "Install iTerm2" \
        "Install applications" \
        "Install VSCode extensions" \
        "Install Mackup" \
        "Fetch Mackup configuration"
}

function print_step_info() {
    separatorPrintFmt="\033[34;1m%s\033[0m\n\n"
    stepInfoPrintFmt="\033[32;1m%s\033[0m\n\n"

    printf_separator

    if [ ! -z "$2" ]; then
        printf $stepInfoPrintFmt $2
    fi
    # read -s -k $'?Press any key to continue\n\n'
    $1

    steps=("one" "two" "three")
    print_manual_action_required $steps
}

function print_manual_action_required() {
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
