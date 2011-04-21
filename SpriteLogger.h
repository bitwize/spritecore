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

#ifndef __SPRITELOGGER_H
#define __SPRITELOGGER_H

#include <stdarg.h>

/*

  The SpriteLogger protocol is a generic interface to logging
  debugging info, status, etc.

*/

@protocol SpriteLogger

/*
  logCategory: cat message: msg,...   : (char *,char *,...) -> void

  Writes a message `msg' belonging to category `cat' to the log
  stream, formatting with the remaining arguments. Use as follows:

    [logger logCategory: "Test" message: "initializing engine"];
 

  And you'll get a log message:

    Test: initializing engine

  or summat.
 */
-(void)logCategory: (char *)cat message: (char*)msg,...;

/*
  varargsLogCategory: cat message: msg rest: rest
     : (char *,char *,va_list) -> void

  Writes a message `msg' belonging to category `cat' to the log
  stream, formatting with the arguments passed in va_list `rest' (as
  vprintf to printf).

  Best not to use directly, but in an implementation of the above
  interface.

 */


-(void)varargsLogCategory: (char *)cat message: (char *)msg rest: (va_list)rest;
@end


#endif
