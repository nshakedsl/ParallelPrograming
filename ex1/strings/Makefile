# Define the compiler and the assembler
CC = gcc
CFLAG += -msse4.2
AS = as
GFLAG += -g
# Define the output file name
OUT = program

# Define object files
OBJS = main.o hamming.o b64.o

# Link object files to create the final executable
$(OUT): $(OBJS)
	$(CC) -o $(OUT) $(OBJS) $(CFLAG) $(GFLAG)

# Compile main.c to main.o
main.o: main.c libstr.h
	$(CC) -c main.c $(CFLAG) $(GFLAG)

# Assemble hamming.s to hamming.o
hamming.o: hamming.s
	$(AS) -o hamming.o hamming.s $(GFLAG)
# compile b64.c to b64.o
b64.o: b64.o
	$(CC) -c b64.c -o b64.o $(GFLAG) -msse4.1
# Clean up
clean:
	rm -f $(OUT) $(OBJS)