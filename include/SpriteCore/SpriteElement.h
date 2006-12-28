
#ifndef __SPRITEELEMENT_H
#define __SPRITEELEMENT_H

@class SpriteNode;
@protocol SpriteElement
-(void)step;
-(void)renderToApp: (SpriteApp *)a;
-(SpriteNode *)node;
@end

#endif
