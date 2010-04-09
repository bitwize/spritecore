#import <SpriteCore/SpriteLogger.h>
#include <stdio.h>
@implementation StderrLogger <SpriteLogger>
-(void)logCategory: (char *)cat message: (char*)msg
{
	fprintf(stderr,"%s: %s",cat,message);
}

@end
