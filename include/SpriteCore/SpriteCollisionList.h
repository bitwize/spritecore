/* -*- objc -*- */

#ifndef __SPRITECOLLISIONNODE_H
#define __SPRITECOLLISIONNODE_H
#import <SpriteCore/SCNode.h>

/*
 * The SpriteCollisionList class represents a list of sprites which
 * are candidates for mutual collision detection.
 * These lists are maintained separately from the main sprite list.
 */
struct SpriteCollisionNode;

@protocol HandlesCollisions
-(void)collideWith: (SCNode *)s;
@end

@interface SpriteCollisionList : SCObject
{
	struct SpriteCollisionNode *head;
	int (*collision_check)(SCNode *,SCNode *);
}

-(void)add: (SCNode <HandlesCollisions> *)s;
-(void)remove: (SCNode <HandlesCollisions> *)s;
-(void)removeAll;
-(void)handleCollisions;
-(void)setCollisionChecker: (int (*)(SCNode *,SCNode *)) f;

@end

#endif
