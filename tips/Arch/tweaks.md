# battery life
```
# pacman -S tlp
# systemctl enable tlp.service --now
```

# systemd configuration

## taming the journal's *size*
```
# journalctl --vacuum-size=100M
# journalctl --vacuum-time=2weeks
```

## forwarding the journal to /dev/tty12
1.
just create the file `/etc/systemd/journald.conf.d/fw-tty12.conf`

```
[Journal]
ForwardToConsole=yes
TTYPath=/dev/tty12
MaxLevelConsole=info
```

# improving performance on intel + intel graphics (HD 620)
## packages
```
# pacman -S libva-intel-driver vulkan-intel intel-ucode
```

### intel microcode (`intel-ucode`)
sys-boot
`/boot/loader/entries/arch.conf`

```
title ~~~
lin~~ ~~~~
initrd /intel-ucode.img
in~~~ ~~~~~~~
options ~~~~rw
```

### enabling early KMS
`/etc/mkinitcpio.conf`
[archwiki](https://wiki.archlinux.org/title/Kernel_mode_setting#Early_KMS_start)
```
MODULES=(intel_agp i915)
```
then
```
# mkinitcpio -p linux
```
finally. reboot sys
