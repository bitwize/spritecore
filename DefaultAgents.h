/* -*- objc -*- */

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
#ifndef __DEFAULTAGENTS_H
#define __DEFAULTAGENTS_H
#include <spriteevent.h>
#include <spriteimage.h>
@class SpriteApp;
@class Sprite;
@interface DefaultAppearanceAgent : Object <SpriteAppearanceAgent>
{
  
}
-(void)renderSprite: (Sprite *)s on: (SpriteImage *)si;
@end

@interface WrapperAppearanceAgent : Object <SpriteAppearanceAgent>
{
  void (*func)(Sprite *,SpriteImage *);
}
-(WrapperAppearanceAgent *)initWrappingRenderer: (void (*)(Sprite *,SpriteImage *)) f;
-(void)renderSprite: (Sprite *)s on: (SpriteImage *)si;
@end

@interface DefaultBehaviorAgent : Object <SpriteBehaviorAgent>
{

}
-(void)act: (Sprite *)s;
@end

@interface WrapperBehaviorAgent : Object <SpriteBehaviorAgent>
{
  void (*func)(Sprite *);
}
-(WrapperBehaviorAgent *)initWrappingBehavior: (void (*)(Sprite *)) f;
-(void)act: (Sprite *)s;
@end
@interface SelectorBehaviorAgent : Object <SpriteBehaviorAgent>
{
	SEL _sel;
}
-(SelectorBehaviorAgent *)initWrappingSelector: (SEL)s;
-(void)act: (Sprite *)s;
@end

@interface SequenceBehaviorAgent : Object <SpriteBehaviorAgent>
{
  id <SpriteBehaviorAgent> agent1;
  id <SpriteBehaviorAgent> agent2;
}
-(SequenceBehaviorAgent *)initSequencingBehaviors: (id <SpriteBehaviorAgent>)a1
					      and: (id <SpriteBehaviorAgent>)a2;
-(void)act: (Sprite *)s;
@end

@interface DefaultEventAgent : Object <SpriteEventAgent>
{

}
-(void)handleEvent: (SpriteEvent *)e forApp: (SpriteApp *) a;
@end

@interface WrapperEventAgent : Object <SpriteEventAgent>
{
  void (*handler)(SpriteEvent *,SpriteApp *);
}
-(WrapperEventAgent *)initWrappingHandler: (void (*)(SpriteEvent *,SpriteApp *))h;
-(void)handleEvent: (SpriteEvent *)e forApp: (SpriteApp *) a;

@end
#endif
