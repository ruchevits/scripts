#!/bin/zsh

# https://stackoverflow.com/questions/314675/how-to-redirect-output-of-an-entire-shell-script-within-the-script-itself
# exec > >(tee -a "setup.log") 2>&1

########################################################################################################################

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
    print_line_blue "Configuration script"
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

########################################################################################################################

function step_config() {
    # Symlink
    if [[ $+commands[mackup] != 0 ]]; then

        if [ -d ~/Mackup ]; then
            echo "Existing Mackup directory found\n"
            mackup uninstall -f
            rm -rf ~/Mackup
        else
            mkdir ~/.ssh
            echo "Host *
	IdentityAgent \"~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock\"" >~/.ssh/config
        fi

        git clone git@github.com:ruchevits/setup-macos.git ~/Mackup

        # TODO: refactor
        echo "[storage]
engine = file_system
path =
directory = Mackup

[applications_to_sync]
ssh" >~/.mackup.cfg

        mackup restore -f
        # mackup uninstall
    fi
}

########################################################################################################################

print_intro

print_step_info step_config "Fetching configuration"

print_done
