# Define the compiler and the assembler
CC = gcc
AS = as

# Define the output file name
OUT = program

# Define object files
OBJS = main.o hamming.o

# Link object files to create the final executable
$(OUT): $(OBJS)
	$(CC) -o $(OUT) $(OBJS)

# Compile main.c to main.o
main.o: main.c libstr.h
	$(CC) -c main.c

# Assemble hamming.s to hamming.o
hamming.o: hamming.s
	$(AS) -o hamming.o hamming.s

# Clean up
clean:
	rm -f $(OUT) $(OBJS)
