# 打包压缩备份

在备份软件方面，无须其他特殊软件，只要有 tar、gzip、bzip2 几个常见命令即可。下面依次以直接打包备份、打包压缩备份、打包压缩带进度备份三种方式，由浅入深介绍具体备份操作。

第一步，直接打包备份。为了保持目录结构，通过采用打包命令tar进行备份。比如，将 /data/ 目录备份到名为backup_120g的外置硬盘上，备份文件命名为 data_backup.tar，那么完整命令及参数如下：

`
tar -p -P /data -cf /media/backup_120g/data_backup.tar
`

其中，-p 表示完全保持 /data/ 目录下所有文件的文件属性，-P 表示使用绝对路径（否则 tar 忽略所有路径中的第一个 /，将其转换为相对路径，并给出警告 Removing leading `/’ from member names），-cf 表示需要创建一个备份文件且命名为 backup.tar。

数据备份的时间点往往是我们最为关心的信息，所以习惯上备份文件名应该加上时间戳。linux 的 date 命令能根据不同参数生成指定日期信息，如下命令可在备份文件名中添加备份操作发起的日期：

`
tar -p -P /data -cf /media/backup_120g/data_backup@`date +%m-%d`.tar
`

其中，包裹命令 date 的”`”符号是 tab 键正上方那个键，而非单引号。以指示 shell 优先执行整个命令行中该符号对包裹的命令（即，date +%m-%d）。

如果外置硬盘空间有限，/data/ 中又包含部分不那么重要的数据（如，临时目录 tmp、windows 虚拟机共享目录 share_folder/），那么备份时可以将这些目录排除掉，通过 tar 的 --exclude 参数即可实现：

`
tar -p -P /data --exclude=/data/misc/tmp --exclude=/data/misc/software/vm/win_7/share_folder -cf /media/backup_120g/data_backup@`date +%m-%d`.tar
`

其中，--exclude 参数语法非常特殊（其他命令中的该参数也是如此），注意几点：A）命令中的所有参数必须为绝对路径而非相对路径，且不能用 ~ 等等缩写字符；B）所有路径最后不能以 / 结尾。

第二步，打包压缩备份。如果排除了部分不重要数据后外置硬盘空间仍然紧张，可以考虑对打包文件进行压缩。linux 上常见的压缩命令包括 gzip 和 bzip2 ，由于两者采用的不同压缩算法，导致前者压缩率较低但速度较快，后者压缩率较高但速度慢，但相关用法差不多，请按需择优选用（本例以 gzip 为例，若需 bzip2 则直接替换即可）。打包和压缩是两个独立操作，写两条命令多麻烦啊！不用，借助 linux 强大的管道和重定向机制，可以在一条命令中以非常自然的方式实现：

`
tar -p -P -cf - /data --exclude='/data/misc/tmp' --exclude='/data/misc/software/vm/win_7/share_folder' | gzip > /media/backup_120g/data_backup@`date +%m-%d`.tar.gz
`

别被这些奇怪符号吓着，管道符 | 用于实现“打包一点压缩一点”，重定向符 > 用于实现“压缩一点写一点到备份文件中”，这样，串起来就是“不停打包、不停压缩、不停写文件”的流水作业，理解了吧！其中，上个命令中 -cf 后面跟的是备份文件名，本命令中改为“-”，就在告诉 shell 说，“先别急着写文件，你（shell）把我（tar）刚生成的数据流传递给后面负责压缩的兄弟（gzip），它知道该写哪个文件，谢谢哈～”。说明两点，A）你是否注意到备份文件的扩展名为 .tar.gz，不仅本例，涉及 linux 主题的网站提供的下载几乎都采用这种命名方式，这叫命名约定，通常来说，如果仅打包不压缩则扩展名为 .tar，如果打包且采用 gzip 压缩则扩展名为 .tar.gz，如果打包且采用 bzip2 压缩则扩展名为 .tar.bz 或 .tar.bz2；B）其实 tar 命令使用 --gzip 和 --bzip2 参数可以直接实现打包压缩，无须像上例，采用管道和重定向来实现，但，为精确显示整个备份进度率，必须采用这种变通方式，请接着看。

第三步，打包压缩带进度备份。要显示备份进度，必须得事前知道待备份数据（/data/）的大小，可通过 du 命令实现：

`
du -sb /data --exclude='/data/misc/tmp' --exclude='/data/misc/software/vm/win_7/share_folder'
`

其中，-s 表示计算 /data/ 整个目录包括子目录下所有文件的大小总和，-b 表示计算结果以 byte 为单位（或者 -k、-h 等）显示，单位的精度越高，计算百分比进度时越精确。

待备份目录大小知道了，如何计算进度？上面介绍过，打包、压缩、写文件都在借助管道传递数据流，如果能查看到管道中已经传递的数据量大小，用此大小除以总大小不就能显示出当前备份进度了么？铛铛铛铛哒～，pv 现身，顾名思义 pv 就是 pipe viewer，明白了吧，管道查看器，它是监测管道数据的超级武器，没事多用用、系统更健康。

`
tar -p -cf - /data --exclude='/data/misc/tmp' --exclude='/data/misc/software/vm/win_7/share_folder' | pv --size xxx | gzip > /media/backup_120g/data_backup@`date +%m-%d`.tar.gz
`

其中，xxx 部分填入前面du命令输出结果（待备份目录 /data/ 总大小），不带单位则表示以 byte 为单位（-k 以 kb 为单位、m、g、t 亦然）。效果如下：

（可视化备份进度）

好了，到此包括打包、压缩、排除不重要目录、打时间戳、显示进度等特性在内的 linux 常规备份操作就介绍完了，一条命令啰哩吧嗦说了一大堆，大妈命～～。内容是多了点，一次没看明白就多看几次，其实也不复杂，我们一起看看简化模型吧（啰嗦的平方就是在下，谢谢，：O）。

`
du -sk /source
tar -p -P -cf - /source | pv --size xxxk | gzip > dest.tar.gz
`
# 若仅打包不压缩则将上条命令中的gzip改为cat即可

有备份就有恢复，相对备份操作而言，恢复就太简单了。仍用tar命令，参数不同而言：

`
tar -xv -f dest.tar.gz -C .
`

其中，-x 表示执行解压解包操作，采用哪种解压算法由 tar 自行侦测后决定，-v 表示显示以及解压出的文件列表，-f 表示该参数后面紧跟的就是待解压的文件名，-C 表示该参数后面紧跟是解压后的文件存放路径。
