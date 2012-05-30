/* -*- objc -*- */

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
#ifndef __SPRITENODE_H
#define __SPRITENODE_H

#import <SpriteCore/SpriteApp.h>

@interface SpriteNode : SCObject {
	SpriteNode *next;
	SpriteNode *prev;
	SpriteApp *host;
}
-(id)initOn: (SpriteApp *)h;
/*!
  Returns the next node after this one in the node list.
*/

-(SpriteNode *)next;

/*!
  Returns the previous node in the node list.
*/

-(SpriteNode *)prev;

/*!
  Returns the host SpriteApp of which this node is a client.
*/

-(SpriteApp *)host;

/*! Sets the next node in the list to the node t. Used only by SpriteApp
  methods to maintain the list. Don't use it yourself! */

-(SpriteNode *)setNext:(SpriteNode *)t;

/*! Sets the previous node in the list to the node t. Used only by
  SpriteApp methods to maintain the list. Don't use it yourself! */

-(SpriteNode *)setPrev:(SpriteNode *)t;

/*! Sets the host SpriteApp for this node to t. Used only by SpriteApp.
  Don't use it! */


-(SpriteApp *)setHost:(SpriteApp *)t;

/*! Instructs the node to move behind the node s. Of course it only sends
  -place:behind: to the node's host SpriteApp. */

-(void)goBehind: (SpriteNode *)s;

-(void)render;

-free;
-(void)step;

@end

#endif
