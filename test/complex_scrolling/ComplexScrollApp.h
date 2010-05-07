#ifndef __COMPLEX_SCROLLAPP_H
#define __COMPLEX_SCROLLAPP_H
#include <SpriteCore/SpriteCore.h>

@interface ComplexScrollApp : SpriteApp {
	Sprite *bg;
	Sprite *fg;
	SpriteImage bgsi;
	SpriteImage fgsi;
	SpriteResLoader *rl;
}

-(id)init;
-(Sprite *)createScrollLayerLoading: (char *)resName image: (SpriteImage *)i;

+initialize;
@end

#endif
