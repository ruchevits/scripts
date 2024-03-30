#!/bin/zsh

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

function print_intro() {
    asciiArtPrintFmt="\033[34;1m%s\033[0m\n"
    scriptDescriptionPrintFmt="\n\033[34;1m%s\033[0m\n\n"
    blueLinesListPrintFmt="\033[34;1mx %s\033[0m\n"

    printf $asciiArtPrintFmt \
        "   ____                   _                      _   _           " \
        "  |  _ \   _   _    ___  | |__     ___  __   __ (_) | |_   ___   " \
        "  | |_) | | | | |  / __| | '_ \   / _ \ \ \ / / | | | __| / __|  " \
        "  |  _ <  | |_| | | (__  | | | | |  __/  \ V /  | | | |_  \__ \  " \
        "  |_| \_\  \__,_|  \___| |_| |_|  \___|   \_/   |_|  \__| |___/  " \
        "                                                                 " \
        "-----------------------------------------------------------------"

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
    separatorPrintFmt="\n\033[34;1m%s\033[0m\n\n"
    stepInfoPrintFmt="\033[32;1m%s\033[0m\n\n"

    printf $separatorPrintFmt "-----------------------------------------------------------------"
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
    manualActionPromptPrintFmt="\n\033[35;1m%s\033[0m\n"

    printf $manualActionWarningPrintFmt "Manual action required:"
    printf $manualActionListPrintFmt $@
    while true; do
        printf $manualActionPromptPrintFmt "Type 'done' when you are ready to proceed"
        read "yn?> "
        case $yn in
        done)
            break
            ;;
        esac
    done
}

function print_done() {
    printf "\n"
    # print_line_blue "                                                                 "
    # print_line_blue "-----------------------------------------------------------------"
    # print_line_blue "   ____                                                          "
    # print_line_blue "  |  _ \  ___  _ __   ___                                        "
    # print_line_blue "  | | | |/ _ \| '_ \ / _ \                                       "
    # print_line_blue "  | |_| | (_) | | | |  __/                                       "
    # print_line_blue "  |____/ \___/|_| |_|\___|                                       "
    # print_line_blue "                                                                 "
}
