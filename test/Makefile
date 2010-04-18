CC = gcc
CFLAGS = -g -I../include
LIBPATH = -L/usr/X11R7/lib -Wl,-R/usr/X11R7/lib -L.. -Wl,-R..
LIBS = -lX11 -lXext -lm -lSpriteCore -lobjc

objects = res_loader_test.o
targets = res_loader_test

all: $(targets)

$(objects): %.o: %.m
	$(CC) -c $(CFLAGS) $< -o $@

$(targets): %: %.o
	$(CC)  $(LIBPATH) -o $@ $< $(LIBS)

clean:
	-rm -f *.o
	-rm -f $(targets)
