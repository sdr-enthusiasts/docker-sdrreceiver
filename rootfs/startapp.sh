#!/bin/bash

export HOME=/config

/opt/SDRReceiver/bin/SDRReceiver -s /${CONFIG_FILE} | stdbuf -o0 awk '{print "[SDRReceiver] " strftime("%Y/%m/%d %H:%M:%S", systime()) " " $0}'

sleep 10

