<html>
<head>
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<script language="JavaScript" src="lingual_<% CmoGetCfg("lingual","none"); %>.js"></script>
<script language="Javascript" src="lang.js"></script>
<script language="Javascript" src="public.js"></script>
<script language="Javascript">
var submit_button_flag = 0;
	function onPageLoad(){
		get_by_id("connect_b2").disabled = true;
		var next_page = get_by_id("html_response_page").value;
		if(next_page == "wizard_ipv6_pppoe.asp")
			get_by_name("ipv6_type")[0].checked = "true";
		else if(next_page == "wizard_ipv6_static.asp")
			get_by_name("ipv6_type")[1].checked = "true";
		else if(next_page == "wizard_ipv6_6rd.asp")
			get_by_name("ipv6_type")[2].checked = "true";
		else
			get_by_name("ipv6_type")[0].checked = "true";
	}

	function send_request() {
		if(get_by_name("ipv6_type")[0].checked)
		{
			get_by_id("html_response_page").value="wizard_ipv6_pppoe.asp";
			get_by_id("html_response_return_page").value="wizard_ipv6_pppoe.asp";
		}
		else if(get_by_name("ipv6_type")[1].checked)
		{
			get_by_id("html_response_page").value="wizard_ipv6_static.asp";
			get_by_id("html_response_return_page").value="wizard_ipv6_static.asp";
		}
		else if(get_by_name("ipv6_type")[2].checked)
		{
			get_by_id("html_response_page").value="wizard_ipv6_6rd.asp";
			get_by_id("html_response_return_page").value="wizard_ipv6_6rd.asp";
		}

	        if(submit_button_flag == 0){
        	        submit_button_flag = 1;
                	return true;
	        }else{
        	        return false;
	        }
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
			<h1 align="left"><script>show_words(IPV6_wizard_step_1);</script></h1>
			<div align="left">
			<p class="box_msg"><script>show_words(IPv6_wizard_6);</script></p>
			<div>
			<div id=w1>
			<form id="form1" name="form1" method="post" action="apply.cgi">
				<input type="hidden" id="html_response_page" name="html_response_page" value="<% CmoGetCfg("html_response_page",""); %>">
				<input type="hidden" name="html_response_message" value="">
				<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="">
				<input type="hidden" name="reboot_type" value="none">
				<input type="hidden" id="asp_temp_42" name="asp_temp_42" value ="">

			<table align="center" class=formarea>
			<tbody>
			<tr>
				<td><input type="radio" id="ipv6_type" name="ipv6_type" value="pppoe" checked></td>
				<td><B><script>show_words(IPv6_wizard_7);</script></B></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td><script>show_words(IPV6_wizard_info_4);</script><br>&nbsp;</td>
			</tr>
			<tr>
				<td><input type="radio" id="ipv6_type" name="ipv6_type" value="static"></td>
				<td><B><script>show_words(IPv6_wizard_8);</script></B></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td><script>show_words(IPV6_wizard_info_5);</script><br>&nbsp;</td>
			</tr>
			<tr>
				<td><input type="radio" id="ipv6_type" name="ipv6_type" value="6rd"></td>
				<td><B><script>show_words(IPv6_wizard_9);</script></B></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td><script>show_words(IPV6_wizard_info_6);</script><br>&nbsp;</td>
			</tr>
			<tr align="center">
				<td>&nbsp;</td>
				<td>&nbsp;<BR>
					<input type="button" id="prev_b2" class="button_submit" name="prev_b2" value="Prev" onclick="window.location.href='wizard_ipv6_1.asp'">
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
