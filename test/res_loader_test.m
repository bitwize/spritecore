struct tagSpriteEvent;
#include <SpriteCore/SpriteCore.h>
#include <unistd.h>

void resl_test_handler(SpriteEvent *,SpriteApp *);

int main(void) {
	WrapperEventAgent *wa = 
		(WrapperEventAgent *)[[WrapperEventAgent alloc] 
			initWrappingHandler:
			(resl_test_handler)];
	SpriteApp *a = [[SpriteApp alloc] initWithTitle: "test" width: 512 height: 384];
	[a setEventAgent: wa];
	[[a logger] logCategory: "Test" message: "foo"];
	SpriteResLoader *loader = [[SpriteResLoader alloc] initOn: a named: "foo"];
	SpriteImage shp;
	Sprite *s;
	int i = [a loader: loader loadResPPM: "spritecore.ppm" toImage: &shp];
	printf("%d %d\n",shp.cx,shp.cy);
	s = [[Sprite alloc] initOn: a shape: &shp frames: 1];
	[s moveTo: make_sc_vec2_fl(234,190)];
	[s setVel: make_sc_vec2_fl(1.0,1.0)];
	[a run];
	[a free];
	[loader free];
	return 0;
}

void resl_test_handler(SpriteEvent *e,SpriteApp *a)
{
	if(e->source_type == SPRITEEVENT_SOURCE_KEYBOARD &&
	   e->code   == XK_Escape) {
		[a quit];
	}
}
