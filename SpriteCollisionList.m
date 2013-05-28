#include <SpriteCore/SpriteCore.h>

struct SpriteCollisionNode
{
	SCNode<HandlesCollisions> *spr;
	struct SpriteCollisionNode *next;
};

@implementation SpriteCollisionList
-init
{
	self = [super init];
	head = NULL;
	return self;
}
-(void)add: (SCNode <HandlesCollisions> *)s
{
	struct SpriteCollisionNode *n = head;
	head = (struct SpriteCollisionNode *)
		malloc(sizeof(struct SpriteCollisionNode));
	if(!head) {
		perror("cannot allocate collision node");
		exit(-1);
	}
	head->spr = s;
	head->next = n;
}
-(void)remove: (SCNode <HandlesCollisions> *)s
{
	struct SpriteCollisionNode *n;
	struct SpriteCollisionNode *n2;
	// are we empty? If so, bug out early.
	if(head == NULL) {
		return;
	}
	// Otherwise...
	n = head;
	if(n->spr == s) {
		head = n->next;
		free(n);
		return;
	}
	while((n2=n->next) != NULL) {
    
		if(n2->spr == s) {
			// remove the sprite, close up the hole, and 
			// free the SpriteCollisionNode
			n->next = n2->next;
			free(n2);
			return;
		}
		n = n2;
		n2 = n->next;
	}
}
-(void)removeAll
{
	struct SpriteCollisionNode *n;
	while(head != NULL) {
		n = head;
		head = n->next;
		free(n);
	}
}

-(void)handleCollisions
{
	struct SpriteCollisionNode *n1;
	struct SpriteCollisionNode *n2;
	for(n1 = head;n1 != NULL;n1 = n1->next) {
		for(n2 = head;n2 != NULL;n2 = n2->next) {
			if((n1->spr != n2->spr) &&
			   collision_check(n1->spr,n2->spr)) {
				[(n1->spr) collideWith: (n2->spr)];
			}
		}
	}
}

-(void)setCollisionChecker: (int (*)(SCNode *,SCNode *)) f
{
	collision_check = f;
}

-free
{
	[self removeAll];
	[super free];
}
@end
