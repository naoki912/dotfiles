# dotfile展開/設定用ansible

## つかいかた

```sh
sudo pacman -S --noconfirm ansible
ansible-playbook dotfile.yml --ask-become-pass
ansible-playbook arch_base.yml --ask-become-pass
ansible-playbook arch_gui.yml --ask-become-pass
```

