#!/bin/bash

PREFERRED="guard-e-loo-lan"
CURRENT="$(nmcli -t -f NAME connection show --active | head -n1)"

if nmcli -t -f SSID dev wifi list | grep -Fxq "$PREFERRED"; then
    if [ "$CURRENT" != "$PREFERRED" ]; then
        nmcli connection up "$PREFERRED"
    fi
fi
