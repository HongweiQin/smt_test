# SMT Tester

This program allows you to test smt acceleration of your system by using multiple threads calculating the fibonacci.

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

```bash
time ./smt_test -f 20000000000 -g 4096
```

