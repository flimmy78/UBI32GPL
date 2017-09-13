<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<meta http-equiv=Content-Type content="text/html; charset=UTF8">
<script language="JavaScript" src="lingual_<% CmoGetCfg("lingual","none"); %>.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_ipv6.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript">
    var submit_button_flag = 0;
    var reboot_needed = "<% CmoGetStatus("reboot_needed"); %>";

	function onPageLoad(){
        var link_local ;
		var ipv6_advert_lifetime = document.getElementById("ipv6_ra_adv_valid_lifetime_l_one").value;
        get_by_id("ipv6_6in4_adver_lifetime").value = ipv6_advert_lifetime/60;
        link_local = document.getElementById("link_local_ip_l").value;
        document.getElementById("lan_link_local_ip").innerHTML= link_local.toUpperCase();
        set_checked(get_by_id("ipv6_autoconfig").value, get_by_id("ipv6_autoconfig_sel"));
        set_checked(get_by_id("ipv6_dhcp_pd_enable_l").value, get_by_id("ipv6_dhcp_pd_lan")); 
        set_selectIndex("<% CmoGetCfg("ipv6_autoconfig_type","none"); %>", get_by_id("ipv6_autoconfig_type"));
        set_ipv6_autoconfiguration_type();
        set_checked("<% CmoGetCfg("ipv6_6in4_dns_enable","none"); %>", get_by_name("ipv6_dns_6in4_enable"));
        set_checked("<% CmoGetCfg("ipv6_dhcp_pd_enable","none"); %>", get_by_id("ipv6_dhcp_pd_chk"));

		/*var ipv6_wan_proto = "<% CmoGetCfg("ipv6_wan_proto","none"); %>";

		if (ipv6_wan_proto == get_by_id("ipv6_w_proto").value){

			set_checked("<% CmoGetCfg("ipv6_6in4_dns_enable","none"); %>", get_by_name("ipv6_dns_6in4_enable"));

			set_checked("<% CmoGetCfg("ipv6_dhcp_pd_enable","none"); %>", get_by_id("ipv6_dhcp_pd_chk"));

		}else{

			set_checked("1", get_by_name("ipv6_dns_6in4_enable"));

			set_checked("0", get_by_id("ipv6_dhcp_pd_chk"));

		}*/
        disable_autoconfig();
        disable_ipv6_6in4_auto_dns();

		//disable_ipv6_dhcp_pd_chk();//spec 1.06

		disable_ipv6_dhcp_pd_nochkDNS(); //spec 1.08

		if ("<% CmoGetStatus("get_current_user"); %>" == "user") {
            DisableEnableForm(document.form1, true);
        }

		var wan_current_ipaddr = "<% CmoGetStatus("wan_current_ipaddr_00"); %>";
		get_by_id("ipv4_6in4_wan_ip").value = wan_current_ipaddr.split("/")[0];

		set_form_default_values("form1");
    }


  function disable_autoconfig(){
					var disable = get_by_id("ipv6_autoconfig_sel").checked;
						get_by_id("ipv6_autoconfig").value = get_checked_value(get_by_id("ipv6_autoconfig_sel"));
       			get_by_id("ipv6_autoconfig_type").disabled = !disable;
            get_by_id("ipv6_addr_range_start_suffix").disabled = !disable;
            get_by_id("ipv6_addr_range_end_suffix").disabled = !disable;
if(get_by_id("ipv6_dhcp_pd_chk").checked){ 
                        get_by_id("ipv6_dhcp_pd_lan").disabled = !get_by_id("ipv6_dhcp_pd_chk").checked; 
                        get_by_id("ipv6_dhcpd_lifetime").disabled = get_by_id("ipv6_dhcp_pd_chk").checked; 
                        get_by_id("ipv6_6in4_adver_lifetime").disabled = get_by_id("ipv6_dhcp_pd_chk").checked; 
	        }

 }

	function disable_ipv6_6in4_auto_dns(){

        var fixIP = get_by_name("ipv6_dns_6in4_enable");

	    var is_disabled;

	    if (fixIP[0].checked){

	    	is_disabled = true;

	    }else{

	    	is_disabled = false;

    }

	    get_by_id("ipv6_6in4_primary_dns").disabled = is_disabled;

	    get_by_id("ipv6_6in4_secondary_dns").disabled = is_disabled;

	}

	function disable_ipv6_dhcp_pd_chk(){
                get_by_id("ipv6_6in4_lan_ip").disabled = get_by_id("ipv6_dhcp_pd_chk").checked;
		if(get_by_id("ipv6_autoconfig_sel").checked){
			get_by_id("ipv6_dhcp_pd_lan").disabled = !get_by_id("ipv6_dhcp_pd_chk").checked;
			get_by_id("ipv6_dhcpd_lifetime").disabled = get_by_id("ipv6_dhcp_pd_chk").checked;
			get_by_id("ipv6_6in4_adver_lifetime").disabled = get_by_id("ipv6_dhcp_pd_chk").checked;
        }
	}

	function disable_ipv6_dhcp_pd_nochkDNS(){

                get_by_id("ipv6_6in4_lan_ip").disabled = get_by_id("ipv6_dhcp_pd_chk").checked;

		var is_checked = "1";

		var is_disabled;

	    if (get_by_id("ipv6_dhcp_pd_chk").checked){

	    	is_checked = "0";

	    	is_disabled = true;

	    }else{

	    	is_checked = "1";

	    	is_disabled = false;

        }

        }

	function set_ipv6_autoconf_range(){

            var ipv6_lan_ip = get_by_id("ipv6_6in4_lan_ip").value;
            var prefix_length = 64;
            var correct_ipv6="";
            if (ipv6_lan_ip != "") {
                correct_ipv6 = get_stateful_ipv6(ipv6_lan_ip);
                get_by_id("ipv6_addr_range_start_prefix").value  = get_stateful_prefix(correct_ipv6,prefix_length);
                get_by_id("ipv6_addr_range_end_prefix").value  = get_stateful_prefix(correct_ipv6,prefix_length);
            }
    }

    function set_ipv6_stateful_range()
    {
            var prefix_length = 64;
            var ipv6_lan_ip = get_by_id("ipv6_6in4_lan_ip").value;
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

    var remote_ipv4 = get_by_id("ipv4_6in4_remote_ip").value;
	var remote_ipv4_msg = replace_msg(all_ip_addr_msg,IPV6_TEXT40);
    var temp_remote_ipv4 = new addr_obj(remote_ipv4.split("."), remote_ipv4_msg, false, false);
    var remote_ipv6 = get_by_id("ipv6_6in4_remote_ip").value;
	var remote_ipv6_msg = replace_msg(all_ipv6_addr_msg,IPV6_TEXT41);
    var temp_remote_ipv6 = new ipv6_addr_obj(remote_ipv6.split(":"), remote_ipv6_msg, false, false);
    var local_ipv4 = get_by_id("ipv4_6in4_wan_ip").value;
    var local_ipv4_msg = replace_msg(all_ip_addr_msg,IPV6_TEXT42);
    var temp_local_ipv4 = new addr_obj(local_ipv4.split("."), local_ipv4_msg, false, false);
    var local_ipv6 = get_by_id("ipv6_6in4_wan_ip").value;
	var local_ipv6_msg = replace_msg(all_ipv6_addr_msg,IPV6_TEXT43);
    var temp_local_ipv6 = new ipv6_addr_obj(local_ipv6.split(":"), local_ipv6_msg, false, false);
    var primary_dns = get_by_id("ipv6_6in4_primary_dns").value;
	var v6_primary_dns_msg = replace_msg(all_ipv6_addr_msg,_dns1);
    var secondary_dns = get_by_id("ipv6_6in4_secondary_dns").value;
	var v6_secondary_dns_msg = replace_msg(all_ipv6_addr_msg,_dns2);
    var ipv6_lan = get_by_id("ipv6_6in4_lan_ip").value;
	var ipv6_lan_msg = replace_msg(all_ipv6_addr_msg,IPV6_TEXT46);
    var temp_ipv6_lan = new ipv6_addr_obj(ipv6_lan.split(":"), ipv6_lan_msg, false, false);
    var check_mode = get_by_id("ipv6_autoconfig_type").selectedIndex;

	get_by_id("ipv6_autoconfig").value = get_checked_value(get_by_id("ipv6_autoconfig_sel"));

    var enable_autoconfig = get_by_id("ipv6_autoconfig").value;
	var addr_lifetime_msg = replace_msg(check_num_msg, IPV6_TEXT68, 1, 999999);
	var addr_lifetime_obj = new varible_obj(get_by_id("ipv6_dhcpd_lifetime").value, addr_lifetime_msg, 1, 999999, false);
	var adver_lifetime_msg = replace_msg(check_num_msg, IPV6_TEXT69, 1, 999999);
	var adver_lifetime_obj = new varible_obj(get_by_id("ipv6_6in4_adver_lifetime").value, adver_lifetime_msg , 1, 999999, false);
    var ipv6_addr_s_suffix = get_by_id("ipv6_addr_range_start_suffix").value;
    var ipv6_addr_e_suffix = get_by_id("ipv6_addr_range_end_suffix").value;

        get_by_id("ipv6_dhcp_pd_enable").value = get_checked_value(get_by_id("ipv6_dhcp_pd_chk"));
	get_by_id("ipv6_dhcp_pd_enable_l").value = get_checked_value(get_by_id("ipv6_dhcp_pd_lan"));         
	get_by_id("ipv6_6in4_dns_enable").value = get_checked_value(get_by_name("ipv6_dns_6in4_enable"));
        get_by_id("ipv6_wan_specify_dns").value= get_by_id("ipv6_6in4_dns_enable").value;
        get_by_id("ipv6_wan_proto").value = get_by_id("ipv6_w_proto").value;

    // check the remote ipv4 address

    if (!check_address(temp_remote_ipv4)) {
        return false;
    }

    // check the remote ipv6 address
    if (check_ipv6_symbol(remote_ipv6, "::") == 2) { // find two '::' symbol
        return false;

	}else if(check_ipv6_symbol(remote_ipv6,"::")==1){    // find one '::' symbol

        temp_remote_ipv6 = new ipv6_addr_obj(remote_ipv6.split("::"), remote_ipv6_msg, false, false);

		if (!check_ipv6_chk_address(temp_remote_ipv6,"::")){

            return false;
        }

	}else{	//not find '::' symbol

        temp_remote_ipv6 = new ipv6_addr_obj(remote_ipv6.split(":"), remote_ipv6_msg, false, false);

		if (!check_ipv6_chk_address(temp_remote_ipv6,":")){

            return false;
        }
    }

    //check the local ipv4 address
    if (!check_address(temp_local_ipv4)) {
        return false;
    }

    // check the local ipv6 address
    if (check_ipv6_symbol(local_ipv6,"::") == 2) { // find two '::' symbol
        return false;

		}else if(check_ipv6_symbol(local_ipv6,"::")==1){    // find one '::' symbol

        temp_local_ipv6 = new ipv6_addr_obj(local_ipv6.split("::"), local_ipv6_msg, false, false);

			if (!check_ipv6_chk_address(temp_local_ipv6,"::")){

            return false;
        }

		}else{	//not find '::' symbol

        temp_local_ipv6 = new ipv6_addr_obj(local_ipv6.split(":"), local_ipv6_msg, false, false);

			if (!check_ipv6_chk_address(temp_local_ipv6,":")){

            return false;
        }
    }
    //check DNS Address
    if(!get_by_name("ipv6_dns_6in4_enable")[0].checked){
		if (primary_dns!= ""){
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
                }
    //check LAN IP Address

		if(!get_by_id("ipv6_6in4_lan_ip").disabled) {

        if (check_ipv6_symbol(ipv6_lan,"::") == 2) { // find two '::' symbol
            return false;

		}else if(check_ipv6_symbol(ipv6_lan,"::")==1){    // find one '::' symbol

            temp_ipv6_lan = new ipv6_addr_obj(ipv6_lan.split("::"), ipv6_lan_msg, false, false);

			if (!check_ipv6_chk_address(temp_ipv6_lan ,"::")){

                return false;
            }

		}else{	//not find '::' symbol

            temp_ipv6_lan  = new ipv6_addr_obj(ipv6_lan.split(":"), ipv6_lan_msg, false, false);

			if (!check_ipv6_chk_address(temp_ipv6_lan,":")){

                return false;
            }
        }
    }
		if((check_mode == 0 || check_mode == 1) && enable_autoconfig == 1){
        //check the Router Advertisement Lifetime
        if (!check_varible(adver_lifetime_obj)) {
            return false;
        }

        //set Advertisement Lifetime
			get_by_id("ipv6_ra_adv_valid_lifetime_l_one").value = get_by_id("ipv6_6in4_adver_lifetime").value * 60 ;
			get_by_id("ipv6_ra_adv_prefer_lifetime_l_one").value = get_by_id("ipv6_6in4_adver_lifetime").value * 60 ;
    }else if(check_mode == 2 && enable_autoconfig == 1){
        //check the suffix of Address Range(Start)
    		  if(!check_ipv6_address_suffix(ipv6_addr_s_suffix,IPV6_TEXT70)){
            return false;
        }

        //check the suffix of Address Range(End)
					if(!check_ipv6_address_suffix(ipv6_addr_e_suffix,IPV6_TEXT71)){
            return false;
        }

        //compare the suffix of start and the suffix of end
        if (!compare_suffix(ipv6_addr_s_suffix,ipv6_addr_e_suffix)){
            return false;
        }

        //check the IPv6 Address Lifetime
        if (!check_varible(addr_lifetime_obj)){
            return false;
        }

        //set autoconfiguration range value
                    get_by_id("ipv6_dhcpd_start").value = get_by_id("ipv6_addr_range_start_prefix").value + "::" + get_by_id("ipv6_addr_range_start_suffix").value;
                    get_by_id("ipv6_dhcpd_end").value = get_by_id("ipv6_addr_range_end_prefix").value + "::" + get_by_id("ipv6_addr_range_end_suffix").value;
    }

    if (submit_button_flag == 0) {
        submit_button_flag = 1;

			get_by_id("form1").submit();



        return true;

		}else{

    return false;

    }

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
                </table>
</td>

            <form id="form1" name="form1" method="post" action="apply.cgi">
            <input type="hidden" id="html_response_page" name="html_response_page" value="back_long.asp">
            <input type="hidden" id="html_response_message" name="html_response_message" value="">
            <script>get_by_id("html_response_message").value = sc_intro_sv;</script>
            <input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_ipv6_6in4.asp">
            <input type="hidden" id="ipv6_autoconfig" name="ipv6_autoconfig" value="<% CmoGetCfg("ipv6_autoconfig","none"); %>">
            <input type="hidden" id="ipv6_dhcp_pd_enable" name="ipv6_dhcp_pd_enable" value="<% CmoGetCfg("ipv6_dhcp_pd_enable","none"); %>">
		<input type="hidden" id="ipv6_dhcp_pd_enable_l" name="ipv6_dhcp_pd_enable_l" value="<%CmoGetCfg("ipv6_dhcp_pd_enable_l","none"); %>">                     
		<input type="hidden" id="ipv6_6in4_dns_enable" name="ipv6_6in4_dns_enable" value="<% CmoGetCfg("ipv6_6in4_dns_enable","none"); %>">
            <input type="hidden" id="ipv6_dhcpd_start" name="ipv6_dhcpd_start" value="<% CmoGetCfg("ipv6_dhcpd_start","none"); %>">
            <input type="hidden" id="ipv6_dhcpd_end" name="ipv6_dhcpd_end" value="<% CmoGetCfg("ipv6_dhcpd_end","none"); %>">
            <input type="hidden" id="ipv6_wan_proto" name="ipv6_wan_proto" value="<% CmoGetCfg("ipv6_wan_proto","none"); %>">
		    <input type="hidden" id="ipv6_ra_adv_valid_lifetime_l_one" name="ipv6_ra_adv_valid_lifetime_l_one" value="<% CmoGetCfg("ipv6_ra_adv_valid_lifetime_l_one","none"); %>">
		    <input type="hidden" id="ipv6_ra_adv_prefer_lifetime_l_one" name="ipv6_ra_adv_prefer_lifetime_l_one" value="<% CmoGetCfg("ipv6_ra_adv_prefer_lifetime_l_one","none"); %>">
            <input type="hidden" maxLength=80 size=80 name="link_local_ip_l" id="link_local_ip_l" value="<% CmoGetStatus("link_local_ip_l","none"); %>">
            <input type="hidden" id="ipv6_wan_specify_dns" name="ipv6_wan_specify_dns" value="1">
		    <input type="hidden" id="reboot_type" name="reboot_type" value="wan">
            <td valign="top" id="maincontent_container">
                <div id="maincontent">
          <div id=box_header>
                    <h1>IPv6</h1>
                    <script>show_words(IPV6_TEXT28)</script><br>
                    <br>
                        <input name="button" id="button" type="submit" class=button_submit value="" onClick="return send_request()">
                        <input name="button2" id="button2" type="button" class=button_submit value="" onclick="page_cancel_1('form1', 'adv_ipv6_6in4.asp');">
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
                        <option value="ipv6_static" ><script>show_words(IPV6_TEXT32)</script></option>
												<option value="ipv6_autoconfig"><script>show_words(IPV6_TEXT32a);</script></option>
                        <option value="ipv6_pppoe"><script>show_words(IPV6_TEXT34)</script></option>
                        <option value="ipv6_6in4" selected><script>show_words(IPV6_TEXT35)</script></option>
                        <option value="ipv6_6to4" ><script>show_words(IPV6_TEXT36)</script></option>
			<option value="ipv6_6rd">6rd</option>
			<option value="link_local"><script>show_words(IPV6_TEXT37)</script></option>
                      </select></td>
                    </tr>
                   </table>
                  </div>
             <div class=box id=wan_ipv6_settings>
                        <h2 style=" text-transform:none"><script>show_words(IPV6_TEXT38)</script> </h2>
                                        <p class="box_msg"><script>show_words(IPV6_TEXT39)</script> </p>
                    <table cellSpacing=1 cellPadding=1 width=525 border=0>
                        <tr>
                             <td width="187" align=right class="duple"><script>show_words(IPV6_TEXT40)</script> :</td>
                             <td width="331">&nbsp;<input type=text id="ipv4_6in4_remote_ip" name="ipv4_6in4_remote_ip" size="16" maxlength="15" value="<% CmoGetCfg("ipv4_6in4_remote_ip","none"); %>"></td>
                        </tr>
                        <tr>
                            <td width="187" align=right class="duple"><script>show_words(IPV6_TEXT41)</script> :</td>
                            <td width="331">&nbsp;<input type=text id="ipv6_6in4_remote_ip" name="ipv6_6in4_remote_ip" size="30" maxlength="39" value="<% CmoGetCfg("ipv6_6in4_remote_ip","none"); %>"></td>
                        </tr>
                        <tr>
                             <td width="187" align=right class="duple"><script>show_words(IPV6_TEXT42)</script> :</td>
                             <td width="331">&nbsp;<input type=text id="ipv4_6in4_wan_ip" name="ipv4_6in4_wan_ip" size="16" maxlength="15" value="" readOnly></td>
                        </tr>
                        <tr>
                            <td width="187" align=right class="duple"><script>show_words(IPV6_TEXT43)</script> :</td>
                            <td width="331">&nbsp;<input type=text id="ipv6_6in4_wan_ip" name="ipv6_6in4_wan_ip" size="30" maxlength="39" value="<% CmoGetCfg("ipv6_6in4_wan_ip","none"); %>"></td>
                        </tr>
                    </table>
                 </div>

                 <div class=box id=lan_ipv6_settings>
                         <h2 style=" text-transform:none"><script>show_words(IPV6_TEXT63)</script>  </h2>
                    <p class="box_msg"><script>show_words(IPV6_TEXT64)</script> </p>
                    <table cellSpacing=1 cellPadding=1 width=525 border=0>
                        <tr>
                            <td width="187" align=right><input type="radio" name="ipv6_dns_6in4_enable" value="0" onClick="disable_ipv6_6in4_auto_dns()" checked></td>
                            <td width="331">&nbsp;<script>show_words(IPV6_TEXT65)</script></td>
                        </tr>
                        <tr>
                            <td width="187" align=right><input type="radio" name="ipv6_dns_6in4_enable" value="1" onClick="disable_ipv6_6in4_auto_dns()"></td>
                            <td width="331">&nbsp;<script>show_words(IPV6_TEXT66)</script></td>
                        </tr>
                        <tr>
                          <td width="187" align=right class="duple"><script>show_words(IPV6_PDNS)</script> :</td>
                          <td width="331">&nbsp;<input type=text id="ipv6_6in4_primary_dns" name="ipv6_6in4_primary_dns" size="30" maxlength="39" value="<% CmoGetCfg("ipv6_6in4_primary_dns","none"); %>"></td>
                        </tr>
                        <tr>
                          <td width="187" align=right class="duple"><script>show_words(IPV6_SDNS)</script> :</td>
                          <td width="331">&nbsp;<input type=text id="ipv6_6in4_secondary_dns" name="ipv6_6in4_secondary_dns" size="30" maxlength="39" value="<% CmoGetCfg("ipv6_6in4_secondary_dns","none"); %>"></td>
                        </tr>
                    </table>
                 </div>

         <div class=box id=lan_ipv6_settings>
                    <h2 style=" text-transform:none"><script>show_words(IPV6_TEXT44)</script>  : </h2>
                    <p align="justify" class="style1"><script>show_words(IPV6_TEXT45)</script> </p>
                    <table cellSpacing=1 cellPadding=1 width=525 border=0>
                       <tr>
                          <td width="187" align=right class="duple">Enable DHCP-PD :</td>
                          <td width="331">&nbsp;<input type=checkbox id="ipv6_dhcp_pd_chk" name="ipv6_dhcp_pd_chk" value="1" onClick="disable_ipv6_dhcp_pd_chk();"></td>
                       </tr>
                       <tr>
                          <td width="187" align=right class="duple"><script>show_words(IPV6_TEXT46)</script> :</td>
                          <td width="331">&nbsp;
                            <input type=text id="ipv6_6in4_lan_ip" name="ipv6_6in4_lan_ip" size="30" maxlength="63" value="<% CmoGetCfg("ipv6_6in4_lan_ip","none"); %>" onChange="set_ipv6_autoconf_range()">
                            <b>/64</b>
                          </td>
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
 <p align="justify" class="style1"><script>show_words(IPV6_TEXT49);show_words(IPV6_TEXT49a);</script></p> 
                         <table width="525" border=0 cellPadding=1 cellSpacing=1 class=formarea summary="">
                                <tr>
                                  <td width="187" class="duple"><script>show_words(IPV6_TEXT50)</script> :</td>
                                  <td width="331">&nbsp;<input name="ipv6_autoconfig_sel" type=checkbox id="ipv6_autoconfig_sel" value="1" onClick="disable_autoconfig()"></td>
                                </tr>
                                <tr>
                                  <td width="187" class="duple"><script>show_words(IPV6_TEXT50a);</script> :</td> 
                                  <td width="331">&nbsp;<input name="ipv6_dhcp_pd_lan" type=checkbox id="ipv6_dhcp_pd_lan" value="1"></td> 
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
                                     <td class="duple"><script>show_words(IPV6_TEXT53)</script> :</td>
                     <td width="331">&nbsp;&nbsp;<input type=text id="ipv6_addr_range_end_prefix" name="ipv6_addr_range_end_prefix" size="20" maxlength="19">
                     ::<input type=text id="ipv6_addr_range_end_suffix" name="ipv6_addr_range_end_suffix" size="5" maxlength="4">
                     </td>
                </tr>
                <tr id="show_ipv6_addr_lifetime" style="display:none">
                     <td class="duple"><script>show_words(IPV6_TEXT56)</script>:</td>
                     <td width="331">&nbsp;&nbsp;<input type=text id="ipv6_dhcpd_lifetime" name="ipv6_dhcpd_lifetime" size="20" maxlength="6" value="<% CmoGetCfg("ipv6_dhcpd_lifetime","none"); %>">
                                     <script>show_words(_minutes)</script></td>
                </tr>
                <tr id="show_router_advert_lifetime">
                                     <td class="duple"><script>show_words(IPV6_TEXT57)</script>:</td>
                     <td width="331">&nbsp;&nbsp;<input type=text id="ipv6_6in4_adver_lifetime" name="ipv6_6in4_adver_lifetime" size="20" maxlength="6" value="">
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
	set_ipv6_stateful_range();
</script>
</html>
