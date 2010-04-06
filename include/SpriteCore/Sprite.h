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

#ifndef __SPRITE_H
#define __SPRITE_H

#import <objc/Object.h>

#import <SpriteCore/SpriteApp.h>
#include <SpriteCore/svec.h>
#import <SpriteCore/SpriteNode.h>
#import <SpriteCore/SpriteAgent.h>
struct sprite_render_data {
	SpriteImage *simg;
	sc_vec2 pos;
	sc_vec2 hotspot;
	char *key;
	unsigned int frame;
	unsigned int maxframes;
	unsigned int width;
	unsigned int height;
};
/*!
  @class Sprite
  The Sprite class represents a sprite, or an on-screen graphical object.
  Sprites render themselves to their host SpriteApp's back-buffer image.
  Historically, sprites have represented 2D objects or bitmaps which move
  on screen; however, this object may also do special effects or image
  processing.
*/

@interface Sprite : SpriteNode {
	SpriteImage *simg;
	unsigned int frame;
	unsigned int maxframes;
	sc_vec2 pos;
	sc_vec2 vel;
	sc_vec2 hotspot;
	unsigned int width,height;
	char key[MAX_PIXEL_WIDTH];
	id <SpriteRendererAgent> aagent;
	id <SpriteBehaviorAgent> bagent;
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

-(unsigned int)numberFrames;

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
  Draws the sprite. May be overrided.
*/

-(void)render;


/*!
  Moves the sprite to the coordinates specified in the sc_vec2 struct given as
  p. The sprite's hotspot will be centered over the point p.
*/

-(void)moveTo: (sc_vec2)p;

/*!
  Sets the sprite's velocity to the x and y values given by v. Velocity values
  are in pixels per fiftieth of a second.
*/

-(void)setVel: (sc_vec2)v;

/*!
  Sets the sprite's hotspot to the x and y values given by p. The hotspot is
  a point relative to the upper-left corner of the sprite
  (default is (0,0)). Calls to -moveTo: will center the hotspot over the
  location passed to that method.
*/


-(void)setHotspot: (sc_vec2)p;

/*!
  Returns the sprite's position as an sc_vec2.
*/

-(sc_vec2)pos;

/*!
  Returns the sprite's velocity (in pixels per fiftieth of a second) as an
  sc_vec2.
*/


-(sc_vec2)vel;

/*!
  Returns the sprite's hotspot as an sc_vec2. The hotspot is
  a point relative to the upper-left corner of the sprite
  (default is (0,0)). Calls to -moveTo: will center the hotspot over the
  location passed to that method.
*/

-(sc_vec2)hotspot;

/*!
  Returns the sprite's width as an integer.
*/

-(unsigned int)width;

/*!
  Returns the sprite's height as an integer.
*/

-(unsigned int)height;

/*!
  Returns the sprite's size as an sc_vec2.
*/

-(sc_vec2)size;

-(char *)keyPtr;

-(sc_rect2)boundingBox;

/*!
  Returns a Boolean value corresponding to whether the sprite's bounding
  rectangle overlaps with that of another sprite. Useful for simple collision
  detection.
*/

-(int)isTouching: (Sprite *)s;
			  
-(void)setAppearanceAgent: (id<SpriteRendererAgent>) a;
-(id<SpriteRendererAgent>)appearanceAgent;
-(void)setBehaviorAgent: (id<SpriteBehaviorAgent>) a;
-(id<SpriteBehaviorAgent>)behaviorAgent;
-(void)fillRenderData: (struct sprite_render_data *)d;
+(void)initialize;
@end

#endif
