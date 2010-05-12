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
#import <SpriteCore/SpriteNode.h>
#import <SpriteCore/SpriteResLoader.h>
#import <SpriteCore/DefaultAgents.h>
#import <SpriteCore/StderrLogger.h>
#include <malloc.h>

DefaultEventAgent *dea;

@implementation SpriteApp
-(id)initWithTitle: (char *)t width: (unsigned int)w height: (unsigned int)h {
	self = [super init];
	first = nil; deleted = nil;
	title = t; width = w; height = h;
	io_del = createIODelegate(self,w,h,t);
	oldclock = [io_del getTimeMillis];
	clock = [io_del getTimeMillis];
	logger = [[StderrLogger alloc] init];
	quitting = 0;
	eagent = dea;
	return self;
}

-(SpriteNode *)first {
	return first;
}

-(SpriteNode *)last {
	SpriteNode *i,*j;
	i = first;
	if(i == nil) {return i;}
	while((j=[i next]) != nil) {
		i = j;
	}
	return i;

}

-(SpriteNode *)add: (SpriteNode *)newone {
	SpriteNode *r = [self last];
	if(r == nil) {
		first = newone;
		[newone setPrev: nil];
		[newone setNext: nil];
		[newone setHost: self];
		return newone;
	}
	else {
		[r setNext: newone];
		[newone setPrev: r];
		[newone setNext: nil];
		[newone setHost: self];
		return newone;
	}

}

-(SpriteNode *)remove: (SpriteNode *)oldone {
	SpriteNode *n,*p;
	if([oldone host] != self) {
		return nil;
	}
	n = [oldone next];
	p = [oldone prev];
	if(n != nil) {
		[n setPrev: p];
	}
	if(p != nil) {
		[p setNext: n];
	} else {
		first = n;
	}
	return oldone;

}

-(SpriteNode *)delete: (SpriteNode *)oldone {
	[self remove: oldone]; [self addDeleted: oldone]; return oldone;
}

-(SpriteNode *)place: (SpriteNode *) aSprite behind: (SpriteNode *)anotherSprite {
	SpriteNode *b;
	[self remove: aSprite];
	if(anotherSprite == nil) {
		[self add: aSprite];
	}
	else {
		b = [anotherSprite prev];
		[aSprite setPrev: b];
		if(b == nil) {
			first = aSprite;
		}
		else {
			[b setNext: aSprite];
		}
		[aSprite setNext: anotherSprite];
		[anotherSprite setPrev: aSprite];
	}
	return aSprite;
}

-(SpriteNode *)addDeleted: (SpriteNode *)newone {
	[newone setPrev: nil]; [newone setNext: deleted]; deleted=newone; return newone;
}

-(void)freeClients {
	SpriteNode *i,*j;
	i = first;
	while(i != nil) {
		j=[i next];
		[i free];
		i=j;
	}
	first=nil;
  
}


-(void)freeDeleted {
	SpriteNode *i,*j;
	i = deleted;
	while(i != nil) {
		j=[i next];
		[i free];
		i=j;
	}
	deleted=nil;
  
}

-(void)step {
	SpriteNode *i,*j;
	i = first;
	[io_del dispatchEvents];
	oldclock += 20;
	while(i != nil) {
		j=[i next];
		[i step];
		i=j;
	}
	[self freeDeleted];
	[io_del unlockBuf];

	[io_del refreshScreen];
}

-(void)updateDisplay
{
	SpriteNode *i;
	i = first;
	[io_del lockAndClearBuf];
	while(i != nil) {
		[i render];
		i = [i next];
	}
	[io_del unlockBuf];

	[io_del refreshScreen];
	
}

-(void)handleEvent: (SpriteEvent *)evt {
	[eagent handleEvent: evt forApp: self];
}

-(id <SpriteEventAgent>) eventAgent {
	return eagent;
}

-(void) setEventAgent: (id <SpriteEventAgent>) ea {
	eagent = ea;
}

-free {
	[self freeClients];
	[io_del free];
	return [super free];
}

-(int)loadPPMFile: (char *)fn toImage: (SpriteImage *)si {
	return [io_del loadPPMFile: fn toImage: si];
}

-(void)destroyImage: (SpriteImage *)si {
	[io_del destroyImage: si];
}

-(unsigned int)clock {
	return clock;
}

-(unsigned int)lastFrameTime {
	return clock - oldclock;
}
-(char *)resourcePath {
	return res_path;
}

-(void)setResourcePath: (char *)aPath {
	res_path = aPath;
}

-(SpriteImage *)background {
	return [io_del backImage];
}

-(SpriteImage *)surface {
	return [io_del bufImage];
}

-(int)loader: (SpriteResLoader *)aLoader loadResPPM: (char *)aResName 
     toImage: (SpriteImage *)si {
	unsigned char *data;
	int i;
	int sz = [aLoader fetchResource: aResName to: (void **)&data];
	if(data == NULL) {
		return -1;
	}
	i = [io_del convertMemPPM: data size: sz toImage: si];
	free(data);
	return i;
}

-(void)run {
	while(!quitting) {
		while((clock - oldclock) >= 20) {
			[self step];
		}
		[self updateDisplay];
		clock = [io_del getTimeMillis];
		[io_del sleepMillis: 5];
	}
}

-(void)quit {
	quitting = 1;
}

-(void)logCategory: (char *)cat message: (char *) msg,...
{
	va_list l;
	if(logger != nil) {
		va_start(l,msg);
		[logger varargsLogCategory: cat message: msg rest: l];
		va_end(l);
	}

}

+(void)initialize
{
	static int initialized = 0;
	if(!initialized)
	{
		dea = [[DefaultEventAgent alloc] init];
		initialized = 1;
	}
}

@end
