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

#ifndef __X11IODELEGATE_H
#define __X11IODELEGATE_H

#include <X11/Xlib.h>
#include <X11/Xutil.h>
#include <X11/keysym.h>
#import <SpriteCore/SpriteApp.h>

@interface X11IODelegate : Object <SpriteIODelegate> {
  SpriteApp *host;
  SpriteImage back;
  SpriteImage buf;
  Display *dpy;
  Window win;
}

- (X11IODelegate *)initForHost: (SpriteApp *)ha
			 width: (unsigned int)w 
			height: (unsigned int)h
			 title: (char *)t;
- (SpriteImage *)backImage;
- (SpriteImage *)bufImage;
- (void)refreshScreen;
- (int)loadPPMFile: (char *)fn toImage: (SpriteImage *)si;
- (int)convertMemPPM: (unsigned char *)ppm size: (unsigned int) sz
	     toImage: (SpriteImage *)sixo;
- (void)destroyImage: (SpriteImage *)si;
-(void)lockBuf;
-(void)lockAndClearBuf;
-(void)unlockBuf;
-(id)dispatchEvents;
-(unsigned int)getTimeMillis;
-(void)sleepMillis: (unsigned int) ms;
-free;
@end

#endif
