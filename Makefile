CFLAGS= -f elf64

all: hello

hello: hello.o
	ld -z noseparate-code hello.o -o hello

hello.o: hello.asm
	nasm $(CFLAGS) hello.asm

clean:
	rm -f hello.o hello
        
.INTERMEDIATE: hello.o
