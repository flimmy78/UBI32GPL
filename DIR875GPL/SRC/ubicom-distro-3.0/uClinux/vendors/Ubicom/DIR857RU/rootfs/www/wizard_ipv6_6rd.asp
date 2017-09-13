<html>
<head>
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<script language="JavaScript" src="lingual_<% CmoGetCfg("lingual","none"); %>.js"></script>
<script language="Javascript" src="public.js"></script>
<script language="JavaScript" src="public_ipv6.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="Javascript">
	var submit_button_flag = 0;
	var wan_ip;
	function onPageLoad(){
		get_by_id("connect_b2").disabled = true;



                wan_ip = "<% CmoGetStatus("wan_current_ipaddr_00"); %>".split("/")[0];
                get_by_id("wan_ip").innerHTML = replace_null_to_none(wan_ip);
		ipv6_6rd_link_local();
                var login_who= "<% CmoGetCfg("get_current_user","none"); %>";

                if(login_who== "user"){
                        DisableEnableForm(document.form1,true); 
                } 

		ipv6_6rd_prefix_onchange();
	}

	function replace_null_to_none(item){
        	if(item=="(null)"|| item == "null" || item == "NULL")
                	item="None";
	        return item;
	}

	function ipv6_6rd_prefix_onchange() {
		var pf = get_by_id("ipv6_6rd_prefix").value;
		var pf_len = get_by_id("ipv6_6rd_prefix_length").value;
		var v4_masklen = get_by_id("ipv6_6rd_ipv4_mask_length").value;
		var v4_uselen;
		var wan_mac = "<% CmoGetCfg("wan_mac","none"); %>";
		var lan_mac = "<% CmoGetCfg("lan_mac","none"); %>";
		var eui64;

		var ary_ip4 = wan_ip.split(".");
		var u32_ip4 = (ary_ip4[0]*Math.pow(2,24)) + (ary_ip4[1]*Math.pow(2,16)) + (ary_ip4[2]*Math.pow(2,8)) + parseInt(ary_ip4[3]);
		var ary_pf = get_stateful_ipv6(pf).split(":");
		var u32_pf = [0,0];
		var mask_len;

		var ary_ip6rd_pf = [0,0,0,0];
		var str_tmp;

		var IsValid = true;

		/*check 6rd prefix length*/
		if(get_by_id("wan_ip").innerHTML == "None")
			IsValid = false;

                if (IsValid) {
                        if ( (pf_len-0)==pf_len && pf_len.length>0 ) {
                                pf_len = parseInt(pf_len);
                                if (pf_len<1 || pf_len>63)
                                        IsValid = false;
                        } else
                                IsValid = false;
                }
		if (pf_len <= 32) {
		        get_by_id("ipv6_6rd_ipv4_mask_length").disabled = true;
		        get_by_id("ipv6_6rd_ipv4_mask_length").value = "0";
		} else
		        get_by_id("ipv6_6rd_ipv4_mask_length").disabled = false;
                
                /* check ipv4 mask length*/
                if (IsValid && pf_len >32) {
                        if ( (v4_masklen-0)==v4_masklen && v4_masklen.length>0 ) {
                                v4_masklen = parseInt(v4_masklen);
				v4_uselen = 32 - v4_masklen;
				if (v4_masklen<1 || v4_masklen>31 || v4_uselen+pf_len > 64)
                                        IsValid = false;
                        } else
                                IsValid = false;
                }
                
                /*check prefix*/
		var c;
		var tmp_ary_pf = pf.split("::");
		if (IsValid && pf=="")
			IsValid = false;

		if (IsValid && 
			((tmp_ary_pf.length>1 && tmp_ary_pf[1]==":") || tmp_ary_pf.length>2))
				IsValid = false;

		if (IsValid) {
			for (var idx=0; idx < ary_pf.length; idx++) {
				if (idx>0 && ary_pf[idx]=="")
					ary_pf[idx] = "0";
				if (ary_pf[idx].length>=1 && ary_pf[idx].length<=4) {
					for(var pos=0; pos < ary_pf[idx].length; pos++) {
						if( !check_hex(ary_pf[idx].charAt(pos)))
							IsValid = false;
					}
				} else {
					IsValid = false;
					break;
				}
			}
			if (ary_pf.length<2) ary_pf[1] = "0";
			if (ary_pf.length<3) ary_pf[2] = "0";
			if (ary_pf.length<4) ary_pf[3] = "0";
		}

		if (!IsValid) {
			get_by_id("ipv6_6rd_assigned_prefix").innerHTML = "None";
			return;
		}
                
		
		if (ary_pf.length >=1 ) {
                        u32_pf[0] = parseInt( ary_pf[0].lpad("0",4) + ary_pf[1].lpad("0",4), 16);

                        if (pf_len == 32) {
                                u32_pf[1] = parseInt(u32_ip4);
                        } else if (pf_len < 32) {
                                mask_len = (32-pf_len);
                                u32_pf[0] = (u32_pf[0] >>> mask_len) * Math.pow(2,mask_len);
                                u32_pf[0] = parseInt(u32_pf[0]) + (u32_ip4 >>> pf_len);
                                u32_pf[1] = (u32_ip4 - ((u32_ip4 >>> pf_len) * Math.pow(2,pf_len))) * Math.pow(2,mask_len);
                        } else {
                                u32_pf[1] = parseInt( ary_pf[2].lpad("0",4) + ary_pf[3].lpad("0",4), 16);
                                mask_len = (64-pf_len);
                                u32_pf[1] = (u32_pf[1] >>> mask_len) * Math.pow(2,mask_len);
                                u32_ip4 = u32_ip4 % (1*Math.pow(2,v4_uselen));
                                u32_pf[1] = parseInt(u32_pf[1]) + (u32_ip4*Math.pow(2,64-pf_len-v4_uselen));
                        }
                }

                
                if (pf_len <= 32) {
                        eui64 = generate_eui64(lan_mac);
                        str_tmp = u32_pf[0].toString(16).lpad("0",8);
                        ary_ip6rd_pf[0] = str_tmp.substr(0,4);
                        ary_ip6rd_pf[1] = str_tmp.substr(4,4);
                        str_tmp = u32_pf[1].toString(16).lpad("0",8);
                        ary_ip6rd_pf[2] = str_tmp.substr(0,4);
                        ary_ip6rd_pf[3] = str_tmp.substr(4,4);
                        get_by_id("ipv6_6rd_assigned_prefix").innerHTML = 
                                (ary_ip6rd_pf[0]+":"+ary_ip6rd_pf[1]+":"+ary_ip6rd_pf[2]+":"+ary_ip6rd_pf[3]).toUpperCase()+"::/"+(pf_len + 32);
                        str_tmp = ary_ip6rd_pf[0]+":"+ary_ip6rd_pf[1]+":"+ary_ip6rd_pf[2]+":"+ary_ip6rd_pf[3]+":"+eui64;
                        //get_by_id("lan_ipv6_ip_lan_ip").innerHTML = str_tmp.toUpperCase() + "/64";
                } else {
                        eui64 = generate_eui64(lan_mac);
                        str_tmp = u32_pf[0].toString(16).lpad("0",8);
                        ary_ip6rd_pf[0] = str_tmp.substr(0,4);
                        ary_ip6rd_pf[1] = str_tmp.substr(4,4);
                        str_tmp = u32_pf[1].toString(16).lpad("0",8);
                        ary_ip6rd_pf[2] = str_tmp.substr(0,4);
                        ary_ip6rd_pf[3] = str_tmp.substr(4,4);
                        get_by_id("ipv6_6rd_assigned_prefix").innerHTML = 
			(ary_ip6rd_pf[0]+":"+ary_ip6rd_pf[1]+":"+ary_ip6rd_pf[2]+":"+ary_ip6rd_pf[3]).toUpperCase()+"::/"+(pf_len + v4_uselen);
                        str_tmp = ary_ip6rd_pf[0]+":"+ary_ip6rd_pf[1]+":"+ary_ip6rd_pf[2]+":"+ary_ip6rd_pf[3]+":"+eui64;
                        //get_by_id("lan_ipv6_ip_lan_ip").innerHTML = str_tmp.toUpperCase() + "/64";
			}
        }

	function generate_eui64(mac) {
		var ary_mac = mac.split(":");
		var u8_mac = new Array();
		var eui64 = new Array();
		for (i=0; i<6; i++) {
			u8_mac[i] = parseInt(ary_mac[i],16);
		}
		eui64[0] = u8_mac[0] ^ 0x02;
		eui64[1] = u8_mac[1];
		eui64[2] = u8_mac[2];
		eui64[3] = 0xff;
		eui64[4] = 0xfe;
		eui64[5] = u8_mac[3];
		eui64[6] = u8_mac[4];
		eui64[7] = u8_mac[5];
		return  parseInt(eui64[0].toString(16) + eui64[1].toString(16).lpad("0",2), 16).toString(16) + ":" +
			parseInt(eui64[2].toString(16) + eui64[3].toString(16).lpad("0",2), 16).toString(16) + ":" +
			parseInt(eui64[4].toString(16) + eui64[5].toString(16).lpad("0",2), 16).toString(16) + ":" +
			parseInt(eui64[6].toString(16) + eui64[7].toString(16).lpad("0",2), 16).toString(16) ;
	}

	function ipv6_6rd_link_local() {
		if(get_by_id("wan_ip").innerHTML == "None"){
			get_by_id("ipv6_6rd_addr").innerHTML = "None";
			return;
		}
		var u32_pf;
		var ary_ip6rd_pf = [0,0];
		var pf = get_by_id("ipv6_6rd_prefix").value;
		var ary_ip4 = wan_ip.split(".");
		var u32_ip4 = (ary_ip4[0]*Math.pow(2,24)) + (ary_ip4[1]*Math.pow(2,16)) + (ary_ip4[2]*Math.pow(2,8)) + parseInt(ary_ip4[3]);
		
		u32_pf = parseInt(u32_ip4);

		str_tmp = u32_pf.toString(16).lpad("0",8);
		ary_ip6rd_pf[0] = str_tmp.substr(0,4);
		ary_ip6rd_pf[1] = str_tmp.substr(4,4);
		get_by_id("ipv6_6rd_addr").innerHTML = 
			("FE80::"+ary_ip6rd_pf[0]+":"+ary_ip6rd_pf[1]+"/64").toUpperCase();
	}

	function send_request(){ 
		var primary_dns = get_by_id("ipv6_6rd_primary_dns").value;
		var v6_primary_dns_msg = replace_msg(all_ipv6_addr_msg, IPv6_wizard_13);
		var v6_6rd_relay = get_by_id("ipv6_6rd_relay").value;
		var ipv6_addr_msg = replace_msg(all_ip_addr_msg,"IP Address");
		var v6_6rd_relay_obj = new addr_obj(v6_6rd_relay.split("."), ipv6_addr_msg, false, false);
		get_by_id("ipv6_wan_proto").value = "ipv6_6rd";


		if (!check_ipv6_relay_address(v6_6rd_relay_obj)){
			alert(LS46);
			return false;
	        }

		if(Find_word(v6_6rd_relay,":") || (v6_6rd_relay == "")){
			alert(LS46);
			return false;
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
			}else{	//not find '::' symbol
				temp_ipv6_primary_dns  = new ipv6_addr_obj(primary_dns.split(":"), v6_primary_dns_msg, false, false);
				if (!check_ipv6_address(temp_ipv6_primary_dns,":")){
					return false;
				}
			}
		}					
		if(submit_button_flag == 0){
			submit_button_flag = 1;
			return true;
		}else{
			return false;
		}	
	}


	String.prototype.lpad = function(padString, length) {
        var str = this;
        while (str.length < length)
                str = padString + str;
        return str;
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
			<h1 align="left"><script>show_words(IPv6_wizard_12);</script></h1>
			<div align="left">
			<p class="box_msg"><script>show_words(IPV6_wizard_info_7);</script></p>
			<div>
			<div id=w1>
			<form id="form1" name="form1" method="post" action="apply.cgi">
				<input type="hidden" name="html_response_page" id="html_response_page" value="wizard_ipv6_4.asp">
				<input type="hidden" name="html_response_message" value="">
				<input type="hidden" name="html_response_return_page" value="wizard_ipv6_4.asp">
				<input type="hidden" name="reboot_type" value="none">
				<input type="hidden" id="ipv6_wan_proto" name="ipv6_wan_proto" value="<% CmoGetCfg("ipv6_wan_proto","none"); %>">
				<input type="hidden" id="asp_temp_42" name="asp_temp_42" value ="wizard_ipv6_6rd.asp"> <!--wizard_ipv6_prev_page-->
                                <input type="hidden" id="asp_temp_43" name="asp_temp_43" value="adv_ipv6_6rd.asp"> <!--wizard_ipv6_return_page-->

			<table  class=formarea border="0" align="center">
			<tbody>
			<tr>
				<td width="40%" align="right" class="duple"><script>show_words(IPV6_6rd_prefix);</script> :</td>
				<td width="60%" >&nbsp;<b>
				<input type=text id="ipv6_6rd_prefix" name="ipv6_6rd_prefix" size="30" maxlength="39" value="<% CmoGetCfg("ipv6_6rd_prefix","none"); %>" onChange="ipv6_6rd_prefix_onchange()">/
				<input type=text id="ipv6_6rd_prefix_length" name="ipv6_6rd_prefix_length" size="5" maxlength="2" value="<% CmoGetCfg("ipv6_6rd_prefix_length","none"); %>" onChange="ipv6_6rd_prefix_onchange()">
                                </b></td>
			</tr>
			<tr>
				<td align=right class="duple"><script>show_words(IPV6_TEXT01);</script> :</td>
				<td>&nbsp;<b><span id="wan_ip"></span></b>&nbsp;&nbsp;&nbsp;<b><script>show_words(IPV6_6rd_mask);</script> :</b>
					<input type=text id="ipv6_6rd_ipv4_mask_length" name="ipv6_6rd_ipv4_mask_length" size="5" maxlength="2" value="<% CmoGetCfg("ipv6_6rd_ipv4_mask_length","none"); %>" onChange="ipv6_6rd_prefix_onchange()"></td>
			</tr>
			<tr>
				<td align=right class="duple"><script>show_words(IPV6_6rd_assign);</script> :</td>
				<td>&nbsp;<b><span id="ipv6_6rd_assigned_prefix"></span></b></td>
			</tr>
			<tr>
				<td align=right class="duple"><script>show_words(IPV6_6rd_tunnel);</script> :</td>
				<td>&nbsp;<b><span id="ipv6_6rd_addr"></span></b></td>
			</tr>
			<tr>
				<td align=right class="duple"><script>show_words(IPV6_6rd_relay);</script> :</td>
				<td>&nbsp;<input type=text id="ipv6_6rd_relay" name="ipv6_6rd_relay" size="30" maxlength="39" value="<% CmoGetCfg("ipv6_6rd_relay","none"); %>"></td>
			</tr>
			<tr>
			<tr>
				<td align=right class="duple"><script>show_words(IPv6_wizard_13);</script> :</td>
				<td >&nbsp;<input type=text id="ipv6_6rd_primary_dns" name="ipv6_6rd_primary_dns" size="30" maxlength="39" value="<% CmoGetCfg("ipv6_6rd_primary_dns","none"); %>"></td>
			</tr>
				&nbsp;
				<td  align="center" colspan=2>&nbsp;<BR>
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
