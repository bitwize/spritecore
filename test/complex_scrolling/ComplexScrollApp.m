#import <SpriteCore/SpriteCore.h>
#import "ComplexScrollApp.h"
#import "ScrollLayerAgent.h"

WrapperEventAgent *a;
int initialized = 0;

void resl_test_handler(SpriteEvent *e,SpriteApp *a);

@implementation ComplexScrollApp

-(id)init
{
	self = [super initWithTitle: "scrolling" width: 512 height: 384];
	[self setEventAgent: a];
	rl = [[SpriteResLoader alloc] initOn: self named: "complex_scrolling"];
	bg = [self createScrollLayerLoading: "scroll1.pnm" image: &bgsi];
	fg = [self createScrollLayerLoading: "scroll2.pnm" image: &fgsi];
	[bg setVel: make_sc_vec2_fl(1.5,0)];
	[fg setVel: make_sc_vec2_fl(3.0,0)];
	return self;
}

-(Sprite *)createScrollLayerLoading: (char *)resName image: (SpriteImage *)i
{
	[self loader: rl loadResPPM: resName toImage: i];
	Sprite *s = [[Sprite alloc] initOn: self shape: i frames: 1];
	[s setAppearanceAgent: (ScrollLayerAgent *)[ScrollLayerAgent instance]];
	return s;
}

+initialize
{
	if(!initialized)
	{
		a = [[WrapperEventAgent alloc] initWrappingHandler: resl_test_handler];
		initialized = 1;
	}
}

@end

void resl_test_handler(SpriteEvent *e,SpriteApp *a)
{
	if(e->source_type == SPRITEEVENT_SOURCE_KEYBOARD &&
	   e->code   == XK_Escape) {
		[a quit];
	}
}
