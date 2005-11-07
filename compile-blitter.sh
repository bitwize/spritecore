(echo ',batch';echo ',exec ,load compile-blitter.scm';echo ',exit') | scheme48 -i ~/ps-compiler.image
(echo '1,$s/#include "prescheme.h"//g';echo ':wq') | ex -s blitter.psc
