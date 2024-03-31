#!/bin/bash

# TODO: dependencies for mackup: mpdecimal, ca-certificates, openssl@3, readline, sqlite, xz and python@3.12
function step_mackup() {
    print_step_info "Installing Mackup"

    brew_cleanup_needed=0

    # https://github.com/lra/mackup
    brew_install mackup
    brew_cleanup_needed=$((brew_cleanup_needed | $?))

    brew_cleanup $brew_cleanup_needed
}
