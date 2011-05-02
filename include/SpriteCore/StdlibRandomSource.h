#ifndef __STDLIBRANDOMSOURCE_H
#define __STDLIBRANDOMSOURCE_H

#import <SpriteCore/SpriteRandomSource.h>
#import <objc/Object.h>

@interface StdlibRandomSource : Object <SpriteRandomSource>
{

}

-init;
-free;
-(long)next;
-(long)maxVal;
-(void)seed: (long)s;

@end
#endif
