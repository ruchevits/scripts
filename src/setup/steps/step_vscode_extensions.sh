#!/bin/bash

function step_vscode_extensions() {
    print_step_info "Installing VSCode extensions"

    # If VSCode CLI is not found
    if [[ $+commands[code] == 0 ]]; then
        return
    fi

    vscode_extensions=(
        "esbenp.prettier-vscode"
    )

    for i in "${vscode_extensions[@]}"; do
        install_vscode_extension $i
    done
}
