(in 'prescheme-compiler
    '(run (prescheme-compiler 'blitter '("packs.scm")
			      'blitter-init
			      "blitter.psc"
			      '(header "#define TO_INTEGER(x) (long)(x)")
			      '(header "#define TO_FLOAT(x) (double)(x)")
			      '(copy
				(blitter xform-x)
				(blitter xform-y)
				(blitter set-pxl-8!)
				(blitter set-pxl-16!)
				(blitter set-pxl-24!)
				(blitter set-pxl-32!)
				(blitter set-keyed-pxl-8!)
				(blitter set-keyed-pxl-16!)
				(blitter set-keyed-pxl-24!)
				(blitter set-keyed-pxl-32!)
				(blitter xfer-scanline-8!)
				(blitter xfer-scanline-16!)
				(blitter xfer-scanline-24!)
				(blitter xfer-scanline-32!)
				(blitter xfer-keyed-scanline-8!)
				(blitter xfer-keyed-scanline-16!)
				(blitter xfer-keyed-scanline-24!)
				(blitter xfer-keyed-scanline-32!)
				(blitter pxl-8=?)
				(blitter pxl-16=?)
				(blitter pxl-24=?)
				(blitter pxl-32=?)
				(blitter set-pixel!)
				(blitter set-keyed-pixel!)
				(blitter xfer-scanline!)
				(blitter xfer-keyed-scanline!)))))

(in 'prescheme-compiler
    '(run (prescheme-compiler 'generic-blitter '("packs.scm")
			      'blitter-init
			      "generic-blitter.psc"
			      '(header "#define TO_INTEGER(x) (long)(x)")
			      '(header "#define TO_FLOAT(x) (double)(x)")
 			      '(copy
				(generic-blitter pixel-ref-8)
				(generic-blitter pixel-ref-16)
				(generic-blitter pixel-ref-24)
				(generic-blitter pixel-ref-32)
				(generic-blitter pixel-set-8!)
				(generic-blitter pixel-set-16!)
				(generic-blitter pixel-set-24!)
				(generic-blitter pixel-set-32!))
				
)))
