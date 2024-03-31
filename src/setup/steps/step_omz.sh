#!/bin/bash

function step_omz() {
    print_step_info "Installing Oh My Zsh"

    # Install Oh My Zsh
    if [ -d ~/.oh-my-zsh ]; then
        echo "Already installed"
        return
    fi

    # TODO: verify unattended works well
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
}
