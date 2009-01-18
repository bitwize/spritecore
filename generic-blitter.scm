
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
    ((make-blitter rop)
     (lambda (dest-image
	      dest-x
	      dest-y
	      dest-pixel-size
	      dest-scan-length
	      src-image
	      src-x
	      src-y
	      src-pixel-size
	      src-scan-length
	      size-x
	      size-y)
       (let loop1 ((y 0))
	 (let loop2 ((x 0))
	   (cond
	    ((>= y size-y) (unspecific))
	    ((>= x size-x) (loop1 (+ y 1)))
	    (else
	     (let ((srcp-x (+ src-x x))
		   (srcp-y (+ src-y y))
		   (destp-x (+ dest-x x))
		   (destp-y (+ dest-y y)))
	       (rop destp-x
		    destp-y
		    (image-location->address dest-image destp-x destp-y
					     dest-pixel-size
					     dest-scan-length)
		    srcp-x
		    srcp-y 
		    (image-location->address src-image srcp-x srcp-y
					     src-pixel-size
					     src-scan-length))
	       (loop2 (+ x 1)))))))))))



(define-syntax make-rop
  (syntax-rules ()
    ((make-rop bpp-in bpp-out (dx dy dp sx sy sp) expr)
       (lambda (dx dy da sx sy sa)
	 (let ((sp (pixel-ref bpp-in sa))
	       (dp (pixel-ref bpp-in da)))
	   (pixel-set! bpp-out da expr))))))

(define-syntax make-pixel-copy
  (syntax-rules ()
    ((make-pixel-copy bpp)
     (make-rop bpp bpp (dx dy dp sx sy sp) sp))))



(define xfer-rect-32! (make-blitter (make-pixel-copy 32)))
(define xfer-rect-24! (make-blitter (make-pixel-copy 24)))
(define xfer-rect-16! (make-blitter (make-pixel-copy 16)))
(define xfer-rect-8! (make-blitter (make-pixel-copy 8)))
(define xfer-rect-32-24-be! (make-blitter
			     (make-rop 32 24 (dx dy dp sx sy sp)
				       (logical-shift-right sp 8))))
(define xfer-rect-32-24-le! (make-blitter
			     (make-rop 32 24 (dx dy dp sx sy sp)
				       (bitwise-and sp 16777215))))

(define-syntax make-pixel-keyed-copy
  (syntax-rules ()
    ((make-pixel-keyed-copy bpp key-address)
     (make-rop bpp bpp  (dx dy dp sx sy sp)
	       (let ((kp (pixel-ref bpp key-address)))
		 (if (= sp kp) dp sp))))))

(define (xfer-keyed-rect-32! dest-image
			     dest-x
			     dest-y
			     dest-pixel-size
			     dest-scan-length
			     src-image
			     src-x
			     src-y
			     src-pixel-size
			     src-scan-length
			     size-x
			     size-y
			     key-address)
  (let ((blt (make-blitter (make-pixel-keyed-copy 32 key-address))))
    (blt dest-image dest-x dest-y dest-pixel-size dest-scan-length
	 src-image src-x src-y src-pixel-size src-scan-length
	 size-x size-y)))
(define (xfer-keyed-rect-24! dest-image
			     dest-x
			     dest-y
			     dest-pixel-size
			     dest-scan-length
			     src-image
			     src-x
			     src-y
			     src-pixel-size
			     src-scan-length
			     size-x
			     size-y
			     key-address)
  (let ((blt (make-blitter (make-pixel-keyed-copy 24 key-address))))
    (blt dest-image dest-x dest-y dest-pixel-size dest-scan-length
	 src-image src-x src-y src-pixel-size src-scan-length
	 size-x size-y)))
(define (xfer-keyed-rect-16! dest-image
			     dest-x
			     dest-y
			     dest-pixel-size
			     dest-scan-length
			     src-image
			     src-x
			     src-y
			     src-pixel-size
			     src-scan-length
			     size-x
			     size-y
			     key-address)
  (let ((blt (make-blitter (make-pixel-keyed-copy 16 key-address))))
    (blt dest-image dest-x dest-y dest-pixel-size dest-scan-length
	 src-image src-x src-y src-pixel-size src-scan-length
	 size-x size-y)))

(define (xfer-keyed-rect-8! dest-image
			     dest-x
			     dest-y
			     dest-pixel-size
			     dest-scan-length
			     src-image
			     src-x
			     src-y
			     src-pixel-size
			     src-scan-length
			     size-x
			     size-y
			     key-address)
  (let ((blt (make-blitter (make-pixel-keyed-copy 8 key-address))))
    (blt dest-image dest-x dest-y dest-pixel-size dest-scan-length
	 src-image src-x src-y src-pixel-size src-scan-length
	 size-x size-y)))

