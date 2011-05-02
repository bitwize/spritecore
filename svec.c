#include <stdio.h>
#include <SpriteCore/svec.h>

sc_vec2 make_sc_vec2_fl(float x,float y)
{
	sc_vec2 v;
	v.x = x;
	v.y = y;
	return v;
}

int rects_intersect(sc_rect r1,sc_rect r2)
{
	int step1,step2; //Intermediate x and y proximity values.
	//Step 1: Check for horizontal proximity.
	if(r1.pos.x <= r2.pos.x) {
		if(r2.pos.x - r1.pos.x < r1.size.x) step1 = 1; else step1 = 0;
	}
	else {
		if(r2.pos.x + r2.size.x > r1.pos.x) step1 = 1; else step1 = 0;
	}
	//Step 2: Check for vertical proximity.
	if(r1.pos.y <= r2.pos.y) {
		if(r2.pos.y - r1.pos.y < r1.size.y) step2 = 1; else step2 = 0;
	}
	else {
		if(r2.pos.y + r2.size.y > r1.pos.y) step2 = 1; else step2 = 0;
	}
	//Return true if we are overlapping horizontally AND vertically.
	return(step1 && step2);

}
