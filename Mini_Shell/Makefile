SRCS = $(wildcard *.c)

PROGS = $(patsubst %.c,%,$(SRCS))



all: $(PROGS)

%: %.c
	$(CC) $(CFLAGS)     $<    -o $@ 

test: myshell
	./myshell
clean:  
	find . -type f | xargs touch
	rm -rf $(OBJS)
