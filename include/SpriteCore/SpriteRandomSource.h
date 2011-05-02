#ifndef __SPRITERANDOMSOURCE_H
#define __SPRITERANDOMSOURCE_H
@protocol SpriteRandomSource
-(long)next;
-(long)maxVal;
-(void)seed: (long)s;
@end
#endif
