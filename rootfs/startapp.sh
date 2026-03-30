#!/bin/bash

export HOME=/config

#shellcheck disable=SC2093
exec /opt/SDRReceiver/bin/SDRReceiver -s /"${CONFIG_FILE}"

sleep 10
