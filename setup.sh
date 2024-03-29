#!/bin/zsh

HOMEBREW_NO_ENV_HINTS=1

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
    print_line_blue "       |\/|  _   _    _  _ |_      _     _  _  _ .  _  |_        "
    print_line_blue "       |  | (_| (_   _) (- |_ |_| |_)   _) (_ |  | |_) |_        "
    print_line_blue "                                  |                |             "
    # print_line_blue "-----------------------------------------------------------------"
}

function print_step_info() {
    print_line_blue "                                                                 "
    print_line_blue "-----------------------------------------------------------------"
    print_line_green "\n$1\n"
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

function write_zshrc() {
    echo \\nWriting to .zshrc:
    echo "" >>~/.zshrc
    instructions=("$@")
    for i in "${instructions[@]}"; do
        echo "$i" >>~/.zshrc
        touch ~/.zshrc
    done
}

function brew_install() {
    if brew list $1 &>/dev/null; then
        echo "Brew package is already installed: ${1}"
        return 0
    else
        brew install $1 && echo "$1 is installed"
        return 1
    fi
}

function brew_install_cask() {
    if brew list $1 &>/dev/null; then
        echo "Brew package is already installed: ${1}"
        return 0
    else
        if [ -z "$2" ]; then
            brew install --cask $1
        else
            brew install --cask --appdir="$2" $1
        fi
        return 1
    fi
}

function brew_cleanup() {
    if [[ $1 == 1 ]]; then
        brew cleanup
    fi
}

function dock_add_app() {
    defaults write com.apple.dock $1 -array-add "<dict>
                <key>tile-data</key>
                <dict>
                    <key>file-data</key>
                    <dict>
                        <key>_CFURLString</key>
                        <string>$2</string>
                        <key>_CFURLStringType</key>
                        <integer>0</integer>
                    </dict>
                </dict>
            </dict>"
}

function dock_add_directory() {
    # tile-data.displayas: 0 for stack view or 1 for folder icon
    # tile-data.showas: 0 for auto, 1 for fan view, 2 for grid view or 3 for list view
    defaults write com.apple.dock $1 -array-add "<dict>
            <key>tile-type</key>
            <string>directory-tile</string>
            <key>tile-data</key>
            <dict>
                <key>file-data</key>
                <dict>
                    <key>_CFURLString</key>
                    <string>$2</string>
                    <key>_CFURLStringType</key>
                    <integer>0</integer>
                </dict>
                <key>displayas</key>
                <integer>1</integer>
                <key>showas</key>
                <integer>2</integer>
                <key>preferreditemsize</key>
                <integer>-1</integer>
            </dict>
        </dict>"
}

function dock_add_spacer() {
    # spacer-tile, small-spacer-tile, flex-spacer-tile
    defaults write com.apple.dock $1 -array-add "{\"tile-type\"=\"$2\";}"
}

########################################################################################################################

print_intro

########################################################################################################################

print_step_info "Installing XCode developer tools"

xcode-select -p 1>/dev/null
if [[ $? == 2 ]]; then
    echo "Already installed"
else
    xcode-select --install
    MANUAL_STEP_XCODE_SETUP=(
        "Install XCode"
    )
    print_manual_action_required "${MANUAL_STEP_XCODE_SETUP[@]}"
fi
