#include <stdlib.h>
#import <SpriteCore/StdlibRandomSource.h>

@implementation StdlibRandomSource
-init
{
	self = [super init];
	return self;
}
-free
{
	return [super free];
}
-(long)next
{
	return rand();
}
-(long)maxVal
{
	return RAND_MAX;
}
-(void)seed: (long)s
{
	srand(s);
}

@end
