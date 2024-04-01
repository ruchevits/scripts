#!/bin/bash

function step_terraform() {
    print_step_info "Installing AWS CLI"

    brew tap hashicorp/tap

    brew_cleanup_needed=0

    brew_install hashicorp/tap/terraform
    brew_cleanup_needed=$((brew_cleanup_needed | $?))

    brew_cleanup $brew_cleanup_needed
}
