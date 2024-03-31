#!/bin/zsh

function write_zshrc() {
    echo \\nWriting to .zshrc:
    echo "" >>~/.zshrc
    instructions=("$@")
    for i in "${instructions[@]}"; do
        echo "$i" >>~/.zshrc
        touch ~/.zshrc
    done
}

function install_zsh_plugin() {
    if [ -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/$1 ]; then
        echo "Zsh plugin is already installed: $1"
    else
        git clone $2 ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/$1
    fi
}
