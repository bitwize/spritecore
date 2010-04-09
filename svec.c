#include <stdio.h>
#include <SpriteCore/svec.h>

sc_vec2 make_sc_vec2_fl(float x,float y)
{
	sc_vec2 v;
	v.x = SC_FLOAT_TO_FXP(x);
	v.y = SC_FLOAT_TO_FXP(y);
	return v;
}

sc_vec2 make_sc_vec2_fx(sc_fixedpoint x,
			sc_fixedpoint y)
{
	sc_vec2 v;
	v.x = x;
	v.y = y;
	return v;

}
