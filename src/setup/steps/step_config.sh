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
            cp ./files/ssh/config.1password $HOME/ssh/config
            echo "Host *\nIdentityAgent \"~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock\"" >~/.ssh/config
        fi
        git clone git@github.com:ruchevits/setup-macos.git ~/Mackup
        cp ./files/.mackup.cfg $HOME/.mackup.cfg
        mackup restore -f
        # mackup uninstall
    fi
}
