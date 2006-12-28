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

/*!
  @function make_svec2
  Returns an svec2 structure containing the x and y coordinates given.
*/

svec2 make_svec2(float x,float y);

#endif
