
(define (image-location->address image-address
				 x
				 y
				 pixel-size
				 scan-length)
  (address+ image-address
	    (+ (* y scan-length)
	       (* x pixel-size))))

(define (pixel-set-8! pixel-address i)
  (unsigned-byte-set! pixel-address (bitwise-and i 255)))


(define (pixel-set-16! pixel-address i)
  (unsigned-byte-set! pixel-address
		      (bitwise-and (logical-shift-right i 8) 255))
  (unsigned-byte-set! (address+ pixel-address 1)
		      (bitwise-and i 255)))

(define (pixel-set-24! pixel-address i)
  (unsigned-byte-set! pixel-address
		      (bitwise-and (logical-shift-right i 16) 255))
  (unsigned-byte-set! (address+ pixel-address 1)
		      (bitwise-and (logical-shift-right i 8) 255))
  (unsigned-byte-set! (address+ pixel-address 2)
		      (bitwise-and i 255)))

(define (pixel-set-32! pixel-address i)
  (unsigned-byte-set! pixel-address
		      (bitwise-and (logical-shift-right i 24) 255))
  (unsigned-byte-set! (address+ pixel-address 1)
		      (bitwise-and (logical-shift-right i 16) 255))
  (unsigned-byte-set! (address+ pixel-address 2)
		      (bitwise-and (logical-shift-right i 8) 255))
  (unsigned-byte-set! (address+ pixel-address 3)
		      (bitwise-and i 255)))

(define (pixel-ref-8 pixel-address)
  (unsigned-byte-ref pixel-address))

(define (pixel-ref-16 pixel-address)
  (bitwise-ior
   (shift-left (unsigned-byte-ref pixel-address) 8)
   (unsigned-byte-ref (address+ pixel-address 1))))

(define (pixel-ref-24 pixel-address)
  (bitwise-ior
   (bitwise-ior
    (shift-left (unsigned-byte-ref pixel-address) 16)
    (shift-left (unsigned-byte-ref (address+ pixel-address 1)) 8))
   (unsigned-byte-ref (address+ pixel-address 2))))

(define (pixel-ref-32 pixel-address)
  (bitwise-ior
   (bitwise-ior
    (bitwise-ior
     (shift-left (unsigned-byte-ref pixel-address) 24)
     (shift-left (unsigned-byte-ref (address+ pixel-address 1)) 16))
    (shift-left (unsigned-byte-ref (address+ pixel-address 2)) 8))
   (unsigned-byte-ref (address+ pixel-address 3))))

(define-syntax pixel-set!
  (syntax-rules ()
    ((pixel-set! 8 addr a) (pixel-set-8! addr a))
    ((pixel-set! 16 addr a) (pixel-set-16! addr a))
    ((pixel-set! 24 addr a) (pixel-set-24! addr a))
    ((pixel-set! 32 addr a) (pixel-set-32! addr a))))

(define-syntax pixel-ref
  (syntax-rules ()
    ((pixel-ref 8 addr) (pixel-ref-8 addr))
    ((pixel-ref 16 addr) (pixel-ref-16 addr))
    ((pixel-ref 24 addr) (pixel-ref-24 addr))
    ((pixel-ref 32 addr) (pixel-ref-32 addr))))

(define-syntax make-blitter
  (syntax-rules
      ()
    ((make-blitter bpp-in bpp-out rop)
     (lambda (dest-image
	      dest-x
	      dest-y
	      dest-scan-length
	      src-image
	      src-x
	      src-y
	      src-scan-length
	      size-x
	      size-y)
       (let loop1 ((y 0))
	 (let loop2 ((x 0))
	   (cond
	    ((>= y size-y) (unspecific))
	    ((>= x size-x) (loop1 (+ y 1)))
	    (else
	     (let* ((srcp-x (+ src-x x))
		   (srcp-y (+ src-y y))
		   (srcp-address
		    (image-location->address 
		     src-image srcp-x srcp-y
		     (logical-shift-right bpp-in 8)
		     src-scan-length))
		   (destp-x (+ dest-x x))
		   (destp-y (+ dest-y y))
		   (destp-address
		    (image-location->address 
		     dest-image destp-x destp-y
		     (logical-shift-right bpp-out 8)
		     dest-scan-length)))
	       (pixel-set! bpp-out 
			   destp-address
			   (rop destp-x
				destp-y
				(pixel-ref 
				 bpp-in
				 destp-address)
				srcp-x
				srcp-y 
				(pixel-ref
				 bpp-in
				 srcp-address)))
	       (loop2 (+ x 1)))))))))))



(define-syntax make-rop
  (syntax-rules ()
    ((make-rop bpp-in bpp-out (dx dy dp sx sy sp) expr)
       (lambda (dx dy da sx sy sa)
	 (let ((sp (pixel-ref bpp-in sa))
	       (dp (pixel-ref bpp-in da)))
	   (pixel-set! bpp-out da expr))))))

(define-syntax make-xfer-rect
  (syntax-rules ()
    ((make-xfer-rect bpp)
     (make-blitter bpp bpp
		   (lambda (dx dy dp sx sy sp) sp)))))


(define xfer-rect-32! (make-xfer-rect 32))
(define xfer-rect-24! (make-xfer-rect 24))
(define xfer-rect-16! (make-xfer-rect 16))
(define xfer-rect-8! (make-xfer-rect 8))

(define xfer-rect-32-24-be! (make-blitter 32 24 
					  (lambda (dx dy dp sx sy sp)
					    (logical-shift-right sp 8))))
(define xfer-rect-32-24-le! (make-blitter 32 24
					  (lambda (dx dy dp sx sy sp)
						   (bitwise-and sp 16777215))))

(define-syntax 
  make-xfer-keyed-rect
  (syntax-rules ()
    ((make-xfer-keyed-rect bpp)
     (lambda  (dest-image
	       dest-x
	       dest-y
	       dest-scan-length
	       src-image
	       src-x
	       src-y
	       src-scan-length
	       size-x
	       size-y
	       key-address)
       (let ((kp (pixel-ref bpp key-address)))
	 (let ((blt (make-blitter bpp bpp
				  (lambda (dx dy dp sx sy sp)
				    (if (= sp kp) dp sp)))))
	   (blt dest-image dest-x dest-y dest-scan-length
		src-image src-x src-y src-scan-length
		size-x size-y)))))))


(define xfer-keyed-rect-32! (make-xfer-keyed-rect 32))
(define xfer-keyed-rect-24! (make-xfer-keyed-rect 24))
(define xfer-keyed-rect-16! (make-xfer-keyed-rect 16))
(define xfer-keyed-rect-8! (make-xfer-keyed-rect 8))

