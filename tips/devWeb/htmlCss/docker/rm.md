# 删除相关联
`$ sudo docker rm -v [server_name]`

# 删除全部容器
```
$ sudo docker rm $(docker ps -aq)
            # or
$ sudo docker rm $(docker ps -a -q)
```

# 删除所有镜像(image)
`$ docker rmi $(docker images -q)`
