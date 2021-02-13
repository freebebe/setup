####################
# in ext4
###################
~~~
$ swapon --show
$ ls -l /swapfile
$ swapon --show
$ sudo swapoff /swapfile
$ swapon --show
$ free -h
$ sudo fallocate -l *G /swapfile
$ ls -l /swapfile
$ ls -lh /swapfile
$ sudo mkswap /swapfile
$ sudo swapon /swapfile
$ swapon --show
~~~
## change your system using swap rule
~~~
$ cat /proc/sys/vm/swappiness
60
$ sudo sysctl vm.swappiness=10
$ cat /proc/sys/vm/swappiness
10
$ sudo echo vm.swappiness=10 /etc/sysctl.conf
~~~
> [Demo](https://www.youtube.com/watch?v=Tteiw6MY4QI)

##################################
# in LVM
# RESCAN FOR NEWLY ADDED HDS
##################################
echo "- - -" > /sys/class/scsi_host/host#/scan
fdisk -l

# NEW LOGICAL VOLUME
sudo fdisk /dev/sdb
# then create a new partition of type 8e (Linux LVM)
# create a phisical volume
sudo pvcreate /dev/sdb1
# create new volume group
sudo vgcreate vgpool /dev/sdb1
# create logical volume
sudo lvcreate -L 3G -n lvstuff vgpool
# format new volume
sudo mkfs -t ext3 /dev/vgpool/lvstuff
# ENJOY

# RESIZE A SWAP PARTITION
# Create a physical volume on new disk
sudo pvcreate /dev/sdb
# Show volume groups
sudo vgdisplay
# Extend volume groups
sudo vgextend vg-name /dev/sdb
# Resize swap partition
sudo lvresize -L 2G /dev/mapper/xxxx-swap_1
# Turn off swap
sudo swapoff -a
# Re-make swap
sudo mkswap /dev/mapper/xxxx-swap_1
# Turn on swap again
sudo swapon -a

# BONUS
# re-size a non swap partition
sudo resize2fs /dev/mapper/xxx-noswap

> [DEMO](https://www.rootusers.com/how-to-increase-the-size-of-a-linux-lvm-by-expanding-the-virtual-machine-disk/)

###############################
# 3 
###############################
~~~
$ sudo swapoff -v /dev/mapper/vgubuntu-swap_1
swapoff /dev/mapper/vgubuntu-swap_1
~~~
~~~
$ sudo lvresize /dev/mapper/vgubuntu-swap_1 -L +*G
-   Size of logical volume **** changd from *.00GiB*******
-   Extending logical volume *** to **GiB
~~~ 
~~~
$ sudo mkswap /dev/mapper/vgubuntu-swap_1
~~~
~~
$ sudo swapon -v /dev/mapper/vgubuntu-swap_1
~~
# other g
[demo](https://serverfault.com/questions/900934/what-prevents-me-from-extending-an-lvm-logical-volume)
