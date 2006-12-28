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

#ifndef __MATFUNC_H
#define __MATFUNC_H
#include <math.h>
#include "svec.h"

/*!
  @typedef s_mat3
  @discussion Matrix of 3x3 floats.
*/

typedef double s_mat3[9];

/*!
  @typedef s_mat2
  @discussion Matrix of 2x2 floats.
*/

typedef double s_mat2[4];

/*!
  @typedef s_matp
  @discussion Pointer to matrix of floats.
*/

typedef double *s_matp;
/*!
  @function mat_mul
  @discussion Multiplies two 3x3 matrices.
  @param mat1 First matrix
  @param mat2 Second matrix
  @param mdest Matrix where result will be stored
*/

void mat_mul(s_matp mat1,s_matp mat2,s_matp mdest);

/*!
  @function mat_rotate
  @discussion Applies a rotation to a matrix.
  @param rads Rotation angle in radians
  @param mdest Matrix where result will be stored
*/

void mat_rotate(s_matp mat,float rads,s_matp mdest);

/*!
  @function mat_xlate
  @discussion Applies a translation to a matrix.
  @param disp  2D displacement vector
  @param mdest Matrix where result will be stored
*/

void mat_xlate(s_matp mat,svec2 disp,s_matp mdest);

/*!
  @function mat_shear
  @discussion Applies a shear to a matrix.
  @param disp  2D displacement vector
  @param mdest Matrix where result will be stored
*/

void mat_shear(s_matp mat,svec2 disp,s_matp mdest);

#endif
