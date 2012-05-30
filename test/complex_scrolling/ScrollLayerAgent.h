#import <SpriteCore/SpriteCore.h>

@interface ScrollLayerAgent : SCObject <SpriteAppearanceAgent> {

}

-(void)renderSprite: (Sprite *)s on: (SpriteImage *)si;
+initialize;
+(id)instance;
@end
