#!/usr/bin/env sh

sudo -E pacman -S ctags python-pip npm archey3

git clone https://github.com/yyuu/pyenv.git ~/.pyenv
git clone https://github.com/yyuu/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
cd ~/.vim/bundle && git clone https://github.com/Shougo/neobundle.vim
