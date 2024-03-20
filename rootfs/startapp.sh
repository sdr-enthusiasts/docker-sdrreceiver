#!/bin/bash

export HOME=/config

exec /opt/SDRReceiver/bin/SDRReceiver -s /"${CONFIG_FILE}"

sleep 10

