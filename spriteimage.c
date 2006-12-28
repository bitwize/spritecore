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

long get_key(SpriteImage *si) {
  int b = (si->depth + 7) / 8;
  char *s = (char *)si->bits;
  long k=0;
  char *d = ((char*)(&k));
  switch(b) {
  case 1:
    *((char *)(&k)) = s[0]; break;
  case 2:
    *((short *)(&k)) = *((short *)s); break;
  case 3:
    d[0] = s[0]; d[1] = s[1]; d[2] = s[2]; break;
  case 4:
    *((long *)(&k)) = *((long *)s); break;
  default:
    fprintf(stderr,"error: nonstandard bpp %d\n",b);
    exit(1);
  }
  return k;
}

void ImageCopy(SpriteImage *si1,SpriteImage *si2,int sx,int sy,int x,int y,int cx,int cy,int flags, long key) {
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
		     (char *)(&key),
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

void MorpheusImageCopy(SpriteImage *si1,SpriteImage *si2,int sx,int sy,int cx,int cy,s_matp mat,int flags,long key) {
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
			   (char *)(&key),
			   si2->depth);
}
#if 0



/* This function is becoming frustratingly hard to decode. :) 

This is our primary blitter. Messy, isn't it? The guts of it are supposed to
work across rendering targets. Here are the params:

SpriteImage   *si1:   source image
SpriteImage   *si2:   destination image
int          sx,sy:   upper left corner of section of source image to copy
int            x,y:   upper left corner of destination rectangle
int          cx,cy:   size of rectangle
int          flags:   flags (not sure what to do with these yet)
long           key:   key color for transparency
                      (typically the upper left corner of a sprite)
*/


void ImageCopy(SpriteImage *si1,SpriteImage *si2,int sx,int sy,int x,int y,int cx,int cy,int flags, long key) {
    int startx,starty,endx,endy;
    int dx = si2->cx;
    int dy = si2->cy;
    int g = 0;
    char *s = (char *)si1->bits;
    char *d = (char *)si2->bits;
    char *p;
    char *r;
    char *q = (char *)&key;

    int i,j;
    int b = (si1->depth + 7) / 8;
    startx = sx; starty = sy;
    endx = sx + cx; endy = sy + cy;
    if(x < 0) {
      if(x+cx < 0) return;
      startx = sx - x;
    }
    if(y < 0) {
      if(y + cy < 0) return;
      starty = sy - y;
    }
    if(x + cx - 1 >= dx) {
      if(x >= dx) return;
      endx = x + cx - dx;
      endx = cx + sx - endx;
    }
    if(y + cy - 1 >= dy) {
      if(y >= dy) return;
      endy = y + cy - dy;
      endy = cy + sy - endy;
    }
#ifdef __NOT_DEFINED__
      AsmImageCopy((void *)s,(void *)d,x + startx - sx,y + starty - sy,startx,starty,endx - startx,endy - starty,b,si1->scan_length,si2->scan_length,key);
#else
      if(flags & SIMG_USE_KEY) {
	switch(b) {
	case 1:
	  for(j=starty;j<endy;j++) {
	    p = s + ((j * si1->scan_length) + startx * b);
	    r = d + (((((int)y + j - sy) * si2->scan_length) + 
		      ((startx - sx + (int)x) * b)));
	    for(i=startx;i<endx;i++) {
	      if(*((char *)p) != *((char *)q)) {
		*r = *p;
	      }
	      r++; p++;
	    }
	  }
	  break;
	case 2:
	  for(j=starty;j<endy;j++) {
	    p = s + ((j * si1->scan_length) + startx * b);
	    r = d + (((((int)y + j - sy) * si2->scan_length) + 
		      ((startx - sx + (int)x) * b)));
	    for(i=startx;i<endx;i++) {
	      if(*((short *)p) != *((short *)q)) {
		*((short *)r) = *((short *)p);
	      }
	      r++; p++;
	      r++; p++;
	    }
	  }
	  break;
	case 3:
	  for(j=starty;j<endy;j++) {
	    
	    p = s + ((j * si1->scan_length) + startx * b);
	    r = d + (((((int)y  + j - sy) * si2->scan_length) + 
		      ((startx - sx + (int)x) * b)));
	    
	    for(i=startx;i<endx;i++) {
	      if((*p != *q) && (*(p+1) != *(q+1)) && (*(p+2) != *(q+2))) {
		r[0] = p[0];
		r[1] = p[1];
		r[2] = p[2];
	      }
	      p++; r++;
	      p++; r++;
	      p++; r++;
	    }
	  }
	  break;
	case 4:
	  for(j=starty;j<endy;j++) {
	    
	    p = s + ((j * si1->scan_length) + startx * b);
	    r = d + (((((int)y  + j - sy) * si2->scan_length) + 
		      ((startx - sx + (int)x) * b)));
	    
	    for(i=startx;i<endx;i++) {
	      
	      if(*((long *)p) != *((long *)q)) {
		*((long *)r) = *((long *)p);
	      }
	      p++; r++;
	      p++; r++;
	      p++; r++;
	      p++; r++;
	    }
	  }
	  break;
	default:
	  fprintf(stderr,"error: nonstandard bpp %d\n",b);
	  exit(1);
	}
      }
      else {
	switch(b) {
	case 1:
	  for(j=starty;j<endy;j++) {
	    p = s + ((j * si1->scan_length) + startx * b);
	    r = d + (((((int)y + j - sy) * si2->scan_length) + 
		      ((startx - sx + (int)x) * b)));
	    for(i=startx;i<endx;i++) {
	      *r = *p;
	      r++; p++;
	    }
	  }
	  break;
	case 2:
	  for(j=starty;j<endy;j++) {
	    p = s + ((j * si1->scan_length) + startx * b);
	    r = d + (((((int)y + j - sy) * si2->scan_length) + 
		      ((startx - sx + (int)x) * b)));
	    for(i=startx;i<endx;i++) {
	      *((short *)r) = *((short *)p);
	      r++; p++;
	      r++; p++;
	    }
	  }
	  break;
	case 3:
	  for(j=starty;j<endy;j++) {
	    
	    p = s + ((j * si1->scan_length) + startx * b);
	    r = d + (((((int)y  + j - sy) * si2->scan_length) + 
		      ((startx - sx + (int)x) * b)));
	    
	    for(i=startx;i<endx;i++) {
	      r[0] = p[0];
	      r[1] = p[1];
	      r[2] = p[2];
	      p++; r++;
	      p++; r++;
	      p++; r++;
	    }
	  }
	  break;
	case 4:
	  for(j=starty;j<endy;j++) {
	    
	    p = s + ((j * si1->scan_length) + startx * b);
	    r = d + (((((int)y  + j - sy) * si2->scan_length) + 
		      ((startx - sx + (int)x) * b)));
	    
	    for(i=startx;i<endx;i++) {
	      
	      *((long *)r) = *((long *)p);
	      p++; r++;
	      p++; r++;
	      p++; r++;
	      p++; r++;
	    }
	  }
	  break;
	default:
	  fprintf(stderr,"error: nonstandard bpp %d\n",b);
	  exit(1);
	}
      }
#endif
}

void xform_isect(s_matp m,svec2 *ul,svec2 *lr,svec2 *oul,svec2 *olr) {

}

void MorpheusImageCopy(SpriteImage *si1,SpriteImage *si2,int sx,int sy,int cx,int cy,s_matp mat,int flags,long key) {
    int startx,starty,endx,endy;
    svec2 bound1,bound2,isect1,isect2;
    int dx = si2->cx;
    int dy = si2->cy;
    int g = 0;
    char *s = (char *)si1->bits;
    char *d = (char *)si2->bits;
    char *p;
    char *r;
    char *q = (char *)&key;

    double i,j,ip,jp,ip2,jp2;
    float xf = abs(mat[0]);
    float yf = abs(mat[4]);
    float xs = (xf < 1 ? 1 : 1/xf);
    float ys = (yf < 1 ? 1 : 1/yf);
    int b = (si1->depth + 7) / 8;
    startx = sx; starty = sy;
    endx = sx + cx; endy = sy + cy;
    bound1 = make_svec2(startx,starty);
    bound2 = make_svec2(endx,endy);
    xform_isect(mat,&bound1,&bound2,&isect1,&isect2);
      if(flags & SIMG_USE_KEY) {
	switch(b) {
	case 1:
	  for(j=starty;j<endy;j+=ys) {
	    for(i=startx;i<endx;i+=xs) {
	      ip = mat[0] * (i-sx) + mat[1] * (j-sy) + mat[2];
	      jp = mat[3] * (i-sx) + mat[4] * (j-sy) + mat[5];
	      if((ip >= 0) && (ip < dx) && (jp >= 0) && (jp < dy)) {
		
		p = s + (((int)j * si1->scan_length) + (int)i * b);
		r = d + (((((int)jp) * si2->scan_length) + 
			  ((int)ip) * b));
	      
		if(*((char *)p) != *((char *)q)) {
		  *r = *p;
		  if(ip < dx && i < (endx - 1) && *(char *)(p + sizeof(char))
		     != *(char *)q) {
		    r++; *r = *p;
		  }
		}
	      }
	    }
	  }
	  break;
	case 2:
	  for(j=starty;j<endy;j+=ys) {
	    for(i=startx;i<endx;i+=xs) {
	      ip = mat[0] * (i-sx) + mat[1] * (j-sy) + mat[2];
	      jp = mat[3] * (i-sx) + mat[4] * (j-sy) + mat[5];
	      if((ip >= 0) && (ip < dx) && (jp >= 0) && (jp < dy)) {

		p = s + (((int)j * si1->scan_length) + (int)i * b);
		r = d + (((((int)jp) * si2->scan_length) + 
			  ((int)ip) * b));

		if(*((short *)p) != *((short *)q)) {
		  *(short *)r = *(short *)p;
		  if(ip < dx && i < (endx - 1) && *(short *)(p + sizeof(short))
		     != *(short *)q) {
		    r+= sizeof(short); *(short *)r = *(short *)p;
		  }
		}
	      }
	    }
	  }
	  break;
	case 3:
	  for(j=starty;j<endy;j+=ys) {
	    for(i=startx;i<endx;i+=xs) {
	      ip = mat[0] * (i-sx) + mat[1] * (j-sy) + mat[2];
	      jp = mat[3] * (i-sx) + mat[4] * (j-sy) + mat[5];
	      if((ip >= 0) && (ip <= dx) && (jp >= 0) && (jp <= dy)) {
		
		p = s + (((int)j * si1->scan_length) + (int)i * b);
		r = d + ((((int)jp) * si2->scan_length) + 
			  ((int)ip) * b);
		
	        if((*p != *q) && (*(p+1) != *(q+1)) && (*(p+2) != *(q+2))) {
		  r[0] = p[0];
		  r[1] = p[1];
		  r[2] = p[2];
		  if(ip < dx && i < (endx - 1) &&
		     (*(p+3) != *(q+3)) && (*(p+4) != *(q+4)) && (*(p+5) != *(q+5))) {
		    r++; r++; r++; r[0] = p[0]; r[1] = p[1]; r[2] = p[2];
		  }
		}
		
	      }
	    }
	  }
	  break;
	case 4:
	  for(j=starty;j<endy;j+=ys) {
	    for(i=startx;i<endx;i+=xs) {
	      ip = mat[0] * (i-sx) + mat[1] * (j-sy) + mat[2];
	      jp = mat[3] * (i-sx) + mat[4] * (j-sy) + mat[5];
	      if((ip >= 0) && (ip <= dx) && (jp >= 0) && (jp <= dy)) {

		p = s + (((int)j * si1->scan_length) + (int)i * b);
		r = d + (((((int)jp) * si2->scan_length) + 
			  ((int)ip) * b));

		if(*((long *)p) != *((long *)q)) {
		  *((long *)r) = *((long *)p);
		  if(ip < dx && i < (endx - 1) && *(long *)(p + sizeof(long))
		     != *(long *)q) {
		    r+= sizeof(long); *(long *)r = *(long *)p;
		  }
		}



	      }
	    }
	  }
	  break;
	default:
	  fprintf(stderr,"error: nonstandard bpp %d\n",b);
	  exit(1);
	}
      }
      else {

	switch(b) {
	case 1:
	  for(j=starty;j<endy;j+=ys) {
	    for(i=startx;i<endx;i+=xs) {
	      ip = mat[0] * (i-sx) + mat[1] * (j-sy) + mat[2];
	      jp = mat[3] * (i-sx) + mat[4] * (j-sy) + mat[5];
	      if((ip >= 0) && (ip <= dx) && (jp >= 0) && (jp <= dy)) {
		
		p = s + (((int)j * si1->scan_length) + (int)i * b);
		r = d + (((((int)jp) * si2->scan_length) + 
			  ((int)ip) * b));
	      
		*r = *p;
	      }
	    }
	  }
	  break;
	case 2:
	  for(j=starty;j<endy;j+=ys) {
	    for(i=startx;i<endx;i+=xs) {
	      ip = mat[0] * (i-sx) + mat[1] * (j-sy) + mat[2];
	      jp = mat[3] * (i-sx) + mat[4] * (j-sy) + mat[5];
	      if((ip >= 0) && (ip <= dx) && (jp >= 0) && (jp <= dy)) {

		p = s + (((int)j * si1->scan_length) + (int)i * b);
		r = d + (((((int)jp) * si2->scan_length) + 
			  ((int)ip) * b));

		*(short *)r = *(short *)p;
	      }
	    }
	  }
	  break;
	case 3:
	  for(j=starty;j<endy;j+=ys) {
	    for(i=startx;i<endx;i+=xs) {
	      ip = mat[0] * (i-sx) + mat[1] * (j-sy) + mat[2];
	      jp = mat[3] * (i-sx) + mat[4] * (j-sy) + mat[5];
	      if((ip >= 0) && (ip <= dx) && (jp >= 0) && (jp <= dy)) {
		
		p = s + (((int)j * si1->scan_length) + (int)i * b);
		r = d + ((((int)jp) * si2->scan_length) + 
			  ((int)ip) * b);
		
		  r[0] = p[0];
		  r[1] = p[1];
		  r[2] = p[2];
		
	      }
	    }
	  }
	  break;
	case 4:
	  for(j=starty;j<endy;j+=ys) {
	    for(i=startx;i<endx;i+=xs) {
	      ip = mat[0] * (i-sx) + mat[1] * (j-sy) + mat[2];
	      jp = mat[3] * (i-sx) + mat[4] * (j-sy) + mat[5];
	      if((ip >= 0) && (ip <= dx) && (jp >= 0) && (jp <= dy)) {

		p = s + (((int)j * si1->scan_length) + (int)i * b);
		r = d + (((((int)jp) * si2->scan_length) + 
			  ((int)ip) * b));

		*((long *)r) = *((long *)p);



	      }
	    }
	  }
	  break;
	default:
	  fprintf(stderr,"error: nonstandard bpp %d\n",b);
	  exit(1);
	}

      }
}
#endif
