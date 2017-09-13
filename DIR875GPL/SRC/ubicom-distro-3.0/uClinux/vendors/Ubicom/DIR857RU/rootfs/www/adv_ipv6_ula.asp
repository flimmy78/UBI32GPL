<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<script language="JavaScript" src="lingual_<% CmoGetCfg("lingual","none"); %>.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_ipv6.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript">
var submit_button_flag = 0;
var reboot_needed = "<% CmoGetStatus("reboot_needed"); %>";

function onPageLoad()
{
	//set_checked("<% CmoGetCfg("ipv6_ula_enable","none"); %>", get_by_id("ula_enable"));
	set_checked(get_by_id("ipv6_ula_enable").value, get_by_id("ula_enable"));
	if("<% CmoGetCfg("ipv6_ula_enable","none"); %>" == "1"){
		get_by_id("current_ula_prefix").innerHTML = "<% CmoGetCfg("ipv6_ula_prefix","none"); %>"+"/64".toUpperCase();
		get_by_id("current_ula_lan").innerHTML = "<% CmoGetStatus("ipv6_get_ula","none"); %>".toUpperCase();
	}else{
		get_by_id("current_ula_prefix").innerHTML = "";
		get_by_id("current_ula_lan").innerHTML = "";
	}
	if("<% CmoGetCfg("ipv6_ula_prefix","none"); %>" == "<% CmoGetStatus("default_ula","none"); %>" || "<% CmoGetCfg("ipv6_ula_prefix","none"); %>" == ""){
		get_by_id("ula_prefix").disabled = true;
		set_checked("1", get_by_id("use_default"));
	}
	disable_ula();
	default_ula();
	set_form_default_values("form1");
} 

function disable_ula(){
	if(get_by_id("ula_enable").checked){
		get_by_id("use_default").disabled = false;
		if(get_by_id("use_default").checked)
			get_by_id("ula_prefix").disabled = true;
		else
		get_by_id("ula_prefix").disabled = false;
	}else{
		get_by_id("use_default").disabled = true;
		get_by_id("ula_prefix").disabled = true;
	}
}

function default_ula()
{
	if(get_by_id("use_default").checked){
		get_by_id("ula_prefix").value = "<% CmoGetStatus("default_ula","none"); %>";
		get_by_id("ula_prefix").disabled = true;
	}else{
		get_by_id("ula_prefix").value = "<% CmoGetCfg("ipv6_ula_prefix","none"); %>";
		get_by_id("ula_prefix").disabled = false;
	}
}

function send_request()
{
	var ula_prefix = get_by_id("ula_prefix").value;
	var ipv6_static_msg = replace_msg(all_ipv6_addr_msg,"ULA Prefix");
	var temp_ula_prefix = new ipv6_addr_obj(ula_prefix.split(":"), ipv6_static_msg, false, false);
	var colon_count = ula_prefix.split(":");

	if (!is_form_modified("form1") && !confirm(_ask_nochange)) {
	    return false;
	}
	get_by_id("ipv6_ula_enable").value = get_checked_value(get_by_id("ula_enable"));
	get_by_id("ipv6_ula_prefix").value = get_by_id("ula_prefix").value;

	if(get_by_id("ula_prefix").value == "" && get_by_id("ula_enable").checked){
		if(!confirm(IPv6_ULA_blank+"\n("+"<% CmoGetStatus("default_ula","none"); %>"+"/64)"))
			return false;
		else
			get_by_id("ipv6_ula_prefix").value = "<% CmoGetStatus("default_ula","none"); %>";
	}else if(get_by_id("ula_enable").checked){
		if(check_ipv6_symbol(ula_prefix,"::") == 2){ // find two '::' symbol
			return false;
		}else if(check_ipv6_symbol(ula_prefix,"::") == 1){    // find one '::' symbol
			if(ula_prefix.substr(0,1) != "f" && ula_prefix.substr(0,1) != "F"){
				alert(IPv6_ULA_error);
				return false;
			}
			if(ula_prefix.substr(1,1) != "d" && ula_prefix.substr(1,1) != "D" && 
			   ula_prefix.substr(1,1) != "c" && ula_prefix.substr(1,1) != "C"){
				alert(IPv6_ULA_error);
				return false;
			}
			if(ula_prefix.substr(2,1) == ":" || ula_prefix.substr(3,1) == ":"){ 
				alert(IPv6_ULA_error);
				return false;
			}
			if(colon_count.length > 6){
				alert(IPv6_ULA_error);
				return false;
			}
			temp_ula_prefix = new ipv6_addr_obj(ula_prefix.split("::"), ipv6_static_msg, false, false);
			if(temp_ula_prefix.addr[temp_ula_prefix.addr.length-1].length != 0){
				alert(IPv6_ULA_error);
				return false;
			}
			else
				temp_ula_prefix.addr[temp_ula_prefix.addr.length-1] = "1111";
			if (!check_ipv6_address(temp_ula_prefix,"::")){
				return false;
			}
		}else{  //not find '::' symbol
			alert(IPv6_ULA_error);
			return false;
		}
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
.style2 {font-size: 12px}
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
                <table border="0" cellpadding="0" cellspacing="0">
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
                </table>
          </td>

            <form id="form1" name="form1" method="post" action="apply.cgi">
                <input type="hidden" id="html_response_page" name="html_response_page" value="reboot.asp">
                <input type="hidden" id="html_response_message" name="html_response_message" value="">
                <script>get_by_id("html_response_message").value = sc_intro_sv;</script>
                <input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_ipv6_ula.asp">
                <input type="hidden" id="reboot_type" name="reboot_type" value="all">
		<input type="hidden" id="action" name="action" value="adv_ipv6_ula">
		<input type="hidden" id="ipv6_ula_enable" name="ipv6_ula_enable" value="<% CmoGetCfg("ipv6_ula_enable","none"); %>">
		<input type="hidden" id="ipv6_ula_prefix" name="ipv6_ula_prefix" value="<% CmoGetCfg("ipv6_ula_prefix","none"); %>">
		<input type="hidden" id="reboot_type" name="reboot_type" value="wan">
              <td valign="top" id="maincontent_container">
                <div id="maincontent">
                  <div id="box_header">
                    <h1><script>show_words(IPv6_ULA_setting_2)</script></h1>
                    <script>show_words(IPv6_ULA_msg_1)</script><br><br>
                    <input name="button" id="button" type="submit" class=button_submit onClick="return send_request()">
                    <input name="button2" id="button2" type="button" class=button_submit value="" onclick="page_cancel_1('form1', 'adv_ipv6_ula.asp');">
                    <script>check_reboot();</script>
                    <script>get_by_id("button").value = _savesettings;</script>
                    <script>get_by_id("button2").value = _dontsavesettings;</script>
                  </div>
                  <br>
                  <div class="box">
                  <h2><script>show_words(IPv6_ULA_setting)</script></h2>

          <table cellpadding="1" cellspacing="1" border="0" width="525">
            <tr>
              <td class="duple"><script>show_words(IPv6_ULA_enable)</script> :</td>
              <td>&nbsp;&nbsp;<input name="ula_enable" id="ula_enable" type="checkbox" value="1" onClick="disable_ula();">
                </td>
            </tr>
		<tr>
			<td width="187" align=right class="duple"><script>show_words(IPv6_ULA_default)</script> :</td>
	                <td>&nbsp;&nbsp;<input name="use_default" id="use_default" type="checkbox" value="1" onClick="default_ula();">
        	        </td>
		</tr>
            <tr>
              <td class="duple"><script>show_words(IPv6_ULA_prefix)</script> :</td>
              <td width="340">&nbsp;&nbsp;<input name="ula_prefix" type="text" id="ula_prefix" size="25" maxlength="40" value="<% CmoGetCfg("ipv6_ula_prefix","none"); %>"> <b>/64</b>
                </td>
            </tr>
          </table>
            </div>
                  <div class="box">
                  <h2><script>show_words(IPv6_ULA_setting_1)</script></h2>

          <table cellpadding="1" cellspacing="1" border="0" width="525">
            <tr>
              <td width="187" align=right class="duple"><script>show_words(IPv6_ULA_current)</script> :</td>
              <td width="331">&nbsp;&nbsp;<b><span id="current_ula_prefix" name="current_ula_prefix"></span></b>
                </td>
            </tr>
            <tr>
              <td width="187" align=right class="duple"><script>show_words(IPv6_ULA_lan)</script> :</td>
              <td width="331">&nbsp;&nbsp;<b><span id="current_ula_lan" name="current_ula_lan"></span></b>
                </td>
            </tr>
          </table>
            </div>
            </form>
            <td valign="top" width="150" id="sidehelp_container" align="left">
                <table cellSpacing=0 cellPadding=2 bgColor=#ffffff border=0>
                  <tbody>
                    <tr>
                        <td id=help_text><strong><script>show_words(_hints)</script>&hellip;</strong>
                          <p><script>show_words(IPv6_ULA_help)</script></p>
                          <p><a href="support_adv.asp#IPv6_ULA" onclick="return jump_if();"><script>show_words(_more)</script>&hellip;</a></p>
                        </td>
                    </tr>
                  </tbody>
                </table>
            </td>
        </tr>
    </table>
    <table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
        <tr>
            <td width="125" align="center">&nbsp;&nbsp;<img src="wireless_tail.gif" width="114" height="35"></td>
            <td width="10">&nbsp;</td>
            <td>&nbsp;</td>
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
