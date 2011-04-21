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

#include <spriteimage.h>
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
