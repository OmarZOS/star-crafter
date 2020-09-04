

VV=~/Proj/Poo/
DIE=OBJ_files
OBJS=Header.o main.o Matrix.o




all: $(OBJS) 
	g++ $(OBJS) -o exe
.PHONY: all



$(OBJS)::%.o: %.cpp
%.cpp: %.h
	g++ -c $@

main.o:: main.cpp
	g++ -c main.cpp
test:
	@./exe
org: $(DIE)
	mv *.o $(DIE)
clr:
	rm -rf $(DIE)
	rm tst
	rm *.o
OBJ_files:
	mkdir $(DIE)
hey:
	cd -
	cd $(VV)
	ls
	
