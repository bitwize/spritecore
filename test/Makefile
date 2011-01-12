CC = gcc
CFLAGS = -g -I../include -I.
LIBPATH = -L/usr/X11R7/lib -Wl,-R/usr/X11R7/lib -L.. -Wl,-R..
LIBS = -lX11 -lXext -lm -lSpriteCore -lobjc

res_loader_test_objects = res_loader_test.o
tests_objects = tests.o
targets = tests res_loader_test

all: $(targets)

.SUFFIXES: .m
.m.o:
	$(CC) -c $(CFLAGS) $< -o $@

res_loader_test: $(res_loader_test_objects)
	$(CC)  $(LIBPATH) -o $@ $< $(LIBS)

tests: $(tests_objects)
	$(CC)  $(LIBPATH) -o tests $(tests_objects) $(LIBS)

clean:
	-rm -f *.o
	-rm -f $(targets)
