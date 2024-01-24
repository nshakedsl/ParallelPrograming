# Define the compiler and the assembler
CC = gcc
CFLAG += -msse4.2
AS = as

# Define the output file name
OUT = program

# Define object files
OBJS = main.o hamming.o b64.o

# Link object files to create the final executable
$(OUT): $(OBJS)
	$(CC) -o $(OUT) $(OBJS) $(CFLAG)

# Compile main.c to main.o
main.o: main.c libstr.h
	$(CC) -c main.c $(CFLAG)

# Assemble hamming.s to hamming.o
hamming.o: hamming.s
	$(AS) -o hamming.o hamming.s
# compile b64.c to b64.o
b64.o: b64.o
	$(CC) -c b64.c -o b64.o
# Clean up
clean:
	rm -f $(OUT) $(OBJS)
