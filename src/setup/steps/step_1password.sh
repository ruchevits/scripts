#!/bin/bash

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
