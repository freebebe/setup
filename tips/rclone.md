#sync && copy
~~~
rclone sync GoogleDrive_****: ~/'user'/
rclone copy ~/'user'/ GoogleDrive_****: 'rmote_file'
~~~

#mount_file
~~~
rclone mount --daemon GoogleDrive_****: /home/***/'mkdir_GoogleDrive_****'
~~~
