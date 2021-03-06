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
#import <SpriteCore/StdlibRandomSource.h>
#include <stdio.h>
#include <stdlib.h>
@implementation TestIODelegate

- (TestIODelegate *)initForHost: (SpriteApp *)ha
			 width: (unsigned int)w
			height: (unsigned int)h 
			 title: (char *)t {
	self = [super init];
	unsigned int dep = 32;
	unsigned int i = 1;
	host = ha;
	back.cx = w;
	back.cy = h;
	back.depth = 32;
	back.scan_length = w * 4;
	back.endian = (*((char *)(&i)) == 1 ?
		      SIMG_LITTLE_ENDIAN   :
		      SIMG_BIG_ENDIAN);
	back.bits = malloc((size_t)(w * h * 4));
	back.img = NULL;

	buf.cx = w;
	buf.cy = h;
	buf.depth = 32;
	buf.scan_length = w * 4;
	buf.endian = (*((char *)(&i)) == 1 ?
		      SIMG_LITTLE_ENDIAN   :
		      SIMG_BIG_ENDIAN);
	buf.bits = malloc((size_t)(w * h * 4));
	buf.img = NULL;

	eq = malloc(sizeof(SpriteEvent) * MAX_QUEUE_DEPTH);
	if(eq == NULL)
	{
		fprintf(stderr, "couldn't allocate syn event queue\n");
		exit(-1);
	}
	q_start = 0;
	q_end = 0;
	rs = [[StdlibRandomSource alloc] init];
	[rs seed: (long)0];


	return self;

}

- (SpriteImage *)backImage {return &back;}
- (SpriteImage *)bufImage {return &buf;}
- (void)refreshScreen { }
- (int)loadPPMFile: (char *)fn toImage: (SpriteImage *)si {
	int _cx,_cy;
	unsigned char *ptr;

	ReadPpmRgbConverted(fn,&_cx,&_cy,&ptr,32);
	if(ptr == NULL) { return -1;}
	si->img = NULL;
	si->cx = _cx;
	si->cy = _cy;
	si->depth = 32;
	si->scan_length = _cx * 4;
	si->endian = buf.endian;
	si->bits = ptr;
	si->auto_free = 1;
	si->img = NULL;
	return 0;

}
- (int)convertMemPPM: (unsigned char *)ppm size: (unsigned int) sz
	     toImage: (SpriteImage *)si {
	int _cx,_cy;
	unsigned char *ptr;
	ReadPpmRgbFromMemoryConverted(ppm,sz,&_cx,&_cy,&ptr,32);
	if(ptr == NULL) {return -1;}
	si->cx = _cx;
	si->cy = _cy;
	si->depth = 32;
	si->scan_length = _cx * 4;
	si->endian = buf.endian;
	si->bits = ptr;
	si->auto_free = 1;
	si->img = NULL;
	return 0;

}
-(void *)createHWSurfWidth: (unsigned int) w
		    height: (unsigned int) h
		     depth: (unsigned int) d
{
	return (void *)NULL;
}
-(int)buildImage: (SpriteImage *)si fromHWSurf: (void *)surf
{
	return 1;
}

-(void)destroyImage: (SpriteImage *)si {
	free(si->bits);

}

-(id)dispatchEvents {
	while(q_start != q_end)
	{
		SpriteEvent se = eq[q_start];
		q_start++;
		q_start %= MAX_QUEUE_DEPTH;
		[host handleEvent: &se];
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

-(void)sendEvent: (SpriteEvent *)evt
{
	if((q_end + 1) % MAX_QUEUE_DEPTH == q_start)
	{
		return;
	}
	eq[q_end] = *evt;
	q_end++;
	q_end %= MAX_QUEUE_DEPTH;
}

-free {
	[self destroyImage: &back];
	[self destroyImage: &buf];
	[rs free];
	return [super free];
}

-(BOOL)goFullScreen: (BOOL)fs
{
	return 0;
}

-(BOOL)isFullScreen
{
	return 0;
}

-(BOOL)changeScreenSizeX: (unsigned int)x Y: (unsigned int) y
{
	return 0;
}

-(id <SpriteRandomSource>)randomSource
{
	return rs;
}

@end

#ifdef __TESTIODEL_PRIMARY 
id createIODelegate(SpriteApp *ha,unsigned int w,unsigned int h,char *t) {
	return [[TestIODelegate alloc] initForHost: ha 
				      width: w height: h title: t];
}
#endif
