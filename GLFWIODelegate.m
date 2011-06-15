#import <SpriteCore/SpriteApp.h>
#import <SpriteCore/GLFWIODelegate.h>
#import <SpriteCore/svppm.h>

static int glfw_inited;

@implementation GLFWIODelegate

- (GLFWIODelegate *)initForHost: (SpriteApp *)ha
			  width: (unsigned int)w
			 height: (unsigned int)h 
			  title: (char *)t {
	int screen;
	self = [super init];
	unsigned int dep = 32;
	host = ha;
	if(!glfw_inited) {
		if(!glfwInit())
		{
			fprintf(stderr,"can't init GLFW\n");
			exit(1);
		}
		
		if(!glfwCreateWindow(w,h,8,8,8,8,16,16,GLFW_WINDOW)) {
			fprintf(stderr,"can't open GLFW window\n");
			glfwTerminate();
			exit(1);
		}
		glfw_inited=1;
	}
	back.img = SDL_CreateRGBSurface(SDL_SWSURFACE,w,h,dep,
					screen->format->Rmask,
					screen->format->Gmask,
					screen->format->Bmask,
					screen->format->Amask);
	buf.img = screen;
	BuildSI(&back);
	BuildSI(&buf);
	glfwSetKeyCallback(scglfwHandleKey);
	glfwSetMousePosCallback(scglfwHandleMousePos);
	glfwSetMouseButtonCallback(scglfwHandleMouseButton);
	return self;

}

-free
{
	glfwCloseWindow();
	glfwTerminate();
	glfw_inited = 0;
	return [super free];
}

-(void)refreshScreen
{
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
	glfwSwapBuffers();
}

@end
