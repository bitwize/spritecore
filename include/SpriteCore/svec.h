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

  The sc_fixedpoint data type represents a fixed-point scalar value
  that can be used as a pixel coordinate for sprite positions and
  velocities, permitting resolutions as fine as 1/1024 of a pixel.

  The MAKE_SC_FXP constructor is a macro that can be thought of as having type:

  MAKE_SC_FXP : (int,unsigned int) -> sc_fixedpoint

  MAKE_SC_FXP(units,fracs) returns a new sc_fixedpoint with integer
  part `units' and fractional part `fracs', where 0 <= fracs < 1024.

  The SC_FXP_TO_FLOAT and SC_FLOAT_TO_FXP macros do what they say on the tin.

*/
typedef int sc_fixedpoint;

#define SC_FXP_FRACBITS 10
#define SC_FXP_SCALE (1 << SC_FXP_FRACBITS)
#define MAKE_SC_FXP(_units,_fracs) ((sc_fixedpoint)((_units << SC_FXP_FRACBITS) | \
						    (_fracs && (SC_FXP_SCALE - 1))))

#define SC_FXP_TO_FLOAT(x) ((float)x/(float)SC_FXP_SCALE)
#define SC_FLOAT_TO_FXP(x) MAKE_SC_FXP((int)x,(int)(x * SC_FXP_SCALE))
/*

  The sc_vec2 struct constitutes a vector in two-dimensional space, in
  pixel coordinates. Its fields are as follows:

    x : sc_fixedpoint -- The X coordinate
    y : sc_fixedpoint -- The Y coordinate

*/


typedef struct __sc_vec2 {
	sc_fixedpoint x;
	sc_fixedpoint y;
} sc_vec2;

/*

  The sc_rect2 struct constitutes a rectangle in two-dimensional space, in
  pixel coordinates. Its fields are as follows:

    pos   : sc_vec2  - The position of the upper left corner
    size  : sc_vec2  - The width and height of the rectangle
*/


typedef struct __sc_rect2 {
	sc_vec2 pos;
	sc_vec2 size;
} sc_rect2;

/*

  make_sc_vec2_fl : (float,float) -> sc_vec2

  make_sc_vec2_fx : (sc_fixedpoint,sc_fixedpoint) -> sc_vec2

  These two routines construct an sc_vec2 from floating-point or raw
  fixed-point components, respectively.

*/

extern sc_vec2 make_sc_vec2_fl(float x,float y);
extern sc_vec2 make_sc_vec2_fx(sc_fixedpoint x,sc_fixedpoint y);

#endif
