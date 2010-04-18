#ifndef __SPRITELOGGER_H
#define __SPRITELOGGER_H
/*

  The SpriteLogger protocol is a generic interface to logging
  debugging info, status, etc.

*/

@protocol SpriteLogger

/*
  logCategory: cat message: msg   : (char *,char *) -> void

  Writes a message `msg' belonging to category `cat' to the log
  stream. Use as follows:

    [logger logCategory: "Test" message: "initializing engine"];
 

  And you'll get a log message:

    Test: initializing engine

  or summat.
 */
-(void)logCategory: (char *)cat message: (char*)msg,...;
@end


#endif
