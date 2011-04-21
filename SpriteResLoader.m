/*
 *  Copyright 1995-2008 Jeffrey T. Read
 *
 * This file is part of SpriteCore.
 *
 * This software is provided 'as-is', without any express or implied
 * warranty.  In no event will the authors be held liable for any
 * damages arising from the use of this software.
 *
 * Permission is granted to anyone to use this software for any purpose,
 * including commercial applications, and to alter it and redistribute it
 * freely, subject to the following restrictions:
 *
 * 1. The origin of this software must not be misrepresented; you must not
 *    claim that you wrote the original software. If you use this software
 *    in a product, an acknowledgment in the product documentation would be
 *    appreciated but is not required.
 * 2. Altered source versions must be plainly marked as such, and must not be
 *    misrepresented as being the original software.
 * 3. This notice may not be removed or altered from any source distribution.
 *
 */

#import <SpriteCore/SpriteResLoader.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

@implementation SpriteResLoader
-initOn: (SpriteApp *)anApp named: (char *)aName {
	self = [super init];
	name = aName;
	parent = anApp;
	return self;
}
-free {
	[super free];
}
-(unsigned int)fetchResource: (char *)aResName to: (void **)aPtr
{
	unsigned char *path = [parent resourcePath];
	unsigned char *fullpath;
	void *data;
	struct stat st;
	int fd;
	int result;
	if(path == NULL)
	{
		path = "./";
	}
	size_t plen = strlen(path);
	size_t nlen = strlen(name);
	size_t rlen = strlen(aResName);
	fullpath = (unsigned char *)malloc(plen + nlen + rlen + 7);
	fullpath[0] = '\0';
	strncat(fullpath,path,plen);
	if(path[plen - 1] != '/')
	{
		fullpath[plen] = '/';
		fullpath[plen + 1] = '\0';
	}
	strncat(fullpath,name,nlen);
	strncat(fullpath,".res/",5);
	strncat(fullpath,aResName,rlen);
	result = stat(fullpath,&st);
	if(result != 0) goto res_err1;
	data = malloc(st.st_size);
	fd = open(fullpath,O_RDONLY);
	if(fd < 0) goto res_err2;
	result = read(fd,data,st.st_size);
	if(result < 0) goto res_err2;
	free(fullpath);
	*aPtr = data;
	return st.st_size;
res_err2:
	free(data);
res_err1:
	free(fullpath);
	*aPtr =  NULL;
	return 0;
}
@end
