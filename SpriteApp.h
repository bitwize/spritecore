/* -*- objc -*- */

/*
 *  Copyright 1995-2008 Jeffrey T. Read
 *
 * This file is part of SpriteCore.
 *
 * This software is provided 'as-is', without any express or implied
 * warranty.  In no event will the authors be held liable for any
 * damages arising from the use of this software.
 *
 * Permission is granted to anyone to use this software for any purpose,
 * including commercial applications, and to alter it and redistribute it
 * freely, subject to the following restrictions:
 *
 * 1. The origin of this software must not be misrepresented; you must not
 *    claim that you wrote the original software. If you use this software
 *    in a product, an acknowledgment in the product documentation would be
 *    appreciated but is not required.
 * 2. Altered source versions must be plainly marked as such, and must not be
 *    misrepresented as being the original software.
 * 3. This notice may not be removed or altered from any source distribution.
 *
 */
/*!
  @header
  @copyright 2005 Jeffrey T. Read
*/

#ifndef __SPRITEAPP_H
#define __SPRITEAPP_H

#import <objc/Object.h>
#import <spriteimage.h>
#import <spriteevent.h>
#import <SpriteAgent.h>
#import <DefaultAgents.h>
#import <SpriteLogger.h>
@class SpriteNode;
@class SpriteResLoader;
#import <SpriteIODelegate.h>

/*!
  @class SpriteApp
  The SpriteApp class represents a SpriteCore application. It provides a
  standard interface to the display and input devices of the particular
  windowing or graphical system used by SpriteCore. Interfacing with these
  devices is handled at a lower level by an IO delegate. SpriteApps also manage
  Sprites, moving them and rendering them on a back-buffer which is then
  written to the screen in a conventional double-buffer setup.
*/

@interface SpriteApp : Object {
	SpriteNode *first;
	SpriteNode *deleted;
	char *title;
	unsigned int width,height;
	unsigned int clock;
	unsigned int oldclock;
	SpriteImage back,buf;
	id <SpriteIODelegate> io_del;
	id <SpriteEventAgent> eagent;
	Object <SpriteLogger> *logger;
	char *res_path;
	int quitting;
	
}

/*!

  @method initWithTitle:width:height:

  Initializes the SpriteApp and creates a display surface for it of
  size (w,h) with window title t and IO delegate del. In a window
  system, creates a window for the SpriteApp.

*/


-(id)initWithTitle: (char *)t
	     width: (unsigned int)w
	    height: (unsigned int)h
	ioDelegate: (id <SpriteIODelegate>) del;


/*!
  @method initWithTitle:width:height:
  Initializes the SpriteApp and creates a display surface for it of size
  (w,h) with window title t. In a window system, creates a window for the
  SpriteApp.
*/

-(id)initWithTitle: (char *)t width: (unsigned int)w height: (unsigned int)h;

/*!
  @method testInitWithTitle:width:height:
  Initializes the SpriteApp for testing and creates a display surface for it
  of size (w,h) with window title t. Does not actually create a window,
  as this is a testing app.
*/

-(id)testInitWithTitle: (char *)t
		 width: (unsigned int)w
		height: (unsigned int)h;

/*!
  @method first
  Returns the SpriteApp's first sprite.
*/

-(SpriteNode *)first;

/*!
  @method last
  Returns the SpriteApp's last sprite.
*/

-(SpriteNode *)last;

/*!
  @method add:
  Adds a sprite, newone, to the sprite list, and returns it.
*/

-(SpriteNode *)add: (SpriteNode *)newone;

/*!
  @method remove:
  Removes a sprite, oldone, from the sprite list, and returns it.
*/

-(SpriteNode *)remove: (SpriteNode *)oldone;

/*!
  @method delete:
  Removes a sprite, oldone, from the sprite list, and adds it to the deleted
  list. Returns the sprite.
*/

-(SpriteNode *)delete: (SpriteNode *)oldone;

/*!
  @method place:behind:
  Removes a sprite, aSprite, from the sprite list, and reinserts it behind
  anotherSprite. List order implies Z order. If anotherSprite is nil, adds the
  sprite to the end of the list, making it drawn last.

  Returns aSprite.
*/

-(SpriteNode *)place: (SpriteNode *)aSprite behind: (SpriteNode *)anotherSprite;

/*!
  @method addDeleted:
  Adds a sprite, newone, to the list of sprites to be deleted. Sprites are
  deleted on every frame update if there are any in the list.
*/


-(SpriteNode *)addDeleted: (SpriteNode *)newone;

/*!
  @method freeDeleted
  Frees all sprites in the deleted list. Called once per frame update.
*/

-(void)freeDeleted;

/*!
  @method freeClients
  Frees all sprites in the sprite list.
*/

-(void)freeClients;

/*!
  @method free
  Deallocates memory associated with this SpriteApp.
*/

-free;

/*!
  @method step
  Frame update function. Draws background, moves and renders sprites onto
  backbuffer, checks for and handles pending events. Should be called in a
  loop.
*/

-(void)step;

-(void)updateDisplay;

-(void)handleEvent: (SpriteEvent *)evt;

-(id <SpriteEventAgent>) eventAgent;

-(void) setEventAgent: (id <SpriteEventAgent>) ea;

-(SpriteImage *)background;
-(SpriteImage *)surface;
/*!
  Loads a PPM file for use in this SpriteApp (or sprites associated with it).
  Fills the SpriteImage struct pointed to by si with an image from the
  PPM/PNM file whose name is in fn.
*/

-(int)loadPPMFile: (char *)fn toImage: (SpriteImage *)si;

-(SpriteImage *)createImageWidth: (unsigned int) w
			  height: (unsigned int) h
			   depth: (unsigned int) d
		       useHWSurf: (BOOL) s;

/*!
  Releases resources associated with the SpriteImage structure si, which
  should have been created with -loadPPMFile:toImage:, or another method which
  creates SpriteImages. Does not release the structure itself.
*/

-(void)destroyImage: (SpriteImage *)si;
-(void)freeImage: (SpriteImage *)si;

/*!
  Returns the number of milliseconds between the application start and the
  last frame update. This value is updated by -step once per frame update.
*/

-(unsigned int)clock;

-(void)clockSync;

/*!
  Returns the number of milliseconds between the last frame update and the
  one before that. It is used internally by Sprite's -step to calculate
  the total distance to move by.
*/

-(unsigned int)lastFrameTime;
-(char *)resourcePath;
-(void)setResourcePath: (char *)aPath;
-(int)loader: (SpriteResLoader *)aLoader loadResPPM: (char *)aResName 
     toImage: (SpriteImage *)si;
-(void)logCategory: (char *)cat message: (char *) msg,...;

-(void)quit;
-(void)runOneFrame;
-(void)run;


@end

/*!
  Creates a standard IO delegate for a SpriteApp. The actual object that's
  created depends on the windowing or graphics subsystem SpriteCore is built
  for; however, it must conform to the SpriteIODelegate protocol.
*/

extern id createIODelegate(SpriteApp *ha,unsigned int w,unsigned int h,char *t);

#endif
