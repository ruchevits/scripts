#!/bin/bash

function step_git() {
    print_step_info "Installing Git"

    brew_cleanup_needed=0

    pkgs=(
        "git"        # Distributed revision control system
        "git-extras" # Small git utilities (https://github.com/tj/git-extras/blob/main/Commands.md)
    )
    for pkg in "${pkgs[@]}"; do
        brew_install $pkg
        brew_cleanup_needed=$((brew_cleanup_needed | $?))
    done

    brew_cleanup $brew_cleanup_needed

}
