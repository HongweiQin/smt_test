# SMT Tester

This program allows you to test the Simultaneous multithreading (SMT) acceleration of your CPU by using multiple threads calculating the fibonacci.

## Compile

`Make`

## Run

```bash
$ ./smt_test -h
Usage: ./smt_test [-t number_of_threads] [-f fibonacci_max] [-b should_set_cpu_affinity] [-i should_inline] [-g alloc_granularity]
```

* **number\_of\_threads**: How many working threads. (Default: 12)

* **fibonacci\_max**: Which element of the fibonacci to calculate. This impacts the total amount of work of each working thread. (long int, Default: 100)

* **should\_set\_cpu\_affinity**: If set as 1, smt\_test will bind each thread to the CPU [thread\_id % online\_CPUs]. (Default: 0)

* **should\_inline**: Whether the calculation function should inline. (Default: 1)

* **alloc\_granularity**: The main function of smt\_test allocates a struct thread\_info tinfo[] array and passes each element of that array to a working thread. The working thread uses the tinfo[i] to calculate fibonacci. This parameter sets the minimal allocation granularity of tinfo[i]. This may affect cache behaviors and thus impact the total running time. (Default: 0)

### Example

Turn off SMT (DISCLAIMER: Check the script before using it. Use with Caution!)

```bash
./turnoff_smt.sh
```

Turn on SMT (DISCLAIMER: Check the script before using it. Use with Caution!)

```bash
./turnon_smt.sh
```

Test workload running time

```bash
time ./smt_test -f 20000000000 -g 4096
```

## Quick Check Results

A quick test on my laptop with an Intel's core i7 CPU (6 Cores, 12 Threads when SMT enabled).

```
$ lscpu
Architecture:                    x86_64
CPU(s):                          12
On-line CPU(s) list:             0-11
Thread(s) per core:              2
Core(s) per socket:              6
Socket(s):                       1
NUMA node(s):                    1
Vendor ID:                       GenuineIntel
Model name:                      Intel(R) Core(TM) i7-9750H CPU @ 2.60GHz
L1d cache:                       192 KiB
L1i cache:                       192 KiB
L2 cache:                        1.5 MiB
L3 cache:                        12 MiB
```

The SMT acceleration is about 52.6% ( = (58.843-38.562)/38.562).

```
qhw@qhw-laptop:~/develop/smt_test$ cat test.sh
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
qhw@qhw-laptop:~/develop/smt_test$ ./test.sh 
turn off smt
threads_num=6, fibonacci_max=20000000000, should_set_affinity=0, should_inline=1, alloc_granularity=4096

real	0m38.562s
user	3m50.786s
sys	0m0.000s
turn on smt
threads_num=6, fibonacci_max=20000000000, should_set_affinity=0, should_inline=1, alloc_granularity=4096

real	0m58.843s
user	5m53.018s
sys	0m0.005s
turn off smt
threads_num=6, fibonacci_max=20000000000, should_set_affinity=0, should_inline=1, alloc_granularity=4096

real	1m13.175s
user	3m39.486s
sys	0m0.008s
turn on smt
```