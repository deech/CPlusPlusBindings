CXX = g++
CC = gcc
CXXFLAGS = -Wall -Werror -g -static -I../cpp-includes
all:
	$(CXX) $(CXXFLAGS) -c A_C.cpp -o A_C.o -lA
	ar rcs libA_C.a A_C.o
clean:
	test -f libA_C.a && rm libA_C.a
	test -f A_C.o && rm A_C.o
