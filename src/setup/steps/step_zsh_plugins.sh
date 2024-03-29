#!/bin/bash

function step_zsh_plugins() {
    # Syntax hightlighting tool (needed for zsh colorize plugin)
    brew_install chroma
    BREW_INSTALLED_CHROMA=$?

    # Install Zsh plugins
    install_zsh_plugin zsh-autosuggestions "https://github.com/zsh-users/zsh-autosuggestions"
    install_zsh_plugin zsh-syntax-highlighting "https://github.com/zsh-users/zsh-syntax-highlighting"

    brew_cleanup $(($BREW_INSTALLED_CHROMA))
}
