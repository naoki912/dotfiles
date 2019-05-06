#!/usr/bin/env sh

set -xveu

sudo -E pacman -S --noconfirm ctags python-pip npm archey3


#--
# pyenv
#--

git clone https://github.com/yyuu/pyenv.git ~/.pyenv
git clone https://github.com/yyuu/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv


#--
# vim
#--
sudo -E pacman -S --noconfirm neovim python-neovim

# pyenv activate 用 (これが無いとコケる)
export PYENV_ROOT="${HOME}/.pyenv"
export PATH=${PYENV_ROOT}/bin:${PATH}
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

CFLAGS=-I/usr/include/openssl-1.0 LDFLAGS=-L/usr/lib64/openssl-1.0 pyenv install -v 2.7.16
CFLAGS=-I/usr/include/openssl-1.0 LDFLAGS=-L/usr/lib64/openssl-1.0 pyenv install -v 3.7.2

pyenv virtualenv 2.7.16 neovim2
pyenv virtualenv 3.7.2 neovim3

pyenv activate neovim2
pip install pynvim
#pyenv which python

pyenv activate neovim3
pip install pynvim
#pyenv which python


#--
# Vim: Python関連のプラグイン
#--

sudo pacman -S autopep8 flake8


#--
# Vim: permission
#--

chmod 700 ~/dotfiles/_vim/undo/


#--
# goenv
#--

#git clone https://github.com/syndbg/goenv.git ~/.goenv


#--
# tmux
#--

sudo -E pacman -S --noconfirm xsel
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm


#--
# zsh
#--

if type packer > /dev/null 2>&1; then
    packer -S --noconfirm zplug
fi

