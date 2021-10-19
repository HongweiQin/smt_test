#!/bin/bash

echo "turn on smt"
sudo sh -c 'echo on > /sys/devices/system/cpu/smt/control'
