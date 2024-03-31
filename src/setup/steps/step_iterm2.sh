#!/bin/bash

function step_iterm2() {
    print_step_info "Installing iTerm2"

    brew_cleanup_needed=0

    brew_install_cask iterm2 "/Applications/Utilities"
    brew_cleanup_needed=$((brew_cleanup_needed | $?))

    # https://github.com/TomAnthony/itermocil
    brew_install "TomAnthony/brews/itermocil"
    brew_cleanup_needed=$((brew_cleanup_needed | $?))

    # Load preferences from a custom folder
    defaults write com.googlecode.iterm2 "PrefsCustomFolder" -string "~/.config/iterm2/Preferences"
    defaults write com.googlecode.iterm2 "LoadPrefsFromCustomFolder" -bool true

    brew_cleanup $brew_cleanup_needed
}
