#!/usr/bin/env sh

sudo -E pacman -S --noconfirm ctags python-pip npm archey3

# pyenv
git clone https://github.com/yyuu/pyenv.git ~/.pyenv
git clone https://github.com/yyuu/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv

# vim
cd ~/.vim/bundle && git clone https://github.com/Shougo/neobundle.vim

# tmux
sudo -E pacman -S --noconfirm xsel
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
