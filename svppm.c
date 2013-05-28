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

#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <SpriteCore/svppm.h>

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

uint8_t *ppm_next_line(uint8_t *p,size_t s)
{
	uint8_t *ep = p + s - 1;
	while(*p != '\n' || *(p+1) == '#') {
		p++;
		if(p >= ep) {return NULL;}
	}
	return (p+1);
}

void ReadPpmAsRgba(char *ppmname,int *wret,int *hret,uint8_t **rgbret)
{
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
	if(sscanf(ppmbuf,"P%d",&t) < 1) {free(ppmbuf); goto error;}
	if(t < 5) {free(ppmbuf); goto error;}
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
	*rgbret = (uint8_t *)r;
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


void ReadPpmAsRgb(char *ppmname,int *wret,int *hret,uint8_t **rgbret)
{
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
	if(sscanf(ppmbuf,"P%d",&t) < 1) {free(ppmbuf); goto error;}
	if(t < 5) {free(ppmbuf); goto error;}
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
	*rgbret = (uint8_t *)r;
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

void ReadPpmRgbFromMemory(uint8_t *data,size_t sz,int *wret,int *hret,
			  uint8_t **imgret)
{
	uint8_t *data2,*r,*p;
	int clr,cx,cy,i,t;
	if(!data) {
	error:
		*wret = 0;
		*hret = 0;
		*imgret = NULL;
		return;
	}
	if(sscanf(data,"P%d",&t) < 1) goto error;
	if(t < 5) goto error;
	data2 = ppm_next_line(data,sz);
	if(data2 == NULL) goto error;
	sz -= (data2 - data);
	data = data2;
	sscanf(data,"%d%d",wret,hret);
	cx = *wret; cy = *hret;
	data2 = ppm_next_line(data,sz);
	if(data2 == NULL) goto error;
	sz -= (data2 - data);
	data = data2;
	sscanf(data,"%d",&clr);
	if(clr != 255) goto error;
	data2 = ppm_next_line(data,sz);
	if(data2 == NULL) goto error;
	sz -= (data2 - data);
	p = data2;
	r = (uint8_t *)malloc(cx * cy * 3);
	*imgret = (uint8_t *)r;
	for(i=0;i < sz;i++) {
		*r = *p;
		r++; p++;
	}
}

void ReadPpmRgbConverted(char *ppmname,int *wret,int *hret,
			 uint8_t **imgret,int bpp)
{
	uint8_t *rgb;
	int cx,cy;
	ReadPpmAsRgb(ppmname,wret,hret,&rgb);
	cx = *wret;
	cy = *hret;
	*imgret = ConvertBpp(rgb,cx,cy,bpp);
	free(rgb);
}

void ReadPpmRgbFromMemoryConverted(uint8_t *data,size_t sz,
				   int *wret,int *hret,
				   uint8_t **imgret,int bpp)
{
	uint8_t *rgb;
	int cx,cy;
	ReadPpmRgbFromMemory(data,sz,wret,hret,&rgb);
	cx = *wret;
	cy = *hret;
	*imgret = ConvertBpp(rgb,cx,cy,bpp);
	free(rgb);
}

uint8_t *ConvertBpp(uint8_t *rgb,int cx,int cy,int bpp)
{
	uint8_t *image;
	uint16_t *image2;
	uint32_t *image4;
	int i;
	if(bpp!=8 && bpp!=15 && bpp!=16 && bpp!=24 && bpp!=32) {
		return NULL;
	}
	image = (uint8_t *)malloc(cx * cy * ((bpp+7)/8));
	if(!image) return image;
	image2 = (uint16_t *)image;
	image4 = (uint32_t *)image;
	for(i=0;i<cx*cy;i++) {
		switch(bpp) {
		case 8:
			image[i]=RED8(rgb[3*i]) | GRN8(rgb[3*i+1]) |
				BLU8(rgb[3*i+2]);
			break;
		case 15:
			image2[i]=RED15(rgb[3*i]) | GRN15(rgb[3*i+1]) |
				BLU15(rgb[3*i+2]);
			break;
		case 16:
			image2[i]=RED16(rgb[3*i]) | GRN16(rgb[3*i+1]) |
				BLU16(rgb[3*i+2]);
			break;
		case 24:
			image[3*i]=rgb[3*i]; image[3*i+1] = rgb[3*i+1];
			image[3*i+2] = rgb[3*i+2];
			break;
		case 32:
			image4[i]=RED32(rgb[3*i]) | GRN32(rgb[3*i+1]) |
				BLU32(rgb[3*i+2]);
			break;
		  
		}
	}
	return image;
}
