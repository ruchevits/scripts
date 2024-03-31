#!/bin/bash

function step_iterm2() {
    brew_install_cask iterm2 "/Applications/Utilities"
    BREW_INSTALLED_ITERM2=$?

    # https://github.com/TomAnthony/itermocil
    brew_install "TomAnthony/brews/itermocil"
    BREW_INSTALLED_ITERMOCIL=$?

    brew_cleanup $(($BREW_INSTALLED_ITERM2 | $BREW_INSTALLED_ITERMOCIL))
}
