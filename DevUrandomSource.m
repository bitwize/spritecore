#import <SpriteCore/DevUrandomSource.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>

@implementation DevUrandomSource

-init
{
	self = [super init];
	_durFd = open("/dev/urandom",O_RDONLY);
	if(_durFd < 0)
	{
		perror("cannot get random source from /dev/urandom: ");
		_exit(1);
	}
	return self;
}

-free
{
	close(_durFd);
	return [super free];
}
-(long)next
{
	long i;
	int r;
	do
	{
	} while((r=read(_durFd,&i,sizeof(long))) < sizeof(long));

	fprintf(stderr,"%d\n",i);
	i &= 0x7fffffffL;
	return i;
}

-(long)maxVal
{
	return (long)(0x7fffffffL);
}
-(void)seed: (long)s
{

}


@end
