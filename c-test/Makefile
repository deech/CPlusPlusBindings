CXX = g++
CC = gcc
CXXFLAGS = -Wall -Werror -g
CFLAGS = -Wall -Werror -g -I../c-src
CLIBDIR = ../c-src
CPPLIBDIR = ../cpp-src
all:
	cd $(CPPLIBDIR); make all
	cd $(CLIBDIR); make all
	$(CC) $(CFLAGS) -c call_a.c -o call_a.o
	$(CXX) -o call_a call_a.o $(CLIBDIR)/libA_C.a $(CPPLIBDIR)/libA.a
	strip call_a
clean:
	cd $(CPPLIBDIR); make clean
	cd $(CLIBDIR); make clean
	cd c-test
	test call_a && rm -f call_a
	test call_a.o && rm -f call_a.o
