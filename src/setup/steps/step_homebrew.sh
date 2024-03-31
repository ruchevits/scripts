#!/bin/bash

function step_homebrew() {
    print_step_info "Installing Homebrew"

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
