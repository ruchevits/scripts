#!/bin/bash

function step_omz() {
    # Install Oh My Zsh
    if [ -d ~/.oh-my-zsh ]; then
        echo "Already installed"
    else
        # TODO: verify unattended works well
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    fi
}
