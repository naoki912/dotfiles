# python
set -gx PYENV_ROOT $HOME/.pyenv
fish_add_path $PYENV_ROOT/bin
if test -e ~/.pyenv/bin/pyenv
  pyenv init - | source
  pyenv virtualenv-init - | source
end

# ruby
if test -e ~/.rbenv/bin/rbenv
  status --is-interactive; and ~/.rbenv/bin/rbenv init - fish | source
end

# node
fish_add_path {$HOME}/.nodenv/bin

# go
set -gx GOPATH {$HOME}/.go
fish_add_path {$GOROOT}/bin:{$GOPATH}/bin

# local bin
fish_add_path ~/dotfiles/bin

# asdf
if test -e /opt/homebrew/opt/asdf/libexec/asdf.fish
  source /opt/homebrew/opt/asdf/libexec/asdf.fish
end

# brew
if test (uname -s) = "Darwin"
  fish_add_path /opt/homebrew/opt/coreutils/libexec/gnubin
  fish_add_path /opt/homebrew/opt/findutils/libexec/gnubin
  fish_add_path /opt/homebrew/opt/gnu-sed/libexec/gnubin
  fish_add_path /opt/homebrew/opt/gnu-tar/libexec/gnubin
  fish_add_path /opt/homebrew/opt/grep/libexec/gnubin
  fish_add_path /opt/homebrew/opt/ed/libexec/gnubin
  fish_add_path /opt/homebrew/opt/gnu-indent/libexec/gnubin
  fish_add_path /opt/homebrew/opt/gnu-which/libexec/gnubin
  fish_add_path /opt/homebrew/opt/gnu-time/libexec/gnubin
  fish_add_path /opt/homebrew/opt/gnu-getopt/libexec/gnubin

  set --path MANPATH /opt/homebrew/opt/coreutils/libexec/gnuman
  set --path MANPATH /opt/homebrew/opt/findutils/libexec/gnuman
  set --path MANPATH /opt/homebrew/opt/gnu-sed/libexec/gnuman
  set --path MANPATH /opt/homebrew/opt/gnu-tar/libexec/gnuman
  set --path MANPATH /opt/homebrew/opt/grep/libexec/gnuman
  set --path MANPATH /opt/homebrew/opt/ed/libexec/gnuman
  set --path MANPATH /opt/homebrew/opt/gnu-indent/libexec/gnuman
  set --path MANPATH /opt/homebrew/opt/gnu-which/libexec/gnuman
  set --path MANPATH /opt/homebrew/opt/gnu-time/libexec/gnuman
  set --path MANPATH /opt/homebrew/opt/gnu-getopt/libexec/gnuman
end
