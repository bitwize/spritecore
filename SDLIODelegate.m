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
#import "SDLIODelegate.h"
#import "svppm.h"

#define IMAGE(x) ((SDL_Surface *)x)
int sdl_inited = 0;


int SC_SpecialKeyMap[] = {
  SDLK_F1,SC_Key_F1,
  SDLK_F2,SC_Key_F2,
  SDLK_F3,SC_Key_F3,
  SDLK_F4,SC_Key_F4,
  SDLK_F5,SC_Key_F5,
  SDLK_F6,SC_Key_F6,
  SDLK_F7,SC_Key_F7,
  SDLK_F8,SC_Key_F8,
  SDLK_F9,SC_Key_F9,
  SDLK_F10,SC_Key_F10,
  SDLK_F11,SC_Key_F11,
  SDLK_F12,SC_Key_F12,
  SDLK_UP,SC_Key_Up,
  SDLK_DOWN,SC_Key_Down,
  SDLK_LEFT,SC_Key_Left,
  SDLK_RIGHT,SC_Key_Right,
  SDLK_PAGEUP,SC_Key_PgUp,
  SDLK_PAGEDOWN,SC_Key_PgDn,
  SDLK_HOME,SC_Key_Home,
  SDLK_END,SC_Key_End,
  SDLK_INSERT,SC_Key_Ins,
  SDLK_DELETE,SC_Key_Del,
  SDLK_LSHIFT,SC_Key_Shift,
  SDLK_LCTRL,SC_Key_Ctrl,
  SDLK_LALT,SC_Key_Alt,
  SDLK_LMETA,SC_Key_Meta,
  SDLK_RSHIFT,SC_Key_Shift,
  SDLK_RCTRL,SC_Key_Ctrl,
  SDLK_RALT,SC_Key_Alt,
  SDLK_RMETA,SC_Key_Meta,
  0,0
};


void BuildSI(SpriteImage *si) {
  si->cx = IMAGE(si->img)->w;
  si->cy = IMAGE(si->img)->h;
  si->depth = IMAGE(si->img)->format->BitsPerPixel;
  si->scan_length = IMAGE(si->img)->pitch;
  si->endian = (SDL_BYTEORDER == SDL_LIL_ENDIAN ? SIMG_LITTLE_ENDIAN : SIMG_BIG_ENDIAN);
  si->bits = IMAGE(si->img)->pixels;
  si->auto_free = 0;
}

@implementation SDLIODelegate

- (SDLIODelegate *)initForHost: (SpriteApp *)ha
			 width: (unsigned int)w
			height: (unsigned int)h 
			 title: (char *)t {
  self = [super init];
  unsigned int dep = 32;
  host = ha;
  if(!sdl_inited) {
    SDL_Init(SDL_INIT_VIDEO | SDL_INIT_TIMER);
    sdl_inited=1;
  }
  screen = SDL_SetVideoMode(w,h,dep,SDL_DOUBLEBUF);
  SDL_WM_SetCaption(t,"");
  if(!screen) {
    fprintf(stderr,"can't init SDL\n");
    exit(1);
  }
  back.img = SDL_CreateRGBSurface(SDL_SWSURFACE,w,h,dep,
			       screen->format->Rmask,
			       screen->format->Gmask,
			       screen->format->Bmask,
			       screen->format->Amask);
  buf.img = screen;
  BuildSI(&back);
  BuildSI(&buf);
  SDL_EventState(SDL_KEYDOWN,SDL_ENABLE);
  SDL_EventState(SDL_KEYUP,SDL_ENABLE);
  SDL_EventState(SDL_MOUSEBUTTONDOWN,SDL_ENABLE);
  SDL_EventState(SDL_MOUSEBUTTONUP,SDL_ENABLE);
  SDL_EventState(SDL_MOUSEMOTION,SDL_ENABLE);
  SDL_EnableKeyRepeat(0,0);
  
  return self;

}

- (SpriteImage *)backImage {return &back;}
- (SpriteImage *)bufImage {return &buf;}
- (void)refreshScreen {SDL_Flip(IMAGE(buf.img));}
- (int)loadPPMFile: (char *)fn toImage: (SpriteImage *)si {
  int i;
  int _cx,_cy;
  unsigned char *ptr;

  ReadPpmRgbConverted(fn,&_cx,&_cy,&ptr,32);
  IMAGE(si->img) = SDL_CreateRGBSurfaceFrom(ptr,_cx,_cy,32,_cx * 4,0xff0000,0x00ff00,0x0000ff,0x0);
  si->cx = IMAGE(si->img)->w;
  si->cy = IMAGE(si->img)->h;
  si->depth = IMAGE(si->img)->format->BitsPerPixel;
  si->scan_length = IMAGE(si->img)->pitch;
  si->endian = (SDL_BYTEORDER == SDL_LIL_ENDIAN ? SIMG_LITTLE_ENDIAN : SIMG_BIG_ENDIAN);
  si->bits = IMAGE(si->img)->pixels;
  si->auto_free = 1;
  return i;

}

-(void)destroyImage: (SpriteImage *)si {
  SDL_FreeSurface(IMAGE(si->img));

}

-(id)dispatchEvents {
  SDL_Event evt;
  int code;
  int ks;
  int i;
  while(SDL_PollEvent(&evt)) {
    switch(evt.type) {
    case SDL_KEYDOWN:
    case SDL_KEYUP:
      ks = (evt.key.keysym).sym;
      if(ks >= 0x01 && ks <= 0x7f) {
	code = ks;
      }
      else {
	for(i=0;SC_SpecialKeyMap[i] != 0;i += 2) {
	  if(ks == SC_SpecialKeyMap[i]) {
	    code = SC_SpecialKeyMap[i + 1];
	  }
	}
      }
      if ((evt.type) == SDL_KEYUP) {[host keyUp: code];} else
	{[host keyDown: code];}
      break;
    case SDL_MOUSEMOTION:
      [host mouseMoveX: evt.motion.x Y: evt.motion.y];
      break;
    case SDL_MOUSEBUTTONDOWN:
      [host keyDown: (evt.button.button - 1 + SC_Key_Button1)];
      break;
    case SDL_MOUSEBUTTONUP:
      [host keyUp: (evt.button.button - 1 + SC_Key_Button1)];
      break;
    }
  }
}

-(void)lockBuf {
  SDL_LockSurface(IMAGE(buf.img));
}
-(void)lockAndClearBuf {
  [self lockBuf];
  ImageCopy(&back,&buf,0,0,0,0,back.cx,back.cy,0,0);
}

-(void)unlockBuf {
  SDL_UnlockSurface(IMAGE(buf.img));
}

-(unsigned int)getTimeMillis {
  return SDL_GetTicks();
}

@end

id createIODelegate(SpriteApp *ha,unsigned int w,unsigned int h,char *t) {
  return [[SDLIODelegate alloc] initForHost: ha width: w height: h title: t];
}
