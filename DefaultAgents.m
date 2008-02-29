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
  SpriteImage *simg = [s shape];
  svec2 pos = [s pos];
  svec2 hotspot = [s hotspot];
  char key[4];
  unsigned int frame = [s frame];
  unsigned int maxframes = [s numberFrames];
  unsigned int width = [s width];
  unsigned int height = [s height];
  if(simg != NULL) {
    get_key(simg,key);
    if(maxframes < 2) {
      ImageCopy(simg,si,0,0,pos.x-hotspot.x,pos.y-hotspot.y,
		width,height,SIMG_USE_KEY,key);
    }
    else {
      ImageCopy(simg,si,0,height * frame,pos.x-hotspot.x,pos.y-hotspot.y
		,width,height,SIMG_USE_KEY,key);
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
