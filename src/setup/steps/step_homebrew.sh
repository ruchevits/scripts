#!/bin/bash

HOMEBREW_NO_ENV_HINTS=1

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
