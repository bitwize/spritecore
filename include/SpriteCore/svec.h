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

#ifndef __SVEC_H
#define __SVEC_H
/*!
  @typedef svec2
  @discussion A 2 dimensional vector of floats.
  @field x X coordinate
  @field y Y coordinate
*/

typedef struct __svec2 {
  float x;
  float y;
} svec2;

typedef struct __srect2 {
  svec2 pos;
  svec2 size;
} srect2;

/*!
  @function make_svec2
  Returns an svec2 structure containing the x and y coordinates given.
*/

svec2 make_svec2(float x,float y);

#endif
