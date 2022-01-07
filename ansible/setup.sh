#!/usr/bin/bash

set -uvx


function install_ansible_on_mac() {
    if type brew > /dev/null 2>&1; then
        bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    brew install ansible
}


function install_ansible_on_linux() {
    sudo pacman -S --noconfirm ansible
}


if type ansible-playbook > /dev/null 2>&1; then
    if [[ "$(uname -s)" == "Darwin" ]]; then
        install_ansible_on_mac
    elif [[ "$(uname -s)" == "Linux" ]]; then
        install_ansible_on_linux
    else
        exit 1
    fi
fi

