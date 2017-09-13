/* ssi - server-side-includes CGI program*/
#include <getopt.h>
#include <unistd.h>

#include "ssi.h"
#include "helper.h"
#include "querys.h"
#include "log.h"
#include "public.h"
#include "hnap.h"
//#define __HNAP__ /* undefine pure network for D-Link require at 2007/5/14 */
#define ST_GROUND 0
#define ST_LESSTHAN 1
#define ST_BANG 2
#define ST_MINUS1 3
#define ST_MINUS2 4


#ifdef __SSI_LOGGER__
FILE *LOGFD;
#endif //__SSI_LOGGER__

struct nvram_ops *nvram = NULL;
struct method_plugin *ssi_get_method_plugin = NULL;
/*
struct method_plugin virtual_files[] = {
	{"/save_log.cgi", save_log},
	{"/save_configure.cgi", save_conf},
	{"", NULL}
};
*/
static void parse(char *filename, FILE * fp, char *str)
{
	int argc = 10 * sizeof(char *);
	char **argv = malloc(argc);
	char *t, *x;
	int i = 0;
	struct ssi_helper *p;

	while ((t = strsep(&str, " \t\n\r\"")) != NULL) {
		if (strlen(t) == 0)
			continue;
		argv[i] = t;
		i++;
		if (i  >= (argc / 4) - 1) {
			argc += 10  * sizeof(char *);
			x = realloc(argv, argc);
			if (x == NULL) {
				printf("No more memory\n");
				exit(1);
			}
			argv = (char **)x;
		}
	}
	argv[i] = NULL;

	for (p = helpers; p->name[0] != '\0'; p++) {
		if (strncmp(argv[0], p->name, sizeof(p->name)) == 0) {
			if (p->fn) {
				p->fn(filename, fp, i, argv);
			}
		}
	}
	free(argv);
}

static void
slurp(char *filename, FILE * fp)
{
	char buf[1000];
	int i;
	int state;
	int ich;

	/* Now slurp in the rest of the comment from the input file. */
	i = 0;
	state = ST_GROUND;
	while ((ich = getc(fp)) != EOF) {
		switch (state) {
		case ST_GROUND:
			if (ich == '-')
				state = ST_MINUS1;
			break;
		case ST_MINUS1:
			if (ich == '-')
				state = ST_MINUS2;
			else
				state = ST_GROUND;
			break;
		case ST_MINUS2:
			if (ich == '>') {
				buf[i - 2] = '\0';
				parse(filename, fp, buf);
				return;
			} else if (ich != '-')
				state = ST_GROUND;
			break;
		}
		if (i < sizeof(buf) - 1)
			buf[i++] = (char) ich;
	}
}

static void
read_file(char *filename, FILE * fp)
{
	int ich;
	int state;
	
	// Copy it to output, while running a state-machine to look for
	// SSI directives.
	
	state = ST_GROUND;
	while ((ich = getc(fp)) != EOF) {
		switch (state) {
		case ST_GROUND:
			if (ich == '<') {
				state = ST_LESSTHAN;
				continue;
			}
			break;
		case ST_LESSTHAN:
			if (ich == '!') {
				state = ST_BANG;
				continue;
			} else {
				state = ST_GROUND;
				putchar('<');
			}
			break;
		case ST_BANG:
			if (ich == '-') {
				state = ST_MINUS1;
				continue;
			} else {
				state = ST_GROUND;
				(void) fputs("<!", stdout);
			}
			break;
		case ST_MINUS1:
			if (ich == '-') {
				state = ST_MINUS2;
				continue;
			} else {
				state = ST_GROUND;
				(void) fputs("<!-", stdout);
			}
			break;
		case ST_MINUS2:
			if (ich == '#') {
				slurp(filename, fp);
				state = ST_GROUND;
				continue;
			} else {
				state = ST_GROUND;
				(void) fputs("<!--", stdout);
			}
			break;
		}
		//putchar((char) ich);
		fputc((char) ich, stdout);
	}
}

/* @path_file := /www/chklst.txt */
static int content_type_hook(char *path_file)
{
	char content_type[128];
	struct {
		const char *path_file;
		const char *content_type;
	} *p, l[] = {
		{ "/www/device_status.xml", "application/xml" },
		{ "/www/ipv6_status.xml", "application/xml" },
		{ "/www/ipv6_autoconnect.xml", "application/xml" },
		{ "/www/internet_session.xml", "application/xml" },
		{ NULL, "text/html" }	/* defualt */
	};

	for (p = l; p->path_file; p++) {
		if (strcmp(path_file, p->path_file) == 0)
			break;
	}

	sprintf(content_type, "Content-type: %s\r\n\r\n", p->content_type);
	(void) fputs(content_type, stdout);
	SYSLOG(content_type);

	return 0;
}

int ssi_func(char* path_file)
{
	FILE *fp;
	char *path_info;
	struct method_plugin *f;
	int ret = 1;

	// Open it.
	SYSLOG("SSI opening:%s<br>\n", path_file);
	fp = fopen(path_file, "r");
	if (fp) {
	/* If path_file equal to "/www/hnap.cgi" or "/www/hnap_response.xml",
	 * cgi don't need to response \r\n in MIME header, because of HNAP
	 * response need some special MIME fields. These fields will be cteated
	 * by misc/hnap, not here.
	 * 
	 * 2010/6/23 FredHung */
		if (strcmp(path_file, HNAP_RESPONSE_PATH) != 0 &&
		    strcmp(path_file, HNAP_CGI_ENTRY_PATH) != 0)
		{
#if 0
			/* The MIME type has to be text/html. */
			(void) fputs("Content-type: text/html\r\n\r\n", stdout);
			SYSLOG("Content-type: text/html\n");
#endif
			/* cgi/ssi cannot always return text/html,
			 * because like .xml format must need application/xml here.
			 * So I use a routine to hooking the content-type.
			 *
			 * 2010/7/6, FredHung */
			content_type_hook(path_file);
		}
		read_file(path_file, fp);
		SYSLOG("SSI parse (%s) Finished", path_file);
		
		(void) fclose(fp);
		ret = 0;
		goto out;
	}

	path_info = getenv("PATH_INFO");
	SYSLOG("Open:%s failure, PATH=%s<br>\n", 
			path_file, path_info);
	if (path_info == NULL)
		goto not_found;
	
	for(f = ssi_get_method_plugin; f != NULL && f->func != NULL; f++) {
		if(strncmp(path_info, f->file_path, \
					sizeof(f->file_path)) == 0) {
			ret = f->func();
			goto out;
		}			
	}

not_found:
	not_found(path_file);
out:
	return ret;
}

inline void dump_ssi_info()
{
#ifdef DEBUG_SSI
	extern char **environ;
	char **env;
	
	SYSLOG(HTML_TITLE_HEAD, "print environ variable");
		for (env = environ; *env != NULL; env++) {
		SYSLOG("\"%s\"<br>", *env);
	}
#endif //DEBUG_SSI
	return;
}

inline int __do_ssc(const char *docroot, char *backurl, int len)
{
	char *t, *s;
	
	memset(backurl, '\0', len);
	STDOUT("\n"); 	/* For end of http header, dump debug message to standard output */
	STDOUT("DO SSC PATH");
	t = do_ssc();
	s = rindex(docroot, '/');
	// FIXME: Is it space problem?
	memcpy(backurl, docroot, s - docroot + 1);
	if(t)
		strcat(backurl, t);

	STDOUT("BACK TO%s\n", backurl);
	SYSLOG("SSC BACK: %s to %s\n", t, backurl);
	return 0;
}

extern char **environ;

int main(int argc, char **argv)
{
	int c, ind, debug = 0, result = -1;
	char *path_translated = NULL, *method = NULL;
	char tmp[128], *ssi_page = NULL;
	
	static struct option opts[] = {
		{"debug", 0, 0, 'd'},
		{0, 0, 0, 0}
	};
	
	while (1) {
		if ((c = getopt_long(argc, argv, "d", opts, &ind)) == -1)
			break;
		switch (c) {
		case 'd':
			printf("debug\n");
			debug++;
			break;
		}
	}

	if (debug) {
		char **foo;
	
		for (foo = environ; *foo != NULL; foo++) {
			cprintf("%s\n", *foo);
		}
	}

	/* Init LOG & DB */
#ifdef __SSI_LOGGER__
	if ((LOGFD = fopen(SSI_LOGGER_FILE, "a")) == NULL) {
		printf("Open LOG: %s error: %s", SSI_LOGGER_FILE, strerror(errno));
		goto out;
	}
#else
	openlog(argv[0], LOG_PID, LOG_USER);
#endif //__SSI_LOGGER__

#ifdef __HNAP__
	script = getenv("SCRIPT_NAME");
	if (script == NULL) {
		internal_error
		    ("Couldn't get SCRIPT_NAME environment "
		     "variable.");
		goto out;
	}
	if ( strstr(script, "HNAP1") != 0 ) {
		do_hnap();
		goto out;
	}
#endif
	do_nvram_register();
	if (nvram->init(NULL) < 0) {
		internal_error("SSI init Couldn't init database().");
		goto out;
	}
	/* Get Environmant varibles */
	path_translated = getenv("PATH_TRANSLATED");
	method = getenv("REQUEST_METHOD");
	if (path_translated == NULL || method == NULL) {
		internal_error
		    ("Couldn't get PATH_TRANSLATED OR METHOD environment "
		     "variable.");
		goto out;
	}
	/* uncomment if need debug */
	dump_ssi_info();
	SYSLOG("Web Access:%s from %s\n", 
			path_translated, getenv("REMOTE_ADDR"));
	if (init_plugin() == -1)
		goto out;
	if (strncmp(method, "GET", 3) == 0) {
		ssi_page = path_translated;
		goto do_ssi;
	}

	__do_ssc(path_translated, tmp, sizeof(tmp));
	ssi_page = tmp;
do_ssi:
	{
		char *n, *t, *tag, *val, *j = NULL, *k = NULL, *s, buf[256];
		s = buf;
		n = getenv("QUERY_STRING");
		if (n != NULL) {
			strcpy(s, n);

			while ((t = strtok_r(s, "&", &k)) != NULL) {
				tag = strtok_r(t, "=", &j);	
				val = strtok_r(NULL, "", &j);

				/* XXX: change "clear" to "1", 
				 *      it is workaround version for 
				 *      sys log view page
				 */
				if (strcmp (val, "clear") == 0){
					strcpy(val, "1");
				}
				if (tag != NULL && val != NULL){
					setenv(tag, val, 1);
				}
				s = k;
			}
		}
	}
	SYSLOG("Parsing %s", ssi_page);
	result = ssi_func(ssi_page);
	nvram->exit(NULL);
out:
	closelog();

	return 0;
}

