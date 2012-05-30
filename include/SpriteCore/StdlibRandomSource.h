#ifndef __STDLIBRANDOMSOURCE_H
#define __STDLIBRANDOMSOURCE_H

#import <SpriteCore/SpriteRandomSource.h>
#import <SpriteCore/SCObject.h>

@interface StdlibRandomSource : SCObject <SpriteRandomSource>
{

}

-init;
-free;
-(long)next;
-(long)maxVal;
-(void)seed: (long)s;

@end
#endif
