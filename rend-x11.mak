ALLINCLUDES= -I$(XINCDIR)
ALLLIBS= -L$(XLIBDIR) -Wl,-R$(XLIBDIR) -lX11 -lXext
IODEL_CLASS=X11IODelegate
