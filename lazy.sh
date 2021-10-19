#!/bin/bash

FM=4000000000

sudo printf ""
./turnon_smt.sh
ncpu=`grep -c ^processor /proc/cpuinfo`
echo "Number of test threads = "$ncpu

for smt in on off
do
for alloc_gran in 0 64 4096
do
for bnd in 0 1
do
for inl in 0 1
do
	echo "------smt="$smt" alloc_granularity="${alloc_gran}" bind="$bnd" inline="$inl"------"
	./turn${smt}_smt.sh
	time ./smt_test -t $ncpu -f $FM -b $bnd -i $inline -g ${alloc_gran}
done
done
done
done

./turnon_smt.sh
