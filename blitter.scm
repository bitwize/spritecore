;;  Copyright 1995-2008 Jeffrey T. Read

;; This file is part of SpriteCore.

;; This software is provided 'as-is', without any express or implied
;; warranty.  In no event will the authors be held liable for any
;; damages arising from the use of this software.

;; Permission is granted to anyone to use this software for any purpose,
;; including commercial applications, and to alter it and redistribute it
;; freely, subject to the following restrictions:

;; 1. The origin of this software must not be misrepresented; you must not
;;    claim that you wrote the original software. If you use this software
;;    in a product, an acknowledgment in the product documentation would be
;;    appreciated but is not required.
;; 2. Altered source versions must be plainly marked as such, and must not be
;;    misrepresented as being the original software.
;; 3. This notice may not be removed or altered from any source distribution.

(define n->float (external "TO_FLOAT" (=> (integer)
					   float)))


(define n->integer (external "TO_INTEGER" (=> (float)
					      integer)))


(define-record-type rect rect (make-rect left top right bottom)
  (left integer rect-left set-rect-left!)
  (top integer rect-top set-rect-top!)
  (right integer rect-right set-rect-right!)
  (bottom integer rect-bottom set-rect-bottom!))


(define (rect-intersect! r1 r2 r3)
  (let ((l (if (< (rect-left r2) (rect-left r1))
	       (rect-left r1)
	       (if (> (rect-left r2) (rect-right r1))
		   (rect-right r1)
		   (rect-left r2))))
	(t (if (< (rect-top r2) (rect-top r1))
	       (rect-top r1)
	       (if (> (rect-top r2)
		       (rect-bottom r1))
		   (rect-bottom r1)
		   (rect-top r2))))
	(r (if (> (rect-right r2) (rect-right r1))
	       (rect-right r1)
	       (if (< (rect-right r2)
		       (rect-left r1))
		   (rect-left r1)
		   (rect-right r2))))
	(b (if (> (rect-bottom r2) (rect-bottom r1))
	       (rect-bottom r1)
	       (if (< (rect-bottom r2)
		      (rect-top r1))
		   (rect-top r1)
		   (rect-bottom r2)))))
    (set-rect-left! r3 l)
    (set-rect-top! r3 t)
    (set-rect-right! r3 r)
    (set-rect-bottom! r3 b)))

(define (set-rect-from! r1 r2)
  (set-rect-left! r1 (rect-left r2))
  (set-rect-top! r1 (rect-top r2))
  (set-rect-right! r1 (rect-right r2))
  (set-rect-bottom! r1 (rect-bottom r2))
  )

(define (pt-in-rect x y rect)
  (and (>= x (rect-left rect))
       (< x (rect-right rect))
       (>= y (rect-top rect))
       (< y (rect-bottom rect))))


(define mat-invert3x3! (external "mat_invert3x3" (=> ((^ float)
						     (^ float))
						    integer)))


(define (xform-x mat x y)      
  (fl+ (fl* (vector-ref mat 0)
	    x)
       (fl* (vector-ref mat 1)
	    y)
       (vector-ref mat 2)
	   
       ))

(define (xform-y mat x y)
  
  
  (fl+ (fl* (vector-ref mat 3)
	    x)
       (fl* (vector-ref mat 4)
	    y)
       (vector-ref mat 5)
	   
       ))

(define (xform-rect mat r)
  (values
   (xform-x mat (n->float (rect-left r))
	    (n->float (rect-top r)))
   (xform-y mat (n->float (rect-left r))
	    (n->float (rect-top r)))
   (xform-x mat (n->float (rect-right r))
	    (n->float (rect-top r)))
   (xform-y mat (n->float (rect-right r))
	    (n->float (rect-top r)))
   (xform-x mat (n->float (rect-left r))
	    (n->float (rect-bottom r)))
   (xform-y mat (n->float (rect-left r))
	    (n->float (rect-bottom r)))
   (xform-x mat (n->float (rect-right r))
	    (n->float (rect-bottom r)))
   (xform-y mat (n->float (rect-right r))
	    (n->float (rect-bottom r)))
   r))

(define (min4 a b c d)
  (min (min (min a b)
	    c)
       d))
(define (max4 a b c d)
  (max (max (max a b)
	    c)
       d))


(define (bound-quad! x1 y1 x2 y2 x3 y3 x4 y4 r)
  (set-rect-left! r (min4
		     (n->integer x1)
		     (n->integer x2)
		     (n->integer x3)
		     (n->integer x4)))
  (set-rect-right! r (max4
		      (n->integer x1)
		      (n->integer x2)
		      (n->integer x3)
		      (n->integer x4)))
  (set-rect-top! r (min4 (n->integer y1)
			(n->integer y2)
			(n->integer y3)
			(n->integer y4)))
  (set-rect-bottom! r (max4 (n->integer y1)
			 (n->integer y2)
			 (n->integer y3)
			 (n->integer y4)))
  r)

(define (bound-xform-rect! mat r)
  (call-with-values (lambda ()
		      (xform-rect mat r))
    (lambda (x1 y1 x2 y2 x3 y3 x4 y4 r)
      (bound-quad! x1 y1 x2 y2 x3 y3 x4 y4 r))))

(define (xform-clip! mat inv src-rect dest-rect scratch1 scratch2)
  (if (= (mat-invert3x3! mat inv)
	 0)
      (begin
	(set-rect-from! scratch1 src-rect)
	(bound-xform-rect! mat src-rect)
	(rect-intersect! dest-rect src-rect scratch2)
	(bound-xform-rect! inv scratch2)
	(set-rect-right! scratch2 (+ 1 (rect-right scratch2)))
	(set-rect-bottom! scratch2 (+ 1 (rect-bottom scratch2)))
	(rect-intersect! scratch1 scratch2 src-rect)
	)))


(define (set-pxl-8! addr1 off1 addr2 off2)
  (unsigned-byte-set! (address+ addr1 off1)
		      (unsigned-byte-ref (address+ addr2 off2))))

(define (set-pxl-16! addr1 off1 addr2 off2)
  (unsigned-byte-set! (address+ addr1  (* off1 2))
		      (unsigned-byte-ref (address+ addr2 (* off2 2))))
  (unsigned-byte-set! (address+ addr1  (+ (* off1 2) 1))
		      (unsigned-byte-ref (address+ addr2 (+ (* off2 2) 1))))
  )

(define (set-pxl-24! addr1 off1 addr2 off2)
  (unsigned-byte-set! (address+ addr1  (* off1 3))
		      (unsigned-byte-ref (address+ addr2 (* off2 3))))
  (unsigned-byte-set! (address+ addr1  (+ (* off1 3) 1))		      
		      (unsigned-byte-ref (address+ addr2 (+ (* off2 3) 1))))
  (unsigned-byte-set! (address+ addr1  (+ (* off1 3) 2))		      
		      (unsigned-byte-ref (address+ addr2 (+ (* off2 3) 2))))
  )

(define (set-pxl-32! addr1 off1 addr2 off2)
  (unsigned-byte-set! (address+ addr1  (* off1 4))		      
		      (unsigned-byte-ref (address+ addr2 (* off2 4))))
  (unsigned-byte-set! (address+ addr1  (+ (* off1 4) 1))		      
		      (unsigned-byte-ref (address+ addr2 (+ (* off2 4) 1))))
  (unsigned-byte-set! (address+ addr1  (+ (* off1 4) 2))		      
		      (unsigned-byte-ref (address+ addr2 (+ (* off2 4) 2))))
  (unsigned-byte-set! (address+ addr1  (+ (* off1 4) 3))		      
		      (unsigned-byte-ref (address+ addr2 (+ (* off2 4) 3))))
  )

(define (pxl-8=? addr off px)
  (= (unsigned-byte-ref (address+ addr off))
     (unsigned-byte-ref px)))


(define (pxl-16=? addr off px)
  (and
   (= (unsigned-byte-ref (address+ addr (* off 2)))
      (unsigned-byte-ref px)
      )
   (= (unsigned-byte-ref (address+ addr (+ (* off 2) 1)))
      (unsigned-byte-ref (address+ px 1))
      )))

(define (pxl-24=? addr off px)
  (and
   (= (unsigned-byte-ref (address+ addr (* off 3)))
      (unsigned-byte-ref px))
   (= (unsigned-byte-ref (address+ addr (+ (* off 3) 1)))
      (unsigned-byte-ref (address+ px 1)))
   (= (unsigned-byte-ref (address+ addr (+ (* off 3) 2)))
      (unsigned-byte-ref (address+ px 2)))))

(define (pxl-32=? addr off px)
  (and
   (= (unsigned-byte-ref (address+ addr (* off 4)))
      (unsigned-byte-ref px))
   (= (unsigned-byte-ref (address+ addr (+ (* off 4) 1)))
      (unsigned-byte-ref (address+ px 1)))
   (= (unsigned-byte-ref (address+ addr (+ (* off 4) 2)))
      (unsigned-byte-ref (address+ px 2)))
   (= (unsigned-byte-ref (address+ addr (+ (* off 4) 3)))
      (unsigned-byte-ref (address+ px 3)))))


(define (set-pixel! addr1 off1 addr2 off2 bpp)
  (cond
   ((= bpp 8)
    (set-pxl-8! addr1 off1 addr2 off2))
   ((= bpp 15)
    (set-pxl-16! addr1 off1 addr2 off2))
   ((= bpp 16)
    (set-pxl-16! addr1 off1 addr2 off2))
   ((= bpp 24)
    (set-pxl-24! addr1 off1 addr2 off2))
   ((= bpp 32)
    (set-pxl-32! addr1 off1 addr2 off2))
   
   ))

(define (set-keyed-pxl-8! addr1 off1 addr2 off2 key)
    (if (not (pxl-8=? addr2 off2 key))
	(set-pxl-8! addr1 off1 addr2 off2)))

(define (set-keyed-pxl-16! addr1 off1 addr2 off2 key)
    (if (not (pxl-16=? addr2 off2 key))
	(set-pxl-16! addr1 off1 addr2 off2)))

(define (set-keyed-pxl-24! addr1 off1 addr2 off2 key)
    (if (not (pxl-24=? addr2 off2 key))
	(set-pxl-24! addr1 off1 addr2 off2)))

(define (set-keyed-pxl-32! addr1 off1 addr2 off2 key)
    (if (not (pxl-32=? addr2 off2 key))
	(set-pxl-32! addr1 off1 addr2 off2)))

(define (set-keyed-pixel! addr1 off1 addr2 off2 key bpp)
  ((case bpp
     ((8) set-keyed-pxl-8!)
     ((15 16) set-keyed-pxl-16!)
     ((24) set-keyed-pxl-24!)
     (else set-keyed-pxl-32!))
   addr1 off1 addr2 off2 key))

(define-syntax xfer-scanline!-maker
  (syntax-rules ()
    ((xfer-scanline!-maker set-pixel!)
     (lambda (addr1 dx addr2 sx ex)
       (let loop ((i sx))
	 (if (< i ex)
	     (begin (set-pixel! addr1  (+ dx (- i sx))
				addr2 i)
		    (loop (+ i 1)))))))))

(define xfer-scanline-8!
  (xfer-scanline!-maker set-pxl-8!))
(define xfer-scanline-16!
  (xfer-scanline!-maker set-pxl-16!))
(define xfer-scanline-24!
  (xfer-scanline!-maker set-pxl-24!))
(define xfer-scanline-32!
  (xfer-scanline!-maker set-pxl-32!))

(define-syntax xfer-keyed-scanline!-maker
  (syntax-rules ()
    ((xfer-keyed-scanline!-maker set-keyed-pixel!)
     (lambda (addr1 dx addr2 sx ex key)
       (let loop ((i sx))
	 (if (< i ex)
	     (begin (set-keyed-pixel! addr1 (+ dx (- i sx))
				      addr2 i key)
		    (loop (+ i 1)))))))))

(define xfer-keyed-scanline-8!
  (xfer-keyed-scanline!-maker set-keyed-pxl-8!))
(define xfer-keyed-scanline-16!
  (xfer-keyed-scanline!-maker set-keyed-pxl-16!))
(define xfer-keyed-scanline-24!
  (xfer-keyed-scanline!-maker set-keyed-pxl-24!))
(define xfer-keyed-scanline-32!
  (xfer-keyed-scanline!-maker set-keyed-pxl-32!))

(define-syntax blitter-select 
  (syntax-rules ()
  ((blitter-select bpp b8 b16 b24 b32)
   (case bpp
     ((8) b8)
     ((15 16) b16)
     ((24) b24)
     (else b32)))))

(define-syntax
  xfer-keyed-rect!-maker
  (syntax-rules ()
    ((xfer-keyed-rect!-maker xfer-keyed-scanline!)
     (lambda (addr1 dx dy sl1 addr2 sx sy ex ey sl2 key)
       (let loop ((i sy))
	 (if (< i ey)
	     (begin (xfer-keyed-scanline! (address+ addr1
						    (* sl1 (+ dy (- i sy))))
					  dx  (address+ addr2 (* sl2 i))
					  sx ex key)
		    (loop (+ i 1)))))))))
  
(define-syntax xfer-rect!-maker
  (syntax-rules ()
    ((xfer-rect!-maker xfer-scanline!)
     (lambda (addr1 dx dy sl1 addr2 sx sy ex ey sl2)
       (let loop ((i sy))
	 (if (< i ey)
	     (begin (xfer-scanline! (address+ addr1
					      (* sl1 (+ dy (- i sy))))
				    dx (address+ addr2 (* sl2 i))
				    sx ex)
		    (loop (+ i 1)))))))))

(define (xfer-rect! addr1 dx dy sl1 addr2 sx sy ex ey sl2 bpp)
  ((blitter-select bpp
		   (xfer-rect!-maker xfer-scanline-8!)
		   (xfer-rect!-maker xfer-scanline-16!)
		   (xfer-rect!-maker xfer-scanline-24!)
		   (xfer-rect!-maker xfer-scanline-32!))
   addr1 dx dy sl1 addr2 sx sy ex ey sl2))

(define (xfer-keyed-rect! addr1 dx dy sl1 addr2 sx sy ex ey sl2 key bpp)
  ((blitter-select bpp
		   (xfer-keyed-rect!-maker xfer-keyed-scanline-8!)
		   (xfer-keyed-rect!-maker xfer-keyed-scanline-16!)
		   (xfer-keyed-rect!-maker xfer-keyed-scanline-24!)
		   (xfer-keyed-rect!-maker xfer-keyed-scanline-32!))
   addr1 dx dy sl1 addr2 sx sy ex ey sl2 key))

(define (flabs x)
  (if (fl< x 0.0)
      (fl- x)
      x))






(define (xfer-xformed-rect! addr1 sl1 addr2 sx sy ex ey sl2 mat r bpp)
  (let* ((fsy (n->float sy))
	 (fey (n->float ey))
	 (fsx (n->float sx))
	 (fex (n->float ex))
	 (sclx (flabs (vector-ref mat 0)))
	 
	 (scly (flabs (vector-ref mat 4)))
	 (incx (if (fl< sclx 1.)
		   0.5
		   (fl/ 0.5 sclx)))
	 (incy (if (fl< scly 1.)
		   0.5
		   (fl/ 0.5 scly)))
	 
	 )
    
   (let loop1 ((j fsy))
     (if (fl< j fey)
	 (begin
	   (let loop ((i fsx))
	     (if (fl< i fex)
		 (let ((u (n->integer (xform-x mat i j)))
		       (v (n->integer (xform-y mat i j))))
		   (if
		    (pt-in-rect u v r)
		    (set-pixel! (address+ addr1 (* v sl1))
				u
				(address+ addr2 (* (n->integer j)
						   sl2))
				(n->integer i)
				bpp))
		   (loop (fl+ i incx)))))
	   (loop1 (fl+ j incy)))))))



(define-syntax xfer-xformed-keyed-rect!-maker
  (syntax-rules ()
    ((xfer-xformed-keyed-rect! set-keyed-pixel!)
     (lambda (addr1 sl1 addr2 sx sy ex ey sl2 mat r key)
       (let* ((fsy (n->float sy))
	      (fey (n->float ey))
	      (fsx (n->float sx))
	      (fex (n->float ex))
	      (sclx (flabs (vector-ref mat 0)))
	      
	      (scly (flabs (vector-ref mat 4)))
	      (incx (if (fl< sclx 1.)
			0.5
			(fl/ 0.5 sclx)))
	      (incy (if (fl< scly 1.)
			0.5
			(fl/ 0.5 scly)))
	      
	      )
	 
	 (let loop1 ((j fsy))
	   (if (fl< j fey)
	       (begin
		 (let loop ((i fsx))
		   (if (fl< i fex)
		       (let ((u (n->integer (xform-x mat i j)))
			     (v (n->integer (xform-y mat i j))))
			 (if
			  (pt-in-rect u v r)
			  (set-keyed-pixel! (address+ addr1 (* v sl1))
					    u
					    (address+ addr2 (* (n->integer j)
							       sl2))
					    (n->integer i)
					    key))
			 (loop (fl+ i incx)))))
		 (loop1 (fl+ j incy))))))))))

(define (xfer-xformed-keyed-rect! addr1 sl1 addr2 sx sy ex ey sl2 mat r key bpp)
  ((blitter-select bpp
		   (xfer-xformed-keyed-rect!-maker set-keyed-pxl-8!)
		   (xfer-xformed-keyed-rect!-maker set-keyed-pxl-16!)
		   (xfer-xformed-keyed-rect!-maker set-keyed-pxl-24!)
		   (xfer-xformed-keyed-rect!-maker set-keyed-pxl-32!))
   addr1 sl1 addr2 sx sy ex ey sl2 mat r key))
