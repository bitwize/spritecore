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

(define (set-keyed-pixel! addr1 off1 addr2 off2 key bpp)
  (cond
   ((= bpp 8)
    (if (not (pxl-8=? addr2 off2 key))
	(set-pxl-8! addr1 off1 addr2 off2)))
   ((= bpp 15)
    (if (not (pxl-16=? addr2 off2 key))
	(set-pxl-16! addr1 off1 addr2 off2)))
   ((= bpp 16)
    (if (not (pxl-16=? addr2 off2 key))
	(set-pxl-16! addr1 off1 addr2 off2)))
   ((= bpp 24)
    (if (not (pxl-24=? addr2 off2 key))
	(set-pxl-24! addr1 off1 addr2 off2)))
   ((= bpp 32)
    (if (not (pxl-32=? addr2 off2 key))
	(set-pxl-32! addr1 off1 addr2 off2)))
   
   ))

(define (xfer-scanline! addr1 dx addr2 sx ex bpp)
  
  (let loop ((i sx))
    (if (< i ex)
	(begin (set-pixel! addr1  (+ dx (- i sx))
			   addr2 i bpp)
	       (loop (+ i 1))))))

(define (xfer-keyed-scanline! addr1 dx addr2 sx ex key bpp)
  
  (let loop ((i sx))
    (if (< i ex)
	(begin (set-keyed-pixel! addr1  (+ dx (- i sx))
			   addr2 i key bpp)
	       (loop (+ i 1))))))


(define (xfer-keyed-rect! addr1 dx dy sl1 addr2 sx sy ex ey sl2 key bpp)
  (let loop ((i sy))
    (if (< i ey)
	(begin (xfer-keyed-scanline! (address+ addr1
					       (* sl1 (+ dy (- i sy))))
				     dx  (address+ addr2 (* sl2 i))
				     sx ex key bpp)
	       (loop (+ i 1))))))

(define (xfer-rect! addr1 dx dy sl1 addr2 sx sy ex ey sl2 bpp)
  (let loop ((i sy))
    (if (< i ey)
	(begin (xfer-scanline! (address+ addr1
					 (* sl1 (+ dy (- i sy))))
			       dx (address+ addr2 (* sl2 i))
			       sx ex bpp)
	       (loop (+ i 1))))))

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



(define (xfer-xformed-keyed-rect! addr1 sl1 addr2 sx sy ex ey sl2 mat r key bpp)
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
				key
				bpp))
		   (loop (fl+ i incx)))))
	   (loop1 (fl+ j incy)))))))



