﻿<html>
<head>
<script language="JavaScript" src="lingual_<% CmoGetCfg("lingual","none"); %>_tmp.js"></script>
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<script language="JavaScript" src="lingual_<% CmoGetCfg("lingual","none"); %>.js"></script>
<script language="Javascript" src="lang.js"></script>
<script language="Javascript" src="public.js"></script>
<script language="Javascript">
var submit_button_flag = 0;
function onPageLoad(){
	get_by_id("next_b2").disabled = true;
	get_by_id("cancel_b2").disabled = true;
}

function unsave_key(v6_wan_proto)
{
	if (v6_wan_proto!="ipv6_static")
	{
		get_by_id("ipv6_use_link_local").name += "_unsave";
		get_by_id("ipv6_static_wan_ip").name += "_unsave";
		get_by_id("ipv6_static_prefix_length").name += "_unsave";
		get_by_id("ipv6_static_default_gw").name += "_unsave";
		get_by_id("ipv6_static_primary_dns").name += "_unsave";
		get_by_id("ipv6_static_secondary_dns").name += "_unsave";
		get_by_id("ipv6_static_lan_ip").name += "_unsave";
	}
	if (v6_wan_proto!="ipv6_autoconfig" && v6_wan_proto!="ipv6_pppoe") {
		get_by_id("ipv6_dhcp_pd_enable").name += "_unsave";
		get_by_id("ipv6_dhcp_pd_enable_l").name += "_unsave";
	}
	if (v6_wan_proto!="ipv6_pppoe")
	{
		get_by_id("ipv6_pppoe_dns_enable").name += "_unsave";
		get_by_id("ipv6_pppoe_dynamic").name += "_unsave";
		get_by_id("ipv6_pppoe_username").name += "_unsave";
		get_by_id("ipv6_pppoe_password").name += "_unsave";
		get_by_id("ipv6_pppoe_service").name += "_unsave";
		get_by_id("ipv6_pppoe_share").name += "_unsave";
		get_by_id("ipv6_pppoe_mtu").name += "_unsave";
		get_by_id("ipv6_pppoe_connect_mode").name += "_unsave";
	}
	if (v6_wan_proto!="ipv6_6rd")
	{
		get_by_id("ipv6_6rd_dhcp").name += "_unsave";
		get_by_id("ipv6_6rd_prefix").name += "_unsave";
		get_by_id("ipv6_6rd_prefix_length").name += "_unsave";
		get_by_id("ipv6_6rd_ipv4_mask_length").name += "_unsave";
		get_by_id("ipv6_6rd_relay").name += "_unsave";
		get_by_id("ipv6_6rd_primary_dns").name += "_unsave";
	}
}

function send_request(){
	var wan_proto = get_by_id("ipv6_wan_proto").value;
	var pppoe_share = get_by_id("ipv6_pppoe_share").value
	unsave_key(wan_proto);
	if(wan_proto == "ipv6_pppoe"){
		get_by_id("ipv6_wan_specify_dns").value = "0";
		if(pppoe_share == "0"){
			get_by_id("ipv6_pppoe_mtu").value = "1492";
			get_by_id("ipv6_pppoe_connect_mode").value = "always_on";
		}
	}
	if(wan_proto == "ipv6_static"){
		get_by_id("ipv6_wan_specify_dns").value = "1";
	}
	if(wan_proto == "ipv6_6rd"){
		get_by_id("ipv6_wan_specify_dns").value = "1";
	}

	get_by_id("asp_temp_42").value = "";
	
	if(submit_button_flag == 0){
                submit_button_flag = 1;
                get_by_id("form1").submit();
                return true;
        }else{
                return false;
        }       
}

function go_back(){
	var prev_page = get_by_id("asp_temp_42").value;
	unsave_key(""); // don't save any ipv6 config
	get_by_id("reboot_type").value = "none";
	
	if (prev_page != "") 
		get_by_id("html_response_page").value= prev_page;
	else
		get_by_id("html_response_page").value= "wizard_ipv6_1.asp";
	
	send_submit("form1");
}


</script>
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575" onload="onPageLoad();">
<table border=0 cellspacing=0 cellpadding=0 align=center width=838>
<tr>
	<td bgcolor="#FFFFFF">
	<table width=838 border=0 cellspacing=0 cellpadding=0 align=center height=100>
	<tr>
		<td bgcolor="#FFFFFF">
			<div align=center>
	<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
      <tr>
        <td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://support.dlink.com.tw/"><% CmoGetCfg("model_number","none"); %></a></td>
        <td align="right" nowrap><script>show_words(TA3)</script>: <% CmoGetStatus("hw_version"); %> &nbsp;</td>
	    	<td align="right" nowrap><script>show_words(sd_FWV)</script>: <% CmoGetStatus("version"); %></td>
		<td>&nbsp;</td>
      </tr>
    </table>
			<img src="wlan_masthead.gif" width="836" height="92" align="middle"> 
			</div>
		</td>
	</tr>
	</table>
	</td>
</tr>
<tr>
	<td bgcolor="#FFFFFF">
	<p>&nbsp;</p>
	<table width="650" border="0" align="center">
	<tr>
		<td>
			<div id=box_header>
			<h1 align="left"><script>show_words(IPv6_wizard_14);</script></h1>
			<div align="left">
			<p class="box_msg"><script>show_words(IPV6_wizard_info_8);</script></p>
			<div>
			<div id=w1>
			<form id="form1" name="form1" method="post" action="apply.cgi">
				<input type="hidden" id="html_response_page" name="html_response_page" value="back_long.asp">
                    		<input type="hidden" id="html_response_message" name="html_response_message" value=""><script>get_by_id("html_response_message").value = sc_intro_sv;</script>
			<input type="hidden" name="html_response_return_page" value="ipv6.asp">
<input type="hidden" id="reboot_type" name="reboot_type" value="all">
				<input type="hidden" id="asp_temp_42" name="asp_temp_42" value ="<% CmoGetCfg("asp_temp_42",""); %>">

				<!--Shared Key -->
				<input type="hidden" id="ipv6_wan_proto" name="ipv6_wan_proto" value="<% CmoGetCfg("ipv6_wan_proto","none"); %>">
                                <input type="hidden" id="ipv6_wan_specify_dns" name="ipv6_wan_specify_dns" value="<% CmoGetCfg("ipv6_wan_specify_dns","none"); %>">
				<input type="hidden" id="ipv6_autoconfig" name="ipv6_autoconfig" value="1">
				<input type="hidden" id="ipv6_autoconfig_type" name="ipv6_autoconfig_type" value="stateless_dhcp">
				<!--input type="hidden" id="ipv6_ra_adv_valid_lifetime_l_one" name="ipv6_ra_adv_valid_lifetime_l_one" value="86400">
				<input type="hidden" id="ipv6_ra_adv_prefer_lifetime_l_one" name="ipv6_ra_adv_prefer_lifetime_l_one" value="86400"-->
				<!-- IPv6 pppoe-->
                                <input type="hidden" id="ipv6_pppoe_dns_enable" name="ipv6_pppoe_dns_enable" value="0">
                                <input type="hidden" id="ipv6_pppoe_dynamic" name="ipv6_pppoe_dynamic" value="1">
				<input type="hidden" id="ipv6_pppoe_username" name="ipv6_pppoe_username" value="<% CmoGetCfg("ipv6_pppoe_username","none"); %>">
                    		<input type="hidden" id="ipv6_pppoe_password" name="ipv6_pppoe_password" value="<% CmoGetCfg("ipv6_pppoe_password","none"); %>">
                                <input type="hidden" id="ipv6_pppoe_service" name="ipv6_pppoe_service" value="<% CmoGetCfg("ipv6_pppoe_service","none"); %>">
                                <input type="hidden" id="ipv6_pppoe_share" name="ipv6_pppoe_share" value="<% CmoGetCfg("ipv6_pppoe_share","none"); %>">
                                <input type="hidden" id="ipv6_pppoe_mtu" name="ipv6_pppoe_mtu" value="<% CmoGetCfg("ipv6_pppoe_mtu","none"); %>">
                                <input type="hidden" id="ipv6_pppoe_connect_mode" name="ipv6_pppoe_connect_mode" value="<% CmoGetCfg("ipv6_pppoe_connect_mode","none"); %>">
                                <input type="hidden" id="ipv6_dhcp_pd_enable" name="ipv6_dhcp_pd_enable" value="1">
                                <input type="hidden" id="ipv6_dhcp_pd_enable_l" name="ipv6_dhcp_pd_enable_l" value="1">
				<!-- IPv6 static -->
				<input type="hidden" id="ipv6_use_link_local" name="ipv6_use_link_local" value="<% CmoGetCfg("ipv6_use_link_local","none"); %>">
				<input type="hidden" id="ipv6_static_wan_ip" name="ipv6_static_wan_ip" value="<% CmoGetCfg("ipv6_static_wan_ip","none"); %>">
				<input type="hidden" id="ipv6_static_prefix_length" name="ipv6_static_prefix_length" value="<% CmoGetCfg("ipv6_static_prefix_length","none"); %>"> 
				<input type="hidden" id="ipv6_static_default_gw" name="ipv6_static_default_gw" value="<% CmoGetCfg("ipv6_static_default_gw","none"); %>">
				<input type="hidden" id="ipv6_static_primary_dns" name="ipv6_static_primary_dns" value="<% CmoGetCfg("ipv6_static_primary_dns","none"); %>">
				<input type="hidden" id="ipv6_static_secondary_dns" name="ipv6_static_secondary_dns" value="<% CmoGetCfg("ipv6_static_secondary_dns","none"); %>">
				<input type="hidden" id="ipv6_static_lan_ip" name="ipv6_static_lan_ip" value="<% CmoGetCfg("ipv6_static_lan_ip","none"); %>">
				<!--IPv6 6rd -->
				<input type="hidden" id="ipv6_6rd_dhcp" name="ipv6_6rd_dhcp" value="0">
				<input type="hidden" id="ipv6_6rd_prefix" name="ipv6_6rd_prefix" value="<% CmoGetCfg("ipv6_6rd_prefix","none"); %>">
                                <input type="hidden" id="ipv6_6rd_prefix_length" name="ipv6_6rd_prefix_length" value="<% CmoGetCfg("ipv6_6rd_prefix_length","none"); %>">
				<input type="hidden" id="ipv6_6rd_ipv4_mask_length" name="ipv6_6rd_ipv4_mask_length" value="<% CmoGetCfg("ipv6_6rd_ipv4_mask_length","none"); %>">
				<input type="hidden" id="ipv6_6rd_relay" name="ipv6_6rd_relay" value="<% CmoGetCfg("ipv6_6rd_relay","none"); %>">
				<input type="hidden" id="ipv6_6rd_primary_dns" name="ipv6_6rd_primary_dns" value="<% CmoGetCfg("ipv6_6rd_primary_dns","none"); %>">

			<table class=formarea border="0" align="center">
			<tbody>
			<tr>
				<td>&nbsp;</td>
				<td>&nbsp;<BR>
					<input type="button" id="prev_b2" class="button_submit" name="prev_b2" value="Prev" onclick="go_back();">
					<input type="button" id="next_b2" class="button_submit" name="next_b2" value="Next">
					<input type="button" id="cancel_b2" class="button_submit" name="cancel_b2" value="Cancel" onclick="window.location.href='ipv6.asp'">
					<input type="button" class="button_submit" id="connect_b2" name="connect_b2" value="connect"onclick="return send_request()">
						<script>
                                                	get_by_id("prev_b2").value = _prev;
                                                	get_by_id("next_b2").value = _next;
	                                                get_by_id("cancel_b2").value = _cancel;
							get_by_id("connect_b2").value = _connect;
        	                                </script>
				</td>
			</tr>
			</tbody>
			</table>

			<br>&nbsp;
			</form>
			</div><!--w1-->
			</div>
			</div><!--left-->
			</div><!--header-->
		</td>
	</tr>
	</table>
	<p>&nbsp;</p>
	</td>
</tr>
<tr>
	<td bgcolor="#FFFFFF">
	<table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="836" align="center">
	<tr>
		<td width="125" align="center">&nbsp;&nbsp;<img src="wireless_tail.gif" width="114" height="35"></td>
		<td width="10">&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	</table>
	</td>
</tr>
</table>
<div id="copyright"><script>show_words(_copyright);</script></div>
</body>
</html>
