# Sprite32 Configuration file
# Version 0.6
# Jeff Read

# This is the configuration file for Sprite32. For many stock Linux and Darwin
# systems this should work OK as it is. If you have an exotic system configura-
# tion please edit it to suit your system.

# Specify the name of compiler, linker, and other tools.

CC=gcc
OBJCC=gcc
LINK=gcc
AR=ar
RANLIB=ranlib
INSTALL=install

# Specify location of your X11 libs and headers
# For X11 and GLX renderers.

XLIBDIR=/usr/X11R7/lib
XINCDIR=/usr/X11R7/include

# Specify location of your OpenGL libs and headers
# For GLX renderer.

GLLIBDIR=/usr/X11R7/lib
GLINCDIR=/usr/X11R7/include

GLFWLIBDIR=/home/bitwize/glfw-2.7/lib/x11
GLFWINCDIR=/home/bitwize/glfw-2.7/include

# Specify location of your SDL libs and headers
# For SDL renderer.

SDLLIBDIR=/usr/pkg/lib
SDLINCDIR=/usr/pkg/include

# Specify where the SpriteCore libraries and headers will be installed.
# Headers will be placed in a SpriteCore/ subdir.

DESTLIBDIR=/usr/local/lib
DESTINCDIR=/usr/local/include


LIBBASENAME=libSpriteCore
VERMAJOR=0
VERMINOR=7
CFLAGS=-fPIC -O3
OBJCFLAGS=$(CFLAGS) -Wno-import

# Set to your current platform (currently available: linux, darwin)
# NOTE: If your platform is not on the list you can always put
# "unix-static" here to compile a static lib (which should work on most Unix
# systems). Alternatively, add your platform by making up an appropriate 
# mklib.* file and updating the Makefile.

PLATFORM=linux


# Set to the renderer you want (currently available: sdl,x11)
RENDERER=glfw

