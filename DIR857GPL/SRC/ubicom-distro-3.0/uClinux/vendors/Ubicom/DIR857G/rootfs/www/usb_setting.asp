<html>
<head>
<script language="JavaScript" src="lingual_<% CmoGetCfg("lingual","none"); %>_tmp.js"></script>
<script language="JavaScript" src="lingual_<% CmoGetCfg("lingual","none"); %>.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript">
    var submit_button_flag = 0;
    var reboot_needed = "<% CmoGetStatus("reboot_needed"); %>";
    
	function onPageLoad()
	{
		if ("<% CmoGetStatus("get_current_user"); %>" == "user") {
			DisableEnableForm(document.form1, true);
		}

        var show_selected = get_by_id("usb_type").value;
        set_selectIndex(show_selected, get_by_id("usb"));
        set_checked("<% CmoGetCfg("netusb_guest_zone","none"); %>", get_by_id("shareport"));
        select_shareport();
        
        set_form_default_values("form1");
	}
	function select_shareport(){
		var usb_type = get_by_id("usb").value;
		var show_shareport = get_by_id("show_shareport");
		if(usb_type =="1" || usb_type =="2"){
			show_shareport.style.display = "none";
		}else{
			show_shareport.style.display = "";
        }

    }

    function send_request()
    {
		if (!is_form_modified("form1") && !confirm(_ask_nochange)) {
            return false;
        }
        
        var mode = get_by_id("wanmode").value;
        var usb_type = get_by_id("usb").value;
        var share_value = get_checked_value(get_by_id("shareport"));

		if ((usb_type == get_by_id("usb_type").value) && (share_value == get_by_id("netusb_guest_zone").value) && !confirm(_ask_nochange)) {
            return false;
        }
        if (mode == "usb3g" && usb_type == "0") {
            get_by_id("asp_temp_72").value = "0"; //usb_type = Network USB
            send_submit("form2");
            return false;
        }
        else if (usb_type == "2") {
            get_by_id("asp_temp_72").value = "2"; //usb_type = 3G USB
            send_submit("form2");
            return false;
        }
        else if (mode == "usb3g" && usb_type == "1") {
            get_by_id("asp_temp_72").value = "1"; //usb_type = 3G USB
            send_submit("form2");
            return false;
        }
        else {
            get_by_id("asp_temp_72").value= get_by_id("usb").value;
            send_submit("form2");
        }
        get_by_id("usb_type").value = get_by_id("usb").value;
        get_by_id("netusb_guest_zone").value = get_checked_value(get_by_id("shareport"));

        if (submit_button_flag == 0) {
            submit_button_flag = 1;
            return true;
        }
        return false;
    }
</script>

<title><% CmoGetStatus("title"); %></title>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
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
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td id="sidenav_container">
                            <div id="sidenav">
                                <ul>
                                    <li><div id="sidenavon"><a href="index.asp" onclick="return jump_if();"><script>show_words(sa_Internet)</script></a></div></li>
                                    <li><div id="sidenavon"><a href="wizard_wireless.asp" onclick="return jump_if();"><script>show_words(_wirelesst)</script></a></div></li>
                                    <li><div id="sidenavon"><a href="lan.asp" onclick="return jump_if();"><script>show_words(bln_title_NetSt)</script></a></div></li>
                                    <li><div id="sidenavoff"><script>show_words(bln_title_usb)</script></div></li>
                                </ul>
                            </div>
                        </td>
                    </tr>
                </table>
            </td>
            <form id="form2" name="form2" method="post" action="apply.cgi">
            <input type="hidden" id="html_response_page" name="html_response_page" value="wan_usb3G.asp">
            <input type="hidden" id="asp_temp_72" name="asp_temp_72" value="<% CmoGetCfg("asp_temp_72","none"); %>">
            <input type="hidden" id="reboot_type" name="reboot_type" value="none">
            </form>

            <form id="form1" name="form1" method="post" action="apply.cgi">
            <input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
            <input type="hidden" id="html_response_message" name="html_response_message" value="">
            <script>get_by_id("html_response_message").value = sc_intro_sv;</script>
            <input type="hidden" id="html_response_return_page" name="html_response_return_page" value="usb_setting.asp">
            <input type="hidden" id="wanmode" name="wanmode" value="<% CmoGetCfg("wan_proto","none"); %>">

            <td valign="top" id="maincontent_container">
                <div id="maincontent">
                  <div id=box_header>
                    <h1><script>show_words(bln_title_usb)</script></h1>
                    <script>show_words(bwn_intro_usb)</script><br><br>
                    <script>show_words(usb_3g_help_support_help)</script><br><br>
                  <input name="button" id="button" class="button_submit" type="submit" onClick="return send_request()">
                  <input name="button2" id="button2" class="button_submit" type="button" onclick="page_cancel('form1', 'usb_setting.asp');">
                  <script>check_reboot();</script>
                  <script>get_by_id("button2").value = _dontsavesettings;</script>
                  <script>get_by_id("button").value = _savesettings;</script>
                  </div>
                  <br>
                  <div class=box>
                    <h2><script>show_words(bln_title_usb)</script></h2>
                    <P><script>show_words(bwn_msg_usb)</script> </P>

          <table cellSpacing=1 cellPadding=1 width=525 border=0>
            <tr>
              <td width=155 align=right class="duple"><script>show_words(new_bwn_mici_usb)</script>&nbsp;:</td>
              <td width="360">&nbsp; <select name="usb" id="usb" onChange="select_shareport()">
                  <option value="0">SharePort</option>
                  <option value="2"><script>show_words(usb_3g)</script></option>
                  <option value="1"><script>show_words(usb_wcn)</script></option>
                </select>
                <input type="hidden" id="usb_type" name="usb_type" value="<% CmoGetCfg("usb_type","none"); %>">
              </td>
            </tr>
          </table>

                  </div>
			<div class=box id="show_shareport">
                <h2><script>show_words(SharePort)</script></h2>

            <table cellSpacing=1 cellPadding=1 width=525 border=0>
                <tr>
                    <td width=155 align=right class="duple"><script>show_words(Enable_SharePort)</script>&nbsp;:</td>
                    <td width="360">&nbsp;
                    <input name="shareport" type=checkbox id="shareport" value="1">
                    <input type="hidden" id="netusb_guest_zone" name="netusb_guest_zone" value="<% CmoGetCfg("netusb_guest_zone","none"); %>">
                     </td>
                </tr>
            </table>

            </div>
                  <div class=box style="display:none">
                    <h2><script>show_words(usb_network)</script></h2>

          <P><script>show_words(_info_netowrk)</script>
            <label class="duple" for="network_usb_enable_select"></label>
          </P>
          <P>
            <label class="duple" for="network_usb_enable_select"><script>show_words(_network_usb_auto)</script>&nbsp;:</label>
            <input type="hidden" id="network_usb_enable" name="config.usb_kcode_enable" value="1"/>
            <input name="checkbox" type="checkbox" id="network_usb_enable_select" onclick="network_usb_enable_selector(this.checked);"/>
          </P>
          <P>
            <label class="duple" for="usb_kcode_timer"><script>show_words(bwn_usb_time)</script>&nbsp;:</label>
            <input type="text" name="usb_intervalr" id="usb_interval" size="10" maxlength="5" value="10" >
            <script>show_words(bwn_bytes_usb)</script> </P>

                  </div>
              </div></td>
            </form>
            <td valign="top" width="150" id="sidehelp_container" align="left">
                <table cellSpacing=0 cellPadding=2 bgColor=#ffffff border=0>
                    <tr>
                      <td id=help_text><strong><script>show_words(_hints)</script>&hellip;</strong>
                          <p><script>show_words(usb_network_support_help)</script> </p>
                          <p><script>show_words(usb_3g_help_support_help)</script></p>
                          <p style="display:none"><script>show_words(hhan_ping)</script></p>
                          <p style="display:none"><script>show_words(hhan_mc)</script></p>

                          <p class="more"><a href="support_internet.asp#USB"><script>show_words(_more)</script>&hellip;</a></p>
                      </td>
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