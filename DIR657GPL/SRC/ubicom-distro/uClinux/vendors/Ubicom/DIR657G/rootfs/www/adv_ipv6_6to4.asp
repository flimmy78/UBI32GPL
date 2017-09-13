<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<script language="JavaScript" src="lingual_<% CmoGetCfg("lingual","none"); %>.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_ipv6.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript">
    var submit_button_flag = 0;
    var ipv6_6to4_lan_prefix;
    var reboot_needed = "<% CmoGetStatus("reboot_needed"); %>";

    function onPageLoad()
    {
        var link_local ;
        var ipv6_advert_lifetime = <% CmoGetStatus("ipv6_tunnel_lifetime"); %>;
        get_by_id("ipv6_6to4_adver_lifetime").value = Math.round(ipv6_advert_lifetime/60*100)/100;
				get_by_id("ipv6_dhcpd_lifetime").value = get_by_id("ipv6_6to4_adver_lifetime").value;
        ipv6_6to4_lan_prefix =  document.getElementById("ipv6_6to4_lan_addr").value;
        ipv6_6to4_tunnel_addr   = document.getElementById("ipv6_6to4_tunnel_address").value;
        link_local = document.getElementById("link_local_ip_l").value;
        document.getElementById("lan_link_local_ip").innerHTML= link_local.toUpperCase();
        document.getElementById("ipv6_6to4_addr").innerHTML = ipv6_6to4_tunnel_addr.toUpperCase();
        document.getElementById("lan_ipv6_ip_prefix").innerHTML = ipv6_6to4_lan_prefix.toUpperCase();
        set_checked(get_by_id("ipv6_autoconfig").value, get_by_id("ipv6_autoconfig_sel"));
        set_selectIndex("<% CmoGetCfg("ipv6_autoconfig_type","none"); %>", get_by_id("ipv6_autoconfig_type"));
        set_ipv6_autoconfiguration_type();
        disable_autoconfig();
        set_checked("1", get_by_name("ipv6_dhcp_auto_dns"));
        set_ipv6_stateful_range();

        if ("<% CmoGetStatus("get_current_user"); %>" == "user") {
            DisableEnableForm(document.form1, true);
        }

        set_form_default_values("form1");
    }

  function disable_autoconfig(){
					var disable = get_by_id("ipv6_autoconfig_sel").checked;
						get_by_id("ipv6_autoconfig").value = get_checked_value(get_by_id("ipv6_autoconfig_sel"));
       			get_by_id("ipv6_autoconfig_type").disabled = !disable;
            get_by_id("ipv6_addr_range_start_suffix").disabled = !disable;
            get_by_id("ipv6_addr_range_end_suffix").disabled = !disable;
	        }

    function set_ipv6_autoconf_range(){
            var ipv6_6to4_lan_ip_subnet = get_by_id("ipv6_6to4_lan_ip_subnet").value;
            if (ipv6_6to4_lan_ip_subnet != "") {
                get_by_id("ipv6_addr_range_start_prefix").value  = ipv6_6to4_lan_prefix.toUpperCase()+ ipv6_6to4_lan_ip_subnet;
                get_by_id("ipv6_addr_range_end_prefix").value  = ipv6_6to4_lan_prefix.toUpperCase()+ ipv6_6to4_lan_ip_subnet;
            }
    }
    function set_ipv6_stateful_range()
    {
            var prefix_length = 64;
            var ipv6_lan_ip = get_by_id("ipv6_6to4_lan_ip").value;
            var ipv6_dhcpd_start_range = get_by_id("ipv6_dhcpd_start").value;
            var ipv6_dhcpd_end_range = get_by_id("ipv6_dhcpd_end").value;
            var correct_ipv6="";
            if (ipv6_lan_ip != "") {
                correct_ipv6 = get_stateful_ipv6(ipv6_lan_ip);
                get_by_id("ipv6_addr_range_start_prefix").value  = get_stateful_prefix(correct_ipv6,prefix_length);
                get_by_id("ipv6_addr_range_end_prefix").value  = get_stateful_prefix(correct_ipv6,prefix_length);
            }
            get_by_id("ipv6_addr_range_start_suffix").value  = get_stateful_suffix(ipv6_dhcpd_start_range);
            get_by_id("ipv6_addr_range_end_suffix").value  = get_stateful_suffix(ipv6_dhcpd_end_range);
    }
    function set_ipv6_autoconfiguration_type(){
        var mode = get_by_id("ipv6_autoconfig_type").selectedIndex;
        switch(mode){
        case 0:
            get_by_id("show_ipv6_addr_range_start").style.display = "none";
            get_by_id("show_ipv6_addr_range_end").style.display = "none";
            get_by_id("show_ipv6_addr_lifetime").style.display ="none";
            get_by_id("show_router_advert_lifetime").style.display = "";
            break;
        case 1:
					get_by_id("show_ipv6_addr_range_start").style.display = "none";
					get_by_id("show_ipv6_addr_range_end").style.display = "none";
					get_by_id("show_ipv6_addr_lifetime").style.display ="none";
					get_by_id("show_router_advert_lifetime").style.display = "";
					break;
        case 2:
            set_ipv6_autoconf_range();
            get_by_id("ipv6_addr_range_start_prefix").disabled = true;
            get_by_id("ipv6_addr_range_end_prefix").disabled = true;
            get_by_id("show_ipv6_addr_range_start").style.display = "";
            get_by_id("show_ipv6_addr_range_end").style.display = "";
            get_by_id("show_ipv6_addr_lifetime").style.display ="";
            get_by_id("show_router_advert_lifetime").style.display = "none";
            break;
        default:
            get_by_id("show_ipv6_addr_range_start").style.display = "none";
            get_by_id("show_ipv6_addr_range_end").style.display = "none";
            get_by_id("show_ipv6_addr_lifetime").style.display ="none";
            get_by_id("show_channel_width").style.display = "";
            break;
        }
    }


function send_request(){
    var primary_dns = get_by_id("ipv6_6to4_primary_dns").value;
    var v6_primary_dns_msg = replace_msg(all_ipv6_addr_msg,"Primary DNS Address");
    var secondary_dns = get_by_id("ipv6_6to4_secondary_dns").value;
    var v6_secondary_dns_msg = replace_msg(all_ipv6_addr_msg,"Secondary DNS Address");
    var ipv6_lan_ip_subnet = get_by_id("ipv6_6to4_lan_ip_subnet").value;
    var check_mode = get_by_id("ipv6_autoconfig_type").selectedIndex;
    get_by_id("ipv6_autoconfig").value = get_checked_value(get_by_id("ipv6_autoconfig_sel"));
    var enable_autoconfig = get_by_id("ipv6_autoconfig").value;
    var ipv6_addr_s_suffix = get_by_id("ipv6_addr_range_start_suffix").value;
    var ipv6_addr_e_suffix = get_by_id("ipv6_addr_range_end_suffix").value;
	var v6_6to4_relay = get_by_id("ipv6_6to4_relay").value;
	var ipv6_addr_msg = replace_msg(all_ip_addr_msg,_ipaddr);
	var v6_6to4_relay_obj = new addr_obj(v6_6to4_relay.split("."), ipv6_addr_msg, false, false);


	if (!check_ipv6_relay_address(v6_6to4_relay_obj)){
		alert(LS46);
		return false;
	}

	if (get_by_id("ipv6_wan_proto").value == get_by_id("ipv6_w_proto").value) {
        if (!is_form_modified("form1") && !confirm(_ask_nochange)) {
            return false;
        }
    }

    if(Find_word(v6_6to4_relay,":") || (v6_6to4_relay == "")){
		alert(LS46);
		return false;
        }

    get_by_id("ipv6_wan_proto").value = get_by_id("ipv6_w_proto").value;
    //set the LAN IPv6
    get_by_id("ipv6_6to4_lan_ip").value = ipv6_6to4_lan_prefix + get_by_id("ipv6_6to4_lan_ip_subnet").value + "::1";

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
	if (secondary_dns != ""){
		if(check_ipv6_symbol(secondary_dns,"::")==2){ // find two '::' symbol
			return false;
		}else if(check_ipv6_symbol(secondary_dns,"::")==1){    // find one '::' symbol
			temp_ipv6_secondary_dns = new ipv6_addr_obj(secondary_dns.split("::"), v6_secondary_dns_msg, false, false);
			if (!check_ipv6_address(temp_ipv6_secondary_dns ,"::")){
					return false;
			}
		}else{	//not find '::' symbol
			temp_ipv6_secondary_dns  = new ipv6_addr_obj(secondary_dns.split(":"), v6_secondary_dns_msg, false, false);
			if (!check_ipv6_address(temp_ipv6_secondary_dns,":")){
				return false;
			}
		}
	}
    //check the subnet of LAN IPv6
    if (!check_lan_ipv6_subnet(ipv6_lan_ip_subnet,"LAN IPv6")) {
        return false;
    }
	if(check_mode == 2 && enable_autoconfig == 1){
            //check the suffix of Address Range(Start)
        if(!check_ipv6_address_suffix(ipv6_addr_s_suffix,"Address Range(Start)")){
            return false;
        }
        //check the suffix of Address Range(End)
        if(!check_ipv6_address_suffix(ipv6_addr_e_suffix,"Address Range(End)")){
            return false;
        }
        //compare the suffix of start and the suffix of end
        if(!compare_suffix(ipv6_addr_s_suffix,ipv6_addr_e_suffix)){
            return false;
        }
        //set autoconfiguration range value
        get_by_id("ipv6_dhcpd_start").value = get_by_id("ipv6_addr_range_start_prefix").value + "::" + get_by_id("ipv6_addr_range_start_suffix").value;
        get_by_id("ipv6_dhcpd_end").value = get_by_id("ipv6_addr_range_end_prefix").value + "::" + get_by_id("ipv6_addr_range_end_suffix").value;
    }

    if (submit_button_flag == 0) {
        submit_button_flag = 1;
        return true;
    }

    return false;
}
</script>

<title><% CmoGetStatus("title"); %></title>
<meta http-equiv=Content-Type content="text/html; charset=UTF8">
<meta http-equiv="REFRESH" content="<% CmoGetStatus("gui_logout"); %>">
<style type="text/css">
<!--
.style1 {font-size: 11px}
-->
</style>
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
    <table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
      <tr>
        <td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://support.dlink.com.tw/"><% CmoGetCfg("model_number","none"); %></a></td>
        <td align="right" nowrap><script>show_words(TA3)</script>: <% CmoGetStatus("hw_version"); %> &nbsp;</td>
        <td align="right" nowrap><script>show_words(sd_FWV)</script>: <% CmoGetStatus("version"); %></td>
        <td>&nbsp;</td>
      </tr>
    </table>
    <table id="topnav_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
        <tr>
            <td align="center" valign="middle"><img src="wlan_masthead.gif" width="836" height="92"></td>
        </tr>
    </table>
    <table border="0" cellpadding="2" cellspacing="1" width="838" align="center" bgcolor="#FFFFFF">
        <tr id="topnav_container">
            <td><img src="short_modnum.gif" width="125" height="25"></td>
            <td id="topnavon"><a href="index.asp" onclick="return jump_if();"><script>show_words(_setup)</script></a></td>
            <td id="topnavoff"><a href="adv_virtual.asp" onclick="return jump_if();"><script>show_words(_advanced)</script></a></td>
            <td id="topnavoff"><a href="tools_admin.asp" onclick="return jump_if();"><script>show_words(_tools)</script></a></td>
            <td id="topnavoff"><a href="st_device.asp" onclick="return jump_if();"><script>show_words(_status)</script></a></td>
            <td id="topnavoff"><a href="support_men.asp" onclick="return jump_if();"><script>show_words(_support)</script></a></td>
        </tr>
    </table>
    <table border="1" cellpadding="2" cellspacing="0" width="838" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
        <tr>
            <td id="sidenav_container" valign="top" width="125" align="right">
                <table cellSpacing=0 cellPadding=0 border=0>
                  <tbody>
                    <tr>
						<td id="sidenav_container">
							<div id="sidenav">
								<ul>
									<script>
										show_side_bar(6);
									</script>
								</ul>
                        </div>
                      </td>
                    </tr>
                  </tbody>
                </table></td>

            <form id="form1" name="form1" method="post" action="apply.cgi">
            <input type="hidden" id="html_response_page" name="html_response_page" value="back_long.asp">
            <input type="hidden" id="html_response_message" name="html_response_message" value="">
            <script>get_by_id("html_response_message").value = sc_intro_sv;</script>
            <input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_ipv6_6to4.asp">
            <input type="hidden" id="ipv6_autoconfig" name="ipv6_autoconfig" value="<% CmoGetCfg("ipv6_autoconfig","none"); %>">
            <input type="hidden" id="ipv6_dhcpd_start" name="ipv6_dhcpd_start" value="<% CmoGetCfg("ipv6_dhcpd_start","none"); %>">
            <input type="hidden" id="ipv6_dhcpd_end" name="ipv6_dhcpd_end" value="<% CmoGetCfg("ipv6_dhcpd_end","none"); %>">
            <input type="hidden" id="ipv6_wan_proto" name="ipv6_wan_proto" value="<% CmoGetCfg("ipv6_wan_proto","none"); %>">
            <input type="hidden" maxLength=80 size=80 name="ipv6_6to4_tunnel_address" id="ipv6_6to4_tunnel_address" value="<% CmoGetStatus("6to4_tunnel_address","none"); %>">
            <input type="hidden" maxLength=80 size=80 name="ipv6_6to4_lan_addr" id="ipv6_6to4_lan_addr" value="<% CmoGetStatus("6to4_lan_address","none"); %>">
            <input type="hidden" maxLength=80 size=80 name="link_local_ip_l" id="link_local_ip_l" value="<% CmoGetStatus("link_local_ip_l","none"); %>">
            <input type="hidden" id="ipv6_6to4_lan_ip" name="ipv6_6to4_lan_ip" value="<% CmoGetCfg("ipv6_6to4_lan_ip","none"); %>">
            <input type="hidden" id="ipv6_wan_specify_dns" name="ipv6_wan_specify_dns" value="1">
		    <input type="hidden" id="reboot_type" name="reboot_type" value="wan">
            <td valign="top" id="maincontent_container">
                <div id="maincontent">
          <div id=box_header>
                    <h1>IPv6</h1>
                    <script>show_words(IPV6_TEXT28)</script><br>
                    <br>
                        <input name="button" id="button" type="submit" class=button_submit value="" onClick="return send_request()">
                        <input name="button2" id="button2" type="button" class=button_submit value="" onclick="page_cancel('form1', 'adv_ipv6_6to4.asp');">
                        <script>check_reboot();</script>
                        <script>get_by_id("button").value = _savesettings;</script>
                        <script>get_by_id("button2").value = _dontsavesettings;</script>
                 </div>
                  <div class=box>
                    <h2 style=" text-transform:none">
                   <script>show_words(IPV6_TEXT29)</script></h2>
				   <p class="box_msg"><script>show_words(IPV6_TEXT30)</script></p>
                   <table cellSpacing=1 cellPadding=1 width=525 border=0>
                    <tr>
                      <td align=right width="187" class="duple"><script>show_words(IPV6_TEXT31)</script> :</td>
                      <td width="331">&nbsp; <select name="ipv6_w_proto" id="ipv6_w_proto" onChange=select_ipv6_wan_page(get_by_id("ipv6_w_proto").value);>
			<option value="ipv6_autodetect"><script>show_words(IPV6_TEXT32b);</script></option>
                        <option value="ipv6_static"><script>show_words(IPV6_TEXT32)</script></option>
			<option value="ipv6_autoconfig"><script>show_words(IPV6_TEXT32a);</script></option>
                        <option value="ipv6_pppoe"><script>show_words(IPV6_TEXT34)</script></option>
                        <option value="ipv6_6in4"><script>show_words(IPV6_TEXT35)</script></option>
                        <option value="ipv6_6to4" selected><script>show_words(IPV6_TEXT36)</script></option>
<option value="ipv6_6rd">6rd</option>
<option value="link_local"><script>show_words(IPV6_TEXT37)</script></option>
                      </select></td>
                    </tr>
                   </table>
                  </div>
             <div class=box id=wan_ipv6_settings>
	                <h2 style=" text-transform:none"><script>show_words(IPV6_TEXT60)</script>  </h2>
					<p class="box_msg"><script>show_words(IPV6_TEXT61)</script> </p>
                    <table cellSpacing=1 cellPadding=1 width=525 border=0>
                        <tr>
	                      <td width="187" align=right class="duple"><script>show_words(IPV6_TEXT62)</script> :</td>
                          <td width="331">&nbsp;<b><span id="ipv6_6to4_addr"></span></b></td>
                        </tr>
                        <tr>
                          <td width="187" align=right class="duple">6to4 Relay :</td>
                          <td width="331">&nbsp;<input type=text id="ipv6_6to4_relay" name="ipv6_6to4_relay" size="30" maxlength="39" value="<% CmoGetCfg("ipv6_6to4_relay","none"); %>"></td>
                        </tr>
                        <tr>
	                      <td width="187" align=right class="duple"><script>show_words(IPV6_PDNS)</script> :</td>
                          <td width="331">&nbsp;<input type=text id="ipv6_6to4_primary_dns" name="ipv6_6to4_primary_dns" size="30" maxlength="39" value="<% CmoGetCfg("ipv6_6to4_primary_dns","none"); %>"></td>
                        </tr>
                        <tr>
	                      <td width="187" align=right class="duple"><script>show_words(IPV6_SDNS)</script> :</td>
                          <td width="331">&nbsp;<input type=text id="ipv6_6to4_secondary_dns" name="ipv6_6to4_secondary_dns" size="30" maxlength="39" value="<% CmoGetCfg("ipv6_6to4_secondary_dns","none"); %>"></td>
                        </tr>
                    </table>
                 </div>
         <div class=box id=lan_ipv6_settings>
                    <h2 style=" text-transform:none"><script>show_words(IPV6_TEXT44)</script>   </h2>
					<p align="justify" class="style1"><script>show_words(IPV6_TEXT45)</script> </p>
                    <table cellSpacing=1 cellPadding=1 width=525 border=0>
                        <tr>
                          <td width="187" align=right class="duple"><script>show_words(IPV6_TEXT46)</script> :</td>
                          <td width="331">&nbsp;
                              <b><span id=lan_ipv6_ip_prefix></span></b>
                              <input type=text id="ipv6_6to4_lan_ip_subnet" name="ipv6_6to4_lan_ip_subnet" size="8" maxlength="4" value="<% CmoGetCfg("ipv6_6to4_lan_ip_subnet","none"); %>" onChange="set_ipv6_autoconf_range()">
                          <b>::1/64</b>                       </td>
                </tr>
                <tr>
                  <td width="187" align=right class="duple"><script>show_words(IPV6_TEXT47)</script> :</td>
                          <td width="331">&nbsp;
                            <b><span id="lan_link_local_ip"></span></b>
                          </td>
                      </tr>
            </table>
                 </div>
         <div class="box" id=ipv6_autoconfiguration_settings>
			  <h2><script>show_words(IPV6_TEXT48)</script></h2>
			   <p align="justify" class="style1"><script>show_words(IPV6_TEXT49)</script></p>
                          <table width="525" border=0 cellPadding=1 cellSpacing=1 class=formarea summary="">
                                <tr>
                                  <td width="187" class="duple"><script>show_words(IPV6_TEXT50)</script> :</td>
                                  <td width="331">&nbsp;<input name="ipv6_autoconfig_sel" type=checkbox id="ipv6_autoconfig_sel" value="1" onClick="disable_autoconfig()"></td>
                                </tr>
                                <tr>
                                <td class="duple"><script>show_words(IPV6_TEXT51)</script> :</td>
                                  <td width="331">&nbsp;
                   <select id="ipv6_autoconfig_type" name="ipv6_autoconfig_type" onChange="set_ipv6_autoconfiguration_type()">
				      <option value="stateless"><script>show_words(IPV6_TEXT52);</script></option>
				      <option value="stateless_dhcp"><script>show_words(IPV6_TEXT53a);</script></option>
 				      <option value="stateful"><script>show_words(IPV6_TEXT53);</script></option>
                   </select>
                  </td>
                                </tr>
                                <tr id="show_ipv6_addr_range_start" style="display:none">
				     <td class="duple"><script>show_words(IPV6_TEXT54)</script> :</td>
                     <td width="331">&nbsp;&nbsp;<input type=text id="ipv6_addr_range_start_prefix" name="ipv6_addr_range_start_prefix" size="20" maxlength="19">
                     ::<input type=text id="ipv6_addr_range_start_suffix" name="ipv6_addr_range_start_suffix" size="5" maxlength="4">
                     </td>
                </tr>
                <tr id="show_ipv6_addr_range_end" style="display:none">
				     <td class="duple"><script>show_words(IPV6_TEXT55)</script> :</td>
                     <td width="331">&nbsp;&nbsp;<input type=text id="ipv6_addr_range_end_prefix" name="ipv6_addr_range_end_prefix" size="20" maxlength="19">
                     ::<input type=text id="ipv6_addr_range_end_suffix" name="ipv6_addr_range_end_suffix" size="5" maxlength="4">
                     </td>
                </tr>
                <tr id="show_ipv6_addr_lifetime" style="display:none">
                     <td class="duple"><script>show_words(IPV6_TEXT56)</script> :</td>
                     <td width="331">&nbsp;&nbsp;<input type=text id="ipv6_dhcpd_lifetime" name="ipv6_dhcpd_lifetime" size="20" maxlength="15" value="" disabled="disabled">
				     <script>show_words(_minutes)</script></td>
                </tr>
                <tr id="show_router_advert_lifetime">
				     <td class="duple"><script>show_words(IPV6_TEXT57)</script> :</td>
                     <td width="331">&nbsp;&nbsp;<input type=text id="ipv6_6to4_adver_lifetime" name="ipv6_6to4_adver_lifetime" size="20" maxlength="15" value="" disabled="disabled">
				     <script>show_words(_minutes)</script></td>
                </tr>
                          </table>
         </div>
               </td>
          </form>
            <td valign="top" width="150" id="sidehelp_container" align="left">
                <table borderColor=#ffffff cellSpacing=0 borderColorDark=#ffffff
      cellPadding=2 bgColor=#ffffff borderColorLight=#ffffff border=0>
                  <tbody>
                    <tr>
                      <td id=help_text><b><script>show_words(_hints)</script>&hellip;</b>
                      	<p><script>show_words(IPV6_TEXT58)</script></p>
              			<p><script>show_words(IPV6_TEXT59)</script></p>
						<p><a href="support_adv.asp#ipv6" onclick="return jump_if();"><script>show_words(_more)</script>&hellip;</a></p>
                      </td>
                    </tr>
                  </tbody>
              </table></td>
        </tr>
    </table>
    <table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
        <tr>
            <td width="125" align="center">&nbsp;&nbsp;<img src="wireless_tail.gif" width="114" height="35"></td>
            <td width="10">&nbsp;</td><td>&nbsp;</td>
        </tr>
    </table>
<br>
<div id="copyright"><% CmoGetStatus("copyright"); %></div>
<br>
</body>
<script>
	reboot_form();
	onPageLoad();
</script>
</html>
