#!/bin/sh

# Auto detect interfaces
# ifaces=$(ls /sys/class/net | grep -E '^(eno|enp|ens|enx|eth|wlan|wlp)')

echo '{"version:1"}[[], '; xtitle -s -f '[{"full_text": "%s"}],'


# #!/bin/bash
# while read xtit; do echo $xtit; done < <(xtitle -s)

