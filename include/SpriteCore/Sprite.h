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

#ifndef __SPRITE_H
#define __SPRITE_H

#import <objc/Object.h>

#import <SpriteCore/SpriteApp.h>
#import <SpriteCore/SpriteElement.h>
#include <SpriteCore/svec.h>
#import <SpriteCore/SpriteNode.h>

/*!
  @class Sprite
  The Sprite class represents a sprite, or an on-screen graphical object.
  Sprites render themselves to their host SpriteApp's back-buffer image.
  Historically, sprites have represented 2D objects or bitmaps which move
  on screen; however, this object may also do special effects or image
  processing.
*/

@interface Sprite : Object <SpriteElement> {
  SpriteImage *simg;
  unsigned int frame;
  unsigned int maxframes;
  svec2 pos;
  svec2 vel;
  svec2 hotspot;
  unsigned int width,height;
  long key;
  SpriteNode *node;
}

/*!
  Initialises the sprite on host h, with shape si (which can be NULL for an
  "invisible" sprite, and max frames mf. The image si is divided vertically
  into mf frames, and the sprite will assume one of these frame-shapes at a
  time.
*/
-(id)initOn: (SpriteApp *)h
      shape: (SpriteImage *)si
     frames: (unsigned int)mf;

/*! Sets the sprite's shape to sh, with a frame count of f. The image sh is
  divided vertically into f frames (so its height should be f times the
  height of a single frame). */

-(SpriteImage *)setShape: (SpriteImage *)sh frames: (unsigned int)f;

/*! Sets the sprite's shape to sh with only one frame. */

-(SpriteImage *)setShape: (SpriteImage *)sh;

/*! Returns a pointer to the SpriteImage which represents this sprite's shape.
 */

-(SpriteImage *)shape;

/*! Returns the number of the current frame. */

-(unsigned int)frame;

/*! Changes the current frame number to f. The frame count cannot exceed the
  maximum number of frames for the image; it will have a modulus operation
  applied so that it doesn't (i.e., a frame number of 30 on a 4-frame image
  will be the same as a frame number of 2). */

-(void)setFrame: (unsigned int)f;

/*!
  This method is called once per frame update by the host SpriteApp. Typically
  it updates the sprite's position. You can override it to make it do anything,
  however: check for collisions, switch frames in a multi-frame animation,
  etc.
*/

-(void)step;

/*!
  Draws the sprite on anImage. May be overrided.
*/

-(void)renderOn: (SpriteImage *)anImage;

/*!
  Draws the sprite on anApp's display. May be overrided.
*/

-(void)renderToApp: (SpriteApp *)anApp;

/*!
  Moves the sprite to the coordinates specified in the svec2 struct given as
  p. The sprite's hotspot will be centered over the point p.
*/

-(void)moveTo: (svec2)p;

/*!
  Sets the sprite's velocity to the x and y values given by v. Velocity values
  are in pixels per fiftieth of a second.
*/

-(void)setVel: (svec2)v;

/*!
  Sets the sprite's hotspot to the x and y values given by p. The hotspot is
  a point relative to the upper-left corner of the sprite
  (default is (0,0)). Calls to -moveTo: will center the hotspot over the
  location passed to that method.
*/


-(void)setHotspot: (svec2)p;

/*!
  Returns the sprite's position as an svec2.
*/

-(svec2)pos;

/*!
  Returns the sprite's velocity (in pixels per fiftieth of a second) as an
  svec2.
*/


-(svec2)vel;

/*!
  Returns the sprite's hotspot as an svec2. The hotspot is
  a point relative to the upper-left corner of the sprite
  (default is (0,0)). Calls to -moveTo: will center the hotspot over the
  location passed to that method.
*/

-(svec2)hotspot;

/*!
  Returns the sprite's width as an integer.
*/

-(unsigned int)width;

/*!
  Returns the sprite's height as an integer.
*/

-(unsigned int)height;

/*!
  Returns the sprite's size as an svec2.
*/

-(svec2)size;

-(SpriteNode *)node;
-(SpriteApp *)host;

/*!
  Returns a Boolean value corresponding to whether the sprite's bounding
  rectangle overlaps with that of another sprite. Useful for simple collision
  detection.
*/

-(int)isTouching: (Sprite *)s;

@end

#endif
