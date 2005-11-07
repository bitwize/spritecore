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
 * Some functions copyright (c) 2000 Gerd Knorr
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

#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>
#include <stdio.h>
#include "svppm.h"

#define RED8(x) ((x >> 5) << 5)
#define GRN8(x) ((x >> 5) << 2)
#define BLU8(x) (x >> 6)

#define RED15(x) ((x >> 3) << 10)
#define GRN15(x) ((x >> 3) << 5)
#define BLU15(x) (x >> 3)

#define RED16(x) ((x >> 3) << 11)
#define GRN16(x) ((x >> 2) << 5)
#define BLU16(x) (x >> 3)

#define RED32(x) (x << 16)
#define GRN32(x) (x << 8)
#define BLU32(x) (x)

void ReadPpmAsRgba(char *ppmname,int *wret,int *hret,unsigned char **rgbret) {
  FILE *fp;
  char *ppmbuf,*p,*r;
  int cx,cy,i,t;
  struct stat st;
  stat(ppmname,&st);
  fp = fopen(ppmname,"r");
  if(!fp) {
error:
    *wret = 0;
    *hret = 0;
    *rgbret = NULL;
    return;
  }
  ppmbuf = (char *)malloc(st.st_size);
  fgets(ppmbuf,st.st_size,fp);
  if(sscanf(ppmbuf,"P%d",&t) < 1) goto error;
  if(t < 5) goto error;
  for(;;) {
    fgets(ppmbuf,st.st_size,fp);
    if(ppmbuf[0] == '#' || ppmbuf[0] == '\n') continue;
    break;
  }
  sscanf((char *)ppmbuf,"%d%d",&cx,&cy);
  *wret = cx;
  *hret = cy;
  fgets(ppmbuf,st.st_size,fp);
#ifdef __LJBAD_DEBUG
  printf("%d %d\n",cx,cy);
#endif /* __LJBAD_DEBUG */
  fread(ppmbuf,3,cx*cy,fp);
  p = ppmbuf;
  r = (char *)malloc(cx * cy * 4);
  *rgbret = (unsigned char *)r;
  for(i=0;i < cx * cy;i++) {
    *r = *p;
    r++; p++;
    *r = *p;
    r++; p++;
    *r = *p;
    r++; p++;
    *r = 0xff;
    r++;
  }
  fclose(fp);
  free(ppmbuf);
}


void ReadPpmAsRgb(char *ppmname,int *wret,int *hret,unsigned char **rgbret) {
  FILE *fp;
  char *ppmbuf,*p,*r;
  int cx,cy,i,t;
  struct stat st;
  stat(ppmname,&st);
  fp = fopen(ppmname,"r");
  if(!fp) {
error:
    *wret = 0;
    *hret = 0;
    *rgbret = NULL;
    return;
  }
  ppmbuf = (char *)malloc(st.st_size);
  fgets(ppmbuf,st.st_size,fp);
  if(sscanf(ppmbuf,"P%d",&t) < 1) goto error;
  if(t < 5) goto error;
  for(;;) {
    fgets(ppmbuf,st.st_size,fp);
    if(ppmbuf[0] == '#' || ppmbuf[0] == '\n') continue;
    break;
  }
  sscanf((char *)ppmbuf,"%d%d",&cx,&cy);
  *wret = cx;
  *hret = cy;
  fgets(ppmbuf,st.st_size,fp);
#ifdef __LJBAD_DEBUG
  printf("%d %d\n",cx,cy);
#endif /* __LJBAD_DEBUG */
  fread(ppmbuf,3,cx*cy,fp);
  p = ppmbuf;
  r = (char *)malloc(cx * cy * 3);
  *rgbret = (unsigned char *)r;
  for(i=0;i < cx * cy;i++) {
    *r = *p;
    r++; p++;
    *r = *p;
    r++; p++;
    *r = *p;
    r++; p++;
  }
  fclose(fp);
  free(ppmbuf);
}

void ReadPpmRgbConverted(char *ppmname,int *wret,int *hret,unsigned char **imgret,int bpp) {
  unsigned char *rgb;
  int cx,cy;
  ReadPpmAsRgb(ppmname,wret,hret,&rgb);
  cx = *wret;
  cy = *hret;
  *imgret = ConvertBpp(rgb,cx,cy,bpp);
  free(rgb);
}

unsigned char *ConvertBpp(unsigned char *rgb,int cx,int cy,int bpp) {
  unsigned char *image;
  unsigned short *image2;
  unsigned long *image4;
  int i;
  if(bpp!=8 && bpp!=15 && bpp!=16 && bpp!=24 && bpp!=32) {
    return NULL;
  }
  image = (unsigned char *)malloc(cx * cy * ((bpp+7)/8));
  if(!image) return image;
  image2 = (unsigned short *)image;
  image4 = (unsigned long *)image;
  for(i=0;i<cx*cy;i++) {
      switch(bpp) {
      case 8:
	image[i]=RED8(rgb[3*i]) | GRN8(rgb[3*i+1]) | BLU8(rgb[3*i+2]);
	break;
      case 15:
	image2[i]=RED15(rgb[3*i]) | GRN15(rgb[3*i+1]) | BLU15(rgb[3*i+2]);
	break;
      case 16:
	image2[i]=RED16(rgb[3*i]) | GRN16(rgb[3*i+1]) | BLU16(rgb[3*i+2]);
	break;
      case 24:
	image[3*i]=rgb[3*i]; image[3*i+1] = rgb[3*i+1];
	image[3*i+2] = rgb[3*i+2];
	break;
      case 32:
	image4[i]=RED32(rgb[3*i]) | GRN32(rgb[3*i+1]) | BLU32(rgb[3*i+2]);
	break;
      }
  }
  return image;
}
