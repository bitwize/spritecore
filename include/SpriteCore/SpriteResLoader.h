#ifndef __SPRITERESLOADER_H
#define __SPRITERESLOADER_H
#import <SpriteCore/SpriteApp.h>
@interface SpriteResLoader : Object
{
  char *name;
  SpriteApp *parent;
}

-initOn: (SpriteApp *)anApp named: (char *)aName;
-free;
-(unsigned int)fetchResource: (char *)aResName to: (void **)aPtr;
@end
#endif
