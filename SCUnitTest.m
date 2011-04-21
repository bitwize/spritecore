#include <SpriteCore/SCUnitTest.h>
#include <objc/objc-api.h>

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

	[self setUp];
	b = ([self perform: aSel] != 0);
	[self tearDown];

	if(b)
		[self pass: aSel];
	else
		[self fail: aSel];

	return b;
}

-(void)pass: (SEL)aSel
{
	printf("%s passed\n",sel_get_name(aSel));
}

-(void)fail: (SEL)aSel
{
	printf("%s failed\n",sel_get_name(aSel));
}

-(void)test
{

}
@end
