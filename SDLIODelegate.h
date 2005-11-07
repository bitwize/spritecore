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
#include <SDL/SDL.h>
#import "SpriteApp.h"

@interface SDLIODelegate : Object {
  SpriteApp *host;
  SpriteImage back;
  SpriteImage buf;
  SDL_Surface *screen;
}

- (SDLIODelegate *)initForHost: (SpriteApp *)ha
			 width: (unsigned int)w 
			height: (unsigned int)h
			 title: (char *)t;
- (SpriteImage *)backImage;
- (SpriteImage *)bufImage;
- (void)refreshScreen;
- (int)loadPPMFile: (char *)fn toImage: (SpriteImage *)si;
- (void)destroyImage: (SpriteImage *)si;
-(void)lockBuf;
-(void)lockAndClearBuf;
-(void)unlockBuf;
-(id)dispatchEvents;
-(unsigned int)getTimeMillis;

@end
