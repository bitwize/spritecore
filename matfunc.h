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
  @function mat_zero
  @discussion Zeroes a 3x3 matrix.
  @param mat The matrix
*/
void mat_zero(s_matp mat);
/*!
  @function mat_ident
  @discussion Replaces a 3x3 matrix with an identity matrix.
  @param mat The matrix
*/
void mat_ident(s_matp mat);
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

void mat_xlate(s_matp mat,float disp_x,float disp_y,s_matp mdest);

/*!
  @function mat_shear
  @discussion Applies a shear to a matrix.
  @param disp  2D displacement vector
  @param mdest Matrix where result will be stored
*/

void mat_shear(s_matp mat,float disp_x,float disp_y,s_matp mdest);

#endif
