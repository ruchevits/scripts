#!/bin/bash

function step_aws() {
    print_step_info "Installing AWS CLI"

    brew_cleanup_needed=0

    brew_install awscli
    brew_cleanup_needed=$((brew_cleanup_needed | $?))

    brew_cleanup $brew_cleanup_needed
}
