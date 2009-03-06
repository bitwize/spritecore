/* -*- objc -*- */

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

@protocol SpriteIODelegate

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
- (int)convertMemPPM: (unsigned char *)ppm size: (unsigned int) sz
	     toImage: (SpriteImage *)si;

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

-(void)sleepMillis: (unsigned int) ms;

/*!
  Releases the SpriteIODelegate object.
*/

-free;
@end

