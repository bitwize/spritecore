#import <SpriteCore/SpriteCore.h>

@interface ScrollLayerAgent : Object <SpriteAppearanceAgent> {

}

-(void)renderSprite: (Sprite *)s on: (SpriteImage *)si;
+initialize;
+(id)instance;
@end
