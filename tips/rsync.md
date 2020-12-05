Linux/Unix系统中，同本地操作一样能够进行远程拷贝，同步文件和文件夹的场景中，用得最多的命令就是Rsync(Remote Sync)。 使用rsync命令，可以用来在本地，远程机器之间拷贝同步文件，文件夹；能够跨文件夹，跨硬盘和网络；进行数据备份；制作机器镜像。

该文章包含了简单和高级的10个例子，解释了使用rsync命令将文件在本地和远程的linux机器之间传递。 运行rsync命令并不需要root用户的权限。
使用Rsync命令的优点

    高效的在远程系统中拷贝和同步文件
    支持拷贝链接，设备，所有者，用户组和权限
    比scp（Secure Copy）指令要快，因为rsync命令使用远程更新协议，允许只传递两个文件集不同的部分 第一次传递，将全量的文件或者文件夹从源拷贝到目标。从下一次开始，只拷贝改变的块或者字节到目标
    占用更少的带宽。当两端传递或者接受文件时，会使用压缩和解压的方法对文件进行处理

rsync命令的基本语法

    -v: 打印命令执行过程中的详细信息
    -r: 递归拷贝数据（在传递文件的过程中不会保留权限信息以及时间戳）
    -a: 归档模式，可以允许递归拷贝数据，并且保留链接符号，文件权限，用户和用户组的归属，时间戳
    -z: 压缩数据
    -h: 可读模式，输出可读的数字格式

在Linux系统中安装rsync

可以通过如下命令安装rsync包

# yum install rsync (Red Hat系统)
# agt-get install rsync (Debian 系统)

1. 在本地系统中拷贝/同步文件
在本地拷贝/同步一个文件

下述命令在本地的机器上将一个文件从一个目录同步到另一个目录中。 下面是例子，一个名称为backup.tar的文件需要拷贝到/tmp/backups/目录下。

[root@ilife5]# rsync -zvh backup.tar /tmp/backups/

created directory /tmp/backups

backup.tar

sent 14.71M bytes  received 31 bytes  3.27M bytes/sec

total size is 16.18M  speedup is 1.10

上述例子中，你可以看到在同步时，目标文件夹并不存在，rsync命令会自动根据目标文件夹新建目录。
在本地拷贝/同步文件夹

下述命令将一个文件夹下的所有文件从一个文件夹同步或传递到本地机器上的另一个文件夹下。 下面的例子中，/root/rmppkgs包含一些rpm包文件，我们会把这些文件拷贝到/tmp/backups/目录下。

[root@ilife5]# rsyc -avzh /root/rpmpkgs /tmp/backups/

sending incremental file list

rpmpkgs/

rpmpkgs/httpd-2.2.3-82.el5.centos.i386.rpm

rpmpkgs/mod_ssl-2.2.3-82.el5.centos.i386.rpm

rpmpkgs/nagios-3.5.0.tar.gz

rpmpkgs/nagios-plugins-1.4.16.tar.gz

sent 4.99M bytes  received 92 bytes  3.33M bytes/sec

total size is 4.99M  speedup is 1.00

2. 和远程服务拷贝/同步文件
从本地拷贝一个文件夹到远程服务器

该命令将从本地向服务器同步一个文件夹。例如：在本地机器上又一个目录名为rpmpkgs，包含了一些RPM包文件。 我们想要把这些本地的内容同步到远程的服务器上。 可以用到如下的命令。

[root@ilife5]# rsync -avz rpmpkgs/ root@192.168.0.101:/home/

root@192.168.0.101`s password:

sending incremental file list

./

httpd-2.2.3-82.el5.centos.i386.rpm

mod_ssl-2.2.3-82.el5.centos.i386.rpm

nagios-3.5.0.tar.gz

nagios-plugins-1.4.16.tar.gz

sent 4993369 bytes  received 91 bytes  399476.80 bytes/sec

total size is 4991313  speedup is 1.00

译者注：建议先配置免密码登陆，就可以省掉输入密码的一步了。 另外需要注意的是，如果远程服务器上的目标目录不存在，但是上层目录存在，可以自动创建。 但是多级目录不存在，通过rsync命令是没有办法新建的。需要手动创建。
拷贝/同步一个远端服务器的文件夹到本地

如下命令可以同步一个远程服务器上的文件夹到本地服务器。 在远端服务器上you一个名字为/home/tarunika/rpmpkgs文件夹，如下例子将把它同步到本地机器的/tmp/myrpms目��下。

[root@ilife5]# rsync -avzh root@192.168.0.100:/home/tarunika/rpmpkgs /tmp/myrpms

root@192.168.0.100's password:

receiving incremental file list

created directory /tmp/myrpms

rpmpkgs/

rpmpkgs/httpd-2.2.3-82.el5.centos.i386.rpm

rpmpkgs/mod_ssl-2.2.3-82.el5.centos.i386.rpm

rpmpkgs/nagios-3.5.0.tar.gz

rpmpkgs/nagios-plugins-1.4.16.tar.gz

sent 91 bytes  received 4.99M bytes  322.16K bytes/sec

total size is 4.99M  speedup is 1.00

3. 通过ssh使用rsync

在使用rsync时，数据传递部分可以使用SSH（Secure Shell）协议。 使用SSH协议可以确保传递的数据使用加密的安全链接。 这样通过网络做数据传递时，就没有人可以读取数据了。

所以，当使用rsync并使用rsync时需要提供用户名以及密码。 使用SSH配置后，可以保证传递的用户密码为编码过的安全模式。
通过SSH协议将一个文件从远程服务器拷贝到本地服务器

使用rsync时，可以通过"-e"的配置项来指定协议。 下面的例子中，我们将在"-e"配置项中使用"ssh"参数来传递数据。

[root@ilife5]# rsync -avzhe ssh root@192.168.0.100:/root/install.log /tmp/

root@192.168.0.100's password:

receiving incremental file list

install.log

sent 30 bytes  received 8.12K bytes  1.48K bytes/sec

total size is 30.74K  speedup is 3.77

将本地文件通过ssh协议同步到远程服务器

[root@ilife5]# rsync -avzhe ssh backup.tar root@192.168.0.100:/backups/

root@192.168.0.100's password:

sending incremental file list

backup.tar

sent 14.71M bytes  received 31 bytes  1.28M bytes/sec

total size is 16.18M  speedup is 1.10

4. 在传递数据过程中显示进度

我们可以通过参数"-progress"在从一台机器到另一台机器的数据传递过程中显示进度。 显示内容为传递过程的文件和剩余时间。

[root@ilife5]# rsync -avzhe ssh --progress /home/rpmpkgs root@192.168.0.100:/root/rpmpkgs

root@192.168.0.100's password:

sending incremental file list

created directory /root/rpmpkgs

rpmpkgs/

rpmpkgs/httpd-2.2.3-82.el5.centos.i386.rpm

           1.02M 100%        2.72MB/s        0:00:00 (xfer#1, to-check=3/5)

rpmpkgs/mod_ssl-2.2.3-82.el5.centos.i386.rpm

          99.04K 100%  241.19kB/s        0:00:00 (xfer#2, to-check=2/5)

rpmpkgs/nagios-3.5.0.tar.gz

           1.79M 100%        1.56MB/s        0:00:01 (xfer#3, to-check=1/5)

rpmpkgs/nagios-plugins-1.4.16.tar.gz

           2.09M 100%        1.47MB/s        0:00:01 (xfer#4, to-check=0/5)

sent 4.99M bytes  received 92 bytes  475.56K bytes/sec

total size is 4.99M  speedup is 1.00

5. 使用 -include 和 -exclude 配置项

通过这两个配置相以及对应的参数，可以指定或者排除同步时需要发送的文件或者文件夹。

下面的例子中，rsync命令会包含用'R'打头的文件或者文件夹，排除其余的文件或者文件夹。

[root@ilife5]# rsync -avze ssh --include '*/' --include 'R*' --exclude '*' root@192.168.0.101:/var/lib/rpm/ /root/rpm

root@192.168.0.101's password:

receiving incremental file list

created directory /root/rpm

./

Requirename

Requireversion

sent 67 bytes  received 167289 bytes  7438.04 bytes/sec

total size is 434176  speedup is 2.59

ref: Using Rsync include and exclude options to include directory and file by pattern
6.使用 -delete 配置项

如果一个文件或者文件夹不存在，但是在目标文件夹中存在，你可能想要在同步之后删掉这些文件和文件夹。

可以使用'-delete'选项来删除这些不存在源文件中的文件。

下面的例子中，源文件和目标文件现在是同步的，可以在目标文件夹中新建一个文件text.txt作为测试使用。

[root@ilife5]# touch test.txt
[root@ilife5]# rsync -avz --delete root@192.168.0.100:/var/lib/rpm/ .
Password:
receiving file list ... done
deleting test.txt
./
sent 26 bytes  received 390 bytes  48.94 bytes/sec
total size is 45305958  speedup is 108908.55

目标文件夹中存在一个新文件test.txt，当同步时使用了'-delete'选项，会将test.txt文件删除。
7. 设置文件传送的最大尺寸

可以指定被传送和同步的最大文件尺寸。 可以通过设置'--max-size'配置项。 在这个例子中，设置最大的文件尺寸为200k，所以这个rsync命令只会同步尺寸小于或者等于200k的文件。

[root@ilife5]# rsync -avzhe ssh --max-size='200k' /var/lib/rpm/ root@192.168.0.100:/root/tmprpm

root@192.168.0.100's password:

sending incremental file list

created directory /root/tmprpm

./

Conflictname

Group

Installtid

Name

Provideversion

Pubkeys

Requireversion

Sha1header

Sigmd5

Triggername

__db.001

sent 189.79K bytes  received 224 bytes  13.10K bytes/sec

total size is 38.08M  speedup is 200.43

8. 当成功传输完毕后自动删除源文件

假设，现在又一个主网络服务器，一个数据备份服务器。 我们每天创建一个数据备份并同步到备份服务器上。 不想将备份文件保留在主服务器上。

所以，你会乐意每次手动的将主服务器上的备份文件删除吗？ 当然不乐意。。。下面的例子中使用'--remove-source-files'配置项实现自动删除。

[root@ilife5]# rsync --remove-source-files -zvh backup.tar /tmp/backups/

backup.tar

sent 14.71M bytes  received 31 bytes  4.20M bytes/sec

total size is 16.18M  speedup is 1.10

[root@ilife5]# ll backup.tar

ls: backup.tar: No such file or directory

译者注：该命令只会删除文件，而不会删除文件夹!
9. 预览rsync执行的结果

如果你作为一个新人并不能清晰的知道你的指令产生的后果。 Rsync会将目标文件夹搞乱，回滚是一个很烦躁的过程。

用'--dry-run'这个配置项只会演示操作的结果而不会产生真实的效果。 如果演示的结果是你想要的，你可以将'--dry-run'配置项移除并重新执行指令即可。

root@ilife5]# rsync --dry-run --remove-source-files -zvh backup.tar /tmp/backups/

backup.tar

sent 35 bytes  received 15 bytes  100.00 bytes/sec

total size is 16.18M  speedup is 323584.00 (DRY RUN)

10. 设置带宽以及传送的文件

当数据从一台机器传送到另一台机器的情况下，你可以通过'--bwlimit'配置项，设置带宽限制。 这个配置项能够限制I/O的带宽。

[root@ilife5]# rsync --bwlimit=100 -avzhe ssh  /var/lib/rpm/  root@192.168.0.100:/root/tmprpm/
root@192.168.0.100's password:
sending incremental file list
sent 324 bytes  received 12 bytes  61.09 bytes/sec
total size is 38.08M  speedup is 113347.05

同样的，默认情况下，rsync命令只会同步变化的数据块和字节，如果你明确的想要同步整个文件，你可以使用'-W'配置项。

[root@ilife5]# rsync -zvhW backup.tar /tmp/backups/backup.tar
backup.tar
sent 14.71M bytes  received 31 bytes  3.27M bytes/sec
total size is 16.18M  speedup is 1.10

以上就是本篇文章关于rsync的全部内容，你可以通过查看文档来获取更多的配置项。�
