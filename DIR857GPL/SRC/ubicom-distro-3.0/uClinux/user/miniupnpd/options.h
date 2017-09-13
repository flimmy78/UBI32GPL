/* $Id: options.h,v 1.2 2009/07/08 11:18:33 jimmy_huang Exp $ */
/* MiniUPnP project
 * http://miniupnp.free.fr/ or http://miniupnp.tuxfamily.org/
 * author: Ryan Wagoner
 * (c) 2006 Thomas Bernard 
 * This software is subject to the conditions detailed
 * in the LICENCE file provided within the distribution */

#ifndef __OPTIONS_H__
#define __OPTIONS_H__

#include "config.h"

/* enum of option available in the miniupnpd.conf */
enum upnpconfigoptions {
	UPNP_INVALID = 0,
	UPNPEXT_IFNAME = 1,		/* ext_ifname */
	/*	Date:	2009-07-08
	*	Name:	jimmy huang
	*	Reason:	To add rules with "-o br0"
	*/
	UPNPINT_IFNAME,			/* int_ifname */
	UPNPEXT_IP,				/* ext_ip */
	UPNPLISTENING_IP,		/* listening_ip */
	UPNPPORT,				/* "port" */
	UPNPBITRATE_UP,			/* "bitrate_up" */
	UPNPBITRATE_DOWN,		/* "bitrate_down" */
	UPNPPRESENTATIONURL,	/* presentation_url */
	UPNPNOTIFY_INTERVAL,	/* notify_interval */
	UPNPSYSTEM_UPTIME,		/* "system_uptime" */
	UPNPPACKET_LOG,			/* "packet_log" */
/*	Date:	2009-04-20
*	Name:	jimmy huang
*	Reason:	For wps enable / disable, and UPnP related stuff
*/
	UPNPWPS_ENABLE,			/* wps_enable */
	UPNPFRIENDLY_NAME,		/* friendly_name */
	UPNPMANUFACTURER_NAME,	/* manufacturer_name */
	UPNPMANUFACTURER_URL,	/* manufacturer_url */
	UPNPMODEL_NAME,			/* model_name */
	UPNPMODEL_URL,			/* model_url */
//----------
	UPNPUUID,				/* uuid */
	UPNPSERIAL,				/* serial */
	UPNPMODEL_NUMBER,		/* model_number */
	UPNPCLEANTHRESHOLD,		/* clean_ruleset_threshold */
	UPNPCLEANINTERVAL,		/* clean_ruleset_interval */
	UPNPENABLENATPMP,		/* enable_natpmp */
#ifdef USE_NETFILTER
	UPNPFORWARDCHAIN,
	UPNPNATCHAIN,
#endif
#ifdef USE_PF
	UPNPQUEUE,				/* queue */
	UPNPTAG,				/* tag */
#endif
#ifdef PF_ENABLE_FILTER_RULES
	UPNPQUICKRULES,			/* quickrules */
#endif
	UPNPSECUREMODE,			/* secure_mode */
#ifdef ENABLE_LEASEFILE
	UPNPLEASEFILE,			/* lease_file */
#endif
	UPNPMINISSDPDSOCKET,	/* minissdpdsocket */
	UPNPENABLE				/* enable_upnp */
};

/* readoptionsfile()
 * parse and store the option file values
 * returns: 0 success, -1 failure */
int
readoptionsfile(const char * fname);

/* freeoptions() 
 * frees memory allocated to option values */
void
freeoptions(void);

#define MAX_OPTION_VALUE_LEN (80)
struct option
{
	enum upnpconfigoptions id;
	char value[MAX_OPTION_VALUE_LEN];
};

extern struct option * ary_options;
extern int num_options;

#endif

