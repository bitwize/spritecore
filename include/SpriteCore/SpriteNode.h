#ifndef __SPRITENODE_H
#define __SPRITENODE_H

#import <SpriteCore/SpriteApp.h>

@interface SpriteNode : Object {
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
