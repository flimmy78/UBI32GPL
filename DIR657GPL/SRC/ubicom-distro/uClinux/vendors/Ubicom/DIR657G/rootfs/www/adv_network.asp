<html>
<head>
<script language="JavaScript" src="lingual_<% CmoGetCfg("lingual","none"); %>.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language=JavaScript>
    var submit_button_flag = 0;
    var rule_max_num = 10;
    var inbound_used = 2;
    var DataArray = new Array();
    var reboot_needed = "<% CmoGetStatus("reboot_needed"); %>";

    function onPageLoad()
    {
        set_checked("<% CmoGetCfg("upnp_enable","none"); %>", get_by_id("upnpEnable"));
        set_checked("<% CmoGetCfg("wan_port_ping_response_enable","none"); %>", get_by_id("wan_ping"));
        set_selectIndex("<% CmoGetCfg("wan_port_speed","none"); %>", get_by_id("wan_port_speed"));
        set_checked("<% CmoGetCfg("multicast_stream_enable","none"); %>", get_by_id("multi_enable"));
	
        var show_selected = get_by_id("wan_port_ping_response_inbound_filter").value;
        get_by_id("filtext").value = get_by_id("wan_port_ping_response_inbound_filter").value;
        if (get_by_id("wan_port_ping_response_inbound_filter").value != "Allow_All" && get_by_id("wan_port_ping_response_inbound_filter").value != "Deny_All") {
            for (i=0;i<DataArray.length;i++) {
                if (DataArray[i].Name == get_by_id("wan_port_ping_response_inbound_filter").value) {
                    get_by_id("filtext").value = DataArray[i].sAction + "," + DataArray[i].Show_W;
                    show_selected = i;
                    break;
                }
            }
        }
        set_selectIndex(show_selected, get_by_id("inbound_filter"));

        if ("<% CmoGetStatus("get_current_user"); %>" == "user") {
            DisableEnableForm(document.form1,true);
        }
        set_form_default_values("form1");
    }

    //name/action/used(vs/port/wan/remote)
    function Data(name, action, used, onList)
    {
        this.Name = name;
        this.Show_W = "";
        this.Used = used;
        this.OnList = onList;
        var sActionW = "Allow All"

        if (action == "deny") {
            sActionW = "Deny";
        }
        this.sAction = sActionW;
    }

    function set_Inbound()
    {
        var index = 0;
        for (var i = 0; i < rule_max_num; i++) {
            var temp_st;
            var temp_A;
            var temp_B;
            var k=i;

            if (parseInt(i, 10) < 10) {
                k = "0" + i;
            }

            temp_st = (get_by_id("inbound_filter_name_" + k).value).split("/");
            if (temp_st.length > 1) {
                if (temp_st[0] != "") {
                    DataArray[DataArray.length++] = new Data(temp_st[0], temp_st[1], temp_st[2], index);
                    temp_A = get_by_id("inbound_filter_ip_" + k + "_A").value.split(",");
                    for (j=0;j<temp_A.length;j++) {
                        var temp_A_e = temp_A[j].split("/");
                        var temp_A_ip = temp_A_e[1].split("-");
                        if (temp_A_e[0] == "1") {
                            var T_IP_R = temp_A_e[1];
                            if (temp_A_e[1] == "0.0.0.0-255.255.255.255") {
                                T_IP_R = "*";
                            }
                            else if (temp_A_ip[0] == temp_A_ip[1]) {
                                T_IP_R = temp_A_ip[0];
                            }

                            if (DataArray[index].Show_W != "") {
                                DataArray[index].Show_W = DataArray[index].Show_W + ",";
                            }

                            DataArray[index].Show_W = DataArray[index].Show_W + T_IP_R;
                        }
                    }
                    temp_B = get_by_id("inbound_filter_ip_"+ k +"_B").value.split(",");

                    for (j=0;j<temp_B.length;j++) {
                        var temp_B_e = temp_B[j].split("/");
                        var temp_B_ip = temp_B_e[1].split("-");
                        if (temp_B_e[0] == "1") {
                            var T_IP_R = temp_B_e[1];
                            if (temp_B_e[1] == "0.0.0.0-255.255.255.255") {
                                T_IP_R = "*";
                            }
                            else if (temp_B_ip[0] == temp_B_ip[1]) {
                                T_IP_R = temp_B_ip[0];
                            }

                            if (DataArray[index].Show_W != "") {
                                DataArray[index].Show_W = DataArray[index].Show_W + ",";
                            }
                            DataArray[index].Show_W = DataArray[index].Show_W + T_IP_R;
                        }
                    }

                    load_inbound_used(k, temp_st, inbound_used);
                    index++;
                }
            }
        }
    }

    function show_option_value()
    {
        for (i=0;i<DataArray.length;i++) {
            document.write("<option value=\"" + DataArray[i].OnList + "\">" + DataArray[i].Name + "</option>");
        }
    }

    function send_request()
    {
        if (!is_form_modified("form1") && !confirm(_ask_nochange)) {
            return false;
        }

        get_by_id("upnp_enable").value = get_checked_value(get_by_id("upnpEnable"));
        get_by_id("wan_port_ping_response_enable").value = get_checked_value(get_by_id("wan_ping"));
        get_by_id("multicast_stream_enable").value = get_checked_value(get_by_id("multi_enable"));
	    save_inbound_used(get_by_id("wan_port_ping_response_inbound_filter").value, inbound_used);

        if (submit_button_flag == 0) {
            submit_button_flag = 1;
            return true;
        }
        else {
            return false;
        }
    }

    function wan_ping_ingress_filter_name_selector(obj_value)
    {
        if (obj_value !="Allow_All" && obj_value != "Deny_All") {
            get_by_id("wan_port_ping_response_inbound_filter").value = DataArray[obj_value].Name;
            get_by_id("filtext").value = DataArray[obj_value].sAction + "," + DataArray[obj_value].Show_W;
        }
        else {
            get_by_id("wan_port_ping_response_inbound_filter").value = obj_value;
            get_by_id("filtext").value = obj_value;
        }
    }
</script>

<link rel="STYLESHEET" type="text/css" href="css_router.css">
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
			<td id="topnavoff"><a href="index.asp" onclick="return jump_if();"><script>show_words(_setup)</script></a></td>
			<td id="topnavon"><a href="adv_virtual.asp" onclick="return jump_if();"><script>show_words(_advanced)</script></a></td>
			<td id="topnavoff"><a href="tools_admin.asp" onclick="return jump_if();"><script>show_words(_tools)</script></a></td>
			<td id="topnavoff"><a href="st_device.asp" onclick="return jump_if();"><script>show_words(_status)</script></a></td>
			<td id="topnavoff"><a href="support_men.asp" onclick="return jump_if();"><script>show_words(_support)</script></a></td>
        </tr>
    </table>
    <table border="1" cellpadding="2" cellspacing="0" width="838" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
        <tr>
            <td id="sidenav_container" valign="top" width="125" align="right">
                <table cellSpacing=0 cellPadding=0 border=0>
                    <tr>
                      <td id=sidenav_container>
                        <div id=sidenav>
                          <UL>
						    <LI><div><a href="adv_virtual.asp" onClick="return jump_if();"><script>show_words(_virtserv)</script></a></div></LI>
                            <LI><div><a href="adv_portforward.asp" onclick="return jump_if();"><script>show_words(_pf)</script></a></div></LI>
                            <LI><div><a href="adv_appl.asp" onclick="return jump_if();"><script>show_words(_specappsr)</script></a></div></LI>
                            <LI><div><a href="adv_qos.asp" onclick="return jump_if();"><script>show_words(YM48)</script></a></div></LI>
                            <LI><div><a href="adv_filters_mac.asp" onclick="return jump_if();"><script>show_words(_netfilt)</script></a></div></LI>
                            <LI><div><a href="adv_access_control.asp" onclick="return jump_if();"><script>show_words(_acccon)</script></a></div></LI>
							<LI><div><a href="adv_filters_url.asp" onclick="return jump_if();"><script>show_words(_websfilter)</script></a></div></LI>
							<LI><div><a href="Inbound_Filter.asp" onclick="return jump_if();"><script>show_words(_inboundfilter)</script></a></div></LI>
							<LI><div><a href="adv_dmz.asp" onclick="return jump_if();"><script>show_words(_firewalls)</script></a></div></LI>
                            <LI><div><a href="adv_routing.asp" onclick="return jump_if();"><script>show_words(_routing)</script></a></div></LI>
							<LI><div><a href="adv_wlan_perform.asp" onclick="return jump_if();"><script>show_words(_adwwls)</script></a></div></LI>
                            <LI><div><a href="adv_wish.asp" onclick="return jump_if();">WISH</a></div></LI>
							<LI><div><a href="adv_wps_setting.asp" onclick="return jump_if();"><script>show_words(LY2)</script></a></div></LI>
                            <LI><div id=sidenavoff><script>show_words(_advnetwork)</script></div></LI>
                            <LI><div><a href="guest_zone.asp" onclick="return jump_if();"><script>show_words(_guestzone)</script></a></div></LI>
 				<LI><div><a href="adv_ipv6_firewall.asp" onclick="return jump_if();"><script>show_words(Tag05762)</script></a></div></LI>
                		<LI><div><a href="adv_ipv6_routing.asp" onclick="return jump_if();"><script>show_words(IPV6_routing)</script></a></div></LI>
                            	
                          </UL>
                        </div>
                      </td>
                    </tr>
                </table></td>

                <input type="hidden" id="inbound_filter_ip_00_A" name="inbound_filter_ip_00_A" value="<% CmoGetCfg("inbound_filter_ip_00_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_01_A" name="inbound_filter_ip_01_A" value="<% CmoGetCfg("inbound_filter_ip_01_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_02_A" name="inbound_filter_ip_02_A" value="<% CmoGetCfg("inbound_filter_ip_02_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_03_A" name="inbound_filter_ip_03_A" value="<% CmoGetCfg("inbound_filter_ip_03_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_04_A" name="inbound_filter_ip_04_A" value="<% CmoGetCfg("inbound_filter_ip_04_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_05_A" name="inbound_filter_ip_05_A" value="<% CmoGetCfg("inbound_filter_ip_05_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_06_A" name="inbound_filter_ip_06_A" value="<% CmoGetCfg("inbound_filter_ip_06_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_07_A" name="inbound_filter_ip_07_A" value="<% CmoGetCfg("inbound_filter_ip_07_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_08_A" name="inbound_filter_ip_08_A" value="<% CmoGetCfg("inbound_filter_ip_08_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_09_A" name="inbound_filter_ip_09_A" value="<% CmoGetCfg("inbound_filter_ip_09_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_10_A" name="inbound_filter_ip_10_A" value="<% CmoGetCfg("inbound_filter_ip_10_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_11_A" name="inbound_filter_ip_11_A" value="<% CmoGetCfg("inbound_filter_ip_11_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_12_A" name="inbound_filter_ip_12_A" value="<% CmoGetCfg("inbound_filter_ip_12_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_13_A" name="inbound_filter_ip_13_A" value="<% CmoGetCfg("inbound_filter_ip_13_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_14_A" name="inbound_filter_ip_14_A" value="<% CmoGetCfg("inbound_filter_ip_14_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_15_A" name="inbound_filter_ip_15_A" value="<% CmoGetCfg("inbound_filter_ip_15_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_16_A" name="inbound_filter_ip_16_A" value="<% CmoGetCfg("inbound_filter_ip_16_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_17_A" name="inbound_filter_ip_17_A" value="<% CmoGetCfg("inbound_filter_ip_17_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_18_A" name="inbound_filter_ip_18_A" value="<% CmoGetCfg("inbound_filter_ip_18_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_19_A" name="inbound_filter_ip_19_A" value="<% CmoGetCfg("inbound_filter_ip_19_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_20_A" name="inbound_filter_ip_20_A" value="<% CmoGetCfg("inbound_filter_ip_20_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_21_A" name="inbound_filter_ip_21_A" value="<% CmoGetCfg("inbound_filter_ip_21_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_22_A" name="inbound_filter_ip_22_A" value="<% CmoGetCfg("inbound_filter_ip_22_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_23_A" name="inbound_filter_ip_23_A" value="<% CmoGetCfg("inbound_filter_ip_23_A","none"); %>">

                <input type="hidden" id="inbound_filter_ip_00_B" name="inbound_filter_ip_00_B" value="<% CmoGetCfg("inbound_filter_ip_00_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_01_B" name="inbound_filter_ip_01_B" value="<% CmoGetCfg("inbound_filter_ip_01_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_02_B" name="inbound_filter_ip_02_B" value="<% CmoGetCfg("inbound_filter_ip_02_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_03_B" name="inbound_filter_ip_03_B" value="<% CmoGetCfg("inbound_filter_ip_03_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_04_B" name="inbound_filter_ip_04_B" value="<% CmoGetCfg("inbound_filter_ip_04_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_05_B" name="inbound_filter_ip_05_B" value="<% CmoGetCfg("inbound_filter_ip_05_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_06_B" name="inbound_filter_ip_06_B" value="<% CmoGetCfg("inbound_filter_ip_06_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_07_B" name="inbound_filter_ip_07_B" value="<% CmoGetCfg("inbound_filter_ip_07_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_08_B" name="inbound_filter_ip_08_B" value="<% CmoGetCfg("inbound_filter_ip_08_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_09_B" name="inbound_filter_ip_09_B" value="<% CmoGetCfg("inbound_filter_ip_09_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_10_B" name="inbound_filter_ip_10_B" value="<% CmoGetCfg("inbound_filter_ip_10_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_11_B" name="inbound_filter_ip_11_B" value="<% CmoGetCfg("inbound_filter_ip_11_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_12_B" name="inbound_filter_ip_12_B" value="<% CmoGetCfg("inbound_filter_ip_12_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_13_B" name="inbound_filter_ip_13_B" value="<% CmoGetCfg("inbound_filter_ip_13_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_14_B" name="inbound_filter_ip_14_B" value="<% CmoGetCfg("inbound_filter_ip_14_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_15_B" name="inbound_filter_ip_15_B" value="<% CmoGetCfg("inbound_filter_ip_15_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_16_B" name="inbound_filter_ip_16_B" value="<% CmoGetCfg("inbound_filter_ip_16_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_17_B" name="inbound_filter_ip_17_B" value="<% CmoGetCfg("inbound_filter_ip_17_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_18_B" name="inbound_filter_ip_18_B" value="<% CmoGetCfg("inbound_filter_ip_18_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_19_B" name="inbound_filter_ip_19_B" value="<% CmoGetCfg("inbound_filter_ip_19_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_20_B" name="inbound_filter_ip_20_B" value="<% CmoGetCfg("inbound_filter_ip_20_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_21_B" name="inbound_filter_ip_21_B" value="<% CmoGetCfg("inbound_filter_ip_21_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_22_B" name="inbound_filter_ip_22_B" value="<% CmoGetCfg("inbound_filter_ip_22_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_23_B" name="inbound_filter_ip_23_B" value="<% CmoGetCfg("inbound_filter_ip_23_B","none"); %>">

                <input type="hidden" id="inbound_filter_name_00" name="inbound_filter_name_00" value="<% CmoGetCfg("inbound_filter_name_00","none"); %>">
                <input type="hidden" id="inbound_filter_name_01" name="inbound_filter_name_01" value="<% CmoGetCfg("inbound_filter_name_01","none"); %>">
                <input type="hidden" id="inbound_filter_name_02" name="inbound_filter_name_02" value="<% CmoGetCfg("inbound_filter_name_02","none"); %>">
                <input type="hidden" id="inbound_filter_name_03" name="inbound_filter_name_03" value="<% CmoGetCfg("inbound_filter_name_03","none"); %>">
                <input type="hidden" id="inbound_filter_name_04" name="inbound_filter_name_04" value="<% CmoGetCfg("inbound_filter_name_04","none"); %>">
                <input type="hidden" id="inbound_filter_name_05" name="inbound_filter_name_05" value="<% CmoGetCfg("inbound_filter_name_05","none"); %>">
                <input type="hidden" id="inbound_filter_name_06" name="inbound_filter_name_06" value="<% CmoGetCfg("inbound_filter_name_06","none"); %>">
                <input type="hidden" id="inbound_filter_name_07" name="inbound_filter_name_07" value="<% CmoGetCfg("inbound_filter_name_07","none"); %>">
                <input type="hidden" id="inbound_filter_name_08" name="inbound_filter_name_08" value="<% CmoGetCfg("inbound_filter_name_08","none"); %>">
                <input type="hidden" id="inbound_filter_name_09" name="inbound_filter_name_09" value="<% CmoGetCfg("inbound_filter_name_09","none"); %>">
                <input type="hidden" id="inbound_filter_name_10" name="inbound_filter_name_10" value="<% CmoGetCfg("inbound_filter_name_10","none"); %>">
                <input type="hidden" id="inbound_filter_name_11" name="inbound_filter_name_11" value="<% CmoGetCfg("inbound_filter_name_11","none"); %>">
                <input type="hidden" id="inbound_filter_name_12" name="inbound_filter_name_12" value="<% CmoGetCfg("inbound_filter_name_12","none"); %>">
                <input type="hidden" id="inbound_filter_name_13" name="inbound_filter_name_13" value="<% CmoGetCfg("inbound_filter_name_13","none"); %>">
                <input type="hidden" id="inbound_filter_name_14" name="inbound_filter_name_14" value="<% CmoGetCfg("inbound_filter_name_14","none"); %>">
                <input type="hidden" id="inbound_filter_name_15" name="inbound_filter_name_15" value="<% CmoGetCfg("inbound_filter_name_15","none"); %>">
                <input type="hidden" id="inbound_filter_name_16" name="inbound_filter_name_16" value="<% CmoGetCfg("inbound_filter_name_16","none"); %>">
                <input type="hidden" id="inbound_filter_name_17" name="inbound_filter_name_17" value="<% CmoGetCfg("inbound_filter_name_17","none"); %>">
                <input type="hidden" id="inbound_filter_name_18" name="inbound_filter_name_18" value="<% CmoGetCfg("inbound_filter_name_18","none"); %>">
                <input type="hidden" id="inbound_filter_name_19" name="inbound_filter_name_19" value="<% CmoGetCfg("inbound_filter_name_19","none"); %>">
                <input type="hidden" id="inbound_filter_name_20" name="inbound_filter_name_20" value="<% CmoGetCfg("inbound_filter_name_20","none"); %>">
                <input type="hidden" id="inbound_filter_name_21" name="inbound_filter_name_21" value="<% CmoGetCfg("inbound_filter_name_21","none"); %>">
                <input type="hidden" id="inbound_filter_name_22" name="inbound_filter_name_22" value="<% CmoGetCfg("inbound_filter_name_22","none"); %>">
                <input type="hidden" id="inbound_filter_name_23" name="inbound_filter_name_23" value="<% CmoGetCfg("inbound_filter_name_23","none"); %>">

                <form id="form1" name="form1" method="post" action="apply.cgi">
                <input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
                <input type="hidden" id="html_response_message" name="html_response_message" value="">
                <script>get_by_id("html_response_message").value = sc_intro_sv;</script>
                <input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_network.asp">

            <td valign="top" id="maincontent_container">
            	<div id="maincontent">
                  <!-- === BEGIN MAINCONTENT === -->
                  <div id=box_header>
                    <h1><script>show_words(_advnetwork)</script></h1>
                    <p>
                       <script>show_words(anet_intro)</script>
                    </p>
			<input name="apply" id="apply" type="submit" class=button_submit value="" onClick="return send_request()">
			<input name="cancel" id="cancel" type="button" class=button_submit value="" onclick="page_cancel('form1', 'adv_network.asp');">
			<script>check_reboot();</script>
			<script>get_by_id("apply").value = _savesettings;</script>
			<script>get_by_id("cancel").value = _dontsavesettings;</script>

                  </div>
                  <br>
                  <div class=box>
          <h2>
            <script>show_words(ta_upnp)</script>
          </h2>

          <P class="box_msg">
            <script>show_words(anet_msg_upnp)</script>
          </P>
                    <table cellSpacing=1 cellPadding=1 width=525 border=0>
                        <tr>

              <td width="185" align=right class="duple">
                <script>show_words(ta_EUPNP)</script>
                :</td>
                          <td width="333" colSpan=3>&nbsp;
                          <input name="upnpEnable" type=checkbox id="upnpEnable" value="1">
                          <input type="hidden" id="upnp_enable" name="upnp_enable" value="<% CmoGetCfg("upnp_enable","none"); %>">
                          </td>
                        </tr>
                    </table>
                  </div>
		<!--div class=box>
                    <h2>PPPoE PASS THROUGH</h2>
                    <table cellSpacing=1 cellPadding=1 width=525 border=0>
                        <tr>
                          <td width="185" align=right class="duple">Enable PPPoE Pass Through :</td>
                          <td width="333" colSpan=3>&nbsp;
                          <input name="pppoePassEnabled" type=checkbox id="pppoePassEnabled" value="1">
                          <input type="hidden" id="pppoe_pass_through" name="pppoe_pass_through" value="<% CmoGetCfg("pppoe_pass_through","none"); %>">
                          </td>
                        </tr>
                    </table>
                  </div-->
                  <div class=box>
                    <h2><script>show_words(anet_wan_ping)</script></h2>
                    <P class="box_msg"><script>show_words(anet_msg_wan_ping)</script></P>
                    <table cellSpacing=1 cellPadding=1 width=525 border=0>
                        <tr>
                          <td width="185" align=right class="duple"><script>show_words(bwn_RPing)</script> :</td>
                          <td width="333" colSpan=3>&nbsp;
                          <input name="wan_ping" type="checkbox" id="wan_ping" value="1">
                          <input type="hidden" id="wan_port_ping_response_enable" name="wan_port_ping_response_enable" value="<% CmoGetCfg("wan_port_ping_response_enable","none"); %>">
                          </td>
                        </tr>
                        <tr>

              <td width="185" align=right class="duple">
                <script>show_words(bwn_IF)</script>
                :</td>
                          <td width="333" colSpan=3>&nbsp;
                          <input type="hidden" id="wan_port_ping_response_inbound_filter" name="wan_port_ping_response_inbound_filter" value="<% CmoGetCfg("wan_port_ping_response_inbound_filter","none"); %>">
                          <select id="inbound_filter" name="inbound_filter" onchange="wan_ping_ingress_filter_name_selector(this.value);">
						  	<option value="Allow_All"><script>show_words(_allowall)</script></option>
						  	<option value="Deny_All"><script>show_words(_denyall)</script></option>
                            <script>
                            set_Inbound();
                            show_option_value();
                            </script>
                          </select>
                          </td>
                        </tr>
                        <tr>

              <td width="185" align=right class="duple">
                <script>show_words(_aa_details)</script>
                :</td>
                          <td width="333" colSpan=3>&nbsp;
                          <input type="text" id="filtext" name="filtext" size="48" maxlength="48" readonly="readonly">
                          </td>
                        </tr>
                    </table>
                  </div>

                  <div class=box>
          <h2>
            <script>show_words(anet_wan_phyrate)</script>
          </h2>
                    <table width="525" border=0 cellpadding=0>
                      <tr>

              <td width="185" align=right class="duple">
                <script>show_words(anet_wan_phyrate)</script>
                :</td>
                          <td width="333" colSpan=3>&nbsp;
                          <select name="wan_port_speed" id="wan_port_speed">
							 <option value="10full"><script>show_words(anet_wp_0)</script></option>
                             <option value="100full"><script>show_words(anet_wp_1)</script></option>
                             <option value="giga"><script>show_words(LW3)</script></option>
                             <option value="auto"><script>show_words(anet_wp_auto2)</script></option>
                          </select>
                          </td>
                        </tr>
                    </table>
                  </div>
                  <div class=box>
        <h2>
          <script>show_words(anet_multicast)</script>
        </h2>
                    <table cellSpacing=1 cellPadding=1 width=525 border=0>
                        <tr>

            <td width="185" align=right class="duple">
              <script>show_words(anet_multicast_enable)</script>
              :</td>
                          <td width="333" colSpan=3>&nbsp;
                          <input name="multi_enable" type=checkbox id="multi_enable" value="1">
                          <input type="hidden" id="multicast_stream_enable" name="multicast_stream_enable" value="<% CmoGetCfg("multicast_stream_enable","none"); %>">
                          </td>
                        </tr>
                    </table></form>
            </div>
              <!-- === END MAINCONTENT === -->
              </div></td>
            <td valign="top" width="150" id="sidehelp_container" align="left">
                <table width="125" border=0
      cellPadding=2 cellSpacing=0 borderColor=#ffffff borderColorLight=#ffffff borderColorDark=#ffffff bgColor=#ffffff>
                    <tr>

          <td id=help_text><strong>
            <script>show_words(_hints)</script>
            &hellip;</strong> <p>
              <script>show_words(hhan_upnp)</script>
            </p>

            <p>
              <script>show_words(hhan_ping)</script>
            </p>

            <p>
              <script>show_words(hhan_wans)</script>
            </p>

            <p>
              <script>show_words(hhan_mc)</script>
            </p>
                      	<p class="more"><a href="support_adv.asp#Network" onclick="return jump_if();"><script>show_words(_more)</script>&hellip;</a></p>
                    </tr>
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
