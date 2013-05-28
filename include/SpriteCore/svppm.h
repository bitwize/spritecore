#ifndef __SVPPM_H
#define __SVPPM_H
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

#include <stdint.h>

void ReadPpmAsRgba(char *,int *,int *,uint8_t **);
void ReadPpmAsRgb(char *,int *,int *,uint8_t **);
void ReadPpmRgbConverted(char *ppmname,int *wret,int *hret,uint8_t **imgret,int bpp);
void ReadPpmRgbFromMemory(uint8_t *data,size_t sz,int *wret,int *hret,uint8_t **imgret);
void ReadPpmRgbFromMemoryConverted(uint8_t *data,size_t sz,int *wret,int *hret,uint8_t **imgret,int bpp);
uint8_t *
ConvertBpp(uint8_t *rgb,int cx,int cy,int bpp);
#endif

