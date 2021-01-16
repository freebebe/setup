>  root 默认密码，通常为 vagrant
4. 常用命令
``
# 添加 box
$ vagrant box add new-box-name box文件地址（本地、远程）

# 删除 box
$ vagrant box remove box-name

# 以指定的 box 初始化
$ vagrant init new-box-name

# 启动
$ vagrant up

# 关闭
$ vagrant halt

# 重启，重新加载配置文件
$ vagrant reload

# 挂起
$ vagrant suspend

# 创建快照（vm 名称使用 vagrant status 查看）
$ vagrant snapshot save [vm名称] [快照名称]

# 查看快照列表
$ vagrant snapshot list

# 还原到指定快照
$ vagrant snapshot restore [vm名称] [快照名称]

# 删除快照
$ vagrant snapshot delete [快照名称]

# 关闭、删除 Vagrant 创建的虚拟机资源
$ vagrant destroy
    default: Are you sure you want to destroy the 'default' VM? [y/N] y
==> default: Forcing shutdown of VM...
==> default: Destroying VM and associated drives...

# 打包
$ vagrant package --output 自定义的包名.box

# 更多详细说明
$ vagrant -h
$ vagrant 命令名 -h
``
5.2. 关闭静态文件缓存
`
使用 Apache/Nginx 时会出现诸如图片修改后但页面刷新仍然是旧文件的情况，是由于静态文件缓存造成的。需要对虚拟机里的 Apache/Nginx 配置文件进行修改：

# Apache 配置（httpd.conf 或者 apache.conf）添加：
EnableSendfile off

# Nginx 配置（nginx.conf）添加：
sendfile off;
`
5.1. Vagrantfile 常用配置

~~~
# 虚拟机中 linux 的 hostname
config.vm.hostname = "vm-ubuntu1604-localhost"

# 虚拟机名称，在类似创建备份等操作中会用到
config.vm.define "vm-ubuntu1604"

# 网络设置1 - 公有（public_network）网络（允许局域网中其他机器访问）
config.vm.network "public_network", ip: "192.168.1.223"

# 网络设置2 - 私有（private_network）网络（只允许主机访问虚拟机）
# 此时我们可以使用指定的 IP 加 端口号进行访问，比如使用 192.168.127.11:81 即可访问虚拟机里的 81 端口
config.vm.network "private_network", ip: "192.168.127.11"

# 网络设置3 - 将端口映射到宿主机
# 在宿主机使用 127.0.0.1:8080 即可访问虚拟机里的 80 端口
config.vm.network "forwarded_port", guest: 80, host: 8080

# 共享目录
# 注意：这里的 owner 和 group，与你搭建的 LAMP 环境运行用户一致（在 phpinfo() 页面中搜索 “user”）
config.vm.synced_folder "/Users/用户名/www", "/var/www/html", create:true, owner:"www-data", group:"www-data"

# VirtualBox 虚拟机配置（内存、CPU、显示名称等）
config.vm.provider "virtualbox" do |vb|
#   # Display the VirtualBox GUI when booting the machine
#   vb.gui = true
#
#   # Customize the amount of memory on the VM:
vb.memory = "512"
vb.name = "ubuntu1604"
end
~~~
