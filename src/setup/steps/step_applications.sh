#!/bin/bash

function step_applications() {
    print_step_info "Installing applications"

    brew_cleanup_needed=0

    brew_install_cask spotify "/Applications"
    brew_cleanup_needed=$((brew_cleanup_needed | $?))

    brew_install_cask vlc "/Applications"
    brew_cleanup_needed=$((brew_cleanup_needed | $?))

    brew_install_cask google-chrome "/Applications"
    brew_cleanup_needed=$((brew_cleanup_needed | $?))

    brew_install_cask firefox "/Applications"
    brew_cleanup_needed=$((brew_cleanup_needed | $?))

    brew_install_cask google-drive "/Applications"
    brew_cleanup_needed=$((brew_cleanup_needed | $?))

    brew_install_cask notion "/Applications"
    brew_cleanup_needed=$((brew_cleanup_needed | $?))

    brew_install_cask notion-calendar "/Applications"
    brew_cleanup_needed=$((brew_cleanup_needed | $?))

    brew_install_cask slack "/Applications"
    brew_cleanup_needed=$((brew_cleanup_needed | $?))

    brew_install_cask telegram "/Applications"
    brew_cleanup_needed=$((brew_cleanup_needed | $?))

    brew_install_cask figma "/Applications"
    brew_cleanup_needed=$((brew_cleanup_needed | $?))

    brew_install_cask postico "/Applications"
    brew_cleanup_needed=$((brew_cleanup_needed | $?))

    brew_install_cask rapidapi "/Applications"
    brew_cleanup_needed=$((brew_cleanup_needed | $?))

    brew_install_cask visual-studio-code "/Applications"
    brew_cleanup_needed=$((brew_cleanup_needed | $?))

    brew_install_cask hammerspoon "/Applications/Utilities"
    brew_cleanup_needed=$((brew_cleanup_needed | $?))

    brew_cleanup $brew_cleanup_needed
}
