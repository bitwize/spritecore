
(define-structures ((blitter 
		     (export rect-intersect! 
			     xfer-rect!
			     xfer-keyed-rect!
			     bound-xform-rect!
			     xform-clip!
			     xfer-xformed-rect!
			     xfer-xformed-keyed-rect!)))
  (open prescheme ps-record-types ps-memory ps-flonums) (files blitter))

(define-structures ((generic-blitter 
		     (export xfer-rect-32! xfer-rect-24! xfer-rect-16!
			     xfer-rect-8! xfer-rect-32-24-be!
			     xfer-rect-32-24-le!
			     xfer-keyed-rect-32! xfer-keyed-rect-24!
			     xfer-keyed-rect-16! xfer-keyed-rect-8!))) 
  (open prescheme ps-record-types ps-receive ps-memory ps-flonums) 
  (files generic-blitter))

