#!/bin/bash

function step_zsh_theme() {
    print_step_info "Installing Zsh theme"

    brew_cleanup_needed=0

    brew_install powerlevel10k
    brew_cleanup_needed=$((brew_cleanup_needed | $?))

    # Link powerlevel10k theme
    # https://unix.stackexchange.com/questions/207294/create-symlink-overwrite-if-one-exists
    ln -sfn "/usr/local/share/powerlevel10k/powerlevel10k.zsh-theme" ~/.oh-my-zsh/custom/themes/powerlevel10k.zsh-theme

    brew_cleanup $brew_cleanup_needed
}
