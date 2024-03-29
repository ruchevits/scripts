#!/bin/bash

function step_git() {
    brew_install "git"
    BREW_INSTALLED_GIT=$?

    # https://github.com/tj/git-extras/blob/main/Commands.md
    brew_install git-extras
    BREW_INSTALLED_GIT_EXTRAS=$?

    brew_install tree
    BREW_INSTALLED_TREE=$?

    brew_install defaultbrowser
    BREW_INSTALLED_DEFAULTBROWSER=$?

    brew_cleanup $(($BREW_INSTALLED_GIT | $BREW_INSTALLED_GIT_EXTRAS | $BREW_INSTALLED_TREE | $BREW_INSTALLED_DEFAULTBROWSER))

}
