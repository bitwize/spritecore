#ifndef _SPRITEEVENT_H
#define _SPRITEEVENT_H

#define SPRITEEVENT_SOURCE_KEYBOARD    1
#define SPRITEEVENT_SOURCE_MOUSE       2
#define SPRITEEVENT_SOURCE_JOYSTICK    4
#define SPRITEEVENT_SOURCE_VALUATOR    0x8000

#define SPRITEEVENT_VAL_KEY_RELEASE 0
#define SPRITEEVENT_VAL_KEY_PRESS   1

#ifndef _XLIB_H
#include <xkeysym.h>
#endif

struct tagSpriteEvent {
  unsigned long time;
  unsigned short source_type;
  unsigned short source_selector;
  unsigned int code;
  unsigned int value;
};

typedef struct tagSpriteEvent SpriteEvent;

#endif
