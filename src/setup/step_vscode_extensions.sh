#!/bin/bash

function step_vscode_extensions() {
    VSCODE_EXTENSIONS=(
        "esbenp.prettier-vscode"
    )

    if [[ $+commands[code] != 0 ]]; then
        for i in "${VSCODE_EXTENSIONS[@]}"; do
            install_vscode_extension $i
        done
    fi
}
