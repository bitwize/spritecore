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

#import <SpriteAgent.h>
#import <Sprite.h>
#import <SpriteApp.h>
#import <DefaultAgents.h>
#include <svec.h>

@implementation DefaultAppearanceAgent
-(void)renderSprite: (Sprite *)s on: (SpriteImage *)si
{
	struct sprite_render_data d;
	[s fillRenderData: &d];
	if(d.simg != NULL) {
		if(d.maxframes < 2) {
			ImageCopy(d.simg,si,0,0,
				  (d.pos.x-d.hotspot.x),
				  (d.pos.y-d.hotspot.y),
				  d.width,d.height,SIMG_USE_KEY,d.key);
		}
		else {
			ImageCopy(d.simg,si,0,d.height * d.frame,
				  (d.pos.x-d.hotspot.x),
				  (d.pos.y-d.hotspot.y),
				  d.width,d.height,SIMG_USE_KEY,d.key);
		}
	}
}

@end

@implementation WrapperAppearanceAgent
-(WrapperAppearanceAgent *)initWrappingRenderer: (void (*)(Sprite *,SpriteImage *))f
{
	func = f;
}

-(void)renderSprite: (Sprite *)s on: (SpriteImage *)si
{
	func(s,si);
}

@end

@implementation DefaultBehaviorAgent

-(void)act: (Sprite *)s
{
}

@end

@implementation WrapperBehaviorAgent
-(WrapperBehaviorAgent *)initWrappingBehavior: (void (*)(Sprite *)) f
{
	self = [super init];
	func = f;
	return self;
}

-(void)act: (Sprite *)s
{
	func(s);
}

@end

@implementation SelectorBehaviorAgent
-(SelectorBehaviorAgent *)initWrappingSelector: (SEL) s
{
	self = [super init];
	_sel = s;
	return self;
}

-(void)act: (Sprite *)s
{
	[s perform: _sel];
}

@end

@implementation SequenceBehaviorAgent
-(SequenceBehaviorAgent *)initSequencingBehaviors: (id <SpriteBehaviorAgent>)a1 
				      and: (id <SpriteBehaviorAgent>)a2
{
	self = [super init];
	agent1 = a1;
	agent2 = a2;
	return self;
}

-(void)act: (Sprite *)s
{
	[agent1 act: s];
	[agent2 act: s];
}

@end

@implementation DefaultEventAgent
-(void)handleEvent: (SpriteEvent *)e forApp: (SpriteApp *) a
{

}
@end
@implementation WrapperEventAgent
-(WrapperEventAgent *)initWrappingHandler: (void (*)(SpriteEvent *,SpriteApp *))h
{
	self = [super init];
	handler = h;
	return self;
}
-(void)handleEvent: (SpriteEvent *)e forApp: (SpriteApp *) a
{
	handler(e,a);
}


@end
