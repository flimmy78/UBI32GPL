<html>
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
		get_by_id("prev_b2").disabled = true;
		get_by_id("connect_b2").disabled = true;
	}

	function send_request(){
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
			<h1 align="left"><script>show_words(IPv6_wizard_3);</script></h1>
			<div align="left">
			<p class="box_msg"><script>show_words(IPV6_wizard_info_3);</script></p>
			<div>
			<div id=w1>
			<div align="center"></div>
			<form id="form1" name="form1" method="post" action="apply.cgi">
				<input type="hidden" name="html_response_page" id="html_response_page" value="wizard_ipv6_2.asp">
				<input type="hidden" name="html_response_message" value="">
				<input type="hidden" name="html_response_return_page" value="wizard_ipv6_2.asp">
				<input type="hidden" name="reboot_type" value="none">
				<input type="hidden" id="asp_temp_42" name="asp_temp_42" value ="wizard_ipv6_1.asp"> <!--wizard_ipv6_pre_page-->
			<table class=formarea>
			<tbody>
			<tr>
				<td width="334" height="81">
					<UL>
					<LI><script>show_words(IPV6_wizard_step_1);</script></LI>
					<LI><script>show_words(IPV6_wizard_step_2);</script></LI>
					</UL>
				</td>
			</tr>
			</tbody>
			</table>
			<br></br>

			<table align="center" class="formarea">
			<tr>
				<td>
					<input type="button" class="button_submit" id="prev_b2" name="prev_b2" value="Prev" onclick="window.location.href='ipv6.asp'">
					<input type="submit" class="button_submit" id="next_b2" name="next_b2" value="Next" onclick="return send_request()">
					<input type="button" class="button_submit" id="cancel_b2" name="cancel_b2" value="Cancel" onclick="window.location.href='ipv6.asp'">
					<input type="button" class="button_submit" id="connect_b2" name="connect_b2" value="connect">
					<script>
						get_by_id("prev_b2").value = _prev;
						get_by_id("next_b2").value = _next;
						get_by_id("cancel_b2").value = _cancel;
						get_by_id("connect_b2").value = _connect;
					</script>
				</td>
			</tr>
			</table>
			</form>
			</div>
			</div>
			</div>
			</div>
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
