/* -*- objc -*- */

#ifndef __SPRITECOLLISIONNODE_H
#define __SPRITECOLLISIONNODE_H
#import <SpriteNode.h>

/*
 * The SpriteCollisionList class represents a list of sprites which
 * are candidates for mutual collision detection.
 * These lists are maintained separately from the main sprite list.
 */
struct SpriteCollisionNode;

@protocol HandlesCollisions
-(void)collideWith: (SpriteNode *)s;
@end

@interface SpriteCollisionList : Object
{
	struct SpriteCollisionNode *head;
	int (*collision_check)(SpriteNode *,SpriteNode *);
}

-(void)add: (SpriteNode <HandlesCollisions> *)s;
-(void)remove: (SpriteNode <HandlesCollisions> *)s;
-(void)removeAll;
-(void)handleCollisions;
-(void)setCollisionChecker: (int (*)(SpriteNode *,SpriteNode *)) f;

@end

#endif
