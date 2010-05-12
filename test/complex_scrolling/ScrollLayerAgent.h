#import <SpriteCore/SpriteCore.h>

@interface ScrollLayerAgent : Object <SpriteRendererAgent> {

}

-(void)renderSprite: (Sprite *)s on: (SpriteImage *)si;
+initialize;
+(id)instance;
@end
