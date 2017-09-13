/*
 *	Handle incoming frames
 *	Linux ethernet bridge
 *
 *	Authors:
 *	Lennert Buytenhek		<buytenh@gnu.org>
 *
 *	This program is free software; you can redistribute it and/or
 *	modify it under the terms of the GNU General Public License
 *	as published by the Free Software Foundation; either version
 *	2 of the License, or (at your option) any later version.
 */

#include <linux/kernel.h>
#include <linux/netdevice.h>
#include <linux/etherdevice.h>
#include <linux/netfilter_bridge.h>
#include "br_private.h"

#if 1 //def CONFIG_WIRELESS_GUEST_ZONE
#include <linux/tcp.h>
#include <linux/udp.h>
#include <linux/ip.h>
#endif

/* Bridge group multicast address 802.1d (pg 51). */
const u8 br_group_address[ETH_ALEN] = { 0x01, 0x80, 0xc2, 0x00, 0x00, 0x00 };

static void br_pass_frame_up(struct net_bridge *br, struct sk_buff *skb)
{
	struct net_device *indev, *brdev = br->dev;

	brdev->stats.rx_packets++;
	brdev->stats.rx_bytes += skb->len;

	indev = skb->dev;
	skb->dev = brdev;

	NF_HOOK(PF_BRIDGE, NF_BR_LOCAL_IN, skb, indev, NULL,
		netif_receive_skb);
}

/* note: already called with rcu_read_lock (preempt_disabled) */
int br_handle_frame_finish(struct sk_buff *skb)
{
	const unsigned char *dest = eth_hdr(skb)->h_dest;
	struct net_bridge_port *p = rcu_dereference(skb->dev->br_port);
	struct net_bridge *br;
	struct net_bridge_fdb_entry *dst;
	struct sk_buff *skb2;

#if 1 //def CONFIG_WIRELESS_GUEST_ZONE
	struct tcphdr *tcph;
	struct udphdr *udph;
	struct iphdr *iph;
	int tcp_dest_port;
	int udp_dest_port;
#endif
	if (!p || p->state == BR_STATE_DISABLED)
		goto drop;

	/* insert into forwarding database after filtering to avoid spoofing */
	br = p->br;
	br_fdb_update(br, p, eth_hdr(skb)->h_source);

	if (p->state == BR_STATE_LEARNING)
		goto drop;

	/* The packet skb2 goes to the local host (NULL to skip). */
	skb2 = NULL;

	if (br->dev->flags & IFF_PROMISC)
		skb2 = skb;

	dst = NULL;

	if (is_multicast_ether_addr(dest)) {
		br->dev->stats.multicast++;
		skb2 = skb;
	} else if ((dst = __br_fdb_get(br, dest)) && dst->is_local) {
		skb2 = skb;
		/* Do not forward the packet since it's local. */
		skb = NULL;
	}

	if (skb2 == skb)
		skb2 = skb_clone(skb, GFP_ATOMIC);

	if (skb2)
#if 1 //def CONFIG_WIRELESS_GUEST_ZONE
	{
	    if (p->br->guestzone_enabled == 1) //bridge support guest zone settings
	    {
	        //printk("br_handle_frame_finish: frame up: bridge guestzone_enabled\n");
	        if (skb2->dev->is_guest_zone == 1)
	        {
	            //printk("br_handle_frame_finish: %s is Guest Zone\n", skb2->dev->name);
	            iph = ip_hdr(skb2);
	            //printk("Guest Zone: saddr=%x (%u.%u.%u.%u), daddr=%x (%u.%u.%u.%u)\n", iph->saddr, NIPQUAD(iph->saddr), iph->daddr, NIPQUAD(iph->daddr));
	            //printk("Guest Zone: bridge IP=%x\n", p->br->br_ip);
	            if( p->br->br_ip == iph->daddr)
	            {
	                if( iph->protocol == IPPROTO_TCP)
	                {
	                    tcph = (void *)iph + iph->ihl*4;
	                    tcp_dest_port = ntohs(tcph->dest);
	                    //printk("br_handle_frame_finish: version=%d, iph len=%d, tcph len=%d\n", iph->version, iph->ihl, tcph->doff);
	                    //printk("br_handle_frame_finish: dest=%hu, source=%hu\n", ntohs(tcph->dest), ntohs(tcph->source));
	                    if( ((tcp_dest_port == 80) || (tcp_dest_port == 8099)) && (skb2->dev->support_route == 0) )
	                    {
	                        /*
	                        Guest Zone can browse device when we enable Routing between LAN
	                        80 -> httpd, 8099 -> PureNet Work (QUS)
	                        */
	                        //printk("Guest Zone: %s don't allow to access 80(8099) port of device\n", skb2->dev->name);
	                        kfree_skb(skb2);
	                        goto out;
	                    }
	                    else if(skb2->dev->support_share_port == 0)
	                    {
	                        if( (tcp_dest_port == 20005) || (tcp_dest_port == 19540) )
	                        {
	                            //20005-> KCodes, 19540 -> Silex
	                            //printk("Guest Zone: %s don't allow to use SharePort Utility (TCP)\n", skb2->dev->name);
	                            kfree_skb(skb2);
	                            goto out;
	                        }
	                    }
	                }
	                else if(iph->protocol == IPPROTO_UDP)
	                {
	                    if(skb2->dev->support_share_port == 0)
	                    {
	                        udph = (void *)iph + iph->ihl*4;
	                        udp_dest_port = ntohs(udph->dest);
	                        if( (udp_dest_port == 9303) || (udp_dest_port == 19540) )
	                        {
	                            //9303-> KCodes, 19540 -> Silex
	                            //printk("Guest Zone: %s don't allow to use SharePort Utility (UDP)\n", skb2->dev->name);
	                            kfree_skb(skb2);
	                            goto out;
	                        }
	                    }
	                }
	            }
	        }
	    }
#endif
		br_pass_frame_up(br, skb2);
#if 1 //def CONFIG_WIRELESS_GUEST_ZONE
	}
#endif
	if (skb) {
		if (dst)
#if 1 //def CONFIG_WIRELESS_GUEST_ZONE
            {
                if(p->br->guestzone_enabled == 1)
                {
                    //printk("br_handle_frame_finish: frame forward: bridge guestzone_enabled\n");
                    if(skb->dev->is_guest_zone == 1)
                    {
                        //printk("br_handle_frame_finish: %s is Guest Zone\n", skb->dev->name);
                        if(skb->dev->support_route == 0) /* src dev Disable Routing between LAN*/
                        {
                            //printk("br_handle_frame_finish: br_forward: src Disable Routing between LAN\n");
                            if( strcmp(dst->dst->dev->name, skb->dev->name) && strcmp(dst->dst->dev->name, "eth1") )
                            {
                                /* src != dst and dst != wan*/
                                //printk("Guest Zone: kfree_skb: From Guest Zone=%s To %s\n", skb->dev->name, dst->dst->dev->name);
                                kfree_skb(skb);
                                goto out;
                            }
                        }
//                      if(dst->dst->dev->support_route == 0) /* dst dev Disable Routing between LAN*/
//                      {
//                          //printk("br_handle_frame_finish: br_forward: det Disable Routing between LAN\n");
//                          if( strcmp(skb->dev->name, dst->dst->dev->name) && strcmp(skb->dev->name, "eth1") )
//                          {
//                              /* src != dst and src != wan*/
//                              printk("Guest Zone: kfree_skb: From %s To Guest Zone=%s\n", skb->dev->name, dst->dst->dev->name);
//                              kfree_skb(skb);
//                              goto out;
//                          }
//                      }
                    }
                }
#endif
			br_forward(dst->dst, skb);
#if 1 //def CONFIG_WIRELESS_GUEST_ZONE
            }
#endif
		else
			br_flood_forward(br, skb);
	}

out:
	return 0;
drop:
	kfree_skb(skb);
	goto out;
}

/* note: already called with rcu_read_lock (preempt_disabled) */
static int br_handle_local_finish(struct sk_buff *skb)
{
	struct net_bridge_port *p = rcu_dereference(skb->dev->br_port);

	if (p)
		br_fdb_update(p->br, p, eth_hdr(skb)->h_source);
	return 0;	 /* process further */
}

/* Does address match the link local multicast address.
 * 01:80:c2:00:00:0X
 */
static inline int is_link_local(const unsigned char *dest)
{
	__be16 *a = (__be16 *)dest;
	static const __be16 *b = (const __be16 *)br_group_address;
	static const __be16 m = cpu_to_be16(0xfff0);

	return ((a[0] ^ b[0]) | (a[1] ^ b[1]) | ((a[2] ^ b[2]) & m)) == 0;
}

/*
 * Called via br_handle_frame_hook.
 * Return NULL if skb is handled
 * note: already called with rcu_read_lock (preempt_disabled)
 */
struct sk_buff *br_handle_frame(struct net_bridge_port *p, struct sk_buff *skb)
{
	const unsigned char *dest = eth_hdr(skb)->h_dest;
	int (*rhook)(struct sk_buff *skb);

	if (!is_valid_ether_addr(eth_hdr(skb)->h_source))
		goto drop;

	skb = skb_share_check(skb, GFP_ATOMIC);
	if (!skb)
		return NULL;

	if (unlikely(is_link_local(dest))) {
		/* Pause frames shouldn't be passed up by driver anyway */
		if (skb->protocol == htons(ETH_P_PAUSE))
			goto drop;

		if (NF_HOOK(PF_BRIDGE, NF_BR_LOCAL_IN, skb, skb->dev,
			    NULL, br_handle_local_finish))
			return NULL;	/* frame consumed by filter */
		else
			return skb;	/* continue processing */
	}

	switch (p->state) {
	case BR_STATE_FORWARDING:
		rhook = rcu_dereference(br_should_route_hook);
		if (rhook != NULL) {
			if (rhook(skb))
				return skb;
			dest = eth_hdr(skb)->h_dest;
		}
		/* fall through */
	case BR_STATE_LEARNING:
		if (!compare_ether_addr(p->br->dev->dev_addr, dest))
			skb->pkt_type = PACKET_HOST;

		NF_HOOK(PF_BRIDGE, NF_BR_PRE_ROUTING, skb, skb->dev, NULL,
			br_handle_frame_finish);
		break;
	default:
drop:
		kfree_skb(skb);
	}
	return NULL;
}
