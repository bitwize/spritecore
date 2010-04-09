#import <SpriteCore/SpriteLogger.h>
#include <stdio.h>

@interface StderrLogger <SpriteLogger>
-(void)logCategory: (char *)cat message: (char*)msg;

@end
