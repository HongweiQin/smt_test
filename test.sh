#!/bin/bash

fibonacci=20000000000
sudo printf ""

./turnoff_smt.sh
time ./smt_test -f $fibonacci -g 4096 -t 6

./turnon_smt.sh
time taskset -c 0-2,6-8 ./smt_test -f $fibonacci -g 4096 -t 6

./turnoff_smt.sh
time taskset -c 0-2,6-8 ./smt_test -f $fibonacci -g 4096 -t 6

./turnon_smt.sh
