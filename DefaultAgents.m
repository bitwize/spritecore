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

#import <SpriteCore/SpriteAgent.h>
#import <SpriteCore/Sprite.h>
#import <SpriteCore/DefaultAgents.h>

@implementation DefaultRendererAgent
-(void)renderSprite: (Sprite *)s on: (SpriteImage *)si
{
  struct sprite_render_data d;
  [s fillRenderData: &d];
  if(d.simg != NULL) {
    if(d.maxframes < 2) {
      ImageCopy(d.simg,si,0,0,d.pos.x-d.hotspot.x,d.pos.y-d.hotspot.y,
		d.width,d.height,SIMG_USE_KEY,d.key);
    }
    else {
      ImageCopy(d.simg,si,0,d.height * d.frame,d.pos.x-d.hotspot.x,
		d.pos.y-d.hotspot.y,d.width,d.height,SIMG_USE_KEY,d.key);
    }
  }
}

-(void)act: (Sprite *)s {
  [self renderSprite: s on: [[s host] surface]];
}

@end

@implementation DefaultBehaviorAgent

-(void)act: (Sprite *)s
{
}

@end

@implementation WrapperAgent
-(WrapperAgent *)initWrapping: (void (*)(Sprite *)) f
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

@implementation SequenceAgent
-(SequenceAgent *)initWith: (id <SpriteAgent>)a1 and: (id <SpriteAgent>)a2
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
