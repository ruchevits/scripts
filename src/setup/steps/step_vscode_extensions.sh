#!/bin/bash

function install_vscode_extension() {
    code --list-extensions | grep $1
    if [[ $? == 0 ]]; then
        echo "VSCode extension is already installed: $1"
    else
        code --install-extension $1
    fi
}

function step_vscode_extensions() {
    print_step_info "Installing VSCode extensions"

    # If VSCode CLI is not found
    if [[ $+commands[code] == 0 ]]; then
        return
    fi

    vscode_extensions=(
        "esbenp.prettier-vscode"
        "hashicorp.terraform"
    )

    for i in "${vscode_extensions[@]}"; do
        install_vscode_extension $i
    done
}
