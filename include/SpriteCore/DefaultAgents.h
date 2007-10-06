#ifndef __DEFAULTAGENTS_H
#define __DEFAULTAGENTS_H

@interface DefaultRendererAgent : Object <SpriteAgent>
{
  
}
-(void)renderSprite: (Sprite *)s on: (SpriteImage *)si;
-(void)act: (Sprite *)s;
@end

@interface DefaultBehaviorAgent : Object <SpriteAgent>
{

}
-(void)act: (Sprite *)s;
@end

@interface WrapperAgent : Object <SpriteAgent>
{
  void (*func)(Sprite *);
}
-(WrapperAgent *)initWrapping: (void (*)(Sprite *)) f;
-(void)act: (Sprite *)s;
@end

@interface SequenceAgent : Object <SpriteAgent>
{
  id <SpriteAgent> agent1;
  id <SpriteAgent> agent2;
}
-(SequenceAgent *)initWith: (id <SpriteAgent>)a1 and: (id <SpriteAgent>)a2;
-(void)act: (Sprite *)s;
@end
#endif
