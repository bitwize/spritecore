#import "ScrollLayerAgent.h"

ScrollLayerAgent *instance = NULL;

@implementation ScrollLayerAgent

-(void)renderSprite: (Sprite *)s on: (SpriteImage *)si
{
	sc_vec2 offset;
	struct sprite_render_data d;
	[s fillRenderData: &d];
	if(d.simg != NULL)
	{
		offset.x = (d.pos.x) % d.simg->cx;
		offset.y = (d.pos.y) % d.simg->cy;
		unsigned int blit_width = si->cx;
		if(offset.x > d.simg->cx - si->cx)
		{
			blit_width -= (offset.x + si->cx - d.simg->cx);
			ImageCopy(d.simg,si,
				  0,0,
				  blit_width,
				  0,
				  si->cx - blit_width,
				  d.simg->cy,
				  SIMG_USE_KEY,d.key);
		}

		ImageCopy(d.simg,si,
			  offset.x,
			  0,
			  0,0,
			  blit_width,
			  d.simg->cy,
			  SIMG_USE_KEY,d.key);
	}
}

+initialize
{
	static int is_initialized = 0;
	if(!is_initialized)
	{
		instance = [[ScrollLayerAgent alloc] init];
		is_initialized = 1;
	}
}

+(id)instance
{
	return (id)instance;
}

@end
