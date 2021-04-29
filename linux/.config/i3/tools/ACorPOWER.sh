#!/bin/bash
if on_ac_power; then
    rfkill unblock bluetooth && rfkill block wifi;
else
    rfkill block bluetooth && rfkill block wifi;
fi
