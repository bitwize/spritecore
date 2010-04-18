#import <SpriteCore/StderrLogger.h>
#include <stdio.h>

@implementation StderrLogger 
-(id)init
{
	self = [super init];
	return self;
}

-(void)logCategory: (char *)cat message: (char*)msg,...
{
	va_list l;
	va_start(l,msg);
	fprintf(stderr,"%s: ",cat);
	vfprintf(stderr,msg,l);
	fprintf(stderr,"\n");
	va_end(l);
}

@end
