# 刪除所有容器 Delete all containers

`$ docker rm $(docker ps -a -q) 
# 或
$ docker rm $(docker ps -aq)`

# 刪除所有映像檔 Delete all images

`$ docker rmi $(docker images -q)`

# 刪除執行中的 container

首先取得執行 container 的 container ID，最後拿此 ID 刪除。

`# Get container ID
$ docker ps# 使用CONTAINER ID刪除container
$ docker container kill [CONTAINER-ID]`
