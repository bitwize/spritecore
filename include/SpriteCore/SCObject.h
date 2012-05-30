#ifndef __SCOBJECT_H
#define __SCOBJECT_H

#import <objc/Object.h>

@interface SCObject : Object
-(id)init;
-(id)free;

+(id)alloc;
+(id)new;
@end

#endif
