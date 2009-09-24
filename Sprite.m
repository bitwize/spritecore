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

#include <stdlib.h>
#import <SpriteCore/SpriteNode.h>
#import <SpriteCore/Sprite.h>
#import <SpriteCore/DefaultAgents.h>

DefaultRendererAgent *dra;
DefaultBehaviorAgent *dba;

svec2 make_svec2(float x,float y) {
	svec2 v;
	v.x = x;
	v.y = y;
	return v;
}

@implementation Sprite
-(id)initOn: (SpriteApp *)h
      shape: (SpriteImage *)si
     frames: (unsigned int)mf
{
	self = [super initOn: h];
	simg = si;
	maxframes = mf;
	frame = 0;
	pos.x = 0; pos.y = 0; vel.x = 0; vel.y = 0;
	hotspot.x = 0; hotspot.y = 0;
	[self setShape: si frames: mf];
	aagent = dra;
	bagent = dba;
	return self;
}


-(SpriteImage *)setShape: (SpriteImage *)sh frames: (unsigned int)f {
	simg = sh;
	maxframes = f;
	if(simg != NULL) {
		width = simg->cx;
		height = simg->cy / f;
	}
	else {width=0; height=0;}
	get_key(sh,key);
	return sh;
}

-(SpriteImage *)setShape: (SpriteImage *)sh {
	return [self setShape: sh frames: 1];
}

-(SpriteImage *)shape {
	return simg;
}

- (unsigned int)frame {
	return frame;
}

- (unsigned int)numberFrames {
	return maxframes;
}

- (void)setFrame: (unsigned int)f {
	frame = f % maxframes;
}

-(void)step {
	unsigned int t = [host lastFrameTime];
	float nj = (float)t / 20.0;
	pos.x += vel.x * nj;
	pos.y += vel.y * nj;
	[bagent act: self];
}

-(void)render {
	[aagent renderSprite: self on: [host surface]];
}

-(void)moveTo: (svec2)p {
	pos = p;
}

-(void)setVel: (svec2)v {
	vel = v;
}
-(void)setHotspot: (svec2)h {
	hotspot = h;
}

-(svec2)pos {
	return pos;
}

-(svec2)vel {
	return vel;
}

-(svec2)hotspot {
	return hotspot;
}

-(unsigned int)width {return width;}
-(unsigned int)height {return height;}
-(svec2)size {return make_svec2(width,height);}
-(srect2)boundingBox
{
	srect2 bb;
	bb.pos = pos;
	bb.size = make_svec2(width,height);
	return bb;
}
-(char *)keyPtr {return key;}

-(int)isTouching: (Sprite *)s {
	int step1,step2; //Intermediate x and y proximity values.
	svec2 pos2 = [s pos];
	svec2 hotspot2 = [s hotspot];
	int x1 = pos.x - hotspot.x;
	int y1 = pos.y - hotspot.y;
	int x2 = pos2.x - hotspot2.x;
	int y2 = pos2.y - hotspot2.y;
	//Step 1: Check for horizontal proximity.
	if(x1 <= x2) {
		if(x2 - x1 < width) step1 = 1; else step1 = 0;
	}
	else {
		if(x2 + [s width] > x1) step1 = 1; else step1 = 0;
	}
	//Step 2: Check for vertical proximity.
	if(y1 <= y2) {
		if(y2 - y1 < height) step2 = 1; else step2 = 0;
	}
	else {
		if(y2 + [s height] > y1) step2 = 1; else step2 = 0;
	}
	//Return true if we are overlapping horizontally AND vertically.
	return(step1 && step2);
}

-(void)setAppearanceAgent: (id<SpriteRendererAgent>) a
{
	aagent = a;
}

-(id<SpriteRendererAgent>)appearanceAgent
{
	return aagent;
}

-(void)setBehaviorAgent: (id<SpriteBehaviorAgent>) a
{
	bagent = a;
}

-(id<SpriteBehaviorAgent>)behaviorAgent
{
	return bagent;
}
-(void)fillRenderData: (struct sprite_render_data *)d
{
	d->simg = simg;
	d->pos = pos;
	d->hotspot = hotspot;
	d->key = key;
	d->frame = frame;
	d->maxframes = maxframes;
	d->width = width;
	d->height = height;
}

+(void)initialize
{
	static int initialized = 0;
	if(!initialized)
	{
		dba = [[DefaultBehaviorAgent alloc] init];
		dra = [[DefaultRendererAgent alloc] init];
		initialized = 1;
	}
}
 
@end
