#!/bin/bash
nmcli -t -f SSID,SECURITY,BARS dev wifi list | awk -F: '
BEGIN { print "[" }
NR > 1 { printf "," }
{
    ssid = $1
    security = $2
    bars = $3
    printf "{\"SSID\":\"%s\",\"SECURITY\":\"%s\",\"BARS\":\"%s\"}", ssid, security, bars
}
END { print "]" }
'
