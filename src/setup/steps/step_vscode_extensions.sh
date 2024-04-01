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

    # bierner.markdown-preview-github-styles
    # bradlc.vscode-tailwindcss
    # christian-kohler.npm-intellisense
    # christian-kohler.path-intellisense
    # chrmarti.regex
    # dbaeumer.vscode-eslint
    # donjayamanne.python-environment-manager
    # eamodio.gitlens
    # ecmel.vscode-html-css
    # github.copilot
    # github.copilot-chat
    # github.github-vscode-theme
    # github.vscode-github-actions
    # golang.go
    # johnpapa.vscode-peacock
    # miclo.sort-typescript-imports
    # ms-python.debugpy
    # ms-python.python
    # ms-python.vscode-pylance
    # ms-toolsai.jupyter
    # ms-toolsai.jupyter-keymap
    # ms-toolsai.jupyter-renderers
    # ms-toolsai.vscode-jupyter-cell-tags
    # ms-toolsai.vscode-jupyter-slideshow
    # pmneo.tsimporter
    # rust-lang.rust-analyzer
    # rvest.vs-code-prettier-eslint
    # thang-nm.catppuccin-perfect-icons
    # vscode-icons-team.vscode-icons
    # vue.volar
    # yoavbls.pretty-ts-errors

    vscode_extensions=(
        "esbenp.prettier-vscode"
        "hashicorp.terraform"
    )

    for i in "${vscode_extensions[@]}"; do
        install_vscode_extension $i
    done
}
