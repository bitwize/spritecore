CC = gcc
CFLAGS = -g -I../include
LIBFLAGS = -L/usr/X11R6/lib -L.. -lX11 -lXext -lm -lSpriteCore -lobjc

objects = res_loader_test.o
targets = res_loader_test

all: $(targets)

$(objects): %.o: %.m
	$(CC) -c $(CFLAGS) $< -o $@

$(targets): %: %.o
	$(CC) $< $(LIBFLAGS) -o $@
