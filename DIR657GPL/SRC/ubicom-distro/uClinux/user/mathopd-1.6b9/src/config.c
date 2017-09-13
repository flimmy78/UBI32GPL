/*
 *   Copyright 1996, Michiel Boland.
 *   All rights reserved.
 *
 *   Redistribution and use in source and binary forms, with or
 *   without modification, are permitted provided that the following
 *   conditions are met:
 *
 *   1. Redistributions of source code must retain the above
 *      copyright notice, this list of conditions and the following
 *      disclaimer.
 *
 *   2. Redistributions in binary form must reproduce the above
 *      copyright notice, this list of conditions and the following
 *      disclaimer in the documentation and/or other materials
 *      provided with the distribution.
 *
 *   3. The name of the author may not be used to endorse or promote
 *      products derived from this software without specific prior
 *      written permission.
 *
 *   THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY
 *   EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
 *   THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 *   PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR
 *   BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 *   EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 *   TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 *   DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 *   ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 *   LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
 *   IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
 *   THE POSSIBILITY OF SUCH DAMAGE.
 */

/* House of Games */

static const char rcsid[] = "$Id: config.c,v 1.193 2007/07/07 16:04:12 boland Exp $";

#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netinet/tcp.h>
#include <netdb.h>
#include <pwd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "mathopd.h"

struct tuning tuning;
char *pid_filename;
char *log_filename;
char *error_filename;
char *rootdir;
char *coredir;
struct server *servers;
struct vserver *vservers;
uid_t server_uid;
gid_t server_gid;
int log_columns;
int *log_column;
int log_gmt;

struct configuration {
	FILE *config_file;
	char *tokbuf;
	size_t size;
	int line;
};

static int num_servers;
static struct control *controls;
static struct virtual *virtuals;

static const char c_all[] =			"*";
static const char c_accept_multi[] =		"AcceptMulti";
static const char c_address[] =			"Address";
static const char c_admin[] =			"Admin";
static const char c_alias[] =			"Alias";
static const char c_allow_dotfiles[] =		"AllowDotfiles";
static const char c_any_host[] =		"AnyHost";
static const char c_auto_index_command[] =	"AutoIndexCommand";
static const char c_backlog[] =			"Backlog";
static const char c_buf_size[] =		"BufSize";
static const char c_bytes_read[] =		"BytesRead";
static const char c_bytes_written[] =		"BytesWritten";
static const char c_child_log[] =		"ChildLog";
static const char c_clobber[] =			"Clobber";
static const char c_content_length[] =		"ContentLength";
static const char c_control[] =			"Control";
static const char c_core_directory[] =		"CoreDirectory";
static const char c_ctime[] =			"Ctime";
static const char c_encrypted_user_file[] =	"EncryptedUserFile";
static const char c_error_log[] =		"ErrorLog";
static const char c_error_401_file[] =		"Error401File";
static const char c_error_404_file[] =		"Error404File";
static const char c_exact_match[] =		"ExactMatch";
static const char c_expire_interval[] =		"ExpireInterval";
static const char c_export[] =			"Export";
static const char c_external[] =		"External";
static const char c_extra_headers[] =		"ExtraHeaders";
static const char c_family[] =			"Family";
static const char c_greedy[] =			"Greedy";
static const char c_host[] =			"Host";
static const char c_index_names[] =		"IndexNames";
static const char c_input_buf_size[] =		"InputBufSize";
static const char c_local_address[] =		"LocalAddress";
static const char c_local_port[] =		"LocalPort";
static const char c_location[] =		"Location";
static const char c_log[] =			"Log";
static const char c_log_format[] =		"LogFormat";
static const char c_log_gmt[] =			"LogGMT";
static const char c_method[] =			"Method";
static const char c_micro_time[] =		"MicroTime";
static const char c_no_host[] =			"NoHost";
static const char c_num_connections[] =		"NumConnections";
static const char c_num_headers[] =		"NumHeaders";
static const char c_num_processes[] =		"NumProcesses";
static const char c_off[] =			"Off";
static const char c_on[] =			"On";
static const char c_options[] =			"Options";
static const char c_path_args[] =		"PathArgs";
static const char c_path_info[] =		"PathInfo";
static const char c_pid[] =			"PID";
static const char c_pid_file[] =		"PIDFile";
static const char c_port[] =			"Port";
static const char c_putenv[] =			"PutEnv";
static const char c_query_string[] =		"QueryString";
static const char c_realm[] =			"Realm";
static const char c_referer[] =			"Referer";
static const char c_remote_address[] =		"RemoteAddress";
static const char c_remote_port[] =		"RemotePort";
static const char c_remote_user[] =		"RemoteUser";
static const char c_root_directory[] =		"RootDirectory";
static const char c_run_scripts_as_owner[] =	"RunScriptsAsOwner";
static const char c_sanitize_path[] =		"SanitizePath";
static const char c_script_buf_size[] =		"ScriptBufSize";
static const char c_script_timeout[] =		"ScriptTimeout";
static const char c_script_user[] =		"ScriptUser";
static const char c_server[] =			"Server";
static const char c_server_name[] =		"ServerName";
static const char c_specials[] =		"Specials";
static const char c_status[] =			"Status";
static const char c_stay_root[] =		"StayRoot";
static const char c_timeout[] =			"Timeout";
static const char c_time_taken[] =		"TimeTaken";
static const char c_tuning[] =			"Tuning";
static const char c_types[] =			"Types";
static const char c_virtual[] =			"Virtual";
static const char c_wait[] =			"Wait";
static const char c_umask[] =			"Umask";
static const char c_uri[] =			"Uri";
static const char c_user[] =			"User";
static const char c_user_agent[] =		"UserAgent";
static const char c_user_directory[] =		"UserDirectory";
static const char c_user_file[] =		"UserFile";
static const char c_version[] =			"Version";

static const char e_bad_alias[] =	"alias without matching location";
static const char e_help[] =		"unknown error (help)";
static const char e_inval[] =		"illegal quantity";
static const char e_keyword[] =		"unknown keyword";
static const char e_memory[] =		"out of memory";
static const char e_illegalport[] =	"illegal port number";
static const char e_noinput[] =		"no input";
static const char e_user_invalid[] =	"invalid user";
static const char e_user_unknown[] =	"user unknown";
static const char e_toobig[] =		"number too big";

static const char t_close[] =		"unexpected closing brace";
static const char t_eof[] =		"unexpected end of file";
static const char t_open[] =		"unexpected opening brace";
static const char t_string[] =		"unexpected string";
static const char t_too_long[] =	"token too long";

static int default_log_column[] = {
	ML_CTIME,
	ML_USERNAME,
	ML_REMOTE_ADDRESS,
	ML_REMOTE_PORT,
	ML_SERVERNAME,
	ML_METHOD,
	ML_URI,
	ML_STATUS,
	ML_CONTENT_LENGTH,
	ML_REFERER,
	ML_USER_AGENT,
	ML_BYTES_READ,
	ML_BYTES_WRITTEN
};

static const char *gettoken(struct configuration *p)
{
	int c;
	char w;
	size_t i;
	char state;
	const char *t;
	char *newtokbuf;
	size_t newtokbufsize;

	i = 0;
	state = 1;
	t = e_help;
	do {
		w = 0;
		if ((c = getc(p->config_file)) == EOF) {
			state = 0;
			t = t_eof;
		} else if (c == '\n')
			++p->line;
		switch (state) {
		case 1:
			switch (c) {
			case ' ':
			case '\t':
			case '\r':
			case '\n':
				break;
			case '#':
				state = 2;
				break;
			case '{':
				t = t_open;
				w = 1;
				state = 0;
				break;
			case '}':
				t = t_close;
				w = 1;
				state = 0;
				break;
			case '"':
				t = t_string;
				state = 3;
				break;
			default:
				t = t_string;
				w = 1;
				state = 4;
				break;
			}
			break;
		case 2:
			if (c == '\n')
				state = 1;
			break;
		case 3:
			if (c == '\\')
				state = 5;
			else if (c == '"')
				state = 0;
			else
				w = 1;
			break;
		case 4:
			switch (c) {
			case ' ':
			case '\t':
			case '\r':
			case '\n':
				state = 0;
				break;
			case '#':
			case '"':
			case '{':
			case '}':
				ungetc(c, p->config_file);
				state = 0;
				break;
			default:
				w = 1;
				break;
			}
			break;
		case 5:
			w = 1;
			state = 3;
			break;
		}
		if (w) {
			if (i + 1 < p->size)
				p->tokbuf[i++] = c;
			else {
				newtokbufsize = 2 * p->size;
				newtokbuf = realloc(p->tokbuf, newtokbufsize);
				if (newtokbuf == 0) {
					state = 0;
					t = e_memory;
				} else {
					p->size = newtokbufsize;
					p->tokbuf = newtokbuf;
					p->tokbuf[i++] = c;
				}
			}
		}
	} while (state);
	p->tokbuf[i] = 0;
	return t;
}

static const char *config_string(struct configuration *p, char **a)
{
	const char *t;

	if ((t = gettoken(p)) != t_string)
		return t;
	if ((*a = strdup(p->tokbuf)) == 0)
		return e_memory;
	return 0;
}

static const char *config_int(struct configuration *p, unsigned long *i)
{
	char *e;
	unsigned long u;
	const char *t;

	if ((t = gettoken(p)) != t_string)
		return t;
	u = strtoul(p->tokbuf, &e, 0);
	if (*e || e == p->tokbuf)
		return e_inval;
	*i = u;
	return 0;
}

static const char *config_flag(struct configuration *p, int *i)
{
	const char *t;

	if ((t = gettoken(p)) != t_string)
		return t;
	if (!strcasecmp(p->tokbuf, c_off))
		*i = 0;
	else if (!strcasecmp(p->tokbuf, c_on))
		*i = 1;
	else
		return e_keyword;
	return 0;
}

static const char *config_list(struct configuration *p, struct simple_list **ls)
{
	struct simple_list *l;
	const char *t;

	if ((t = gettoken(p)) != t_open)
		return t;
	while ((t = gettoken(p)) != t_close) {
		if (t != t_string)
			return t;
		if ((l = malloc(sizeof *l)) == 0)
			return e_memory;
		if ((l->name = strdup(p->tokbuf)) == 0)
			return e_memory;
		l->next = *ls;
		*ls = l;
	}
	return 0;
}

static const char *config_log(struct configuration *p, int **colsp, int *numcolsp)
{
	int ml;
	int *cols;
	int numcols;
	const char *t;

	ml = 0;
	cols = *colsp;
	numcols = *numcolsp;
	if ((t = gettoken(p)) != t_open)
		return t;
	while ((t = gettoken(p)) != t_close) {
		if (t != t_string)
			return t;
		if (!strcasecmp(p->tokbuf, c_ctime))
			ml = ML_CTIME;
		else if (!strcasecmp(p->tokbuf, c_remote_user))
			ml = ML_USERNAME;
		else if (!strcasecmp(p->tokbuf, c_remote_address))
			ml = ML_REMOTE_ADDRESS;
		else if (!strcasecmp(p->tokbuf, c_remote_port))
			ml = ML_REMOTE_PORT;
		else if (!strcasecmp(p->tokbuf, c_local_address))
			ml = ML_LOCAL_ADDRESS;
		else if (!strcasecmp(p->tokbuf, c_local_port))
			ml = ML_LOCAL_PORT;
		else if (!strcasecmp(p->tokbuf, c_server_name))
			ml = ML_SERVERNAME;
		else if (!strcasecmp(p->tokbuf, c_method))
			ml = ML_METHOD;
		else if (!strcasecmp(p->tokbuf, c_uri))
			ml = ML_URI;
		else if (!strcasecmp(p->tokbuf, c_version))
			ml = ML_VERSION;
		else if (!strcasecmp(p->tokbuf, c_status))
			ml = ML_STATUS;
		else if (!strcasecmp(p->tokbuf, c_content_length))
			ml = ML_CONTENT_LENGTH;
		else if (!strcasecmp(p->tokbuf, c_referer))
			ml = ML_REFERER;
		else if (!strcasecmp(p->tokbuf, c_user_agent))
			ml = ML_USER_AGENT;
		else if (!strcasecmp(p->tokbuf, c_bytes_read))
			ml = ML_BYTES_READ;
		else if (!strcasecmp(p->tokbuf, c_bytes_written))
			ml = ML_BYTES_WRITTEN;
		else if (!strcasecmp(p->tokbuf, c_query_string))
			ml = ML_QUERY_STRING;
		else if (!strcasecmp(p->tokbuf, c_time_taken))
			ml = ML_TIME_TAKEN;
		else if (!strcasecmp(p->tokbuf, c_micro_time))
			ml = ML_MICRO_TIME;
		else if (!strcasecmp(p->tokbuf, c_pid))
			ml = ML_PID;
		else
			return e_keyword;
		++numcols;
		cols = realloc(cols, sizeof *cols * numcols);
		if (cols == 0)
			return e_memory;
		cols[numcols - 1] = ml;
		*colsp = cols;
		*numcolsp = numcols;
	}
	return 0;
}

static const char *config_mime(struct configuration *p, struct mime **ms, int class)
{
	struct mime *m;
	char *name;
	const char *t;

	if ((t = gettoken(p)) != t_open)
		return t;
	while ((t = gettoken(p)) != t_close) {
		if (t != t_string)
			return t;
		if ((name = strdup(p->tokbuf)) == 0)
			return e_memory;
		if ((t = gettoken(p)) != t_open)
			return t;
		while ((t = gettoken(p)) != t_close) {
			if (t != t_string)
				return t;
			if ((m = malloc(sizeof *m)) == 0)
				return e_memory;
			m->class = class;
			m->name = name;
			if (!strcasecmp(p->tokbuf, c_all))
				m->ext = 0;
			else if ((m->ext = strdup(p->tokbuf)) == 0)
				return e_memory;
			m->next = *ms;
			*ms = m;
		}
	}
	return 0;
}

static const char *config_script_user(struct configuration *p, struct control *c)
{
	const char *t;
	struct passwd *pw;

	t = gettoken(p);
	if (t != t_string)
		return t;
	pw = getpwnam(p->tokbuf);
	if (pw == 0)
		return e_user_unknown;
	c->script_identity = SI_CHANGETOFIXED;
	c->script_uid = pw->pw_uid;
	c->script_gid = pw->pw_gid;
	return 0;
}

static const char *config_run_scripts_as_owner(struct configuration *p, struct control *c)
{
	const char *t;
	int o;

	t = config_flag(p, &o);
	if (t)
		return t;
	if (o)
		c->script_identity = SI_CHANGETOOWNER;
	return 0;
}

static void chopslash(char *s)
{
	char *t;

	t = s + strlen(s);
	while (--t >= s && *t == '/')
		*t = 0;
}

static const char *config_control(struct configuration *p, struct control **as)
{
	struct control *a, *b;
	struct simple_list *l;
	const char *t;

	b = *as;
	while (b && b->locations)
		b = b->next;
	if ((a = malloc(sizeof *a)) == 0)
		return e_memory;
	a->locations = 0;
	a->alias = 0;
	a->exact_match = 0;
	a->user_directory = 0;
	if (b) {
		a->index_names = b->index_names;
		a->mimes = b->mimes;
		a->path_args_ok = b->path_args_ok;
		a->admin = b->admin;
		a->realm = b->realm;
		a->userfile = b->userfile;
		a->error_401_file = b->error_401_file;
		a->error_404_file = b->error_404_file;
		a->do_crypt = b->do_crypt;
		a->child_filename = b->child_filename;
		a->exports = b->exports;
		a->script_identity = b->script_identity;
		a->script_uid = b->script_uid;
		a->script_gid = b->script_gid;
		a->allow_dotfiles = b->allow_dotfiles;
		a->putenvs = b->putenvs;
		a->extra_headers = b->extra_headers;
		a->path_info_ok = b->path_info_ok;
		a->auto_index_command = b->auto_index_command;
		a->expire_interval = b->expire_interval;
		a->sanitize_path = b->sanitize_path;
	} else {
		a->index_names = 0;
		a->mimes = 0;
		a->path_args_ok = 0;
		a->admin = 0;
		a->realm = 0;
		a->userfile = 0;
		a->error_401_file = 0;
		a->error_404_file = 0;
		a->do_crypt = 0;
		a->child_filename = 0;
		a->exports = 0;
		a->script_identity = SI_DONOTCHANGE;
		a->script_uid = 0;
		a->script_gid = 0;
		a->allow_dotfiles = 0;
		a->putenvs = 0;
		a->extra_headers = 0;
		a->path_info_ok = 1;
		a->auto_index_command = 0;
		a->expire_interval = 0;
		a->sanitize_path = 0;
	}
	a->next = *as;
	*as = a;
	if ((t = gettoken(p)) != t_open)
		return t;
	while ((t = gettoken(p)) != t_close) {
		if (t != t_string)
			return t;
		if (!strcasecmp(p->tokbuf, c_location)) {
			if ((l = malloc(sizeof *l)) == 0)
				return e_memory;
			if ((t = gettoken(p)) != t_string)
				return t;
			chopslash(p->tokbuf);
			if ((l->name = strdup(p->tokbuf)) == 0)
				return e_memory;
			if (a->locations) {
				l->next = a->locations->next;
				a->locations->next = l;
			} else {
				l->next = l;
				a->locations = l;
			}
			continue;
		} else if (!strcasecmp(p->tokbuf, c_alias)) {
			if ((t = gettoken(p)) != t_string)
				return t;
			chopslash(p->tokbuf);
			if ((a->alias = strdup(p->tokbuf)) == 0)
				return e_memory;
			continue;
		} else if (!strcasecmp(p->tokbuf, c_path_args))
			t = config_flag(p, &a->path_args_ok);
		else if (!strcasecmp(p->tokbuf, c_index_names))
			t = config_list(p, &a->index_names);
		else if (!strcasecmp(p->tokbuf, c_types))
			t = config_mime(p, &a->mimes, CLASS_FILE);
		else if (!strcasecmp(p->tokbuf, c_specials))
			t = config_mime(p, &a->mimes, CLASS_SPECIAL);
		else if (!strcasecmp(p->tokbuf, c_external))
			t = config_mime(p, &a->mimes, CLASS_EXTERNAL);
		else if (!strcasecmp(p->tokbuf, c_admin))
			t = config_string(p, &a->admin);
		else if (!strcasecmp(p->tokbuf, c_realm))
			t = config_string(p, &a->realm);
		else if (!strcasecmp(p->tokbuf, c_user_file))
			t = config_string(p, &a->userfile);
		else if (!strcasecmp(p->tokbuf, c_error_401_file))
			t = config_string(p, &a->error_401_file);
		else if (!strcasecmp(p->tokbuf, c_error_404_file))
			t = config_string(p, &a->error_404_file);
		else if (!strcasecmp(p->tokbuf, c_encrypted_user_file))
			t = config_flag(p, &a->do_crypt);
		else if (!strcasecmp(p->tokbuf, c_child_log))
			t = config_string(p, &a->child_filename);
		else if (!strcasecmp(p->tokbuf, c_export))
			t = config_list(p, &a->exports);
		else if (!strcasecmp(p->tokbuf, c_exact_match))
			t = config_flag(p, &a->exact_match);
		else if (!strcasecmp(p->tokbuf, c_script_user))
			t = config_script_user(p, a);
		else if (!strcasecmp(p->tokbuf, c_run_scripts_as_owner))
			t = config_run_scripts_as_owner(p, a);
		else if (!strcasecmp(p->tokbuf, c_allow_dotfiles))
			t = config_flag(p, &a->allow_dotfiles);
		else if (!strcasecmp(p->tokbuf, c_user_directory))
			t = config_flag(p, &a->user_directory);
		else if (!strcasecmp(p->tokbuf, c_putenv))
			t = config_list(p, &a->putenvs);
		else if (!strcasecmp(p->tokbuf, c_extra_headers))
			t = config_list(p, &a->extra_headers);
		else if (!strcasecmp(p->tokbuf, c_path_info))
			t = config_flag(p, &a->path_info_ok);
		else if (!strcasecmp(p->tokbuf, c_auto_index_command))
			t = config_string(p, &a->auto_index_command);
		else if (!strcasecmp(p->tokbuf, c_expire_interval))
			t = config_int(p, &a->expire_interval);
		else if (!strcasecmp(p->tokbuf, c_sanitize_path))
			t = config_flag(p, &a->sanitize_path);
		else
			t = e_keyword;
		if (t)
			return t;
	}
	if (a->alias && (a->locations == 0))
		return e_bad_alias;
	return 0;
}

static const char *config_vhost(struct virtual **vs, struct vserver *s, const char *host, int anyhost)
{
	struct virtual *v;

	if ((v = malloc(sizeof *v)) == 0)
		return e_memory;
	if (host == 0)
		v->host = 0;
	else {
		if ((v->host = strdup(host)) == 0)
			return e_memory;
		sanitize_host(v->host);
	}
	v->vserver = s;
	v->next = *vs;
	v->anyhost = anyhost;
	*vs = v;
	return 0;
}

static const char *config_virtual(struct configuration *p, struct vserver **vs, struct server *parent)
{
	struct vserver *v;
	const char *t;
	struct virtual **vp;

	if ((v = malloc(sizeof *v)) == 0)
		return e_memory;
	if (parent) {
		v->controls = parent->controls;
		vp = &parent->children;
	} else {
		v->controls = controls;
		vp = &virtuals;
	}
	v->next = *vs;
	*vs = v;
	if ((t = gettoken(p)) != t_open)
		return t;
	while ((t = gettoken(p)) != t_close) {
		if (t != t_string)
			return t;
		if (!strcasecmp(p->tokbuf, c_host)) {
			if ((t = gettoken(p)) != t_string)
				return t;
			t = config_vhost(vp, v, p->tokbuf, 0);
		} else if (!strcasecmp(p->tokbuf, c_no_host))
			t = config_vhost(vp, v, 0, 0);
		else if (!strcasecmp(p->tokbuf, c_control))
			t = config_control(p, &v->controls);
		else if (!strcasecmp(p->tokbuf, c_any_host)) {
			t = config_vhost(vp, v, 0, 1);
			continue;
		} else
			t = e_keyword;
		if (t)
			return t;
	}
	return 0;
}

static const char *config_family(struct configuration *p, int *fp)
{
	const char *t;

	if ((t = gettoken(p)) != t_string)
		return t;
	if (!strcasecmp(p->tokbuf, "inet"))
		*fp = AF_INET;
	else if (!strcasecmp(p->tokbuf, "inet6"))
		*fp = AF_INET6;
	else
		return "unknown address family";
	return 0;
}

static const char *config_sockopts(struct configuration *p, struct server_sockopts **ss)
{
	struct server_sockopts *s;
	const char *t;
	int l, n, o, *op;
	unsigned long u;
	enum {
		SO_FLAG,
		SO_INT
	} what;

	if ((t = gettoken(p)) != t_open)
		return t;
	while ((t = gettoken(p)) != t_close) {
#ifdef SO_RCVBUF
		if (!strcasecmp(p->tokbuf, "rcvbuf")) {
			l = SOL_SOCKET;
			n = SO_RCVBUF;
			what = SO_INT;
		} else
#endif
#ifdef SO_SNDBUF
		if (!strcasecmp(p->tokbuf, "sndbuf")) {
			l = SOL_SOCKET;
			n = SO_SNDBUF;
			what = SO_INT;
		} else
#endif
#ifdef IPV6_V6ONLY
		if (!strcasecmp(p->tokbuf, "v6only")) {
			l = IPPROTO_IPV6;
			n = IPV6_V6ONLY;
			what = SO_FLAG;
		} else
#endif
#ifdef TCP_NODELAY
		if (!strcasecmp(p->tokbuf, "nodelay")) {
			l = IPPROTO_TCP;
			n = TCP_NODELAY;
			what = SO_FLAG;
		} else
#endif
			return "unknown socket option";
		switch (what) {
		case SO_FLAG:
			t = config_flag(p, &o);
			break;
		case SO_INT:
			t = config_int(p, &u);
			break;
		}
		if (t)
			return t;
		s = malloc(sizeof *s);
		if (s == 0)
			return e_memory;
		op = malloc(sizeof *op);
		if (op == 0)
			return e_memory;
		switch (what) {
		case SO_FLAG:
			*op = o;
			break;
		case SO_INT:
			*op = (int) u;
			break;
		}
		s->ss_level = l;
		s->ss_optname = n;
		s->ss_optval = op;
		s->ss_optlen = sizeof *op;
		s->next = *ss;
		*ss = s;
	}
	return 0;
}

static const char *config_server(struct configuration *p, struct server **ss)
{
	struct server *s;
	const char *t;
	struct addrinfo hints, *res;
	int rv, fam;

	if ((s = malloc(sizeof *s)) == 0)
		return e_memory;
	s->children = virtuals;
	s->vservers = vservers;
	s->controls = controls;
	s->backlog = DEFAULT_BACKLOG;
	s->addr = 0;
	s->port = strdup("80");
	if (s->port == 0)
		return e_memory;
	s->options = 0;
	fam = AF_UNSPEC;
	if ((t = gettoken(p)) != t_open)
		return t;
	while ((t = gettoken(p)) != t_close) {
		if (t != t_string)
			return t;
		if (!strcasecmp(p->tokbuf, c_port))
			t = config_string(p, &s->port);
		else if (!strcasecmp(p->tokbuf, c_address))
			t = config_string(p, &s->addr);
		else if (!strcasecmp(p->tokbuf, c_virtual))
			t = config_virtual(p, &s->vservers, s);
		else if (!strcasecmp(p->tokbuf, c_control))
			t = config_control(p, &s->controls);
		else if (!strcasecmp(p->tokbuf, c_backlog))
			t = config_int(p, &s->backlog);
		else if (!strcasecmp(p->tokbuf, c_family))
			t = config_family(p, &fam);
		else if (!strcasecmp(p->tokbuf, c_options))
			t = config_sockopts(p, &s->options);
		else
			t = e_keyword;
		if (t)
			return t;
	}
	memset(&hints, 0, sizeof hints);
	hints.ai_flags = AI_PASSIVE;
	hints.ai_family = fam;
	hints.ai_socktype = SOCK_STREAM;
	hints.ai_protocol = 0;
	rv = getaddrinfo(s->addr, s->port, &hints, &res);
	if (rv) {
		fprintf(stderr, "address %s port %s: %s\n", s->addr ? s->addr : "[any]", s->port, gai_strerror(rv));
		return e_illegalport;
	}
	s->server_addr = malloc(res->ai_addrlen);
	if (s->server_addr == 0) {
		freeaddrinfo(res);
		return e_memory;
	}
	s->family = res->ai_family;
	s->socktype = res->ai_socktype;
	s->protocol = res->ai_protocol;
	memcpy(s->server_addr, res->ai_addr, res->ai_addrlen);
	s->server_addrlen = res->ai_addrlen;
	freeaddrinfo(res);
	num_servers++;
	s->next = *ss;
	*ss = s;
	return 0;
}

static const char *config_smallint(struct configuration *p, int *i)
{
	const char *t;
	unsigned long u;

	t = config_int(p, &u);
	if (t)
		return t;
	if (u > CONF_SMALLINT_MAX)
		return e_toobig;
	*i = u;
	return 0;
}

static const char *config_tuning(struct configuration *p, struct tuning *tp)
{
	const char *t;

	if ((t = gettoken(p)) != t_open)
		return t;
	while ((t = gettoken(p)) != t_close) {
		if (t != t_string)
			return t;
		if (!strcasecmp(p->tokbuf, c_timeout))
			t = config_int(p, &tp->timeout);
		else if (!strcasecmp(p->tokbuf, c_buf_size))
			t = config_int(p, &tp->buf_size);
		else if (!strcasecmp(p->tokbuf, c_input_buf_size))
			t = config_int(p, &tp->input_buf_size);
		else if (!strcasecmp(p->tokbuf, c_num_connections))
			t = config_int(p, &tp->num_connections);
		else if (!strcasecmp(p->tokbuf, c_accept_multi))
			t = config_flag(p, &tp->accept_multi);
		else if (!strcasecmp(p->tokbuf, c_num_headers))
			t = config_int(p, &tp->num_headers);
		else if (!strcasecmp(p->tokbuf, c_script_timeout))
			t = config_int(p, &tp->script_timeout);
		else if (!strcasecmp(p->tokbuf, c_script_buf_size))
			t = config_int(p, &tp->script_buf_size);
		else if (!strcasecmp(p->tokbuf, c_clobber))
			t = config_flag(p, &tp->clobber);
		else if (!strcasecmp(p->tokbuf, c_wait))
			t = config_int(p, &tp->wait_timeout);
		else if (!strcasecmp(p->tokbuf, c_num_processes))
			t = config_smallint(p, &tp->num_processes);
		else if (!strcasecmp(p->tokbuf, c_greedy))
			t = config_flag(p, &tp->greedy);
		else
			t = e_keyword;
		if (t)
			return t;
	}
	return 0;
}

static const char *config_user(struct configuration *p)
{
	const char *t;
	struct passwd *pw;

	t = gettoken(p);
	if (t != t_string)
		return t;
	pw = getpwnam(p->tokbuf);
	if (pw == 0)
		return e_user_unknown;
	if (pw->pw_uid == 0)
		return e_user_invalid;
	server_uid = pw->pw_uid;
	server_gid = pw->pw_gid;
	return 0;
}

static const char *config_main(struct configuration *p)
{
	const char *t;

	while ((t = gettoken(p)) != t_eof) {
		if (t != t_string)
			return t;
		if (!strcasecmp(p->tokbuf, c_root_directory))
			t = config_string(p, &rootdir);
		else if (!strcasecmp(p->tokbuf, c_core_directory))
			t = config_string(p, &coredir);
		else if (!strcasecmp(p->tokbuf, c_umask))
			t = config_int(p, &fcm);
		else if (!strcasecmp(p->tokbuf, c_stay_root))
			t = config_flag(p, &stayroot);
		else if (!strcasecmp(p->tokbuf, c_user))
			t = config_user(p);
		else if (!strcasecmp(p->tokbuf, c_pid_file))
			t = config_string(p, &pid_filename);
		else if (!strcasecmp(p->tokbuf, c_log))
			t = config_string(p, &log_filename);
		else if (!strcasecmp(p->tokbuf, c_error_log))
			t = config_string(p, &error_filename);
		else if (!strcasecmp(p->tokbuf, c_tuning))
			t = config_tuning(p, &tuning);
		else if (!strcasecmp(p->tokbuf, c_control))
			t = config_control(p, &controls);
		else if (!strcasecmp(p->tokbuf, c_server))
			t = config_server(p, &servers);
		else if (!strcasecmp(p->tokbuf, c_log_format))
			t = config_log(p, &log_column, &log_columns);
		else if (!strcasecmp(p->tokbuf, c_log_gmt))
			t = config_flag(p, &log_gmt);
		else if (!strcasecmp(p->tokbuf, c_virtual))
			t = config_virtual(p, &vservers, 0);
		else
			t = e_keyword;
		if (t)
			return t;
	}
	return 0;
}

const char *config(const char *config_filename)
{
	const char *s;
	struct configuration c;

	c.size = 64;
	c.tokbuf = malloc(c.size);
	if (c.tokbuf == 0)
		return e_memory;
	if (config_filename) {
		c.config_file = fopen(config_filename, "r");
		if (c.config_file == 0) {
			fprintf(stderr, "Cannot open configuration file %s\n", config_filename);
			free(c.tokbuf);
			return e_noinput;
		}
	} else
		c.config_file = stdin;
	tuning.buf_size = DEFAULT_BUF_SIZE;
	tuning.input_buf_size = DEFAULT_INPUT_BUF_SIZE;
	tuning.num_connections = DEFAULT_NUM_CONNECTIONS;
	tuning.timeout = DEFAULT_TIMEOUT;
	tuning.accept_multi = 1;
	tuning.num_headers = DEFAULT_NUM_HEADERS;
	tuning.script_timeout = DEFAULT_SCRIPT_TIMEOUT;
	tuning.script_buf_size = DEFAULT_SCRIPT_BUF_SIZE;
	tuning.clobber = 1;
	tuning.wait_timeout = DEFAULT_WAIT_TIMEOUT;
	tuning.num_processes = 1;
	tuning.greedy = 1;
	fcm = DEFAULT_UMASK;
	stayroot = 0;
	log_columns = 0;
	log_column = 0;
	log_gmt = 0;
	c.line = 1;
	s = config_main(&c);
	if (config_filename)
		fclose(c.config_file);
	if (s) {
		if (config_filename)
			fprintf(stderr, "In configuration file: %s\n", config_filename);
		fprintf(stderr, "Error at token '%s' around line %d\n", c.tokbuf, c.line);
		free(c.tokbuf);
		return s;
	}
	free(c.tokbuf);
	if (log_column == 0) {
		log_column = default_log_column;
		log_columns = sizeof default_log_column / sizeof default_log_column[0];
	}
	return 0;
}

int init_buffers(void)
{
	if (init_pollfds(2 * tuning.num_connections + num_servers) == -1)
		return -1;
	if (init_connections(tuning.num_connections) == -1)
		return -1;
	if (init_log_buffer(tuning.input_buf_size + 1000) == -1)
		return -1;
	if (init_cgi_headers() == -1)
		return -1;
	return 0;
}
