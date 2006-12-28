#include <SpriteCore/SpriteCore.h>
#include <unistd.h>

@interface LoaderTestApp : SpriteApp
-keyDown: (int)aKey;
@end

@implementation LoaderTestApp 
-keyDown: (int)aKey { if(aKey == SC_Key_Escape) [self quit];}
@end

int main(void) {
  LoaderTestApp *a = [[LoaderTestApp alloc] initWithTitle: "test" width: 512 height: 384];
  SpriteResLoader *loader = [[SpriteResLoader alloc] initOn: a named: "foo"];
  SpriteImage shp;
  Sprite *s;
  int i = [a loader: loader loadResPPM: "spritecore.ppm" toImage: &shp];
  printf("%d %d\n",shp.cx,shp.cy);
  s = [[Sprite alloc] initOn: a shape: &shp frames: 1];
  [s moveTo: make_svec2(234,190)];
  [a run];
  [a free];
  [loader free];
  return 0;
}
