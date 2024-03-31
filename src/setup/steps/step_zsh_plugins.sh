#!/bin/bash

function step_zsh_plugins() {
    print_step_info "Installing Zsh plugins"

    brew_cleanup_needed=0

    # Syntax hightlighting tool (needed for zsh colorize plugin)
    brew_install chroma
    brew_cleanup_needed=$((brew_cleanup_needed | $?))

    # Install Zsh plugins
    install_zsh_plugin zsh-autosuggestions "https://github.com/zsh-users/zsh-autosuggestions"
    install_zsh_plugin zsh-syntax-highlighting "https://github.com/zsh-users/zsh-syntax-highlighting"

    brew_cleanup $brew_cleanup_needed
}
