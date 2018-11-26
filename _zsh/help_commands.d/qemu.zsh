alias h-qemu-mount='echo "\
# ホストにディスクイメージをマウント
losetup -f -P DISK_IMAGE
mount /dev/loop0p1 MOUNT_POINT

# mountコマンドを直接叩く方法
# fdiskでマウントしたいパーティションのoffsetを確認する
# Startとなっている部分に512を掛ける
fdisk -l DISK_IMAGE
> Disk image.qcow2: 384 KiB, 393216 bytes, 768 sectors
> Units: sectors of 1 * 512 = 512 bytes
> Sector size (logical/physical): 512 bytes / 512 bytes
> I/O size (minimum/optimal): 512 bytes / 512 bytes
> Disklabel type: dos
> Disk identifier: 0xfdf2dd6c
>
> Device         Boot Start   End Sectors   Size Id Type
> image.qcow2p1            1   767     767 383.5K 83 Linux

mount -o loop,offset=`expr 1 \* 512` image.raw /mnt
"'

alias h-qemu-disk-size-change='echo "\
# disk size の変更
qemu-img resize guest.qcow2 +5G

# diskをマウント
modprobe -av nbd
qemu-nbd -c /dev/nbd0 ~/img.qcow2

# パーティションの削除
fdisk /dev/nbd0
> d 1
> n
> Enter...

# umount
qemu-nbd --disconnect /dev/nbd0
modprobe -rv nbd

# ファイルシステムのリサイズ
resize2fs /dev/vda1"'

alias h-qemu-disk-create='echo "\
# 4Gのrawイメージを作成
qemu-img create -f raw IMAGE_FILE 4G
qemu-img create -f qcow2 IMAGE_FILE 4G

---
btrfs上に作成する場合はCopy-on-Write を無効化すること
$ chattr +C </dir/file>
or
$ mv /path/to/dir /path/to/dir_old
$ mkdir /path/to/dir
$ chattr +C /path/to/dir
$ cp -a /path/to/dir_old/* /path/to/dir
$ rm -rf /path/to/dir_old

cp --reflink を使用した場合、CoWになってしまうため注意"'

alias h-qemu-disk-backing='echo "\
qemu-img create -o backing_file=img1.raw,backing_fmt=raw -f qcow2 img1.cow

# backing fileのPATHが変わった場合は修正が必要
# PATHを変更するのは大変なのであまりやらないほうがいいらしい(やり方は調べてない)

# パスの変更
qemu-img rebase -b /new/img1.raw /new/img1.cow
# backingイメージの古いパスがチェックされない 「危険な」rebase
qemu-img rebase -u -b /new/img1.raw /new/img1.cow"'

alias h-qemu-install-os='echo "\
qemu-system-x86_64 -cdrom iso_image -boot order=d -drive file=disk_image,format=raw"'

alias h-qemu-kvm-check='echo "\
# kvmをサポートしているかチェックするコマンド
LC_ALL=C lscpu | grep Virtualization
# もしくは
grep -E --color=auto \"vmx|svm|0xc0f\" /proc/cpuinfo

# kernel moduleがあるか確認
# yかmになっていればok
zgrep CONFIG_KVM /proc/config.gz

# virtioが使えるか確認
zgrep VIRTIO /proc/config.gz

# kvmとvirtioが自動でロードされているか確認
lsmod | grep kvm
lsmod | grep virtio"'

alias h-qemu-kvm-nested='echo "\
# moduleをロード
modprobe -r kvm_intel
modprobe kvm_intel nested=1

# ファイルに書き込む場合
```conf=/etc/modprobe.d/kvm_intel.conf
options kvm_intel nested=1
```

# 有効になっているか確認
systool -m kvm_intel -v | grep nested
    nested              = "Y"

# VMの上でVMを動かす場合の、下のVMの起動方法
# qemuを使う場合
qemu-system-x86_64 -enable-kvm -cpu host
# virt-managerを使う場合
#CPUモデルをhost-passthroughに変更する
# virshを使用する場合
virsh edit vm-name
<cpu mode=\"host-passthrough\" check=\"partial\"/> # \"からシングルクォートに変更する

# vm上でvmxフラグがあるか確認する
grep -E --color=auto \"vmx|svm\" /proc/cpuinfo"'

alias h-qemu-nic='echo "\
qemu-system-x86_64 -net nic,macaddr=52:54:XX:XX:XX:XX -net vde disk_image

# -netdev を使用しない場合、TCPとUDPプロトコルしか喋れないのでICMPは使えない "'

alias h-qemu-virtio='echo "\
qemu-system-x86_64 -boot order=c -drive file=disk_image,if=virtio
qemu-system-x86_64 -net nic,model=virtio"'

