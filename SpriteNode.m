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

#import <SpriteCore/SpriteNode.h>

@implementation SpriteNode
-(id)initOn: (SpriteApp *)h {
	self = [super init];
	[h add: self];
	return self;
}
-(SpriteNode *)next {
	return next;
}

-(SpriteNode *)prev {
	return prev;
}

-(SpriteApp *)host {
	return host;
}

-(SpriteNode *)setNext:(SpriteNode *)t {
	next=t; return t;
}

-(SpriteNode *)setPrev:(SpriteNode *)t {
	prev=t; return t;
}

-(SpriteApp *)setHost:(SpriteApp *)t {
	host=t; return t;
}

-(void)goBehind: (SpriteNode *)s {
	[host place: self behind: s];
}

-(void)step {
}
-(void)render {
}

-free {
	return [super free];
}

@end
