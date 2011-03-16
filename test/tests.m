#import <SpriteCore/SpriteCore.h>
#import <SpriteCore/SCUnitTest.h>

@interface SpriteCoreTestSuite : SCUnitTest
{
	SpriteApp *sa;
	SpriteImage *si;
}

-(void)setUp;
-(void)tearDown;
-(void)test;

-testSpriteApp;
-testSpritePos;
-testSpriteMotion;
-testReadPpm;
-testResLoader;

@end

@implementation SpriteCoreTestSuite

-(void)setUp
{
	sa = [[SpriteApp alloc] testInitWithTitle: "test"
					    width: 320
					   height: 200];
	si = NULL;
}

-(void)tearDown
{
	if(si != NULL)
	{
		[sa destroyImage: si];
	}
	[sa free];
	sa = nil;
}

-testSpriteApp
{
	SpriteImage *b = [sa background];
	SC_CHECK(b->cx == 320);
	SC_CHECK(b->cy == 200);
	return (id)1;
}

-testSpritePos
{
	Sprite *s = [[Sprite alloc] initOn: sa shape: NULL frames: 1];
	[s moveTo: make_sc_vec2_fl(50.0,70.0)];
	sc_vec2 p = [s pos];
	SC_CHECK(SC_FLOAT_EQ(p.x,50.0));
	SC_CHECK(SC_FLOAT_EQ(p.y,70.0));
	return (id)1;
}

-testSpriteMotion
{
	Sprite *s = [[Sprite alloc] initOn: sa shape: NULL frames: 1];
	[s setVel: make_sc_vec2_fl(5.0,7.0)];
	while([sa clock] <= 200)
	{
		[sa runOneFrame];
	}
	sc_vec2 p = [s pos];
	SC_CHECK(SC_FLOAT_EQ(p.x,50.0));
	SC_CHECK(SC_FLOAT_EQ(p.y,70.0));
	return (id)1;
}

-testReadPpm
{
	si = malloc(sizeof(SpriteImage));
	[sa loadPPMFile: "foo.res/spritecore.ppm" toImage: si];
	SC_CHECK(si->cx == 45);
	SC_CHECK(si->cy == 5);
	return (id)1;
}

-testResLoader
{
	SpriteResLoader *loader = [[SpriteResLoader alloc] initOn: sa named:
								   "foo"];
	si = malloc(sizeof(SpriteImage));
	[sa loader: loader loadResPPM: "spritecore.ppm" toImage: si];
	[loader free];
	SC_CHECK(si->cx == 45);
	SC_CHECK(si->cy == 5);
	return (id)1;
}

-testCreateImage
{
	si = 
}

-(void)test
{
	[self runTest: @selector(testSpriteApp)];
	[self runTest: @selector(testSpritePos)];
	[self runTest: @selector(testSpriteMotion)];
	[self runTest: @selector(testReadPpm)];
	[self runTest: @selector(testResLoader)];
}

@end

int main(void)
{
	SpriteCoreTestSuite *suite = [[SpriteCoreTestSuite alloc] init];
	[suite test];
	[suite free];
	return 0;
}
