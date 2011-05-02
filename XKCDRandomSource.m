#import <SpriteCore/XKCDRandomSource.h>

@implementation XKCDRandomSource

-init
{
	return (self = [super init]);
}
-free
{
	return [super free];
}

-(long) next
{
	return 4; // guaranteed to be random
}

-(long) maxVal
{
	return 0x7fffffffL;
}

-(void)seed: (long)s
{
	
}

@end
