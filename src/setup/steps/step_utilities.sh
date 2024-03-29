#!/bin/bash

function step_utilities() {
    brew_install tree
    BREW_INSTALLED_TREE=$?

    brew_install wget
    BREW_INSTALLED_WGET=$?

    brew_install trash
    BREW_INSTALLED_TRASH=$?

    brew_install openssl@3
    BREW_INSTALLED_OPENSSL=$?

    brew_install sqlite
    BREW_INSTALLED_SQLITE=$?

    brew_install xz
    BREW_INSTALLED_XZ=$?

    brew_cleanup $(($BREW_INSTALLED_TREE | $BREW_INSTALLED_WGET | $BREW_INSTALLED_TRASH | $BREW_INSTALLED_OPENSSL | $BREW_INSTALLED_SQLITE | $BREW_INSTALLED_XZ))
}
