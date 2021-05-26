alias h-usacloud-server-build='cat << EOF
usacloud server build \\
    --core=1 \\
    --memory=1 \\
    --disk-mode=create \\
    --os-type=ubuntu \\
    --disk-size=20 \\
    --network-mode=switch \\
    --switch-id= {{SWITCH_ID}} \\
    --hostname= {{HOSTNAME}} \\
    --password= {{PASSWORD}} \\
    --disable-pw-auth=true \\
    --ip=10.0.0.1 \\
    --nw-masklen=24 \\
    --gateway=10.0.0.254 \\
    --ssh-key-mode=id \\
    --ssh-key-ids= {{SSH_KEY_ids}} \\
    --name= {{NAME}} \\
    --description= {{DESCRIPTION}} \\
    --tags= {{TAGS}} \\
    -y

usacloud server build --core=1 --memory=1 --disk-mode=create --os-type=ubuntu --disk-size=20 --network-mode=switch --switch-id= {{SWITCH_ID}} --hostname= {{HOSTNAME}} --password= {{PASSWORD}} --disable-pw-auth=true --ip=10.0.0.1 --nw-masklen=24 --gateway=10.0.0.254 --ssh-key-mode=id --ssh-key-ids= {{SSH_KEY_ids}} --name= {{NAME}} --description= {{DESCRIPTION}} --tags= {{TAGS}} -y

- --network-mode
  - shared
    switch
    disconnect
    none
- --password
  - \${SAKURACLOUD_SERVER_PASSWORD}
EOF
'

alias h-usacloud-server-build-template='cat << EOF
usacloud server build -y --param-template {
    "core": 1,
    "memory": 1,
    "disk-mode": "create",
    "os-type": "ubuntu",
    "disk-size": 20,
    "network-mode": "switch",
    "switch-id": "{{SWITCH_ID}}",
    "hostname": "{{HOSTNAME}}",
    "password": "{{PASSWORD}}",
    "disable-pw-auth": "true",
    "ip": "10.0.0.1",
    "nw-masklen": 24,
    "gateway": "10.0.0.254",
    "ssh-key-mode": "id",
    "ssh-key-ids": "{{SSH_KEY_ids}}",
    "name": "{{NAME}}",
    "description": "{{DESCRIPTION}}",
    "tags": "{{TAGS}}"
}

or

--param-template-file
EOF
'
