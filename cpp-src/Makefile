CXX = g++
CXXFLAGS = -Wall -Werror -g -I../cpp-includes -static
all:
	@echo "***Compiling C++***"
	$(CXX) $(CXXFLAGS) -c A.cpp -o A.o
	ar rcs libA.a A.o
clean:
	test -f libA.a && rm -f libA.a
	test -f A.o && rm -f A.o
