#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <dirent.h>
#include <sys/types.h>
#include <sys/wait.h>
#include "libdb.h"
#include "ssi.h"

/* cgi_tool.c */
extern int vpn_main(int argc, char *argv[]);
extern int echo_schedules_inused(int argc, char *argv[]);
extern int strip_main(int argc, char *argv[]);
extern int get_time(int argc, char *argv[]);
extern int ca_inused_main(int argc, char *argv[]);
extern int group_inused_main(int argc, char *argv[]);
extern int http_login(int argc, char *argv[]);
extern int vpn_ip_main(int argc, char *argv[]);
extern void main_using(struct subcmd *cmds);

extern int active_main(int argc, char *argv[]);
extern int clone_main(int argc, char *argv[]);
extern int dynamicdhcp_main(int argc, char *argv[]);
extern int delete_vpn_main(int argc, char *argv[]);
extern int firmware_info_main(int argc, char *argv[]);
extern int firmw_check_main(int argc, char *argv[]);
extern int get_trx_main(int argc, char *argv[]);
extern int log_page_main(int argc, char *argv[]);
extern int staticdhcp_main(int argc, char *argv[]);
extern int stat_info_main(int argc, char *argv[]);
extern int wl_sta_list_main(int argc, char *argv[]);
extern int firmupdate_main(int argc, char *argv[]);
extern int file_exist(int argc, char *argv[]);
extern int user_behavior(int argc, char *argv[]);
extern int get_os_version(int argc, char *argv[]);
extern int checksum(int argc, char *argv[]);
extern int get_os_date(int argc, char *argv[]);
extern int get_wl_channel_main(int argc, char *argv[]);
extern int list_url_main(int argc, char *argv[]);
extern int get_wl_domain(int argc, char *argv[]);
extern int authgraph_main(int argc, char *argv[]);
extern int get_usb_status_main(int argc, char *argv[]);
extern int get_wl_country_main(int argc, char *argv[]);
extern int auth_mech_main(int argc, char *argv[]);
extern int auth_local(int argc, char *argv[]);
extern int socket_sslvpn_main(int argc, char *argv[]);
extern int ipsec_dns_main(int argc, char *argv[]);
extern int lang_pack_main(int argc, char *argv[]);

int main(int argc, char *argv[])
{
	struct subcmd *p, ops[] = {
		{"vpn", vpn_main},
		{"schedule", echo_schedules_inused},
		{"strip_cmd", strip_main},
		/* {"vpn_exist", vpn_exist_main}, */
		{"active", active_main},
		{"clone", clone_main},
		{"delete_vpn", delete_vpn_main},
		{"dynamicdhcp", dynamicdhcp_main},
		{"firmware_info", firmware_info_main},
		{"firmw_check", firmw_check_main},
		{"get_trx", get_trx_main},
		{"log_page", log_page_main},
		{"staticdhcp", staticdhcp_main},
		{"stat_info", stat_info_main},
		{"wl_sta_list", wl_sta_list_main},
		{"get_time", get_time},
		{"ca_inused", ca_inused_main},
		{"group_inused", group_inused_main},
		{"http_login", http_login},
		{"vpn_ip", vpn_ip_main},
		{"firmupdate", firmupdate_main},
		{"file_exist", file_exist},
		{"user_behavior", user_behavior},
		{"get_os_version", get_os_version},
		{"checksum", checksum},
		{"get_os_date", get_os_date},
		{"get_wl_channel", get_wl_channel_main},
		{"list_url", list_url_main},
		{"get_wl_domain", get_wl_domain},
		{"graph_auth", authgraph_main},
		{"get_usb_status", get_usb_status_main},
		{"get_wl_country", get_wl_country_main},
		{"auth_mech", auth_mech_main},
		{"auth_local", auth_local},
		/* {"socket_sslvpn", socket_sslvpn_main}, */
		{"ipsec_dns", ipsec_dns_main},
		{"lang", lang_pack_main},
		{NULL, NULL}
	};
	int rev = -1;
	char *base = strrchr(argv[0], '/');

	base = base ? base + 1 : argv[0];
	
	if (argv[1] && (strcmp(argv[1], "-h") == 0 || strcmp(argv[1], "--help") == 0)) {
		main_using(ops);
		goto out;
	}
	
	for (p = ops; p->action != NULL; p++) {
		if (strcmp(base, p->action) == 0) {
			return p->fn(argc, argv);
		}
	}
out:
	return rev;
}
