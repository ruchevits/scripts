#!/bin/zsh

source ./utils/utils_colours.sh
source ./utils/utils_brew.sh
source ./utils/utils_zsh.sh
source ./utils/utils_vscode.sh
source ./utils/utils_dock.sh

source ./steps/step_xcode.sh
source ./steps/step_homebrew.sh
source ./steps/step_1password.sh
source ./steps/step_git.sh
source ./steps/step_fonts.sh
source ./steps/step_utilities.sh
source ./steps/step_volta.sh
source ./steps/step_javascript.sh
source ./steps/step_omz.sh
source ./steps/step_zsh_theme.sh
source ./steps/step_zsh_plugins.sh
source ./steps/step_iterm2.sh
source ./steps/step_applications.sh
source ./steps/step_vscode_extensions.sh
source ./steps/step_mackup.sh
source ./steps/step_config.sh
source ./steps/step_macos_dock.sh

# if [[ $# < 1 ]]; then
# 	usage
# fi

# https://stackoverflow.com/questions/314675/how-to-redirect-output-of-an-entire-shell-script-within-the-script-itself
# exec > >(tee -a "setup.log") 2>&1

HOMEBREW_NO_ENV_HINTS=1

########################################################################################################################

# # Install python
# brew install python
# brew install virtualenv
# brew install jupyter

# TODO: delete unnecessary apps
# https://macpaw.com/how-to/delete-mail-app-mac

print_intro

if [ -z "$1" ]; then
    print_step_info step_xcode "Installing XCode developer tools"
    # print_step_info step_homebrew "Installing Homebrew"
    # print_step_info step_1password "Installing 1Password"
    # print_step_info step_git "Installing Git"
    # print_step_info step_fonts "Installing fonts"
    # print_step_info step_utilities "Installing utilities"
    # print_step_info step_volta "Installing Volta"
    # print_step_info step_javascript "Installing JavaScript tools"
    # print_step_info step_omz "Installing Oh My Zsh"
    # print_step_info step_zsh_theme "Installing Zsh theme"
    # print_step_info step_zsh_plugins "Installing Zsh plugins"
    # print_step_info step_iterm2 "Installing iTerm2"
    # print_step_info step_applications "Installing applications"
    # print_step_info step_vscode_extensions "Installing VSCode extensions"
    # print_step_info step_mackup "Installing Mackup"
    # print_step_info step_config "Fetching configuration"
    # print_step_info step_macos_dock "Configuring MacOS Dock"
else
    print_step_info $1
fi

print_done
