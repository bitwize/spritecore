#include <SpriteCore/SCUnitTest.h>
#include <objc/runtime.h>
#include <stdio.h>

@implementation SCUnitTest

-(void)setUp
{

}

-(void)tearDown
{

}

-(BOOL)runTest: (SEL)aSel
{
	BOOL b;
	BOOL (*impl)() = (BOOL (*)())(class_getMethodImplementation([self class],aSel));

	[self setUp];
	b = (impl() != 0);
	[self tearDown];

	if(b)
		[self pass: aSel];
	else
		[self fail: aSel];

	return b;
}

-(void)pass: (SEL)aSel
{
	printf("%s passed\n",sel_getName(aSel));
}

-(void)fail: (SEL)aSel
{
	printf("%s failed\n",sel_getName(aSel));
}

-(void)test
{

}
@end
