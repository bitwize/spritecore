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
/*!
  @header
  @copyright 2005 Jeffrey T. Read
*/

#import <objc/Object.h>
#import "spriteimage.h"

#define SC_Key_F1 0x101
#define SC_Key_F2 0x102
#define SC_Key_F3 0x103
#define SC_Key_F4 0x104
#define SC_Key_F5 0x105
#define SC_Key_F6 0x106
#define SC_Key_F7 0x107
#define SC_Key_F8 0x108
#define SC_Key_F9 0x109
#define SC_Key_F10 0x10a
#define SC_Key_F11 0x10b
#define SC_Key_F12 0x10c
#define SC_Key_Up 0x120
#define SC_Key_Down 0x121
#define SC_Key_Left 0x122
#define SC_Key_Right 0x123
#define SC_Key_Home 0x124
#define SC_Key_End 0x125
#define SC_Key_PgUp 0x126
#define SC_Key_PgDn 0x127
#define SC_Key_Ins 0x128
#define SC_Key_Del 0x129

#define SC_Key_BS 0x08
#define SC_Key_Tab 0x09
#define SC_Key_Enter 0x0d
#define SC_Key_Newline 0x0a
#define SC_Key_Escape 0x1b

#define SC_Key_Button1 0x1000
#define SC_Key_Button2 0x1001
#define SC_Key_Button3 0x1002
#define SC_Key_Button4 0x1003
#define SC_Key_WheelUp 0x1003
#define SC_Key_Button5 0x1004
#define SC_Key_WheelDown 0x1004
#define SC_Key_Button6 0x1005
#define SC_Key_Button7 0x1006
#define SC_Key_Button8 0x1007

#define SC_Key_GameBtn1 0x3000
#define SC_Key_GameBtn2 0x3001
#define SC_Key_GameBtn3 0x3002
#define SC_Key_GameBtn4 0x3003
#define SC_Key_GameBtn5 0x3004
#define SC_Key_GameBtn6 0x3005
#define SC_Key_GameBtn7 0x3006
#define SC_Key_GameBtn8 0x3007
#define SC_Key_GameBtn9 0x3008
#define SC_Key_GameBtn10 0x3009
#define SC_Key_GameBtn11 0x300a
#define SC_Key_GameBtn12 0x300b
#define SC_Key_GameBtn13 0x300c
#define SC_Key_GameBtn14 0x300d
#define SC_Key_GameBtn15 0x300e
#define SC_Key_GameBtn16 0x300f

#define SC_Key_Shift 0x2000
#define SC_Key_Ctrl  0x2001
#define SC_Key_Alt   0x2002
#define SC_Key_Meta  0x2003
#define SC_Key_Feature 0x2003

@class Sprite;

/*!
  @protocol IODelegate
  The IODelegate protocol implements a lower level interface to the underlying
  graphics or window system. It is used by SpriteApp to set up the back buffer,
  handle writing to the graphics screen, and handle keyboard, mouse, and other
  user input events. An IODelegate object can be written for a subsystem
  (SDL, X11, Win32, etc.) and then linked with the library at build time; a
  sample IODelegate for SDL (http://www.libsdl.org) is included with the
  library.
*/

@protocol IODelegate

/*!
  Returns the image used as a background (used to clear the back buffer after
  each frame).
*/
- (SpriteImage *)backImage;

/*!
  Returns the image used as a back buffer. Sprites render themselves onto this
  image and then it is displayed on the screen on each frame update.
*/

- (SpriteImage *)bufImage;

/*!
  Write back buffer image to screen.
*/
- (void)refreshScreen;

/*!
  Loads a PPM file given by filename fn; converts it into a SpriteImage
  suitable for rendering on the back buffer, and stores the data in the
  structure pointed to by si.
*/

-(int)loadPPMFile: (char *)fn toImage: (SpriteImage *)si;

/*!
  Destroys the data associated with the SpriteImage si. Does not free the
  structure itself.
*/

-(void)destroyImage: (SpriteImage *)si;

/*!
  Locks the backbuffer image so that it may be drawn upon.
*/

-(void)lockBuf;

/*!
  Locks the backbuffer image so that it may be drawn upon, and overwrites it
  with the background image.
*/

-(void)lockAndClearBuf;

/*!
  Unlocks the backbuffer image after a previous call to lockBuf.
*/
-(void)unlockBuf;

/*!
  Gets any pending events from the windowing system's event queue, and sends
  them as messages back to the host SpriteApp object, which then invokes
  its handlers for the events.
*/

-(id)dispatchEvents;

/*!
  Gets the time since the application started in milliseconds. For a 32-bit
  unsigned int, this value will wrap around once every 49.7 days.
*/

-(unsigned int)getTimeMillis;

/*!
  Releases the IODelegate object.
*/

-free;
@end
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
    Sprite *first;
    Sprite *deleted;
    char *title;
    unsigned int width,height;
    unsigned int clock;
    SpriteImage back,buf;
    id <IODelegate> io_del;
}

/*!
  @method initWithTitle:width:height:
  Initialises the SpriteApp and creates a display surface for it of size
  (w,h) with window title t. In a window system, creates a window for the
  SpriteApp.
 */

-(id)initWithTitle: (char *)t width: (unsigned int)w height: (unsigned int)h;

/*!
  @method first
  Returns the SpriteApp's first sprite.
 */

-(Sprite *)first;

/*!
  @method last
  Returns the SpriteApp's last sprite.
 */

-(Sprite *)last;

/*!
  @method add:
  Adds a sprite, newone, to the sprite list, and returns it.
 */

-(Sprite *)add: (Sprite *)newone;

/*!
  @method remove:
  Removes a sprite, oldone, from the sprite list, and returns it.
 */

-(Sprite *)remove: (Sprite *)oldone;

/*!
  @method delete:
  Removes a sprite, oldone, from the sprite list, and adds it to the deleted
  list. Returns the sprite.
 */

-(Sprite *)delete: (Sprite *)oldone;

/*!
  @method place:behind:
  Removes a sprite, aSprite, from the sprite list, and reinserts it behind
  anotherSprite. List order implies Z order. If anotherSprite is nil, adds the
  sprite to the end of the list, making it drawn last.

  Returns aSprite.
*/

-(Sprite *)place: (Sprite *)aSprite behind: (Sprite *)anotherSprite;

/*!
  @method addDeleted:
 Adds a sprite, newone, to the list of sprites to be deleted. Sprites are
 deleted on every frame update if there are any in the list.
 */


-(Sprite *)addDeleted: (Sprite *)newone;

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

/*!
 Key press handler. Code of key pressed is aKey (it is an ASCII code, or
 one of the SC_Key values in SpriteApp.h). Subclasses may override to
 customise this behavior.
 */

-(void)keyDown: (int)aKey;

/*!
 Key release handler. Code of key released is aKey (it is an ASCII code, or one
 of the SC_Key values in SpriteApp.h). Subclasses may override to customise
 this behavior.
 */

-(void)keyUp: (int)aKey;

/*!
 Mouse motion handler. Mouse position is (x,y). Note: Mouse buttons are keys
  and handled by -keyDown: and -keyUp:.  Subclasses may override to customise
  this behavior.
 */

-(void)mouseMoveX: (int)x Y: (int)y;

/*!
  Loads a PPM file for use in this SpriteApp (or sprites associated with it).
  Fills the SpriteImage struct pointed to by si with an image from the
  PPM/PNM file whose name is in fn.
 */

-(int)loadPPMFile: (char *)fn toImage: (SpriteImage *)si;

/*!
  Releases resources associated with the SpriteImage structure si, which
  should have been created with -loadPPMFile:toImage:, or another method which
  creates SpriteImages. Does not release the structure itself.
 */

-(void)destroyImage: (SpriteImage *)si;

/*!
  Returns the number of milliseconds between the application start and the
  last frame update. This value is updated by -step once per frame update.
 */

-(unsigned int)clock;

@end

/*!
  Creates a standard IO delegate for a SpriteApp. The actual object that's
  created depends on the windowing or graphics subsystem SpriteCore is built
  for; however, it must conform to the IODelegate protocol.
*/

extern id createIODelegate(SpriteApp *ha,unsigned int w,unsigned int h,char *t);

