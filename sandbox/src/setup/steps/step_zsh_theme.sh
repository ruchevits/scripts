#!/bin/bash

function step_zsh_theme() {
    brew_install powerlevel10k
    BREW_INSTALLED_POWERLEVEL10K=$?

    # Link powerlevel10k theme
    # https://unix.stackexchange.com/questions/207294/create-symlink-overwrite-if-one-exists
    ln -sfn "/usr/local/share/powerlevel10k/powerlevel10k.zsh-theme" ~/.oh-my-zsh/custom/themes/powerlevel10k.zsh-theme

    brew_cleanup $(($BREW_INSTALLED_POWERLEVEL10K))
}
