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
#import <SpriteCore/TestIODelegate.h>
#import <SpriteCore/svppm.h>
#include <stdlib.h>
@implementation SDLIODelegate

- (SDLIODelegate *)initForHost: (SpriteApp *)ha
			 width: (unsigned int)w
			height: (unsigned int)h 
			 title: (char *)t {
	self = [super init];
	unsigned int dep = 32;
	host = ha;
	// TODO: fill these
	back.cx = w;
	back.cy = h;
	back.bits = NULL;
	buf.cx = w;
	buf.cy = h;
	buf.bits = NULL;
	return self;

}

- (SpriteImage *)backImage {return &back;}
- (SpriteImage *)bufImage {return &buf;}
- (void)refreshScreen {SDL_Flip(IMAGE(buf.img));}
- (int)loadPPMFile: (char *)fn toImage: (SpriteImage *)si {
	int _cx,_cy;
	unsigned char *ptr;

	ReadPpmRgbConverted(fn,&_cx,&_cy,&ptr,32);
	if(ptr == NULL) { return -1;}
	si->img = (void *)SDL_CreateRGBSurfaceFrom(ptr,_cx,_cy,32,_cx * 4,
						   0xff0000,0x00ff00,0x0000ff,
						   0x0);
	si->cx = IMAGE(si->img)->w;
	si->cy = IMAGE(si->img)->h;
	si->depth = IMAGE(si->img)->format->BitsPerPixel;
	si->scan_length = IMAGE(si->img)->pitch;
	si->endian = (SDL_BYTEORDER == SDL_LIL_ENDIAN ? 
		      SIMG_LITTLE_ENDIAN : 
		      SIMG_BIG_ENDIAN);
	si->bits = IMAGE(si->img)->pixels;
	si->auto_free = 1;
	return 0;

}
- (int)convertMemPPM: (unsigned char *)ppm size: (unsigned int) sz
	     toImage: (SpriteImage *)si {
	int _cx,_cy;
	unsigned char *ptr;

	ReadPpmRgbFromMemoryConverted(ppm,sz,&_cx,&_cy,&ptr,32);
	if(ptr == NULL) {return -1;}
	si->img = (void *)SDL_CreateRGBSurfaceFrom(ptr,_cx,_cy,32,_cx * 4,
						   0xff0000,0x00ff00,0x0000ff,
						   0x0);
	si->cx = _cx;
	si->cy = _cy;
	si->depth = 24;
	si->scan_length = _cx * 3;
	si->endian = (SDL_BYTEORDER == SDL_LIL_ENDIAN ? 
		      SIMG_LITTLE_ENDIAN : 
		      SIMG_LITTLE_ENDIAN);
	si->bits = IMAGE(si->img)->pixels;
	si->auto_free = 1;
	return 0;

}

-(void)destroyImage: (SpriteImage *)si {
	SDL_FreeSurface(IMAGE(si->img));

}

-(id)dispatchEvents {
	SDL_Event evt;
	int code;
	int ks;
	int i;
	SpriteEvent se;
	while(SDL_PollEvent(&evt)) {
		switch(evt.type) {
		case SDL_KEYDOWN:
		case SDL_KEYUP:
			se.source_type = SPRITEEVENT_SOURCE_KEYBOARD;
			se.source_selector = 0;
			ks = (evt.key.keysym).sym;
			if(ks >= 0x01 && ks <= 0x7e) {
				se.code = ks;
				if(ks <= 0x20) {
					se.code |= 0xff00;
				}
			}
			else {
				for(i=0;SC_SpecialKeyMap[i] != 0;i += 2) {
					if(ks == SC_SpecialKeyMap[i]) {
						se.code = SC_SpecialKeyMap[i + 1];
					}
				}
			}
			if ((evt.type) == SDL_KEYUP) {
				se.value = 0;
			} else
			{
				se.value = 1;
			}
			[host handleEvent: &se];
			break;
		case SDL_MOUSEMOTION:
			se.source_type = SPRITEEVENT_SOURCE_MOUSE |
				SPRITEEVENT_SOURCE_VALUATOR;
			se.source_selector = 0;
			se.code = 0;
			se.value = evt.motion.x;
			[host handleEvent: &se];
			se.code = 1;
			se.value = evt.motion.y;
			[host handleEvent: &se];
			break;
		case SDL_MOUSEBUTTONDOWN:
			se.source_type = SPRITEEVENT_SOURCE_MOUSE;
			se.source_selector = 0;
			se.code = evt.button.button;
			se.value = 1;
			[host handleEvent: &se];
			break;
		case SDL_MOUSEBUTTONUP:
			se.source_type = SPRITEEVENT_SOURCE_MOUSE;
			se.source_selector = 0;
			se.code = evt.button.button;
			se.value = 0;
			[host handleEvent: &se];
			break;
		}
	}
}

-(void)lockBuf {
}
-(void)lockAndClearBuf {
	ImageCopy(&back,&buf,0,0,0,0,back.cx,back.cy,0,0);
	[self lockBuf];
}

-(void)unlockBuf {
}

-(unsigned int)getTimeMillis {
	return syn_clock;
}
-(void)sleepMillis: (unsigned int) ms {
	syn_clock += ms;
}
-free {
	return [super free];
}
@end
