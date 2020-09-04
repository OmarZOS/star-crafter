

Objs=Knot.o filer.o piler.o main.o 



all: $(Objs) 
	g++ $(Objs) -o hi
.PHONY:all

$(Objs)::%.o:%.cpp
%.cpp: %.h
	g++ -c $@



main.o:: main.cpp
	g++ -c main.cpp

test:
	@./hi

clr: 
	rm *.o
	rm hi
