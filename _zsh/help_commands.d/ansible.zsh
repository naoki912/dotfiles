
alias h-ansible-check-change='echo "
# notifyを使えない理由がある時に直前のtaskが成功したかどうかを確認したい場合
# ぶっちゃけ無いと思うけど

  - name: example
    lineinfile:
      dest: /etc/ssh/sshd_config
      state: present
      regexp: ListenAddress
      line: "ListenAddress {{ ssh_listen_address }}"
    register: ssh_result
    #notify:
    #  - restart sshd

  - name: reload sshd
    systemd:
      name: sshd
      state: reloaded
    when: ssh_result is defined and ssh_result is changed

    # おまけ
    when: (v4_result is defined and v4_result is changed) or (v6_result is defined and v6_result is changed)
"'

