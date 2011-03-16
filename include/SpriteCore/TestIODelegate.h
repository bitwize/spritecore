/* -*- objc -*- */

#import <SpriteCore/SpriteApp.h>

#define MAX_QUEUE_DEPTH 256

@interface TestIODelegate : Object <SpriteIODelegate> {
	SpriteApp *host;
	SpriteImage back;
	SpriteImage buf;
	unsigned int syn_clock;
	SpriteEvent *eq;
	unsigned int q_start;
	unsigned int q_end;
}

- (TestIODelegate *)initForHost: (SpriteApp *)ha
			  width: (unsigned int)w 
			 height: (unsigned int)h
			  title: (char *)t;
- (SpriteImage *)backImage;
- (SpriteImage *)bufImage;
- (void)refreshScreen;
- (int)loadPPMFile: (char *)fn toImage: (SpriteImage *)si;
- (int)convertMemPPM: (unsigned char *)ppm size: (unsigned int) sz
	     toImage: (SpriteImage *)si;
-(void *)createHWSurfWidth: (unsigned int) w
		    height: (unsigned int) h
		     depth: (unsigned int) d;
-(int)buildImage: (SpriteImage *)si fromHWSurf: (void *)surf;
-(void)destroyImage: (SpriteImage *)si;
-(void)lockBuf;
-(void)lockAndClearBuf;
-(void)unlockBuf;
-(id)dispatchEvents;
-(unsigned int)getTimeMillis;
-(void)sleepMillis: (unsigned int) ms;
-free;
@end
