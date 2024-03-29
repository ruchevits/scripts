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

if command -v xcode-select &>/dev/null; then
    echo "Already installed"
else
    xcode-select --install
    MANUAL_STEP_XCODE_SETUP=(
        "Install XCode"
    )
    print_manual_action_required "${MANUAL_STEP_XCODE_SETUP[@]}"
fi

########################################################################################################################

print_step_info "Installing Homebrew"

if [[ $+commands[brew] != 0 ]]; then
    echo "Already installed"
else
    # NONINTERACTIVE=1
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Update Homebrew recipes
print_step_info "Updating Homebrew"
brew update

########################################################################################################################

print_step_info "Installing 1Password"

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
        "Tick checkboxes 'Use the SSH agent' and 'Integrate with 1Password CLI'"
    )
    print_manual_action_required ${MANUAL_ACTION_1PASSWORD[@]}
fi

########################################################################################################################

print_step_info "Installing Git"

brew_install "git"
BREW_INSTALLED_GIT=$?

print_step_info "Installing Git utilities"

# https://github.com/tj/git-extras/blob/main/Commands.md
brew_install git-extras
BREW_INSTALLED_GIT_EXTRAS=$?

brew_install tree
BREW_INSTALLED_TREE=$?

brew_install defaultbrowser
BREW_INSTALLED_DEFAULTBROWSER=$?

brew_cleanup $(($BREW_INSTALLED_GIT | $BREW_INSTALLED_GIT_EXTRAS | $BREW_INSTALLED_TREE | $BREW_INSTALLED_DEFAULTBROWSER))

########################################################################################################################

# TODO: install more fonts!
print_step_info "Installing fonts"

brew tap homebrew/cask-fonts

# https://github.com/Homebrew/homebrew-cask-fonts/tree/master/Casks
brew_install_cask homebrew/cask-fonts/font-meslo-lg-nerd-font
BREW_INSTALLED_FONT_MESLO_LG_NERD_FONT=$?

# TODO: brew_cleanup?

########################################################################################################################

print_step_info "Installing utilities"

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

########################################################################################################################

print_step_info "Installing Volta"

# Install Volta (https://volta.sh/)
if [[ $+commands[volta] != 0 ]]; then
    echo "Already installed"
else
    curl https://get.volta.sh | bash -s -- --skip-setup

    # # Only write if no existing .zshrc to sync!
    # WRITE_ZSHRC_VOLTA=(
    #     "# Volta"
    #     "export VOLTA_HOME=\"$HOME/.volta\""
    #     "export VOLTA_FEATURE_PNPM=\"1\""
    #     "export PATH=\"\$VOLTA_HOME/bin:\$PATH\""
    # )
    # write_zshrc "${WRITE_ZSHRC_VOLTA[@]}"

    export VOLTA_HOME="$HOME/.volta"
    # export VOLTA_FEATURE_PNPM="1"
    export PATH="$VOLTA_HOME/bin:$PATH"

fi

########################################################################################################################

print_step_info "Installing Node and PNPM"

volta install node
volta install pnpm

########################################################################################################################

# # Install python
# brew install python
# brew install virtualenv
# brew install jupyter

########################################################################################################################

print_step_info "Installing Oh My ZSH"

# TODO: verify unattended works well
# Install Oh My Zsh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Install powerlevel10k theme
brew_install powerlevel10k
BREW_INSTALLED_POWERLEVEL10K=$?

ln -s "/usr/local/share/powerlevel10k/powerlevel10k.zsh-theme" ~/.oh-my-zsh/custom/themes/powerlevel10k.zsh-theme

# Install zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Syntax hightlighting tool (needed for zsh colorize plugin)
brew_install chroma
BREW_INSTALLED_CHROMA=$?

# Install iTerm2
print_step_info "Installing iTerm2"
brew_install_cask iterm2 "/Applications/Utilities"
BREW_INSTALLED_ITERM2=$?

# https://github.com/TomAnthony/itermocil
brew_install "TomAnthony/brews/itermocil"
BREW_INSTALLED_ITERMOCIL=$?

brew_cleanup $(($BREW_INSTALLED_POWERLEVEL10K | $BREW_INSTALLED_CHROMA | $BREW_INSTALLED_ITERM2 | $BREW_INSTALLED_ITERMOCIL))

########################################################################################################################

# TODO: delete unnecessary apps
# https://macpaw.com/how-to/delete-mail-app-mac

########################################################################################################################

print_step_info "Installing applications"

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

########################################################################################################################

print_step_info "Installing VSCode extensions"

VSCODE_EXTENSIONS=(
    "esbenp.prettier-vscode"
)

if [[ $+commands[code] != 0 ]]; then
    for i in "${VSCODE_EXTENSIONS[@]}"; do
        code --install-extension $i
    done
fi

########################################################################################################################

# TODO: dependencies for mackup: mpdecimal, ca-certificates, openssl@3, readline, sqlite, xz and python@3.12
print_step_info "Installing Mackup"

# https://github.com/lra/mackup
brew_install mackup
BREW_INSTALLED_MACKUP=$?

brew_cleanup $(($BREW_INSTALLED_MACKUP))

########################################################################################################################

print_step_info "Fetching Mackup configuration"

git clone git@github.com:ruchevits/setup-macos.git ~/Mackup

# TODO: refactor
echo "[storage]
engine = file_system
path =
directory = Mackup

[applications_to_sync]
macosx
1password-4
ssh
zsh
homebrew
git
terminal
itermocil
hammerspoon
telegram_macos
aws
postico
vscode" >~/.mackup.cfg

# Symlink
if [[ $+commands[mackup] != 0 ]]; then
    mackup restore -f
    # mackup uninstall
fi

########################################################################################################################

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

########################################################################################################################

print_done
