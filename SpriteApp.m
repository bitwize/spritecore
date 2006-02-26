/*
*  Copyright 1995-2005 Jeffrey T. Read
*
*  This file is part of SpriteCore.
*
*  SpriteCore is free software; you can redistribute it and/or modify
*  it under the terms of the GNU General Public License as published by
*  the Free Software Foundation; either version 2 of the License, or
*  (at your option) any later version.
*
*  SpriteCore is distributed in the hope that it will be useful,
*  but WITHOUT ANY WARRANTY; without even the implied warranty of
*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*  GNU General Public License for more details.
*
*  You should have received a copy of the GNU General Public License
*  along with SpriteCore; if not, write to the Free Software
*  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
*/
#import "SpriteApp.h"
#import "Sprite.h"

@implementation SpriteApp
-(id)initWithTitle: (char *)t width: (unsigned int)w height: (unsigned int)h {
  self = [super init];
  first = nil; deleted = nil;
  title = t; width = w; height = h;
  io_del = createIODelegate(self,w,h,t);
  return self;
  clock = [io_del getTimeMillis];
  oldclock = 0;
}

-(Sprite *)first {
return first;
}

-(Sprite *)last {
Sprite *i,*j;
i = first;
if(i == nil) {return i;}
while((j=[i next]) != nil) {
  i = j;
}
return i;

}

-(Sprite *)add: (Sprite *)newone {
Sprite *r = [self last];
if(r == nil) {
  first = newone;
  [newone setPrev: nil];
  [newone setNext: nil];
  [newone setHost: self];
  return newone;
}
else {
  [r setNext: newone];
  [newone setPrev: r];
  [newone setNext: nil];
  [newone setHost: self];
  return newone;
}

}

-(Sprite *)remove: (Sprite *)oldone {
Sprite *n,*p;
if([oldone host] != self) {
  return nil;
}
n = [oldone next];
p = [oldone prev];
if(n != nil) {
  [n setPrev: p];
}
if(p != nil) {
  [p setNext: n];
} else {
  first = n;
}
return oldone;

}

-(Sprite *)delete: (Sprite *)oldone {
[self remove: oldone]; [self addDeleted: oldone]; return oldone;
}

-(Sprite *)place: (Sprite *) aSprite behind: (Sprite *)anotherSprite {
  Sprite *b;
  [self remove: aSprite];
  if(anotherSprite == nil) {
    [self add: aSprite];
  }
  else {
    b = [anotherSprite prev];
    [aSprite setPrev: b];
    if(b == nil) {
      first = aSprite;
    }
    else {
      [b setNext: aSprite];
    }
    [aSprite setNext: anotherSprite];
    [anotherSprite setPrev: aSprite];
  }
  return aSprite;
}

-(Sprite *)addDeleted: (Sprite *)newone {
[newone setPrev: nil]; [newone setNext: deleted]; deleted=newone; return newone;
}

-(void)freeClients {
  Sprite *i,*j;
  i = first;
  while(i != nil) {
    j=[i next];
    [i free];
    i=j;
  }
  first=nil;
  
}


-(void)freeDeleted {
  Sprite *i,*j;
  i = deleted;
  while(i != nil) {
    j=[i next];
    [i free];
    i=j;
  }
  deleted=nil;
  
}

-(void)step {
  Sprite *i,*j;
  i = first;
  [io_del dispatchEvents];
  [io_del lockAndClearBuf];
  oldclock = clock;
  clock = [io_del getTimeMillis];
  
  while(i != nil) {
    j=[i next];
    [i step];
    [i renderOn: (SpriteImage *)[io_del bufImage]];
    i=j;
  }
  [self freeDeleted];
  [io_del unlockBuf];

  [io_del refreshScreen];
}

-(void)keyDown: (int)aKey {}
-(void)keyUp: (int)aKey {}
-(void)mouseMoveX: (int)x Y: (int)y {}


-free {
  [self freeClients];
  [io_del free];
  return [super free];
}

-(int)loadPPMFile: (char *)fn toImage: (SpriteImage *)si {
  return [io_del loadPPMFile: fn toImage: si];
}

-(void)destroyImage: (SpriteImage *)si {
  [io_del destroyImage: si];
}

-(unsigned int)clock {
  return clock;
}

-(unsigned int)lastFrameTime {
  return clock - oldclock;
}
@end
