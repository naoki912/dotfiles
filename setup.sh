#!/usr/bin/env sh

set -xveu

sudo -E pacman -S --noconfirm ctags python-pip npm archey3


#--
# pyenv
#--

git clone https://github.com/yyuu/pyenv.git ~/.pyenv
git clone https://github.com/yyuu/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv

#--
# rbenv
#--

git clone https://github.com/rbenv/rbenv.git ~/.rbenv
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

#--
# nodenv
#--

git clone https://github.com/nodenv/nodenv.git ~/.nodenv
git clone https://github.com/nodenv/node-build.git ~/.nodenv/plugins/node-build
git clone https://github.com/nodenv/nodenv-aliases.git ~/.nodenv/plugins/nodenv-aliases
cd ~/.nodenv && src/configure && make -C src

cd

#--
# vim
#--
sudo -E pacman -S --noconfirm neovim python-neovim openssl-1.0

# pyenv activate 用 (これが無いとコケる)
export PYENV_ROOT="${HOME}/.pyenv"
export PATH=${PYENV_ROOT}/bin:${PATH}
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

CFLAGS=-I/usr/include/openssl-1.0 LDFLAGS=-L/usr/lib64/openssl-1.0 pyenv install -v 2.7.16 -s
CFLAGS=-I/usr/include/openssl-1.0 LDFLAGS=-L/usr/lib64/openssl-1.0 pyenv install -v 3.7.2 -s

pyenv virtualenv 2.7.16 neovim2
pyenv virtualenv 3.7.2 neovim3

# flake8 と black はaleが使用する
# python2にはblackが無い
pyenv activate neovim2
pip install pynvim flake8
#pyenv which python

pyenv activate neovim3
pip install pynvim flake8 black
#pyenv which python


# rbenv用
export PATH=~/.rbenv/bin:${PATH}
eval "$(rbenv init -)"

rbenv install 2.6.3 -s

mkdir /tmp/rbenv_nvim
cd /tmp/rbenv_nvim

rbenv local 2.6.3
rbenv exec gem install neovim


# nodenv用
export PATH="~/.nodenv/bin:${PATH}"
eval "$(nodenv init -)"

nodenv install 12.3.1 -s
nodenv alias nvim 12.3.1

mkdir /tmp/nodenv_nvim
cd /tmp/nodenv_nvim

nodenv local nvim
nodenv exec npm -g install neovim typescript eslint tslint

#--
# Vim: Python関連のプラグイン
#--

sudo -E pacman -S --noconfirm autopep8 flake8


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
