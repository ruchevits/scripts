#!/bin/zsh

source ./utils.sh
source ./steps/step_xcode.sh
source ./steps/step_homebrew.sh
source ./steps/step_1password.sh
source ./steps/step_git.sh
source ./steps/step_fonts.sh
source ./steps/step_utilities.sh
source ./steps/step_python.sh
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

steps=(
    step_xcode
    step_homebrew
    step_1password
    step_git
    step_fonts
    step_utilities
    # step_python
    step_volta
    step_javascript
    step_omz
    step_zsh_theme
    step_zsh_plugins
    step_iterm2
    step_applications
    step_vscode_extensions
    step_mackup
    step_config
    step_macos_dock
)

print_intro

if [ -z "$1" ]; then
    for step in "${steps[@]}"; do $step; done
else
    case "${steps[@]}" in *$1*) $1 ;; esac
fi

print_done

# TODO: add the following
# 1Password browser extensions (see: https://github.com/joshukraine/dotfiles/blob/master/brew/Brewfile)
#
