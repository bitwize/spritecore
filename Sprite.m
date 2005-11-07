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
#include <stdlib.h>
#import "Sprite.h"

svec2 make_svec2(float x,float y) {
  svec2 v;
  v.x = x;
  v.y = y;
  return v;
}

@implementation Sprite
-(id)initOn: (SpriteApp *)h
      shape: (SpriteImage *)si
     frames: (unsigned int)mf
{
  self = [super init];
  host = h;
  simg = si;
  maxframes = mf;
  frame = 0;
  next=nil; prev=nil;
  pos.x = 0; pos.y = 0; vel.x = 0; vel.y = 0;
  hotspot.x = 0; hotspot.y = 0;
  [h add: self];
  [self setShape: si frames: mf];
  agent = nil;
  oldtime = [h clock];
  return self;
}

-(Sprite *)next {
return next;
}

-(Sprite *)prev {
return prev;
}

-(SpriteApp *)host {
return host;
}

-(Sprite *)setNext:(Sprite *)t {
next=t; return t;
}

-(Sprite *)setPrev:(Sprite *)t {
prev=t; return t;
}

-(SpriteApp *)setHost:(SpriteApp *)t {
host=t; return t;
}

-(void)goBehind: (Sprite *)s {
  [host place: self behind: s];
}

-(SpriteImage *)setShape: (SpriteImage *)sh frames: (unsigned int)f {
  simg = sh;
  maxframes = f;
  if(simg != NULL) {
    width = simg->cx;
    height = simg->cy / f;
  }
  else {width=0; height=0;}
  key = get_key(sh);
  return sh;
}

-(SpriteImage *)setShape: (SpriteImage *)sh {
  return [self setShape: sh frames: 1];
}

-(SpriteImage *)shape {
  return simg;
}

- (unsigned int)frame {
  return frame;
}

- (void)setFrame: (unsigned int)f {
  frame = f % maxframes;
}

-(void)step {
  unsigned int nt = [host clock];
  unsigned int t = nt - oldtime;
  float nj = (float)t / 20.0;
  pos.x += vel.x * nj;
  pos.y += vel.y * nj;
  if(agent != nil && [agent respondsTo: @selector(step)]) {
    [agent step];
  }
  oldtime = nt;
}

-(void)renderOn: (SpriteImage *)si {
  if(simg != NULL) {
    if(maxframes < 2) {
      ImageCopy(simg,si,0,0,pos.x-hotspot.x,pos.y-hotspot.y,
		width,height,SIMG_USE_KEY,key);
    }
    else {
      ImageCopy(simg,si,0,height * frame,pos.x-hotspot.x,pos.y-hotspot.y
		,width,height,SIMG_USE_KEY,key);
    }
  }
}

-(void)moveTo: (svec2)p {
  pos = p;
}

-(void)setVel: (svec2)v {
  vel = v;
}
-(void)setHotspot: (svec2)h {
  hotspot = h;
}

-(svec2)pos {
  return pos;
}

-(svec2)vel {
  return vel;
}

-(svec2)hotspot {
  return hotspot;
}

-(unsigned int)width {return width;}
-(unsigned int)height {return height;}
-(svec2)size {return make_svec2(width,height);}

-(id)agent {return agent;}
-(void)setAgent: (id)a {agent = a;}

-(int)isTouching: (Sprite *)s {
  int step1,step2; //Intermediate x and y proximity values.
  svec2 pos2 = [s pos];
  svec2 hotspot2 = [s hotspot];
  int x1 = pos.x - hotspot.x;
  int y1 = pos.y - hotspot.y;
  int x2 = pos2.x - hotspot2.x;
  int y2 = pos2.y - hotspot2.y;
  //Step 1: Check for horizontal proximity.
  if(x1 <= x2) {
    if(x2 - x1 < width) step1 = 1; else step1 = 0;
  }
  else {
    if(x2 + [s width] > x1) step1 = 1; else step1 = 0;
  }
  //Step 2: Check for vertical proximity.
  if(y1 <= y2) {
    if(y2 - y1 < height) step2 = 1; else step2 = 0;
  }
  else {
    if(y2 + [s height] > y1) step2 = 1; else step2 = 0;
  }
  //Return true if we are overlapping horizontally AND vertically.
  return(step1 && step2);
}

@end
