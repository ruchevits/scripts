#!/bin/zsh

# https://stackoverflow.com/questions/314675/how-to-redirect-output-of-an-entire-shell-script-within-the-script-itself
# exec > >(tee -a "setup.log") 2>&1

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

function install_zsh_plugin() {
    if [ -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/$1 ]; then
        echo "zsh plugin is already installed: $1"
    else
        git clone $2 ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/$1
    fi
}

function install_vscode_extension() {
    code --list-extensions | grep $1
    if [[ $? == 0 ]]; then
        echo "VSCode extension is already installed: $1"
    else
        code --install-extension $1
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

function step_xcode() {
    xcode-select -p &>/dev/null
    if [[ $? == 0 ]]; then
        echo "Already installed"
    else
        xcode-select --install
        MANUAL_STEP_XCODE_SETUP=(
            "Install XCode"
        )
        print_manual_action_required "${MANUAL_STEP_XCODE_SETUP[@]}"
    fi

}

########################################################################################################################

function step_homebrew() {
    if [[ $+commands[brew] != 0 ]]; then
        echo "Already installed"
    else
        # NONINTERACTIVE=1
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    # Update Homebrew recipes
    echo ""
    brew update
}

########################################################################################################################

function step_1password() {
    brew_install '1password-cli'
    BREW_INSTALLED_1PASSWORD_CLI=$?

    brew_install_cask '1password' "/Applications"
    BREW_INSTALLED_1PASSWORD=$?

    brew_cleanup $(($BREW_INSTALLED_1PASSWORD_CLI | $BREW_INSTALLED_1PASSWORD))

    if [[ $BREW_INSTALLED_1PASSWORD == 1 ]]; then
        open /Applications/1Password.app

        MANUAL_ACTION_1PASSWORD=(
            "Sign in to 1Password app"
            "Go to 1Password \\u2192 Settings \\u2192 Developer"
            "Tick checkbox 'Use the SSH agent' and allow 1Password to update ~/.ssh/config file"
            "Tick checkbox 'Integrate with 1Password CLI'"
        )
        print_manual_action_required ${MANUAL_ACTION_1PASSWORD[@]}
    fi
}

########################################################################################################################

function step_git() {
    brew_install "git"
    BREW_INSTALLED_GIT=$?

    # https://github.com/tj/git-extras/blob/main/Commands.md
    brew_install git-extras
    BREW_INSTALLED_GIT_EXTRAS=$?

    brew_install tree
    BREW_INSTALLED_TREE=$?

    brew_install defaultbrowser
    BREW_INSTALLED_DEFAULTBROWSER=$?

    brew_cleanup $(($BREW_INSTALLED_GIT | $BREW_INSTALLED_GIT_EXTRAS | $BREW_INSTALLED_TREE | $BREW_INSTALLED_DEFAULTBROWSER))

}

########################################################################################################################

# TODO: install more fonts!
function step_fonts() {
    brew tap homebrew/cask-fonts

    # https://github.com/Homebrew/homebrew-cask-fonts/tree/master/Casks
    brew_install_cask homebrew/cask-fonts/font-meslo-lg-nerd-font
    BREW_INSTALLED_FONT_MESLO_LG_NERD_FONT=$?

    # TODO: brew_cleanup?
}

########################################################################################################################

function step_utilities() {
    brew_install tree
    BREW_INSTALLED_TREE=$?

    brew_install wget
    BREW_INSTALLED_WGET=$?

    brew_install trash
    BREW_INSTALLED_TRASH=$?

    brew_install openssl@3
    BREW_INSTALLED_OPENSSL=$?

    brew_install sqlite
    BREW_INSTALLED_SQLITE=$?

    brew_install xz
    BREW_INSTALLED_XZ=$?

    brew_cleanup $(($BREW_INSTALLED_TREE | $BREW_INSTALLED_WGET | $BREW_INSTALLED_TRASH | $BREW_INSTALLED_OPENSSL | $BREW_INSTALLED_SQLITE | $BREW_INSTALLED_XZ))
}

########################################################################################################################

function step_volta() {
    which ~/.volta/bin/volta &>/dev/null
    if [[ $? == 0 ]]; then
        echo "Already installed"
    else
        # https://volta.sh/
        curl https://get.volta.sh | bash -s -- --skip-setup
    fi

    export VOLTA_HOME="$HOME/.volta"
    # export VOLTA_FEATURE_PNPM="1"
    export PATH="$VOLTA_HOME/bin:$PATH"
}

########################################################################################################################

function step_javascript() {
    volta install node
    volta install pnpm
}

########################################################################################################################

# # Install python
# brew install python
# brew install virtualenv
# brew install jupyter

########################################################################################################################

function step_omz() {
    # Install Oh My Zsh
    if [ -d ~/.oh-my-zsh ]; then
        echo "Already installed"
    else
        # TODO: verify unattended works well
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    fi
}

########################################################################################################################

function step_zsh_theme() {
    brew_install powerlevel10k
    BREW_INSTALLED_POWERLEVEL10K=$?

    # Link powerlevel10k theme
    # https://unix.stackexchange.com/questions/207294/create-symlink-overwrite-if-one-exists
    ln -sfn "/usr/local/share/powerlevel10k/powerlevel10k.zsh-theme" ~/.oh-my-zsh/custom/themes/powerlevel10k.zsh-theme

    brew_cleanup $(($BREW_INSTALLED_POWERLEVEL10K))
}

########################################################################################################################

function step_zsh_plugins() {
    # Syntax hightlighting tool (needed for zsh colorize plugin)
    brew_install chroma
    BREW_INSTALLED_CHROMA=$?

    # Install zsh plugins
    install_zsh_plugin zsh-autosuggestions "https://github.com/zsh-users/zsh-autosuggestions"
    install_zsh_plugin zsh-syntax-highlighting "https://github.com/zsh-users/zsh-syntax-highlighting"

    brew_cleanup $(($BREW_INSTALLED_CHROMA))
}

########################################################################################################################

function step_iterm2() {
    brew_install_cask iterm2 "/Applications/Utilities"
    BREW_INSTALLED_ITERM2=$?

    # https://github.com/TomAnthony/itermocil
    brew_install "TomAnthony/brews/itermocil"
    BREW_INSTALLED_ITERMOCIL=$?

    brew_cleanup $(($BREW_INSTALLED_ITERM2 | $BREW_INSTALLED_ITERMOCIL))
}

########################################################################################################################

# TODO: delete unnecessary apps
# https://macpaw.com/how-to/delete-mail-app-mac

########################################################################################################################

function step_applications() {
    brew_install_cask spotify "/Applications"
    BREW_INSTALLED_SPOTIFY=$?

    brew_install_cask vlc "/Applications"
    BREW_INSTALLED_VLC=$?

    brew_install_cask google-chrome "/Applications"
    BREW_INSTALLED_GOOGLE_CHROME=$?

    brew_install_cask firefox "/Applications"
    BREW_INSTALLED_FIREFOX=$?

    brew_install_cask google-drive "/Applications"
    BREW_INSTALLED_GOOGLE_DRIVE=$?

    brew_install_cask notion "/Applications"
    BREW_INSTALLED_NOTION=$?

    brew_install_cask notion-calendar "/Applications"
    BREW_INSTALLED_NOTION_CALENDAR=$?

    brew_install_cask slack "/Applications"
    BREW_INSTALLED_SLACK=$?

    brew_install_cask telegram "/Applications"
    BREW_INSTALLED_TELEGRAM=$?

    brew_install_cask figma "/Applications"
    BREW_INSTALLED_FIGMA=$?

    brew_install_cask postico "/Applications"
    BREW_INSTALLED_POSTICO=$?

    brew_install_cask rapidapi "/Applications"
    BREW_INSTALLED_RAPIDAPI=$?

    brew_install_cask visual-studio-code "/Applications"
    BREW_INSTALLED_VSCODE=$?

    brew_install_cask hammerspoon "/Applications/Utilities"
    BREW_INSTALLED_HAMMERSPOON=$?

    # Force cleanup
    brew_cleanup 1
}

########################################################################################################################

function step_vscode_extensions() {
    VSCODE_EXTENSIONS=(
        "esbenp.prettier-vscode"
    )

    if [[ $+commands[code] != 0 ]]; then
        for i in "${VSCODE_EXTENSIONS[@]}"; do
            install_vscode_extension $i
        done
    fi
}

########################################################################################################################

# TODO: dependencies for mackup: mpdecimal, ca-certificates, openssl@3, readline, sqlite, xz and python@3.12
function step_mackup() {
    # https://github.com/lra/mackup
    brew_install mackup
    BREW_INSTALLED_MACKUP=$?

    brew_cleanup $(($BREW_INSTALLED_MACKUP))
}

########################################################################################################################

function step_config() {
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

function step_macos_dock() {

    # Configure dock (https://developer.apple.com/documentation/devicemanagement/dock)

    defaults delete com.apple.dock

    defaults write com.apple.dock orientation -string bottom
    defaults write com.apple.dock tilesize -integer 64

    defaults write com.apple.dock size-immutable -bool true
    defaults write com.apple.dock position-immutable -bool true
    defaults write com.apple.dock contents-immutable -bool true
    defaults write com.apple.dock showrecents-immutable -bool true

    defaults write com.apple.dock static-only -bool true
    defaults write com.apple.dock show-recents -bool false

    defaults write com.apple.dock static-apps -array
    defaults write com.apple.dock static-others -array
    defaults write com.apple.dock persistent-apps -array
    defaults write com.apple.dock persistent-others -array

    dock_add_app static-apps "/Applications/Spotify.app"
    # dock_add_app static-apps "/Applications/VLC.app"

    dock_add_spacer static-apps flex-spacer-tile

    dock_add_app static-apps "/Applications/Utilities/iTerm.app"

    dock_add_spacer static-apps small-spacer-tile

    dock_add_app static-apps "/Applications/Google Chrome.app"
    dock_add_app static-apps "/Applications/Firefox.app"

    dock_add_spacer static-apps small-spacer-tile

    dock_add_app static-apps "/Applications/Notion Calendar.app"
    dock_add_app static-apps "/Applications/Notion.app"
    dock_add_app static-apps "/Applications/Slack.app"
    dock_add_app static-apps "/Applications/Telegram.app"
    dock_add_app static-apps "/Applications/Figma.app"

    dock_add_spacer static-apps small-spacer-tile

    dock_add_app static-apps "/Applications/Postico 2.app"
    dock_add_app static-apps "/Applications/RapidAPI.app"
    dock_add_app static-apps "/Applications/Visual Studio Code.app"

    dock_add_spacer static-apps flex-spacer-tile

    dock_add_directory static-others /Users/johndoe/Downloads/
    # dock_add_directory static-others "/Users/johndoe/Library/CloudStorage/GoogleDrive-ruchevits@gmail.com"
    # dock_add_directory static-others "/Users/johndoe/Library/CloudStorage/GoogleDrive-edward@ruchevits.com"

    # Mission Control
    defaults write com.apple.dock "mru-spaces" -bool "false"

    killall Dock
}

########################################################################################################################

print_intro

if [ -z "$1" ]; then
    print_step_info step_xcode "Installing XCode developer tools"
    print_step_info step_homebrew "Installing Homebrew"
    print_step_info step_1password "Installing 1Password"
    print_step_info step_git "Installing Git"
    print_step_info step_fonts "Installing fonts"
    print_step_info step_utilities "Installing utilities"
    print_step_info step_volta "Installing Volta"
    print_step_info step_javascript "Installing JavaScript tools"
    print_step_info step_omz "Installing Oh My ZSH"
    print_step_info step_zsh_theme "Installing zsh theme"
    print_step_info step_zsh_plugins "Installing zsh plugins"
    print_step_info step_iterm2 "Installing iTerm2"
    print_step_info step_applications "Installing applications"
    print_step_info step_vscode_extensions "Installing VSCode extensions"
    print_step_info step_mackup "Installing Mackup"
    print_step_info step_config "Fetching configuration"
    print_step_info step_macos_dock "Configuring MacOS Dock"
else
    print_step_info $1
fi

print_done
