#import <SpriteCore/SpriteApp.h>
#import <SpriteCore/GLFWIODelegate.h>
#import <SpriteCore/StdlibRandomSource.h>
#import <SpriteCore/svppm.h>

#include <stdlib.h>
#include <stdio.h>

static int glfw_inited;
static SpriteApp *globalHost;

unsigned int translateGLFWKey(int key)
{
#define TGKEY(glfwkey,xkey)\
	case glfwkey:\
		return xkey;

	if(32 <= key && key < 127)
	{
		return key;
	}
	switch(key)
	{
		TGKEY(GLFW_KEY_ESC,XK_Escape)
		TGKEY(GLFW_KEY_F1,XK_F1)
		TGKEY(GLFW_KEY_F2,XK_F2)
		TGKEY(GLFW_KEY_F3,XK_F3)
		TGKEY(GLFW_KEY_F4,XK_F4)
		TGKEY(GLFW_KEY_F5,XK_F5)
		TGKEY(GLFW_KEY_F6,XK_F6)
		TGKEY(GLFW_KEY_F7,XK_F7)
		TGKEY(GLFW_KEY_F8,XK_F8)
		TGKEY(GLFW_KEY_F9,XK_F9)
		TGKEY(GLFW_KEY_F10,XK_F10)
		TGKEY(GLFW_KEY_F11,XK_F11)
		TGKEY(GLFW_KEY_F12,XK_F12)
		TGKEY(GLFW_KEY_LSHIFT,XK_Shift_L)
		TGKEY(GLFW_KEY_RSHIFT,XK_Shift_R)
		TGKEY(GLFW_KEY_LCTRL,XK_Control_L)
		TGKEY(GLFW_KEY_RCTRL,XK_Control_R)
		TGKEY(GLFW_KEY_LALT,XK_Alt_L)
		TGKEY(GLFW_KEY_RALT,XK_Alt_R)
		TGKEY(GLFW_KEY_LSUPER,XK_Super_L)
		TGKEY(GLFW_KEY_RSUPER,XK_Super_R)
		TGKEY(GLFW_KEY_TAB,XK_Tab)
		TGKEY(GLFW_KEY_ENTER,XK_Return)

	}
	return 0;
#undef TGKEY
}

void GLFWCALL scglfwHandleKey(int key,int action)
{
	SpriteEvent se;
	se.source_type = SPRITEEVENT_SOURCE_KEYBOARD;
	se.source_selector = 0;
	se.code = translateGLFWKey(key);
	switch(action) {
	case GLFW_RELEASE:
		se.value = 0;
		break;
	default:
		se.value = 1;
		break;
	}
	[globalHost handleEvent: &se];
}

void GLFWCALL scglfwHandleMouseButton(int button,int action)
{

}

void GLFWCALL scglfwHandleMousePos(int x,int y)
{

}

@implementation GLFWIODelegate

- (GLFWIODelegate *)initForHost: (SpriteApp *)ha
			  width: (unsigned int)w
			 height: (unsigned int)h 
			  title: (char *)t {
	int screen;
	self = [super init];
	unsigned int dep = 32;
	unsigned int i = 1;
	host = ha;
	globalHost = host;
	if(!glfw_inited) {
		if(!glfwInit())
		{
			fprintf(stderr,"can't init GLFW\n");
			exit(1);
		}
		
		if(!glfwOpenWindow(w,h,8,8,8,8,16,16,GLFW_WINDOW)) {
			fprintf(stderr,"can't open GLFW window\n");
			glfwTerminate();
			exit(1);
		}
		glfwSetWindowTitle(t);
		glfw_inited=1;
	}
	back.cx = w;
	back.cy = h;
	back.depth = 32;
	back.scan_length = w * 4;
	back.endian = (*((char *)(&i)) == 1 ?
		      SIMG_LITTLE_ENDIAN   :
		      SIMG_BIG_ENDIAN);
	back.bits = malloc((size_t)(w * h * 4));
	back.img = NULL;

	buf.cx = w;
	buf.cy = h;
	buf.depth = 32;
	buf.scan_length = w * 4;
	buf.endian = (*((char *)(&i)) == 1 ?
		      SIMG_LITTLE_ENDIAN   :
		      SIMG_BIG_ENDIAN);
	buf.bits = malloc((size_t)(w * h * 4));
	buf.img = NULL;

	glGenTextures(1,&tex);

	glfwSetKeyCallback(scglfwHandleKey);
	glfwSetMousePosCallback(scglfwHandleMousePos);
	glfwSetMouseButtonCallback(scglfwHandleMouseButton);

	rs = (id <SpriteRandomSource>)[[StdlibRandomSource alloc] init];
	[rs seed: (long)time(0)];

	return self;

}

-free
{
	glfwCloseWindow();
	glfwTerminate();
	glfw_inited = 0;
	[self destroyImage: &back];
	[self destroyImage: &buf];
	return [super free];
}

-(void)refreshScreen
{
	glClearColor(0.0f,0.0f,0.0f,1.0f);
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
	glViewport(0,0,buf.cx,buf.cy);
	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	glFrontFace(GL_CCW);
	glCullFace(GL_BACK);
	glEnable(GL_CULL_FACE);
	glBindTexture(GL_TEXTURE_2D,tex);
	glTexImage2D(GL_TEXTURE_2D,0,GL_RGBA,buf.cx,buf.cy,0,GL_BGRA,
		     GL_UNSIGNED_BYTE,buf.bits);
	glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP );
	glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP );
	glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST );
	glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST );
	glEnable(GL_TEXTURE_2D);
	glBegin(GL_TRIANGLE_STRIP);
	glColor3f(1.0f,1.0f,1.0f);
	glTexCoord2f(0.0f,1.0f);
	glVertex3f(-1.0f,-1.0f,1.0f);
	glTexCoord2f(1.0f,1.0f);
	glVertex3f(1.0f,-1.0f,1.0f);
	glTexCoord2f(0.0f,0.0f);
	glVertex3f(-1.0f,1.0f,1.0f);
	glTexCoord2f(1.0f,0.0f);
	glVertex3f(1.0f,1.0f,1.0f);
	glEnd();
	glfwSwapBuffers();
}

- (SpriteImage *)backImage {return &back;}
- (SpriteImage *)bufImage {return &buf;}
- (int)loadPPMFile: (char *)fn toImage: (SpriteImage *)si {
	int _cx,_cy;
	unsigned char *ptr;

	ReadPpmRgbConverted(fn,&_cx,&_cy,&ptr,32);
	if(ptr == NULL) { return -1;}
	si->img = NULL;
	si->cx = _cx;
	si->cy = _cy;
	si->depth = 32;
	si->scan_length = _cx * 4;
	si->endian = buf.endian;
	si->bits = ptr;
	si->auto_free = 1;
	si->img = NULL;
	return 0;

}
- (int)convertMemPPM: (unsigned char *)ppm size: (unsigned int) sz
	     toImage: (SpriteImage *)si {
	int _cx,_cy;
	unsigned char *ptr;
	ReadPpmRgbFromMemoryConverted(ppm,sz,&_cx,&_cy,&ptr,32);
	if(ptr == NULL) {return -1;}
	si->cx = _cx;
	si->cy = _cy;
	si->depth = 32;
	si->scan_length = _cx * 4;
	si->endian = buf.endian;
	si->bits = ptr;
	si->auto_free = 1;
	si->img = NULL;
	return 0;

}
-(void *)createHWSurfWidth: (unsigned int) w
		    height: (unsigned int) h
		     depth: (unsigned int) d
{
	return (void *)NULL;
}
-(int)buildImage: (SpriteImage *)si fromHWSurf: (void *)surf
{
	return 1;
}

-(void)destroyImage: (SpriteImage *)si {
	free(si->bits);

}
-(id)dispatchEvents {
}

-(void)lockBuf {
}
-(void)lockAndClearBuf {
	ImageCopy(&back,&buf,0,0,0,0,back.cx,back.cy,0,0);
	[self lockBuf];
}

-(void)unlockBuf {
}

-(unsigned int)getTimeMillis {
	return (unsigned int)(glfwGetTime() * 1000.);
}
-(void)sleepMillis: (unsigned int) ms {
	glfwSleep((double)ms / 1000.);
}



-(id <SpriteRandomSource>)randomSource
{
	return rs;
}

-(BOOL)goFullScreen: (BOOL)fs
{
	return 1;
}

-(BOOL)isFullScreen
{
	return 1;
}

-(BOOL)changeScreenSizeX: (unsigned int)x Y: (unsigned int) y
{
	return 1;
}

@end

id createIODelegate(SpriteApp *ha,unsigned int w,unsigned int h,char *t) {
	return [[GLFWIODelegate alloc] initForHost: ha 
				      width: w height: h title: t];
}
