#!/bin/bash

# TODO: install more fonts!
function step_fonts() {
    print_step_info "Installing fonts"

    brew_cleanup_needed=0

    brew tap homebrew/cask-fonts

    # https://github.com/Homebrew/homebrew-cask-fonts/tree/master/Casks
    fonts=(
        "font-meslo-lg-nerd-font"
    )
    for font in "${fonts[@]}"; do
        brew_install_cask homebrew/cask-fonts/$font
        brew_cleanup_needed=$((brew_cleanup_needed | $?))
    done

    brew_cleanup $brew_cleanup_needed
}
