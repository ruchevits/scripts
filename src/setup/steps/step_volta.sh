#!/bin/bash

function step_volta() {
    print_step_info "Installing Volta"

    which ~/.volta/bin/volta &>/dev/null
    if [[ $? == 0 ]]; then
        echo "Already installed"
    else
        # https://volta.sh/
        curl https://get.volta.sh | bash -s -- --skip-setup
    fi

    export VOLTA_HOME="$HOME/.volta"
    # export VOLTA_FEATURE_PNPM="1"
    export PATH="$VOLTA_HOME/bin:$PATH"
}
