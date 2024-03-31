#!/bin/bash

function step_utilities() {
    print_step_info "Installing utilities"

    brew_cleanup_needed=0

    pkgs=(
        "tree"           # Display directories as trees (with optional color/HTML output)
        "wget"           # Internet file retriever
        "trash"          # CLI tool that moves files or folder to the trash
        "openssl@3"      # Cryptography and SSL/TLS Toolkit
        "sqlite"         # Command-line interface for SQLite
        "xz"             # General-purpose data compression with high compression ratio
        "defaultbrowser" # Command-line tool for getting & setting the default browser
    )
    for pkg in "${pkgs[@]}"; do
        brew_install $pkg
        brew_cleanup_needed=$((brew_cleanup_needed | $?))
    done

    brew_cleanup $brew_cleanup_needed
}
