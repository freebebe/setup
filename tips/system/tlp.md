tlp-code
=========

Check for running tlp : sudo systemctl status tlp
System info : sudo tlp-stat -s
PCI info : sudo tlp-pcilist
USB info :  sudo tlp-usblist
Show config :  : sudo tlp-stat -c
Show everything : sudo tlp-stat 
Show thermal info : sudo tlp-stat -t
Show processor info : sudo tlp-stat -p
Show battery info : sudo tlp-stat -b
Show refreshing battery info : watch sudo tlp-stat -b

handleLidSwitch-setup
==============================>>>>>>don't choose anymroe

HandleLidSwitch=suspend		#stop
HandleLidSwitch=hibernate		#sleep
--------------------------------
```
/etc/default/acpi-support
```

Looked for this line:

~~~
SUSPEND_METHODS="dbus-pm dbus-hal pm-utils"
~~~

Changed it to this:

~~~
SUSPEND_METHODS="pm-utils"
or
SUSPEND_METHODS="dbus-pm pm-utils"

