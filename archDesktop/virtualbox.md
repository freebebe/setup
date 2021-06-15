# third -> USB
`sudo usermod -aG vboxusers {userName}`

# if update kernel or linux version (you need to do this)
`pacman -S vboxpci`

# network-setting: bridged && host-only networking
pacman -S vboxnetadp vboxnetflt
