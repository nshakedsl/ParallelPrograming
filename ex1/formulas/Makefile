CC = gcc
CFLAG += -msse4.2 -g
AS = as
LFLAGS = -lm
OUT = part2.out

OBJS = main.o forumla1.o formula2.o

$(OUT): $(OBJS)
	$(CC) -o $(OUT) $(OBJS) $(CFLAGS) $(LFLAGS)

# Compile main.c to main.o
main.o: main.c formulas.h
	$(CC) -c main.c $(CFLAGS)

# Assemble formula2.s to formula2.o
formula2.o: formula2.s
	$(AS) -o formula2.o formula2.s

# Compile forumla1.c to forumla1.o
forumla1.o: forumla1.c
	$(CC) -c forumla1.c -o forumla1.o $(CFLAGS) -mavx -mfma

# Clean up
clean:
	rm -f $(OUT) $(OBJS)
