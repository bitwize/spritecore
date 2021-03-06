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
#import <SpriteCore/SCNode.h>
#import <SpriteCore/Sprite.h>
#import <SpriteCore/DefaultAgents.h>

DefaultAppearanceAgent *dra;
DefaultBehaviorAgent *dba;

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
		get_key(sh,key);
	}
	else {width=0; height=0;}
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
	pos.x += (vel.x);
	pos.y += (vel.y);
	[bagent act: self];
}

-(void)render {
	[aagent renderSprite: self on: [host surface]];
}

-(void)moveTo: (sc_vec2)p {
	pos = p;
}

-(void)setVel: (sc_vec2)v {
	vel = v;
}
-(void)setHotspot: (sc_vec2)h {
	hotspot = h;
}

-(sc_vec2)pos {
	return pos;
}

-(sc_vec2)vel {
	return vel;
}

-(sc_vec2)hotspot {
	return hotspot;
}

-(unsigned int)width {return width;}
-(unsigned int)height {return height;}
-(sc_vec2)size {return make_sc_vec2_fl(width,height);}
-(sc_rect)boundingBox
{
	sc_rect bb;
	bb.pos = pos;
	bb.pos.x -= hotspot.x;
	bb.pos.y -= hotspot.y;
	bb.size = make_sc_vec2_fl(width,height);
	return bb;
}
-(char *)keyPtr {return key;}

-(int)isTouching: (Sprite *)s {
	return rects_intersect([self boundingBox],[s boundingBox]);
}

-(void)setAppearanceAgent: (id<SpriteAppearanceAgent>) a
{
	aagent = a;
}

-(id<SpriteAppearanceAgent>)appearanceAgent
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
		dra = [[DefaultAppearanceAgent alloc] init];
		initialized = 1;
	}
}

+(id <SpriteAppearanceAgent>)defaultAppearanceAgent
{
	return dra;
}

+(id <SpriteBehaviorAgent>)defaultBehaviorAgent
{
	return dba;
}

@end
