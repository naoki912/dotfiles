#!/usr/bin/bash

set -vx


function install_ansible_on_mac_with_brew() {
    if ! type brew > /dev/null 2>&1; then
        bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    brew install ansible
}


function install_ansible() {
    if [ -d ${HOME}/.pyenv ]; then
        git clone https://github.com/pyenv/pyenv.git ~/.pyenv
        git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
    fi

    export PYENV_ROOT="${HOME}/.pyenv"
    export PATH=${PYENV_ROOT}/bin:${PATH}
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"

    pyenv install 3.10.1
    pyenv virtualenv 3.10.1 ansible
    export PYENV_VIRTUALENV_DISABLE_PROMPT=1
    pyenv activate ansible
    pyenv exec pip install ansible

    echo '=========='
    echo 'eval "$(pyenv init --path)"'
    echo 'eval "$(pyenv init -)"'
    echo 'eval "$(pyenv virtualenv-init -)"'
    echo 'pyenv exec ansible-playbook ...'
    echo '=========='
}


function install_ansible_on_linux() {
    sudo pacman -S --noconfirm ansible
}


if ! type ansible-playbook > /dev/null 2>&1; then
    if [[ "$(uname -s)" == "Darwin" ]]; then
        install_ansible_on_mac
    elif [[ "$(uname -s)" == "Linux" ]]; then
        install_ansible_on_linux
    else
        exit 1
    fi
fi

