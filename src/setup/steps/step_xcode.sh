#!/bin/bash

function step_xcode() {
    print_step_info "Installing XCode developer tools"

    xcode-select -p &>/dev/null
    if [[ $? == 0 ]]; then
        echo "Already installed"
        return
    fi

    xcode-select --install

    steps=(
        "Install XCode"
    )
    require_manual_action "${steps[@]}"
}
