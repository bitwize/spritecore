CC = gcc
CFLAGS = -g -I../../include
LIBPATH = -L/usr/X11R7/lib -Wl,-R/usr/X11R7/lib -L../.. -Wl,-R../..
LIBS = -lX11 -lXext -lm -lSpriteCore -lobjc

objcobjects = ComplexScrollApp.o main.o ScrollLayerAgent.o
targets = complex_scrolling

all: $(targets)

$(objcobjects): %.o: %.m
	$(CC) -c $(CFLAGS) $< -o $@


$(targets): $(objcobjects)
	$(CC)  $(LIBPATH) -o $@ $(objcobjects) $(LIBS)

clean:
	-rm -f *.o
	-rm -f $(targets)
