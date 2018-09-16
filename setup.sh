#!/usr/bin/env sh

sudo -E pacman -S --noconfirm ctags python-pip npm archey3

# pyenv
git clone https://github.com/yyuu/pyenv.git ~/.pyenv
git clone https://github.com/yyuu/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv

# Vim: Python関連のプラグイン
sudo pacman -S autopep8 flake8

# goenv
git clone https://github.com/syndbg/goenv.git ~/.goenv

# vim
cd ~/.vim/bundle && git clone https://github.com/Shougo/neobundle.vim

# tmux
sudo -E pacman -S --noconfirm xsel
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# zsh
if type packer > /dev/null 2>&1; then
    packer -S --noconfirm zplug
fi

# permission

chmod 700 ~/dotfiles/_vim/undo/
