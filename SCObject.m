#import <SpriteCore/SCObject.h>
#import <objc/runtime.h>
#include <stdlib.h>

@implementation SCObject

-(id)init
{
	return self;
}

-(id)free
{
	
	return object_dispose(self);
}

+(id)alloc
{
	return class_createInstance(self,0);
}

+(id)new
{
	return [[self alloc] init];
}

@end
