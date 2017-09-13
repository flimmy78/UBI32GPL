#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <syslog.h>
#include <stdarg.h>
#include "cmds.h"
#include "shutils.h"
#define PID_FILE		"/var/run/cli"
#define PID_LOCK_TIMEOUT	5

#define SYS_CMDS_LOCK		"sys_cmds_lock"
#define SYS_CMDS_DEBUG		"sys_cmds_debug"

struct cmds_cfg{
	int lock;
	FILE *debug_fd;
} CMDS_CFG;

void __rd__(const char *fmt, ...)
{
	va_list ap;
	va_start(ap, fmt);
	if (CMDS_CFG.debug_fd != NULL) {
		vfprintf(CMDS_CFG.debug_fd, fmt, ap);
		fputc('\n', CMDS_CFG.debug_fd);
	} else 
		vsyslog(LOG_INFO, fmt, ap);
}

void init_cmds_conf()
{
	char *p;
	
	//bzero(&CMDS_CFG, struct cmds_cfg);
	if ((p = nvram_get(SYS_CMDS_LOCK)) != NULL)
		CMDS_CFG.lock = atoi(p);
	if ((p = nvram_get(SYS_CMDS_DEBUG)) != NULL)
		CMDS_CFG.debug_fd = fopen(p, "a");

}
void uninit_cmds_conf()
{
	if (CMDS_CFG.debug_fd != NULL)	
		fclose(CMDS_CFG.debug_fd);
}
int lock_prog(int argc, char *argv[], int force)
{
	FILE *fd;
	char *file = PID_FILE;
	int timeout, i;
	char buf[1024] = "", id[1024];

	if (CMDS_CFG.lock == 0 && force == 0)
		return 0;
	for (i = 0; i < argc; i++) {
		strcat(buf, " ");
		strcat(buf, argv[i]);
	}
	
	for (timeout = 0;timeout < PID_LOCK_TIMEOUT; timeout++) {
		if (access(file, F_OK) != 0)
			break;
		if ((fd = fopen(file, "r")) == NULL)
			return -1;
		fgets(id, sizeof(id), fd);
		cprintf("###########\n!!!! %s locked by %s!\n###########\n", buf, id);
		fclose(fd);
		sleep(1);
	}
	if ((fd = fopen(file, "w")) == NULL)
		return -1;
	fprintf(fd, "%d: %s", getpid(), buf);
	fclose(fd);
	return 0;
}

void unlock_prog(void)
{
	//if (CMDS_CFG.lock)
	if (access(PID_FILE, F_OK) == 0)
		remove(PID_FILE);
}
