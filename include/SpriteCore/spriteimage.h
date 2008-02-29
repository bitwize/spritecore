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


#ifndef __SPRITEIMAGE_H
#define __SPRITEIMAGE_H

#include "matfunc.h"
#include "svec.h"

#define SIMG_FLIP_HORZ 1
#define SIMG_FLIP_VERT 2
#define SIMG_LITTLE_ENDIAN 0
#define SIMG_BIG_ENDIAN 1
#define SIMG_USE_KEY 4
#define SIMG_USE_ALPHA 8

/*!
  @typedef SpriteImage
  @discussion Platform independent representation of a bitmap image
  @field cx Width of image in pixels
  @field cy Height of image in pixels
  @field depth Depth in bits per pixel
  @field scan_length Length of one scan line
  @field endian Byte order of pixels
  @field bits Pointer to actual image pixels
  @field img Pointer to window-system-dependent representation of image
  @field auto_free Reserved for future use.
*/

typedef struct tagSpriteImage {
  unsigned int cx;
  unsigned int cy;
  unsigned int depth;
  unsigned int scan_length;
  unsigned int endian;
  void *bits;
  void *img;
  int auto_free;
} SpriteImage;

/*!
  @function ImageCopy
  @discussion SpriteCore's basic blitter. Copies one SpriteImage onto another
  with optional color-key compositing and other features. If any of the
  coordinates specified exceed the bounds of the source or destination images,
  clipping is automatically performed.

  @param si1 Source image.
  @param si2 Destination image.
  @param sx  Coordinate of left edge of source rectangle to copy.
  @param sy  Coordinate of top edge of source rectangle to copy.
  @param x   Coordinate of left edge of copied rectangle in destination image.
  @param y   Coordinate of top edge of copied rectangle in destination image.
  @param cx  Width of rectangle.
  @param cy  Height of rectangle.
  @param flags Special flags which affect the operation.
  @param key   Key color to use in compositing.
*/

void ImageCopy(SpriteImage *si1,SpriteImage *si2,int sx,int sy,int x,int y,int cx,int cy,int flags, char *key);

/*!
  @function get_key
  @discussion Gets the key color of the upper-left-hand corner of a SpriteImage
  and stores it in a char array of size 4, regardless of depth or endianness.
  @param si The SpriteImage whose key color we want
*/

void get_key(SpriteImage *si,char *k);

/*!
  @function MorpheusImageCopy
  @discussion SpriteCore's matrix-transform blitter. Copies one SpriteImage
  onto another with optional color-key compositing, transforming the source
  image according to the given matrix. Clipping is naive, and so very very slow
  if you scale the image to huge size (or have a huge image to begin with).
  I hope to change this in the near future.

  @param si1 Source image.
  @param si2 Destination image.
  @param sx  Coordinate of left edge of source rectangle to copy.
  @param sy  Coordinate of top edge of source rectangle to copy.
  @param cx  Width of rectangle.
  @param cy  Height of rectangle.
  @param mat Pointer to transformation matrix.
  @param flags Special flags which affect the operation.
  @param key   Key color to use in compositing.
*/

void MorpheusImageCopy(SpriteImage *si1,SpriteImage *si2,int sx,int sy,int cx,int cy,s_matp mat,int flags,char *key);

#endif
