#!/usr/bin/env sh

sudo -E pacman -S ctags python-pip npm archey3

cd ~/            && git clone https://github.com/yyuu/pyenv.git ~/.pyenv
cd ~/.vim/bundle && git clone https://github.com/Shougo/neobundle.vim
