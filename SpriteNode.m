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
