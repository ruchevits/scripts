#!/bin/bash

function step_1password() {
    print_step_info "Installing 1Password"

    brew_cleanup_needed=0

    brew_install '1password-cli'
    brew_cleanup_needed=$((brew_cleanup_needed | $?))

    brew_install_cask '1password' "/Applications"
    brew_installed_1password=$?
    brew_cleanup_needed=$((brew_cleanup_needed | $?))

    brew_cleanup $brew_cleanup_needed

    if [[ $brew_installed_1password == 1 ]]; then
        open /Applications/1Password.app

        steps=(
            "Sign in to 1Password app"
            "Go to 1Password \\u2192 Settings \\u2192 Developer"
            "Tick checkbox 'Use the SSH agent' and allow 1Password to update ~/.ssh/config file"
            "Tick checkbox 'Integrate with 1Password CLI'"
        )
        print_manual_action_required ${steps[@]}
    fi
}
