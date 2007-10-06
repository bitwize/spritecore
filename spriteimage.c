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
/* Sprite32 - small, cross-platform sprite library
 * Copyright (c) 1996-2003 Jeffrey T. Read
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 */

#include <SpriteCore/spriteimage.h>
#include "blitter.psc"
#include <stdio.h>
#include <stdlib.h>
#ifndef MIN
#define 	MIN(a, b)   ((a)<(b)?(a):(b))
#endif
#ifndef MAX
#define 	MAX(a, b)   ((a)>(b)?(a):(b))
#endif

void get_key(SpriteImage *si,char *k) {
  int b = (si->depth + 7) / 8;
  char *s = (char *)si->bits;
  /* This code is not clear. Use of switch-statement fall-thru
     is intentional. */
  switch(b) {
  case 4:
    k[3] = s[3];
  case 3:
    k[2] = s[2];
  case 2:
    k[1] = s[1];
  case 1:
    k[0] = s[0];
    break;
  default:
    fprintf(stderr,"error: nonstandard bpp %d\n",b);
    exit(1);
  }
}

void ImageCopy(SpriteImage *si1,SpriteImage *si2,int sx,int sy,int x,int y,int cx,int cy,int flags, char *key) {
  struct rect r1,r2,r3;
  int offx,offy,sizex,sizey;
  r1.left = 0;
  r1.top = 0;
  r1.right = si2->cx;
  r1.bottom = si2->cy;
  r2.left = x;
  r2.top = y;
  r2.right = x + cx;
  r2.bottom = y + cy;
  rect_intersectB(&r1,&r2,&r3);
  offx = r3.left - x;
  offy = r3.top - y;
  sizex = r3.right-r3.left;
  sizey = r3.bottom - r3.top;
  if(flags & SIMG_USE_KEY) {
    xfer_keyed_rectB((char *)(si2->bits),
		     r3.left,
		     r3.top,
		     si2->scan_length,
		     (char *)(si1->bits),
		     sx + offx,
		     sy + offy,
		     sx + offx + sizex,
		     sy + offy + sizey,
		     si1->scan_length,
		     key,
		     si1->depth);
  }
  else {
    xfer_rectB((char *)(si2->bits),
		     r3.left,
		     r3.top,
		     si2->scan_length,
		     (char *)(si1->bits),
		     sx + offx,
		     sy + offy,
		     sx + offx + sizex,
		     sy + offy + sizey,
		     si1->scan_length,
		     si1->depth);
  }
}

void MorpheusImageCopy(SpriteImage *si1,SpriteImage *si2,int sx,int sy,int cx,int cy,s_matp mat,int flags,char *key) {
  s_mat3 inv;
  struct rect src,dest,sr1,sr2;
  dest.left = 0;
  dest.top = 0;
  dest.right = si2->cx;
  dest.bottom = si2->cy;
  src.left = sx;
  src.top = sy;
  src.right = sx + cx;
  src.bottom = sy + cy;
  xform_clipB(mat,inv,&src,&dest,&sr1,&sr2);
  xfer_xformed_keyed_rectB(si2->bits,
			   si2->scan_length,
			   si1->bits,
			   src.left,
			   src.top,
			   src.right,
			   src.bottom,
			   si1->scan_length,
			   mat,
			   &dest,
			   key,
			   si2->depth);
}
