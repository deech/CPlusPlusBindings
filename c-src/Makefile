CXX = g++
CC = gcc
CXXFLAGS = -Wall -Werror -g -static -I../cpp-includes
all:
	$(CXX) $(CXXFLAGS) -c A_C.cpp -o A_C.o -lA
	ar rcs libA_C.a A_C.o
clean:
	test libA_C.a && rm -f libA_C.a
	test A_C.o && rm -f A_C.o
