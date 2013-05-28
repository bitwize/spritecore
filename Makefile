include ./config.mak
include ./rend-$(RENDERER).mak


SOURCES=SCObject.m SpriteApp.m SCNode.m Sprite.m DefaultAgents.m SpriteResLoader.m SpriteCollisionList.m TestIODelegate.m SCUnitTest.m XKCDRandomSource.m DevUrandomSource.m StdlibRandomSource.m $(IODEL_CLASS).m spriteimage.c svec.c svppm.c matfunc.c StderrLogger.c
OBJECTS=SCObject.o SpriteApp.o SCNode.o Sprite.o DefaultAgents.o SpriteResLoader.o SpriteCollisionList.o TestIODelegate.o SCUnitTest.o XKCDRandomSource.o DevUrandomSource.o StdlibRandomSource.o $(IODEL_CLASS).o spriteimage.o svec.o svppm.o matfunc.o StderrLogger.o
TOOLDIR=.

.SUFFIXES: .m

default: $(PLATFORM)

.c.o:
	$(CC) -c $(CPPFLAGS) $(CFLAGS) -I./include $(ALLINCLUDES) $< -o $@

.m.o:
	$(OBJCC) -c $(CPPFLAGS) $(OBJCFLAGS) -I./include $(ALLINCLUDES) $< -o $@

blitter.psc: blitter.scm
	sh ./compile-blitter.sh

$(LIBBASENAME).a: $(OBJECTS)
	-rm $(LIBBASENAME).a
	$(AR) ruv $(LIBBASENAME).a $(OBJECTS)
	$(RANLIB) $(LIBBASENAME).a

clean:
	-rm -f *.o
	-rm -f *~
	-rm -f lib*.a
	-rm -f lib*.so*
	-rm -f lib*.dylib

.PHONY: install
install: default
	-$(INSTALL) -d $(DESTINCDIR)/SpriteCore/
	-$(INSTALL) -d $(DESTLIBDIR)
	-$(INSTALL) -m 0644 *.h $(DESTINCDIR)/SpriteCore/
	-$(INSTALL) -m 0644 libSpriteCore.a $(DESTLIBDIR)
	-$(INSTALL) -m 0755 lib*.so* $(DESTLIBDIR)
	-$(INSTALL) -m 0755 lib*.dylib $(DESTLIBDIR)

unix-static: $(LIBBASENAME).a
darwin: unix-static
	sh $(TOOLDIR)/mklib.darwin $(LIBBASENAME).dylib $(OBJECTS) $(ALLLIBS) -lobjc

linux: unix-static
	$(TOOLDIR)/mklib.linux $(LIBBASENAME).so $(OBJECTS) $(ALLLIBS) -lobjc


# Note: Make doc requires Apple's headerdoc tools.

.PHONY: doc
doc:
	-rm -fr docs/*
	headerdoc2html -o docs SpriteApp.h Sprite.h spriteimage.h SpriteCore.hdoc matfunc.h svec.h
	gatherheaderdoc docs
# DO NOT DELETE
