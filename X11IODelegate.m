/*
 *  Copyright 1995-2008 Jeffrey T. Read
 *
 * This file is part of SpriteCore.
 *
 * This software is provided 'as-is', without any express or implied
 * warranty.  In no event will the authors be held liable for any
 * damages arising from the use of this software.
 *
 * Permission is granted to anyone to use this software for any purpose,
 * including commercial applications, and to alter it and redistribute it
 * freely, subject to the following restrictions:
 *
 * 1. The origin of this software must not be misrepresented; you must not
 *    claim that you wrote the original software. If you use this software
 *    in a product, an acknowledgment in the product documentation would be
 *    appreciated but is not required.
 * 2. Altered source versions must be plainly marked as such, and must not be
 *    misrepresented as being the original software.
 * 3. This notice may not be removed or altered from any source distribution.
 *
 */


#import <SpriteCore/SpriteApp.h>
#import <SpriteCore/X11IODelegate.h>
#import <SpriteCore/svppm.h>
#import <SpriteCore/spriteevent.h>
#import <SpriteCore/StdlibRandomSource.h>
#include <stdlib.h>
#include <sys/time.h>

#define IMAGE(x) ((XImage *)x)



void BuildSI(SpriteImage *si) {
	si->cx = IMAGE(si->img)->width;
	si->cy = IMAGE(si->img)->height;
	si->depth = IMAGE(si->img)->bits_per_pixel;
	si->scan_length = IMAGE(si->img)->bytes_per_line;
	si->endian = (IMAGE(si->img)->byte_order == LSBFirst ? SIMG_LITTLE_ENDIAN : SIMG_BIG_ENDIAN);
	si->bits = IMAGE(si->img)->data;
	si->auto_free = 0;
}

int clock_inited = 0;
unsigned int inittime;

#define TIME_MSEC(tv) ((tv.tv_sec * 1000) + (tv.tv_usec / 1000))

@implementation X11IODelegate

- (X11IODelegate *)initForHost: (SpriteApp *)ha
			 width: (unsigned int)w
			height: (unsigned int)h 
			 title: (char *)t {
	unsigned int dep;
	struct timeval clock_tv;
	self = [super init];
	host = ha;
	if(!clock_inited) {
		gettimeofday(&clock_tv,NULL);
		inittime = (unsigned int)TIME_MSEC(clock_tv);
		clock_inited = 1;
	}
	dpy = XOpenDisplay(NULL);
	if(!dpy) {
		fprintf(stderr,"cannot open X display\n");
		exit(1);
	}
	
	dep = DefaultDepth(dpy,DefaultScreen(dpy));
	win = XCreateSimpleWindow(dpy,DefaultRootWindow(dpy),0,0,w,h,0,
				  BlackPixel(dpy,DefaultScreen(dpy)),
				  BlackPixel(dpy,DefaultScreen(dpy)));
	XGCValues gcv;
	gcv.graphics_exposures = 1;
	gcv.function = GXcopy;
	gc = XCreateGC(dpy,win,GCGraphicsExposures | 
		       GCFunction,&gcv);
	XStoreName(dpy,win,t);
	XMapRaised(dpy,win);
	back.img = XCreateImage(dpy,
				DefaultVisual(dpy,DefaultScreen(dpy)),
				dep,
				ZPixmap,
				0,
				NULL,
				w,
				h,
				32,
				0);
	buf.img = XCreateImage(dpy,
			       DefaultVisual(dpy,DefaultScreen(dpy)),
			       dep,
			       ZPixmap,
			       0,
			       NULL,
			       w,
			       h,
			       32,
			       0);
	IMAGE(back.img)->data = malloc(h * IMAGE(back.img)->bytes_per_line);
	IMAGE(buf.img)->data = malloc(h * IMAGE(buf.img)->bytes_per_line);
	BuildSI(&back);
	BuildSI(&buf);
	XSelectInput(dpy,win,KeyPressMask | KeyReleaseMask |
		     ButtonPressMask | ButtonReleaseMask |
		     PointerMotionMask | ExposureMask);
	XkbSetDetectableAutoRepeat(dpy,True,NULL);
	rs = [[StdlibRandomSource alloc] init];
	[rs seed: (long)time(0)];
	
	return self;
}

- (SpriteImage *)backImage {return &back;}
- (SpriteImage *)bufImage {return &buf;}
- (void)refreshScreen 
{
	XPutImage(dpy,win,gc,IMAGE(buf.img),0,0,0,0,buf.cx,buf.cy);
	XFlush(dpy);
}
- (int)loadPPMFile: (char *)fn toImage: (SpriteImage *)si {
	int _cx,_cy;
	unsigned char *ptr;
	
	ReadPpmRgbConverted(fn,&_cx,&_cy,&ptr,buf.depth);
	if(ptr == NULL) { return -1;}
	si->img = (void *)XCreateImage(dpy,
				       DefaultVisual(dpy,DefaultScreen(dpy)),
				       buf.depth,
				       ZPixmap,
				       0,
				       (char *)ptr,
				       _cx,
				       _cy,
				       8,
				       0);
	BuildSI(si);
	si->auto_free = 1;
	return 0;
	
}
- (int)convertMemPPM: (unsigned char *)ppm size: (unsigned int) sz
	     toImage: (SpriteImage *)si {
	int _cx,_cy;
	unsigned char *ptr;
	
	ReadPpmRgbFromMemoryConverted(ppm,sz,&_cx,&_cy,&ptr,buf.depth);
	if(ptr == NULL) {return -1;}
	si->img = (void *)XCreateImage(dpy,
				       DefaultVisual(dpy,DefaultScreen(dpy)),
				       buf.depth,
				       ZPixmap,
				       0,
				       (char *)ptr,
				       _cx,
				       _cy,
				       8,
				       0);
	BuildSI(si);
	si->auto_free = 1;
	return 0;
	
}
-(void *)createHWSurfWidth: (unsigned int) w
		    height: (unsigned int) h
		     depth: (unsigned int) d
{
	XImage *img = XCreateImage(dpy,
				   DefaultVisual(dpy,DefaultScreen(dpy)),
				   d,
				   ZPixmap,
				   0,
				   NULL,
				   w,
				   h,
				   32,
				   0);
	
	if(img != NULL) {
		img->data = calloc(h,img->bytes_per_line);
		if(img->data == NULL) {
			XDestroyImage(img);
			return NULL;
		}
	}
	return (void *)img;
}

-(int)buildImage: (SpriteImage *)si
      fromHWSurf: (void *)surf
{
	if(surf == NULL) {
		return 1;
	}
	else {
		si->img = surf;
		BuildSI(si);
		return 0;
	}
}

-(void)destroyImage: (SpriteImage *)si {
	if(si->img != NULL)
	{
		XDestroyImage(IMAGE(si->img));
	}
}

-(id)dispatchEvents {
	XEvent evt;
	SpriteEvent se;
	int code;
	int ks;
	int i;
	se.time = [host clock];
	while(XPending(dpy) > 0) {
		XNextEvent(dpy,&evt);
		switch(evt.type) {
		case GraphicsExpose:
			[self refreshScreen];
			break;
		case KeyPress:
		case KeyRelease:
		{
			se.source_type = SPRITEEVENT_SOURCE_KEYBOARD;
			se.source_selector = 0;
			se.code = XLookupKeysym((XKeyEvent *)&evt,0);
			if ((evt.type) == KeyRelease) {
				se.value = 0;
			}
			else {
				se.value = 1;
			}
			[host handleEvent: &se];
		}
		break;
		case MotionNotify:
		{
			XMotionEvent *me = ((XMotionEvent *)&evt);
			se.source_type = SPRITEEVENT_SOURCE_MOUSE |
				SPRITEEVENT_SOURCE_VALUATOR;
			se.source_selector = 0;
			se.code = 0;
			se.value = me->x;
			[host handleEvent: &se];
			se.code = 1;
			se.value = me->y;
			[host handleEvent: &se];
		}
			break;
		case ButtonPress:
 		{
			XButtonEvent *be = ((XButtonEvent *)&evt);
			se.source_type = SPRITEEVENT_SOURCE_MOUSE;
			se.source_selector = 0;
			se.code = be->button;
			se.value = 1;
			[host handleEvent: &se];
		}
			break;
		case ButtonRelease:
 		{
			XButtonEvent *be = ((XButtonEvent *)&evt);
			se.source_type = SPRITEEVENT_SOURCE_MOUSE;
			se.source_selector = 0;
			se.code = be->button;
			se.value = 1;
			[host handleEvent: &se];
		}
			break;
		}
	}
}

-(void)lockBuf {
}
-(void)lockAndClearBuf {
	[self lockBuf];
	ImageCopy(&back,&buf,0,0,0,0,back.cx,back.cy,0,0);
}

-(void)unlockBuf {
}

-(unsigned int)getTimeMillis {
	struct timeval clock_tv;
	gettimeofday(&clock_tv,NULL);
	return (unsigned int)TIME_MSEC(clock_tv) - inittime;
	
}
-(void)sleepMillis: (unsigned int) ms {
	usleep(ms * 1000);
}
-free {
	XDestroyImage(IMAGE(back.img));
	XDestroyImage(IMAGE(buf.img));
	XFreeGC(dpy,gc);
	XCloseDisplay(dpy);
	return [super free];
}
-(id <SpriteRandomSource>)randomSource
{
	return rs;
}
@end

id createIODelegate(SpriteApp *ha,unsigned int w,unsigned int h,char *t) {
	return [[X11IODelegate alloc] initForHost: ha width: w height: h title: t];
}
