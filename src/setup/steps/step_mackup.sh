#!/bin/bash

# TODO: dependencies for mackup: mpdecimal, ca-certificates, openssl@3, readline, sqlite, xz and python@3.12
function step_mackup() {
    # https://github.com/lra/mackup
    brew_install mackup
    BREW_INSTALLED_MACKUP=$?

    brew_cleanup $(($BREW_INSTALLED_MACKUP))
}
