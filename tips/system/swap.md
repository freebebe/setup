##############################
# add swap file
##############################
`# dd if=/dev/zero of=/mnt/swap bs=1M count=2048`
                                        size

格式化转换为swap
`# mkswap /mnt/swap`

挂载swap
`# swapon /mnt/swap                         #将swap分区文件`

写入fstab 每次系统启动时挂起
~~~
# /etc/fstab: static file system information.
#
# Use 'blkid' to print the universally unique identifier for a
# device; this may be used with UUID= as a more robust way to name devices
# that works even if disks are added and removed. See fstab(5).
#
# <file system> <mount point>   <type>  <options>       <dump>  <pass>
/dev/mapper/vgubuntu-root /               ext4    errors=remount-ro 0       1
# /boot/efi was on /dev/sda1 during installation
UUID=724B-246D  /boot/efi       vfat    umask=0077      0       1
/dev/mapper/vgubuntu-swap_1 none            swap    sw              0       0
/mnt/swap			swap	swap		defaults    0	    0	
~~~

#____________________________/LVM
```
# create the logical volume
$ sudo lvcreate -L 8G -n swap local-lvm
# format the volume as swap
$ sudo mkswap /dev/local-lvm/swap
# add a line to fstab to mount at boot
$ echo '/dev/local-lvm/swap swap swap defaults 0 0' | sudo tee -a /etc/fstab
# turn on swap right now
$ sudo swapon -v /dev/local-lvm/swap`
```
