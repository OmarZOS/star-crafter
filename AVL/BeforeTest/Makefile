



objs= main.o filer.o piler.o arbres.o Knot.o
.PHONY:all





all: $(objs)
	g++ $(objs) -o Prog
	@echo "Fertig!!"
debug:
	g++ $(objs) -gstabs -o  dbg
	@ echo "U haven't chosen debugging option yet.."
#this is where u should

$(objs):: %.o:%.cpp
%.cpp:%.h
	g++ -c $@

main.o:: main.cpp
	g++ -c main.cpp

test:
	@./Prog

clr: 
	rm *.o
	rm Prog
	@rm dbg
