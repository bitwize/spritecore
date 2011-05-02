#ifndef __DEVURANDOMSOURCE_H
#define __DEVURANDOMSOURCE_H
#import <SpriteCore/SpriteRandomSource.h>
#import <objc/Object.h>

@interface DevUrandomSource : Object <SpriteRandomSource>
{
	int _durFd;
}

-init;
-free;
-(long)next;
-(long)maxVal;
-(void)seed: (long)s;

@end

#endif
