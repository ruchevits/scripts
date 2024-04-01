#!/bin/bash

function step_python() {
    print_step_info "Installing Python"

    brew_cleanup_needed=0

    pkgs=(
        "python"
        "jupyter"
    )
    for pkg in "${pkgs[@]}"; do
        brew_install $pkg
        brew_cleanup_needed=$((brew_cleanup_needed | $?))
    done

    brew_cleanup $brew_cleanup_needed
}
