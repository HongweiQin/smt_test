#!/bin/bash

echo "turn off smt"
sudo sh -c 'echo off > /sys/devices/system/cpu/smt/control'
