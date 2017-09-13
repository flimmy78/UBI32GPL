<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<script language="JavaScript" src="lingual_<% CmoGetCfg("lingual","none"); %>.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<title><% CmoGetStatus("title"); %></title>
<meta http-equiv=Content-Type content="text/html; charset=UTF8">
<meta http-equiv="REFRESH" content="<% CmoGetStatus("gui_logout"); %>">
<style type="text/css">
<!--
.style6 {
	font-size: 14px;
	font-weight: bold;
}
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
			<td id="topnavoff"><a href="index.asp"><script>show_words(_setup)</script></a></td>
			<td id="topnavoff"><a href="adv_virtual.asp"><script>show_words(_advanced)</script></a></td>
			<td id="topnavoff"><a href="tools_admin.asp"><script>show_words(_tools)</script></a></td>
			<td id="topnavoff"><a href="st_device.asp"><script>show_words(_status)</script></a></td>
			<td id="topnavon"><a href="support_men.asp"><script>show_words(_support)</script></a></td>
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
									<li><div id="sidenavoff"><script>show_words(ish_menu)</script></div></li>
									<li><div><a href="support_internet.asp"><script>show_words(_setup)</script></a></div></li>
									<li><div><a href="support_adv.asp"><script>show_words(_advanced)</script></a></div></li>
									<li><div><a href="support_tools.asp"><script>show_words(_tools)</script></a></div></li>
									<li><div><a href="support_status.asp"><script>show_words(_status)</script></a></div></li>
								</ul>
								<!-- === END SIDENAV === -->
							</div>
						</td>
					</tr>
				</table>
			</td>
			<td valign="top" id="maincontent_container">
				<div id="maincontent">
					<!-- === BEGIN MAINCONTENT === -->
				  <div id="box_header">
						<h1><script>show_words(help767s)</script></h1>
						<table border=0 cellspacing=0 cellpadding=0>
                          <tr>
                            <td>
                              <ul>
                                <li><a href="#Setup"><script>show_words(_setup)</script></a></li>
                                <li><a href="#Advanced"><script>show_words(_advanced)</script></a></li>
                                <li><a href="#Tools"><script>show_words(_tools)</script></a></li>
                                <li><a href="#Status"><script>show_words(_status)</script></a></li>
                              </ul></td>
                          </tr>
                        </table>
				  </div>

				  <div class="box">
				  <h2> <font size=4><b><a name=Setup><script>show_words(help201a)</script></a></b></font></h2>
				 	<table border=0 cellspacing=0 cellpadding=0>
                          <tr>
                            <td>
                              <ul>
                                <li><a href=support_internet.asp#Internet><script>show_words(_internetc)</script></a></li>
                                <li><a href=support_internet.asp#WAN><script>show_words(_WAN)</script></a></li>
                                <li><a href=support_internet.asp#Wireless><script>show_words(_wireless)</script></a></li>
                                <li><a href=support_internet.asp#Network><script>show_words(bln_title_NetSt)</script></a></li>
                                <!--<li><a href=support_internet.asp#USB><script>show_words(bln_title_usb)</script></a></li>-->
                            </ul></td>
                          </tr>
					</table>
				  </div>

				  <div class="box">
				  <h2><font size=4><b><a name=Advanced><script>show_words(help1)</script></a></b></font></h2>
				 	<table border=0 cellspacing=0 cellpadding=0>
                          <tr>
                            <td>
                              <ul>
                                <li><a href=support_adv.asp#Virtual_Server><script>show_words(_virtserv)</script></a></li>
                                <li><a href=support_adv.asp#Gaming><script>show_words(_pf)</script></a></li>
                                <li><a href=support_adv.asp#Special_Applications><script>show_words(_specappsr)</script></a></li>
                                <li><a href=support_adv.asp#Traffic_Shaping><script>show_words(YM48)</script></a></li>
                                <li><a href=support_adv.asp#MAC_Address_Filter><script>show_words(_netfilt)</script></a></li>
                                <li><a href=support_adv.asp#Access_Control><script>show_words(_acccon)</script></a></li>
                                <li><a href=support_adv.asp#Web_Filter><script>show_words(_websfilter)</script></a></li>
                                <li><a href=support_adv.asp#Inbound_Filter><script>show_words(_inboundfilter)</script></a></li>
                                <li><a href=support_adv.asp#Firewall><script>show_words(_firewalls)</script></a></li>
                                <li><a href=support_adv.asp#Routing><script>show_words(_routing)</script></a></li>
                                <li><a href=support_adv.asp#Advanced_Wireless><script>show_words(_adwwls)</script></a></li>
                                <li><a href=support_adv.asp#WISH >WISH</a></li>
                                <li><a href=support_adv.asp#Protected_Setup><script>show_words(LW65)</script></a></li>
                                <li><a href=support_adv.asp#Network><script>show_words(_advnetwork)</script></a></li>
                                <li><a href=support_adv.asp#GuestZone><script>show_words(_guestzone)</script></script></a></li>
                                <li><a href=support_adv.asp#ipv6>IPv6</a></li>
                                <li><a href=support_adv.asp#firewallv6><script>show_words(Tag05762)</script></a></li>
                                <li><a href=support_adv.asp#Routing><script>show_words(IPV6_routing)</script></a></li>
                            </ul></td>
                          </tr>
					</table>
				  </div>

                  <div class="box">
				  <h2><font size=4><b><a name=Tools><script>show_words(help770)</script></a></b></font></h2>
				 	<table border=0 cellspacing=0 cellpadding=0>
                          <tr>
                            <td>
                              <ul>
                                <li><a href=support_tools.asp#Admin><script>show_words(_admin)</script></a></li>
                                <li><a href=support_tools.asp#Time><script>show_words(_time)</script></a></li>
                                <li><a href=support_tools.asp#SysLog><script>show_words(help704)</script></a></li>
                                <li><a href=support_tools.asp#EMail><script>show_words(te_EmSt)</script></a></li>
                                <li><a href=support_tools.asp#System><script>show_words(_system)</script></a></li>
                                <li><a href=support_tools.asp#Firmware><script>show_words(_firmware)</script></a></li>
                                <li><a href=support_tools.asp#Dynamic_DNS><script>show_words(_dyndns)</script></a></li>
                                <li><a href=support_tools.asp#System_Check><script>show_words(_syscheck)</script></a></li>
                                <li><a href=support_tools.asp#Schedules><script>show_words(_scheds)</script></a></li>
                            </ul></td>
                          </tr>
					</table>
				  </div>

				  <div class="box">
				  <h2><font size=4><b><a name=Status><script>show_words(help771)</script></a></b></font></h2>
				 	<table border=0 cellspacing=0 cellpadding=0>
                          <tr>
                            <td>
                              <ul>
                                <li><a href=support_status.asp#15><script>show_words(_devinfo)</script></a></li>
                                <li><a href=support_status.asp#16><script>show_words(_logs)</script></a></li>
                                <li><a href=support_status.asp#17><script>show_words(_stats)</script></a></li>
                                <li><a href=support_status.asp#17_1><script>show_words(YM157)</script></a></li>
								<li><a href=support_status.asp#Wireless><script>show_words(_wireless)</script></a></li>
                                <li><a href=support_status.asp#ipv6>IPv6</a></li>
                            </ul></td>
                          </tr>
                        </table>
				  </div>
					<!-- === END MAINCONTENT === -->
                </div></td>
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
</html>