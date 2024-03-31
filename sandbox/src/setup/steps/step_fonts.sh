#!/bin/bash

# TODO: install more fonts!
function step_fonts() {
    brew tap homebrew/cask-fonts

    # https://github.com/Homebrew/homebrew-cask-fonts/tree/master/Casks
    brew_install_cask homebrew/cask-fonts/font-meslo-lg-nerd-font
    BREW_INSTALLED_FONT_MESLO_LG_NERD_FONT=$?

    # TODO: brew_cleanup?
}
