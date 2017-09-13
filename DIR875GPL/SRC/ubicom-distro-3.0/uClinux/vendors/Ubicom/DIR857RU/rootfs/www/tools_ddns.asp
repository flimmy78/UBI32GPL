<html>
<head>
<script language="JavaScript" src="lingual_<% CmoGetCfg("lingual","none"); %>.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language=JavaScript>
	
var submit_button_flag = 0;
var kinds_array = new Array("Custom","Dynamic","Static");
var reboot_needed = "<% CmoGetStatus("reboot_needed"); %>";

function onPageLoad()
{
	set_checked("<% CmoGetCfg("ddns_enable","none"); %>", get_by_id("d_enable"));
	var ddns_type = get_by_id("ddns_type").value;
	get_by_id("ddns_type_value").value = ddns_type;
	if(ddns_type == "dyndns.com"){
		for(i=0;i<kinds_array.length;i++){
			if(get_by_id("ddns_dyndns_kinds").value == kinds_array[i]){
				get_by_id("ddns_type_value").value = get_by_id("ddns_type_sel").options[i+2].text;
				break;
			}
		}
	}else{
		for (var pp=0; pp<get_by_id("ddns_type_sel").options.length; pp++){
	        if (get_by_id("ddns_type").value == get_by_id("ddns_type_sel").options[pp].value){
	            get_by_id("ddns_type_value").value = get_by_id("ddns_type_sel").options[pp].text;
	            break;
	        }
	    }
	}
	disable_obj();

        if ("<% CmoGetStatus("get_current_user"); %>" == "user") {
           DisableEnableForm(document.form1,true);
		}

        set_form_default_values("form1");
}

function check_ddns(){
	var ddnsEnable = get_by_id("d_enable");

	if (ddnsEnable.checked){
		temp_obj = get_by_id("ddns_sync_interval");
		var timeout_msg = replace_msg(check_num_msg, "Timeout", 1, 8760);
		obj = new varible_obj(temp_obj.value, timeout_msg, 1, 8760, false);

		if (get_by_id("ddns_type_value").value == ""){
			alert(GW_DYNDNS_SERVER_INDEX_VALUE_INVALID);
			return false;
		}else if (get_by_id("ddns_hostname").value == ""){
			alert(GW_DYNDNS_HOST_NAME_INVALID);
			return false;
		}else if (get_by_id("ddns_username").value == ""){
			alert(GW_DYNDNS_USER_NAME_INVALID);
			return false;
		}else if (get_by_id("ddns_password").value == ""){
			alert(GW_DYNDNS_PASSWORD_INVALID);
			return false;
		}else if (get_by_id("ddns_password").value != get_by_id("ddns_password2").value){
			alert(YM177);
			return false;
		}else if(!check_varible(obj)){
    		return false;
    	}
	}

	return true;
}

function send_request(){
	if (!is_form_modified("form1") && !confirm(_ask_nochange)) {
		return false;
	}
	if (check_ddns()){
		get_by_id("ddns_enable").value = get_checked_value(get_by_id("d_enable"));
		if(submit_button_flag == 0){
			get_by_id("ddns_type").value = get_by_id("ddns_type_value").value;            	
			submit_button_flag = 1;
                return true;
		}
	}
        return false;
}

    function disable_obj()
    {
	var is_disable = true;

        if (get_by_id("d_enable").checked) {
		is_disable = false;
	}

	get_by_id("ddns_type_sel").disabled = is_disable;
	get_by_id("ddns_hostname").disabled = is_disable;
	get_by_id("ddns_username").disabled = is_disable;
        get_by_id("ddns_password").disabled = is_disable;
	get_by_id("ddns_password2").disabled = is_disable;
	get_by_id("ddns_sync_interval").disabled = is_disable;
}

function copy_name(){
	var obj = get_by_id("ddns_type_sel");
	var kinds = get_by_id("ddns_dyndns_kinds");
	if(obj.selectedIndex >= 0){
		if(obj.selectedIndex > 0){
		get_by_id("ddns_type_value").value = obj.options[obj.selectedIndex].text;
		get_by_id("ddns_type").value = obj.options[obj.selectedIndex].value;
		if(obj.selectedIndex > 1 && obj.selectedIndex < 5){
			get_by_id("ddns_dyndns_kinds").value = kinds_array[obj.selectedIndex-2];
		}
		}
	}else{
		get_by_id("ddns_type_value").value = "";
		get_by_id("ddns_type").value = "";
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
        <td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://support.dlink.com.tw/" onclick="return jump_if();"><% CmoGetCfg("model_number","none"); %></a></td>
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
			<td id="topnavoff"><a href="adv_virtual.asp" onclick="return jump_if();"><script>show_words(_advanced)</script></a></td>
			<td id="topnavon"><a href="tools_admin.asp" onclick="return jump_if();"><script>show_words(_tools)</script></a></td>
			<td id="topnavoff"><a href="st_device.asp" onclick="return jump_if();"><script>show_words(_status)</script></a></td>
			<td id="topnavoff"><a href="support_men.asp" onclick="return jump_if();"><script>show_words(_support)</script></a></td>
		</tr>
	</table>
	<table border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
		<tr>
			<td id="sidenav_container" valign="top" width="125" align="right">
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td id="sidenav_container">
							<div id="sidenav">
							<!-- === BEGIN SIDENAV === -->
								<ul>
									<li><div><a href="tools_admin.asp" onclick="return jump_if();"><script>show_words(_admin)</script></a></div></li>
									<li><div><a href="tools_time.asp" onclick="return jump_if();"><script>show_words(_time)</script></a></div></li>
									<li><div><a href="tools_syslog.asp" onclick="return jump_if();"><script>show_words(_syslog)</script></a></div></li>
									<li><div><a href="tools_email.asp" onclick="return jump_if();"><script>show_words(_email)</script></a></div></li>
									<li><div><a href="tools_system.asp" onclick="return jump_if();"><script>show_words(_system)</script></a></div></li>
									<li><div><a href="tools_firmw.asp" onclick="return jump_if();"><script>show_words(_firmware)</script></a></div></li>
									<li><div id="sidenavoff"><script>show_words(_dyndns)</script></div></li>
								    <li><div><a href="tools_vct.asp" onclick="return jump_if();"><script>show_words(_syscheck)</script></a></div></li>
									<li><div><a href="tools_schedules.asp" onclick="return jump_if();"><script>show_words(_scheds)</script></a></div></li></ul>
									</li>
								</ul>
								<!-- === END SIDENAV === -->
							</div>
						</td>
					</tr>
				</table>
			</td>
			<form  name="form1" id="form1" method="post" action="apply.cgi">
				<input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
				<input type="hidden" id="html_response_message" name="html_response_message" value="">
				<script>get_by_id("html_response_message").value = sc_intro_sv;</script>
				<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="tools_ddns.asp">
				<input type="hidden" id="ddns_dyndns_kinds" name="ddns_dyndns_kinds" value="<% CmoGetCfg("ddns_dyndns_kinds","none"); %>">
                <input type="hidden" id="ddns_type" name="ddns_type" value="<% CmoGetCfg("ddns_type","none"); %>">
				<input type="hidden" id="reboot_type" name="reboot_type" value="application">
			<td valign="top" id="maincontent_container">
				<div id="maincontent">
					<!-- === BEGIN MAINCONTENT === -->
				  <div id="box_header">
            <h1>
              <script>show_words(_dyndns)</script>
            </h1>

            <p>
              <script>show_words(td_intro_DDNS)</script>
            </p>

						<p>
              <script>show_words(td_intro_DDNS_DLINK)</script>&nbsp;<a href="http://www.dlinkddns.com" target="ddns" onclick="return jump_if();">www.dlinkddns.com.</a>
            </p>
				        <input id="button1" name="button1" type="submit" class=button_submit value="" onClick="return send_request();">
				        <input id="button2" name="button2" type=button class=button_submit value="" onclick="page_cancel('form1', 'tools_ddns.asp');">
				        <script>check_reboot();</script>
				        <script>get_by_id("button1").value=_savesettings;</script>
				        <script>get_by_id("button2").value = _dontsavesettings;</script>
				  </div>
				  <div class="box">

            <h2>
              <script>show_words(_dyndns)</script>
            </h2>
							<table width=525 border=0 cellpadding=0>

                                <tr>

                <td width=150 align=right class="duple">
                  <script>show_words(td_EnDDNS)</script>
                  :</td>
                                  <td height=20>&nbsp;
                                    <input name="d_enable" type="checkbox" id="d_enable" value="1" onClick="disable_obj();">
									<input type="hidden" id="ddns_enable" name="ddns_enable" value="<% CmoGetCfg("ddns_enable","none"); %>">                                    </td>
                                </tr>
                                <tr>

                <td align=right class="duple">
                  <script>show_words(td_SvAd)</script>
                  :</td>
                                  <td height=20>&nbsp;&nbsp;
                                    <input type="text" id="ddns_type_value" name="ddns_type_value" value="">
                                    <input name="copy_app5" type=button value="<<" class="button" onClick="copy_name();">
                                    <select id="ddns_type_sel" name="ddns_type_sel" tabindex=2>
									  <option><script>show_words(tt_SelDynDns)</script></option>
									  <option value="dlinkddns.com">dlinkddns.com(Free)</option>
									  <option value="dyndns.com">dyndns.com(Custom)</option>
									  <option value="dyndns.com">dyndns.com(Free)</option>
									  <option value="www.oray.cn">www.oray.cn</option>
									  <!--option value="dyndns.com">dyndns.com(Static)</option-->
                                    </select>
                                  </td>
                                </tr>
                                <tr>

                <td align=right class="duple">
                  <script>show_words(_hostname)</script>
                  :</td>
                                  <td height=20>&nbsp;&nbsp;
                                    <input type="text" id="ddns_hostname" name="ddns_hostname" size="40" maxlength="60" value="<% CmoGetCfg("ddns_hostname","none"); %>">
                                  </td>
                                </tr>
                                <tr>

                <td align=right class="duple">
                  <script>show_words(td_UNK)</script>
                  :</td>
                                  <td height=20>&nbsp;&nbsp;
                                    <input type="text" id="ddns_username" name="ddns_username" size="40" maxlength="60" value="<% CmoGetCfg("ddns_username","none"); %>">
                                  </td>
                                </tr>
                                <tr>

                <td align=right class="duple">
                  <script>show_words(td_PWK)</script>
                  :</td>
                                  <td height=20>&nbsp;&nbsp;
                                    <input type="password" id="ddns_password" name="ddns_password" size="40" maxlength="40" onfocus="select();" value="<% CmoGetCfg("ddns_password","none"); %>">
                                  </td>
                                </tr>
                                <tr>

                <td align=right class="duple">
                  <script>show_words(td_VPWK)</script>
                  :</td>
                                  <td height=20>&nbsp;&nbsp;
                                    <input type="password" id="ddns_password2" name="ddns_password2" size="40" maxlength="40" onfocus="select();" value="<% CmoGetCfg("ddns_password","none"); %>">
                                  </td>
                                </tr>
                                <tr>

                <td align=right class="duple">
                  <script>show_words(td_Timeout)</script>
                  &nbsp;:</td>
                                  <td height=20>&nbsp;&nbsp;
                                    <input type="text" id="ddns_sync_interval" name="ddns_sync_interval" size="10" maxLength="4" value="<% CmoGetCfg("ddns_sync_interval","none"); %>">
                                  <script>show_words(td_)</script>
                                  </td>
                                </tr>
                                <tr>

                <td align=right class="duple">
                  <script>show_words(_status)</script>
                  &nbsp;:</td>
                                  <td height=20>&nbsp;&nbsp;
                                    <script>
                                    	var ddns_status = "<% CmoGetStatus("ddns_status"); %>";
                                    	var show_ddns_status = ddns_disconnect;
                                    	if (ddns_status == "success"){
                                    		show_ddns_status = ddns_connected;
                                    	}
                                    	document.write(show_ddns_status);
                                    </script>
                                  </td>
                                </tr>
				    </table>
				  </div>
					<!-- === END MAINCONTENT === -->
                </div></td></form>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table cellpadding="2" cellspacing="0" border="0" bgcolor="#FFFFFF">
					<tr>

          <td id=help_text><strong>
            <script>show_words(_hints)</script>
            &hellip;</strong> <p>
              <script>show_words(TA16)</script>
            </p>
					  	<p class="more"><a href="support_tools.asp#Dynamic_DNS" onclick="return jump_if();"><script>show_words(_more)</script>&hellip;</a></p>
					  </td>
					</tr>
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
