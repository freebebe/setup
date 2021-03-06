# nmcli examples

-   List nearby wifi networks:

    `
    $ nmcli device wifi list
    `

-   Connect to a wifi network:

    `
    $ nmcli device wifi connect SSID_or_BSSID password password
    `

-   Connect to a hidden network:

    `
    $ nmcli device wifi connect SSID_or_BSSID password password hidden yes
    `

-   Connect to a wifi on the wlan1 wifi interface:

    `
    $ nmcli device wifi connect SSID_or_BSSID password password ifname wlan1 profile_name
    `

-   Disconnect an interface:

    `
    $ nmcli device disconnect ifname eth0
    `

-   Reconnect an interface marked as disconnected:

    `
    $ nmcli connection up uuid UUID
    `

-   Get a list of UUIDs:

    `
    $ nmcli connection show
    `

-   See a list of network devices and their state:

    `
    $ nmcli device
    `

-   Turn off wifi:

    `
    $ nmcli radio wifi off
    `

