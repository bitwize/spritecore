/* -*- objc -*- */
#ifndef __XKCDRANDOMSOURCE_H
#define __XKCDRANDOMSOURCE_H
#import <SpriteCore/SpriteRandomSource.h>
#import <SpriteCore/SCObject.h>

@interface XKCDRandomSource : SCObject <SpriteRandomSource>
{
	
}

-init;
-free;
-(long)next;
-(long)maxVal;
-(void)seed: (long)s;

@end

#endif
