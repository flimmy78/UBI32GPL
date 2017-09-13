<html>
<head>
<script language="JavaScript" src="lingual_<% CmoGetCfg("lingual","none"); %>_tmp.js"></script>
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<script language="JavaScript" src="lingual_<% CmoGetCfg("lingual","none"); %>.js"></script>
<script language="Javascript" src="public.js"></script>
<script language="JavaScript" src="public_ipv6.js"></script>
<script language="JavaScript" src="public_msg.js"></script>

<script language="Javascript">
var submit_button_flag = 0;
	function onPageLoad(){
		get_by_id("connect_b2").disabled = true;
		set_checked(get_by_id("ipv6_use_link_local").value, get_by_id("ipv6_use_link_local_sel"));
		 if (get_by_id("ipv6_use_link_local_sel").checked)
                        use_wan_link_local_selector(get_by_id("ipv6_use_link_local_sel").checked);
	}

	var static_wan_ip ;
	var static_prefix_length ;
	
	function use_wan_link_local_selector(value) {
		var link_local_w ;
		var ipv6_local_w_ip;
		//var static_wan_ip = get_by_id("ipv6_static_wan_ip_value").value;
		//var static_prefix_length = get_by_id("ipv6_static_prefix_length_value").value;

		if (value == true) {
			static_wan_ip =  get_by_id("ipv6_static_wan_ip").value;
			static_prefix_length = get_by_id("ipv6_static_prefix_length").value;
			ipv6_local_w_ip = get_by_id("link_local_ip_w").value.split("/");
			if (ipv6_local_w_ip.length > 1) {
			get_by_id("ipv6_static_wan_ip").value = ipv6_local_w_ip[0].toUpperCase();
			get_by_id("ipv6_static_prefix_length").value = ipv6_local_w_ip[1];
			} else {
				get_by_id("ipv6_static_wan_ip").value = "";
				get_by_id("ipv6_static_prefix_length").value = "";
			}
			get_by_id("ipv6_static_wan_ip").disabled = true;
			get_by_id("ipv6_static_prefix_length").disabled = true;
                } else {
			get_by_id("ipv6_static_wan_ip").value = "<% CmoGetCfg("ipv6_static_wan_ip",""); %>";
			get_by_id("ipv6_static_prefix_length").value = "<% CmoGetCfg("ipv6_static_prefix_length",""); %>" ;
			//get_by_id("ipv6_static_wan_ip").value = static_wan_ip;
			//get_by_id("ipv6_static_prefix_length").value = static_prefix_length;
			get_by_id("ipv6_static_wan_ip").disabled = false;
                        get_by_id("ipv6_static_wan_ip").disabled = false;
                        get_by_id("ipv6_static_prefix_length").disabled = false;
                }
        }


	function send_request(){
		var ipv6_static = get_by_id("ipv6_static_wan_ip").value;
		var ipv6_static_msg = replace_msg(all_ipv6_addr_msg, IPV6_TEXT0);
		var temp_ipv6_static = new ipv6_addr_obj(ipv6_static.split(":"), ipv6_static_msg, false, false);
		var prefix_length_msg = replace_msg(check_num_msg, IPV6_TEXT74, 1, 126);
		var prefix_length_obj = new varible_obj(get_by_id("ipv6_static_prefix_length").value, prefix_length_msg, 1, 126, false);
		var ipv6_static_gw = get_by_id("ipv6_static_default_gw").value;
		var ipv6_static_gw_msg = replace_msg(all_ipv6_addr_msg, IPV6_TEXT75);
		var temp_ipv6_static_gw = new ipv6_addr_obj(ipv6_static_gw.split(":"), ipv6_static_gw_msg, false, false);
		var primary_dns = get_by_id("ipv6_static_primary_dns").value;
		var v6_primary_dns_msg = replace_msg(all_ipv6_addr_msg, _dns1);
		var secondary_dns = get_by_id("ipv6_static_secondary_dns").value;
		var v6_secondary_dns_msg = replace_msg(all_ipv6_addr_msg,_dns1);
		var ipv6_lan = get_by_id("ipv6_static_lan_ip").value;
		var ipv6_lan_msg = replace_msg(all_ipv6_addr_msg, IPV6_TEXT46);
		var temp_ipv6_lan = new ipv6_addr_obj(ipv6_lan.split(":"), ipv6_lan_msg, false, false);
		get_by_id("ipv6_wan_proto").value = "ipv6_static";
		get_by_id("ipv6_use_link_local").value = get_checked_value(get_by_id("ipv6_use_link_local_sel"));

		// check the ipv6 address
		if((get_by_id("ipv6_use_link_local").value) != 1){
			if(check_ipv6_symbol(ipv6_static,"::")==2){ // find two '::' symbol
				return false;
			}else if(check_ipv6_symbol(ipv6_static,"::")==1){    // find one '::' symbol
				temp_ipv6_static = new ipv6_addr_obj(ipv6_static.split("::"), ipv6_static_msg, false, false);
				if (!check_ipv6_address(temp_ipv6_static,"::")){
					return false;
				}
			}else{  //not find '::' symbol
				temp_ipv6_static = new ipv6_addr_obj(ipv6_static.split(":"), ipv6_static_msg, false, false);
				if (!check_ipv6_address(temp_ipv6_static,":"))
					return false;
               		}
                }
                //check the Subnet Prefix Length
                if (!check_varible(prefix_length_obj)){
                        return false;
                }

		//check Default Gateway
		if(check_ipv6_symbol(ipv6_static_gw,"::")==2){ // find two '::' symbol
			return false;
		}else if(check_ipv6_symbol(ipv6_static_gw,"::")==1){    // find one '::' symbol
			temp_ipv6_static_gw = new ipv6_addr_obj(ipv6_static_gw.split("::"), ipv6_static_gw_msg, false, false);
			if (!check_ipv6_address(temp_ipv6_static_gw,"::")){
				return false;
			}
		}else{  //not find '::' symbol
			temp_ipv6_static_gw = new ipv6_addr_obj(ipv6_static_gw.split(":"), ipv6_static_gw_msg, false, false);
			if (!check_ipv6_address(temp_ipv6_static_gw,":")){
				return false;
			}
		}
		//check DNS Address
		if (primary_dns != ""){
			if(check_ipv6_symbol(primary_dns,"::")==2){ // find two '::' symbol
				return false;
			}else if(check_ipv6_symbol(primary_dns,"::")==1){    // find one '::' symbol
				temp_ipv6_primary_dns = new ipv6_addr_obj(primary_dns.split("::"), v6_primary_dns_msg, false, false);
				if (!check_ipv6_address(temp_ipv6_primary_dns ,"::")){
					return false;
				}
			}else{  //not find '::' symbol
				temp_ipv6_primary_dns  = new ipv6_addr_obj(primary_dns.split(":"), v6_primary_dns_msg, false, false);
				if (!check_ipv6_address(temp_ipv6_primary_dns,":")){
					return false;
				}
        	        }
		}

		if (secondary_dns != ""){
			if(check_ipv6_symbol(secondary_dns,"::")==2){ // find two '::' symbol
				return false;
			}else if(check_ipv6_symbol(secondary_dns,"::")==1){    // find one '::' symbol
				temp_ipv6_secondary_dns = new ipv6_addr_obj(secondary_dns.split("::"), v6_secondary_dns_msg, false, false);
				if (!check_ipv6_address(temp_ipv6_secondary_dns ,"::")){
					return false;
				}
			}else{  //not find '::' symbol
				temp_ipv6_secondary_dns  = new ipv6_addr_obj(secondary_dns.split(":"), v6_secondary_dns_msg, false, false);
				if (!check_ipv6_address(temp_ipv6_secondary_dns,":")){
					return false;
				}
                        }
                }

		//check LAN IP Address
		if(check_ipv6_symbol(ipv6_lan,"::")==2){ // find two '::' symbol
			return false;
		}else if(check_ipv6_symbol(ipv6_lan,"::")==1){    // find one '::' symbol
			temp_ipv6_lan = new ipv6_addr_obj(ipv6_lan.split("::"), ipv6_lan_msg, false, false);
			if (!check_ipv6_address(temp_ipv6_lan ,"::")){
				return false;
			}
		}else{  //not find '::' symbol
			temp_ipv6_lan  = new ipv6_addr_obj(ipv6_lan.split(":"), ipv6_lan_msg, false, false);
			if (!check_ipv6_address(temp_ipv6_lan,":")){
				return false;
			}
		}
 
                if(submit_button_flag == 0){
                        submit_button_flag = 1;
                        get_by_id("form1").submit();
                        return true;
                }else{
                        return false;
                }
        }

		

	function go_back(){
		get_by_id("html_response_page").value="wizard_ipv6_3.asp";
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
			<h1 align="left"><script>show_words(IPv6_wizard_11);</script></h1>
			<div align="left">
			<p class="box_msg"><script>show_words(IPV6_wizard_info_9);</script></p>
			<div>
			<div id=w1>
			<form id="form1" name="form1" method="post" action="apply.cgi">
				<input type="hidden" name="html_response_page" id="html_response_page" value="wizard_ipv6_4.asp">
				<input type="hidden" name="html_response_message" value="">
				<input type="hidden" name="html_response_return_page" value="wizard_ipv6_4.asp">
				<input type="hidden" name="reboot_type" value="none">
				<input type="hidden" id="ipv6_wan_proto" name="ipv6_wan_proto" value="<% CmoGetCfg("ipv6_wan_proto",""); %>">
				<input type="hidden" id="asp_temp_42" name="asp_temp_42" value ="wizard_ipv6_static.asp"> <!--wizard_ipv6_prev_page-->
                                <input type="hidden" id="asp_temp_43" name="asp_temp_43" value="wizard_ipv6_static.asp"> <!--wizard_ipv6_return_page-->
				<input type="hidden" id="ipv6_use_link_local" name="ipv6_use_link_local" value="<% CmoGetCfg("ipv6_use_link_local",""); %>">
				<input type="hidden" maxLength=80 size=80 name="link_local_ip_w" id="link_local_ip_w" value="<% CmoGetStatus("link_local_ip_w",""); %>">
			
			<table  class=formarea border="0">
			<tbody>
			<tr>
				<td width="30%" class="duple"><script>show_words(IPV6_static_link);</script> :</td>
				<td width="70%">&nbsp;
				<input name="ipv6_use_link_local_sel" type=checkbox id="ipv6_use_link_local_sel" value="1" onclick="use_wan_link_local_selector(this.checked);">
				</td>
			</tr>
			<tr>
				<td align=right class="duple"><script>show_words(IPV6_TEXT0);</script> :</td>
				<td >&nbsp;
				<input type=text id="ipv6_static_wan_ip" name="ipv6_static_wan_ip" size="30" maxlength="63" value="<% CmoGetCfg("ipv6_static_wan_ip",""); %>">
                              </td>
			</tr>
			<tr>
				<td align=right class="duple"><script>show_words(IPV6_TEXT74);</script> :</td>
				<td>&nbsp;
				<input type=text id="ipv6_static_prefix_length" name="ipv6_static_prefix_length" size="5" maxlength="3" value="<% CmoGetCfg("ipv6_static_prefix_length",""); %>">
				</td>
			</tr>
			<tr>
				<td align=right class="duple"><script>show_words(IPV6_TEXT75);</script> :</td>
				<td>&nbsp;
				<input type=text id="ipv6_static_default_gw" name="ipv6_static_default_gw" size="30" maxlength="39" value="<% CmoGetCfg("ipv6_static_default_gw",""); %>">
				</td>
			</tr>
			<tr>
				<td align=right class="duple"><script>show_words(_dns1);</script> :</td>
				<td>&nbsp;
				<input type=text id="ipv6_static_primary_dns" name="ipv6_static_primary_dns" size="30" maxlength="39" value="<% CmoGetCfg("ipv6_static_primary_dns","none"); %>">
				</td>
			</tr>
			<tr>
				<td align=right class="duple"><script>show_words(_dns2);</script> :</td>
				<td>&nbsp;
				<input type=text id="ipv6_static_secondary_dns" name="ipv6_static_secondary_dns" size="30" maxlength="39" value="<% CmoGetCfg("ipv6_static_secondary_dns","none"); %>">
				</td>
			</tr>
<tr>
                              <td align=right class="duple"><script>show_words(IPV6_TEXT46);</script> :</td>
                              <td>&nbsp;
                                <input type=text id="ipv6_static_lan_ip" name="ipv6_static_lan_ip" size="30" maxlength="39" value="<% CmoGetCfg("ipv6_static_lan_ip","none"); %>">
                                <b>/64</b>
                              </td>
                            </tr>

			<tr>
				<td>&nbsp;</td>
				<td>&nbsp;<BR>
					<input type="submit" id="prev_b2" class="button_submit" name="prev_b2" value="Prev" onclick="return go_back()">
					<input type="submit" id="next_b2" class="button_submit" name="next_b2" value="Next" onclick="return send_request()">
					<input type="button" id="cancel_b2" class="button_submit" name="cancel_b2" value="Cancel" onclick="window.location.href='ipv6.asp'">
					<input type="button" class="button_submit" id="connect_b2" name="connect_b2" value="connect">
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
