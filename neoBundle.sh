#!/usr/bin/env sh

sudo pacman -S ctags python-pip npm

cd ~/            && git clone https://github.com/yyuu/pyenv.git ~/.pyenv
cd ~/.vim/bundle && git clone https://github.com/Shougo/vimproc.vim
cd ~/.vim/bundle && git clone https://github.com/Shougo/neobundle.vim

