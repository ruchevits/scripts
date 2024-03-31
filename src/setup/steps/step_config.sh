#!/bin/bash

function step_config() {
    print_step_info "Fetching configuration"

    if [[ $+commands[mackup] != 0 ]]; then
        if [ -d ~/Mackup ]; then
            echo "Existing Mackup directory found\n"
            mackup uninstall -f
            rm -rf ~/Mackup
        else
            mkdir ~/.ssh
            echo "Host *
	IdentityAgent \"~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock\"" >~/.ssh/config
        fi

        git clone git@github.com:ruchevits/setup-macos.git ~/Mackup

        # TODO: refactor
        echo "[storage]
engine = file_system
path =
directory = Mackup

[applications_to_sync]
ssh" >~/.mackup.cfg

        mackup restore -f
        # mackup uninstall
    fi
}
