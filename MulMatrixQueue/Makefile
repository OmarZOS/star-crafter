

dir= main.o Header.o
.PHONY: all


all: $(dir)
	@ g++ $(dir) -o hello  -pthread
main.o: main.cpp
	g++ -c main.cpp
Header.o: Header.cpp Header.h
	g++ -c Header.cpp 





test:
	@ ./hello
clr:
	rm *.o
	rm hello

