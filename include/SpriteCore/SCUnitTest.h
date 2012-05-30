/* -*- objc -*- */
#include <SpriteCore/SCObject.h>

#define SC_FLOAT_EQ(f1,f2) ((f2 - f1) < 0.001 && (f2 - f1) > -0.001)

#define SC_CHECK(condition) if(!(condition)) {return (id)0;}

@interface SCUnitTest : Object
{
	
}

-(BOOL)runTest: (SEL)aSel;
-(void)setUp;
-(void)tearDown;
-(void)pass: (SEL)aSel;
-(void)fail: (SEL)aSel;
-(void)test;
@end
