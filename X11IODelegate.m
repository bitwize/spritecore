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
#include <stdlib.h>
#include <sys/time.h>

#define IMAGE(x) ((XImage *)x)


int SC_SpecialKeyMap[] = {
	XK_F1,SC_Key_F1,
	XK_F2,SC_Key_F2,
	XK_F3,SC_Key_F3,
	XK_F4,SC_Key_F4,
	XK_F5,SC_Key_F5,
	XK_F6,SC_Key_F6,
	XK_F7,SC_Key_F7,
	XK_F8,SC_Key_F8,
	XK_F9,SC_Key_F9,
	XK_F10,SC_Key_F10,
	XK_F11,SC_Key_F11,
	XK_F12,SC_Key_F12,
	XK_Up,SC_Key_Up,
	XK_Down,SC_Key_Down,
	XK_Left,SC_Key_Left,
	XK_Right,SC_Key_Right,
	XK_Page_Up,SC_Key_PgUp,
	XK_Page_Down,SC_Key_PgDn,
	XK_Home,SC_Key_Home,
	XK_End,SC_Key_End,
	XK_Insert,SC_Key_Ins,
	XK_Delete,SC_Key_Del,
	XK_Shift_L,SC_Key_Shift,
	XK_Control_L,SC_Key_Ctrl,
	XK_Alt_L,SC_Key_Alt,
	XK_Meta_L,SC_Key_Meta,
	XK_Shift_R,SC_Key_Shift,
	XK_Control_R,SC_Key_Ctrl,
	XK_Alt_R,SC_Key_Alt,
	XK_Meta_R,SC_Key_Meta,
	0,0
};


void BuildSI(SpriteImage *si) {
	si->cx = IMAGE(si->img)->width;
	si->cy = IMAGE(si->img)->height;
	si->depth = IMAGE(si->img)->bits_per_pixel;
	si->scan_length = IMAGE(si->img)->bytes_per_line;
	si->endian = (IMAGE(si->img) == LSBFirst ? SIMG_LITTLE_ENDIAN : SIMG_BIG_ENDIAN);
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
				       32,
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
				       32,
				       0);
	BuildSI(si);
	si->auto_free = 1;
	return 0;
	
}

-(void)destroyImage: (SpriteImage *)si {
	XDestroyImage(IMAGE(si->img));
}

-(id)dispatchEvents {
	XEvent evt;
	int code;
	int ks;
	int i;
	while(XNextEvent(dpy,&evt)) {
		switch(evt.type) {
		case GraphicsExpose:
			[self refreshScreen];
			break;
		case KeyPress:
		case KeyRelease:
			ks = XLookupKeysym((XKeyEvent *)&evt,0);
			/* Handle basic ASCII keys. */
			if(ks >= 0x20 && ks <= 0x7f) {
				code = ks;
			}
			/* Handle control characters whose keysyms
			   X11 put in the 0xffnn range. */
			else if(ks >= 0xff01 && ks < 0xff10) {
				code = ks & 0xff;
			}
			/* Look up other special keys. */
			else {
				for(i=0;SC_SpecialKeyMap[i] != 0;i += 2) {
					if(ks == SC_SpecialKeyMap[i]) {
						code = SC_SpecialKeyMap[i + 1];
					}
				}
			}
			if ((evt.type) == KeyRelease) {[host keyUp: code];} else
			{[host keyDown: code];}
			break;
		case MotionNotify:
		{
			XMotionEvent *me = ((XMotionEvent *)&evt);
			[host mouseMoveX: me->x Y: me->y];
		}
			break;
		case ButtonPress:
 		{
			XButtonEvent *be = ((XButtonEvent *)&evt);
			[host keyDown: (be->button - Button1 + SC_Key_Button1)];
		}
			break;
		case ButtonRelease:
 		{
			XButtonEvent *be = ((XButtonEvent *)&evt);
			[host keyUp: (be->button - Button1 + SC_Key_Button1)];
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
@end

id createIODelegate(SpriteApp *ha,unsigned int w,unsigned int h,char *t) {
	return [[X11IODelegate alloc] initForHost: ha width: w height: h title: t];
}
