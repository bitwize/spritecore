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
				(blitter pxl-8=?)
				(blitter pxl-16=?)
				(blitter pxl-24=?)
				(blitter pxl-32=?)
				(blitter set-pixel!)
				(blitter set-keyed-pixel!)
				(blitter xfer-scanline!)
				(blitter xfer-keyed-scanline!)))))
