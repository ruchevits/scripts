#!/bin/bash

function step_xcode() {
    xcode-select -p &>/dev/null
    if [[ $? == 0 ]]; then
        echo "Already installed"
    else
        xcode-select --install
        MANUAL_STEP_XCODE_SETUP=(
            "Install XCode"
        )
        print_manual_action_required "${MANUAL_STEP_XCODE_SETUP[@]}"
    fi

}
