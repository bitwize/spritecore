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
#include "matfunc.h"

void mat_mul(s_matp mat1,s_matp mat2,s_matp mdest) {
  mdest[0] =
    mat1[0] * mat2[0] +
    mat1[1] * mat2[3] +
    mat1[2] * mat2[6];
  mdest[1] =
    mat1[0] * mat2[1] +
    mat1[1] * mat2[4] +
    mat1[2] * mat2[7];
  mdest[2] =
    mat1[0] * mat2[2] +
    mat1[1] * mat2[5] +
    mat1[2] * mat2[8];
  mdest[3] =
    mat1[3] * mat2[0] +
    mat1[4] * mat2[3] +
    mat1[5] * mat2[6];
  mdest[4] =
    mat1[3] * mat2[1] +
    mat1[4] * mat2[4] +
    mat1[5] * mat2[7];
  mdest[5] =
    mat1[3] * mat2[2] +
    mat1[4] * mat2[5] +
    mat1[5] * mat2[8];
  mdest[6] =
    mat1[6] * mat2[0] +
    mat1[7] * mat2[3] +
    mat1[8] * mat2[6];
  mdest[7] =
    mat1[6] * mat2[1] +
    mat1[7] * mat2[4] +
    mat1[8] * mat2[7];
  mdest[8] =
    mat1[6] * mat2[2] +
    mat1[7] * mat2[5] +
    mat1[8] * mat2[8];
}

void mat_rotate(s_matp mat,float rads,s_matp mdest) {
  s_mat3  m2;
  m2[0] = cos(rads);
  m2[1] = -sin(rads);
  m2[2] = 0;
  m2[3] = sin(rads);
  m2[4] = cos(rads);
  m2[5] = 0;
  m2[6] = 0;
  m2[7] = 0;
  m2[8] = 1;
  mat_mul(mat,m2,mdest);
}

void mat_xlate(s_matp mat,svec2 disp,s_matp mdest) {
  s_mat3  m2;
  m2[0] = 1;
  m2[1] = 0;
  m2[2] = disp.x;
  m2[3] = 0;
  m2[4] = 1;
  m2[5] = disp.y;
  m2[6] = 0;
  m2[7] = 0;
  m2[8] = 1;
  mat_mul(mat,m2,mdest);
}


void mat_shear(s_matp mat,svec2 disp,s_matp mdest) {
  s_mat3  m2;
  m2[0] = 1;
  m2[1] = disp.x;
  m2[2] = 0;
  m2[3] = disp.y;
  m2[4] = 1;
  m2[5] = 0;
  m2[6] = 0;
  m2[7] = 0;
  m2[8] = 1;
  mat_mul(mat,m2,mdest);
}

float mat_det2x2(s_matp m) {
  return ((m[0]*m[3]) - (m[1]*m[2]));
}

float mat_det3x3(s_matp m) {
  return (m[0] * ((m[4]*m[8]) - (m[5]*m[7]))) +
    (m[1] * ((m[5]*m[6]) - (m[3]*m[8]))) +
    (m[2] * ((m[3]*m[7]) - (m[4]*m[6])));
}

int mat_invert3x3(s_matp m,s_matp md) {
  float d = mat_det3x3(m);
  if(d == 0) return -1;
  float f = 1/d;
  s_mat2 sm;
  sm[0] = m[4]; sm[1] = m[5]; sm[2] = m[7]; sm[3] = m[8];
  md[0] = mat_det2x2(sm) * f;

  sm[0] = m[1]; sm[1] = m[2]; sm[2] = m[7]; sm[3] = m[8];
  md[1] = -mat_det2x2(sm) * f;

  sm[0] = m[1]; sm[1] = m[2]; sm[2] = m[4]; sm[3] = m[5];
  md[2] = mat_det2x2(sm) * f;

  sm[0] = m[3]; sm[1] = m[5]; sm[2] = m[6]; sm[3] = m[8];
  md[3] = -mat_det2x2(sm) * f;

  sm[0] = m[0]; sm[1] = m[2]; sm[2] = m[6]; sm[3] = m[8];
  md[4] = mat_det2x2(sm) * f;

  sm[0] = m[0]; sm[1] = m[2]; sm[2] = m[3]; sm[3] = m[5];
  md[5] = -mat_det2x2(sm) * f;

  sm[0] = m[3]; sm[1] = m[4]; sm[2] = m[6]; sm[3] = m[7];
  md[6] = mat_det2x2(sm) * f;

  sm[0] = m[0]; sm[1] = m[1]; sm[2] = m[6]; sm[3] = m[7];
  md[7] = -mat_det2x2(sm) * f;

  sm[0] = m[0]; sm[1] = m[1]; sm[2] = m[3]; sm[3] = m[4];
  md[8] = mat_det2x2(sm) * f;
  return 0;
}
