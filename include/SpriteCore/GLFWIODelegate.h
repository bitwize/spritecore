// -*- objc -*-
#ifndef __GLFWIODELEGATE_H
#define __GLFWIODELEGATE_H

#import <GL/glfw.h>
#import <SpriteCore/SpriteApp.h>

@interface GLFWIODelegate : Object <SpriteIODelegate>
{
	
}
- (GLFWIODelegate *)initForHost: (SpriteApp *)ha
			 width: (unsigned int)w 
			height: (unsigned int)h
			 title: (char *)t;
-(SpriteImage *)backImage;
-(SpriteImage *)bufImage;
-(void)refreshScreen;
-(int)convertMemPPM: (unsigned char *)ppm size: (unsigned int) sz
	     toImage: (SpriteImage *)si;
-(void)destroyImage: (SpriteImage *)si;
-(void)lockBuf;
-(void)lockAndClearBuf;
-(void)unlockBuf;
-(id)dispatchEvents;
-(unsigned int)getTimeMillis;
-(void)sleepMillis: (unsigned int) ms;
-free;

@end
#endif
