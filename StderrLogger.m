/*
 *  Copyright 1995-2008 Jeffrey T. Read
 *
 * This file is part of SpriteCore.
 *
 * This software is provided 'as-is', without any express or implied
 * warranty.  In no event will the authors be held liable for any
 * damages arising from the use of this software.
 *
 * Permission is granted to anyone to use this software for any purpose,
 * including commercial applications, and to alter it and redistribute it
 * freely, subject to the following restrictions:
 *
 * 1. The origin of this software must not be misrepresented; you must not
 *    claim that you wrote the original software. If you use this software
 *    in a product, an acknowledgment in the product documentation would be
 *    appreciated but is not required.
 * 2. Altered source versions must be plainly marked as such, and must not be
 *    misrepresented as being the original software.
 * 3. This notice may not be removed or altered from any source distribution.
 *
 */

#import <StderrLogger.h>
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
	[self varargsLogCategory: cat message: msg rest: l];
	va_end(l);
}
-(void)varargsLogCategory: (char *)cat message: (char *)msg rest: (va_list)rest
{
	fprintf(stderr,"%s: ",cat);
	vfprintf(stderr,msg,rest);
	fprintf(stderr,"\n");
	fflush(stderr);
}

@end
