# dotfile展開/設定用ansible

## つかいかた

```sh
./setup.sh
ansible-playbook dotfile.yml --ask-become-pass
ansible-playbook arch_base.yml --ask-become-pass
ansible-playbook arch_gui.yml --ask-become-pass
```

macの場合

```sh
. ~/dotfiles/_zsh/zsh_env
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

pyenv activate ansible

pyenv exec ansible-playbook dotfile.yml --ask-become-pass
```
