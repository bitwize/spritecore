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


/*

  The sc_vec2 struct constitutes a vector in two-dimensional space, in
  pixel coordinates. Its fields are as follows:

    x : float -- The X coordinate
    y : float -- The Y coordinate

*/


typedef struct __sc_vec2 {
	float x;
	float y;
} sc_vec2;

/*

  The sc_rect2 struct constitutes a rectangle in two-dimensional space, in
  pixel coordinates. Its fields are as follows:

    pos   : sc_vec2  - The position of the upper left corner
    size  : sc_vec2  - The width and height of the rectangle
*/


typedef struct __sc_rect {
	sc_vec2 pos;
	sc_vec2 size;
} sc_rect;

/*

  make_sc_vec2_fl : (float,float) -> sc_vec2

*/

extern sc_vec2 make_sc_vec2_fl(float x,float y);
extern int rects_intersect(sc_rect r1,sc_rect r2);


#endif
