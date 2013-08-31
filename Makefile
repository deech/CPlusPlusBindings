DIRS = cpp-src c-src c-test
all:
	cd cpp-src; make all
	cd c-src; make all
	cd c-test; make all
clean:
	cd cpp-src; make clean
	cd c-src; make clean
	cd c-test; make clean
