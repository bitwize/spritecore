#import <SpriteCore/SpriteLogger.h>
#import <objc/Object.h>
#include <stdio.h>
#include <stdarg.h>


@interface StderrLogger  : Object <SpriteLogger>
{

}

-(id)init;
-(void)logCategory: (char *)cat message: (char*)msg,...;

@end
