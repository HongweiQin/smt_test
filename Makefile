smt_test:src/smt_test.c
	gcc -o smt_test src/smt_test.c -lpthread
clean:
	rm -f smt_test
