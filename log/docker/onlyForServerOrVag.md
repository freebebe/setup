# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
##  this only for server and vagrant or virtualbox
##  Do not use to your system(personal notetop)
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
```
sudo chmod 666 /var/run/docker.sock
```
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

### do not use your any personal system about application about  'chmod 666'
### this's really important

# PlanA 
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

## planB
This hard chmod open security hole and after each reboot, this error start again and again and you have to re-execute the above command each time. I want a solution once and for all. For that you have two problems :

    1) Problem with SystemD : The socket will be create only with owner 'root' and group 'root'.

    You can check this first problem with this command :

    `
    ls -l /lib/systemd/system/docker.socket
    `

    If every this is good, you should see 'root/docker' not 'root/root'.

    2 ) Problem with graphical Login : https://superuser.com/questions/1348196/why-my-linux-account-only-belongs-to-one-group

    You can check this second problem with this command :

    `
    groups
    `

    If everything is correct you should see the docker group in the list. If not try the command

    `
    sudo su $USER  -c groups
    `

    if you see then the docker group it is because of the bug.

