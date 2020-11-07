# Manage Docker as a non-root user
To create the docker group and add your user:
>   FATA[0000] Post http:///var/run/docker.sock/v1.18/containers/create: dial unix /var/run/docker.sock: permission denied. Are you trying to connect to a TLS-enabled daemon without TLS?

1.  Create the docker group.
```
$ sudo groupadd docker
```
2.  Add your user to the docker group.
```
$ sudo usermod -aG docker $USER
```
