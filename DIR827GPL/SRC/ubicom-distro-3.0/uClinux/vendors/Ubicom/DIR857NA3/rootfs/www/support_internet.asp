<html>
<head>
<script language="JavaScript" src="lingual_<% CmoGetCfg("lingual","none"); %>_tmp.js"></script>
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
							<div id=sidenav> 
							<!-- === BEGIN SIDENAV === -->
								<ul>
									<li><div><a href="support_men.asp"><script>show_words(ish_menu)</script></a></div></li>
									<li><div id="sidenavoff"><script>show_words(_setup)</script></div></li>
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
					<h1><script>show_words(help201a)</script></h1>
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
						<h2><A id=Internet name=Internet><script>show_words(_internetc)</script></a></h2>
						<table border=0 cellspacing=0 cellpadding=0>
							  <tr>
				                <td>
				                	<DL>
						              <DT><script>show_words(wwa_setupwiz)</script> 
						              <DD>
						              <P><script>show_words(bi_wiz)</script></P>
						              <DT><script>show_words(int_LWlsWz)</script> 
						              <DD>
						              <P><script>show_words(bi_man)</script> </P>
						              </DD></DL>
				                </td>
							  </tr>
				        </table>
					</div>
				<div class="box">
					<h2><A id=WAN name=WAN><script>show_words(_WAN)</script></A></h2>
					<table border=0 cellspacing=0 cellpadding=0>
			 		<tr>
                       <td>
                       <P><script>show_words(help254)</script> </P>
			            <DL>
			              <DT><script>show_words(bwn_ict)</script> 
			              <DD>
			              <P><script>show_words(help254_ict)</script> 
			              </P>
			              <DL>
			                <DT><script>show_words(bwn_SWM)</script> 
			                <DD><script>show_words(help255)</script> <SPAN class=option><script>show_words(help256)</script></SPAN>, <SPAN class=option><script>show_words(help703)</script></SPAN>, <SPAN 
			                class=option><script>show_words(_gateway)</script></SPAN>, <SPAN class=option><script>show_words(_dns1)</script></SPAN>, <script>show_words(help257)</script> <SPAN class=option><script>show_words(_dns2)</script></SPAN>. <script>show_words(help258)</script> 
			                <DT><script>show_words(bwn_DWM)</script> 
			                <DD><script>show_words(help259)</script> 
			                <P><SPAN class=option><script>show_words(_hostname)</script>: </SPAN><script>show_words(help261)</script></P>
			                <P><SPAN class=option><script>show_words(_use_unicasting)</script>: </SPAN><script>show_words(help261a)</script> </P>
			                <!--<P><SPAN class=option><script>show_words(help262)</script>:</SPAN>  <script>show_words(help263)</script>
			                <SPAN class=option><script>show_words(bwn_BPS)</script></SPAN>, <SPAN 
			                class=option><script>show_words(bwn_BPU)</script></SPAN>, <script>show_words(help257)</script> <SPAN 
			                class=option><script>show_words(bwn_BPP)</script></SPAN>. </P>-->
			                <DT> <script>show_words(_PPPoE)</script>
			                <DD><script>show_words(help265)</script> <script>show_words(bw_sap)</script>
			                <P><SPAN class=option><script>show_words(carriertype_ct_0)</script>: </SPAN><script>show_words(help265_7)</script> </P>
			                <P><SPAN class=option><script>show_words(_sdi_staticip)</script>: </SPAN><script>show_words(help265_2)</script> <SPAN class=option><script>show_words(_ipaddr)</script></SPAN>. </P>
			                <P><SPAN class=option><script>show_words(_srvname)</script>: </SPAN><script>show_words(help267)</script> </P>
			                <P><SPAN class=option><script>show_words(help268)</script>: </SPAN><script>show_words(help269)</script>: </P>
			                <UL>
			                  <LI><SPAN class=option><script>show_words(help270)</script>: </SPAN><script>show_words(help271)</script> 
			                  <LI><SPAN class=option><script>show_words(help272)</script>: </SPAN><script>show_words(help273)</script> 
			                  <LI><SPAN class=option><script>show_words(help274)</script>: </SPAN><script>show_words(help275)</script> 
			                  </LI></UL>
			                <P><SPAN class=option><script>show_words(help276)</script>: </SPAN><script>show_words(help277)</script> </P>
			                <DT><script>show_words(_PPTP)</script> 
			                <DD><script>show_words(help278)</script> <script>show_words(bw_sap)</script> 
			                <P><SPAN class=option><script>show_words(carriertype_ct_0)</script>: </SPAN><script>show_words(help265_7)</script> </P>
			                <P><SPAN class=option><script>show_words(_sdi_staticip)</script>: </SPAN><script>show_words(help265_5)</script>: <SPAN class=option><script>show_words(_PPTPip)</script></SPAN>, <SPAN class=option><script>show_words(help279)</script> </SPAN>, <script>show_words(help257)</script> 
			                <SPAN class=option><script>show_words(_PPTPgw)</script></SPAN>. </P>
			                <P><SPAN class=option><script>show_words(bwn_PPTPSIPA)</script>: </SPAN><script>show_words(help280)</script> </P>
			                <P><SPAN class=option><script>show_words(help268)</script>: </SPAN><script>show_words(help282)</script>: </P>
			                <UL>
			                  <LI><SPAN class=option><script>show_words(help270)</script>: </SPAN><script>show_words(help271)</script> 
			                  <LI><SPAN class=option><script>show_words(help272)</script>: </SPAN><script>show_words(help273)</script> 
			                  <LI><SPAN class=option><script>show_words(help274)</script>: </SPAN><script>show_words(help275)</script> 
			                  </LI></UL>
			                <P><SPAN class=option><script>show_words(help276)</script>: </SPAN><script>show_words(help283)</script> </P>
			                <DT><script>show_words(_L2TP)</script> 
			                <DD><script>show_words(help284)</script> <script>show_words(bw_sap)</script> 
			                <P><SPAN class=option><script>show_words(carriertype_ct_0)</script>: </SPAN><script>show_words(help265_7)</script> </P>
			                <P><SPAN class=option><script>show_words(_sdi_staticip)</script>: </SPAN><script>show_words(help265_5)</script>: <SPAN class=option><script>show_words(_L2TPip)</script></SPAN>, <SPAN class=option><script>show_words(help285)</script> </SPAN>, <script>show_words(help257)</script> 
			                <SPAN class=option><script>show_words(_L2TPgw)</script></SPAN>. </P>
			                <P><SPAN class=option><script>show_words(bwn_L2TPSIPA)</script>: </SPAN><script>show_words(help280)</script> </P>
			                
                        <P><SPAN class=option><script>show_words(help268)</script>: </SPAN><script>show_words(help286)</script>: </P>
			                <UL>
			                  <LI><SPAN class=option><script>show_words(help270)</script>: </SPAN><script>show_words(help271)</script> 
			                  <LI><SPAN class=option><script>show_words(help272)</script>: </SPAN><script>show_words(help273)</script>
			                  <LI><SPAN class=option><script>show_words(help274)</script>: </SPAN><script>show_words(help275)</script>
			                  </LI></UL>
			                <P><SPAN class=option><script>show_words(help276)</script>: </SPAN><script>show_words(help287)</script> </P></DD></DL>
			              <DT> 
			              <DD>
			              <P><script>show_words(help288)</script> </P>
			              <!--IFDEF	OPENDNS-->
						  <P><span class=option><script>show_words(_sp_title_AdvDNS)</script> :</span>
								<P><script>show_words(ADNS_HELP1)</script></P>
								<P><script>show_words(ADNS_HELP2)</script></P>
								<P><script>show_words(ADNS_HELP3)</script></P>
						  </P>
						<!--ENDIF OPENDNS-->
			              <P><SPAN class=option><script>show_words(help289a)</script>: 
			              </SPAN><script>show_words(help290a)</script> </P>
			              <P><SPAN class=option><script>show_words(help293)</script>:</SPAN> <script>show_words(help294)</script> </P>
			              <P><SPAN class=option><script>show_words(help605)</script>:</SPAN> <script>show_words(help302)</script> <script>show_words(help304)</script> 
						</P></DD>
						<!--DT> <script>show_words(usb_3g)</script>
			                <DD><script>show_words(usb_3g_help)</script> 
							<DT><script>show_words(_support)</script> 
							<DD><script>show_words(usb_3g_help_support_help)</script-->
						</DL>
                       </td>
                    </tr>
					</table>
				</div>
				<div class="box">
					<h2><A id=Wireless name=Wireless><script>show_words(_wireless)</script></a></h2>
					<table border=0 cellspacing=0 cellpadding=0>
						 <tr>
		                   <td>
								<P><script>show_words(help349)</script> </P>
						            <P><script>show_words(help350)</script> </P>
						            <DL>
						              <DT><script>show_words(bwl_EW)</script> 
						              <DD><script>show_words(help351)</script>
						              <DT><script>show_words(bwl_NN)</script> 
						              <DD><script>show_words(help352)</script> 
						              <DT><script>show_words(ebwl_AChan)</script> 
						              <DD><script>show_words(help354)</script> 
						              <DT><script>show_words(_wchannel)</script> 
						              <DD><script>show_words(help355)</script> <!-- super_G -->
						              <DT><script>show_words(bwl_Mode)</script> 
						              <DD><script>show_words(help357)</script> 
						              <DT><script>show_words(bwl_CWM)</script> 
						              <DD><script>show_words(bwl_CWM_h1)</script> <script>show_words(bwl_CWM_h2)</script> 
						              <!--DT><script>show_words(bwl_TxR)</script> 
						              <DD><script>show_words(help356)</script--> 
						
						              <DT><script>show_words(bwl_VS)</script> 
						              <DD><script>show_words(help353)</script> 
						              <DT><script>show_words(bws_SM)</script> 
						              <DD><script>show_words(bws_SM_h1)</script> 
						              <DT><script>show_words(_WEP)</script> 
						              <DD>
						              <P><script>show_words(help366)</script> </P>
						              <DIV class=help_example>
						              <DL>
						                <DT><script>show_words(help367)</script>: 
						                <DD><script>show_words(help368)</script>
						                <DD><script>show_words(help369)</script>
						                <DD><script>show_words(help370)</script>
						                <DD><script>show_words(help371)</script> </DD></DL></DIV>
						              <P><script>show_words(help371_n)</script> </P>
						              <DT><script>show_words(help372)</script> 
						              <DD>
						              <P><script>show_words(help373)</script> </P>
						              <P><SPAN class=option><script>show_words(help374)</script>: </SPAN><script>show_words(help375)</script> </P>
						              <P><SPAN class=option><script>show_words(help378)</script>: </SPAN><script>show_words(help379)</script> </P>
						              <DT><script>show_words(_WPApersonal)</script> 
						              <DD>
						              <P><script>show_words(help380)</script> </P>
						              <P><SPAN class=option><script>show_words(_psk)</script>: </SPAN><script>show_words(help382)</script> </P>
						              <DIV class=help_example>
						              <DL>
						                <DT><script>show_words(help367)</script>: 
						                <DD><CODE><script>show_words(help383)</script></CODE> </DD></DL></DIV>
						              <DT><script>show_words(_WPAenterprise)</script> 
						              <DD>
						              <P><script>show_words(help384)</script> </P>
						              <P><SPAN class=option><script>show_words(help385)</script>: </SPAN><script>show_words(help386)</script> </P>
						              <P><SPAN class=option><script>show_words(help387)</script>: </SPAN><script>show_words(help388)</script> </P>
						              <P><SPAN class=option><script>show_words(help389)</script>: </SPAN><script>show_words(help390)</script> </P>
						              <P><SPAN class=option><script>show_words(help391)</script>: </SPAN><script>show_words(help392)</script> </P>
						              <P><SPAN class=option><script>show_words(help393)</script>: </SPAN><script>show_words(help394)</script> </P>
						              <P><SPAN class=option><script>show_words(help395)</script>: </SPAN></P>
						              <DL>
						                <DT><script>show_words(help396)</script> 
						                <DD><script>show_words(help397)</script> </DD></DL></DD></DL>
							</td>
		                  </tr>
		            </table>
			    </div>
				<div class="box">
					<h2><A id=Network name=Network><script>show_words(bln_title)</script></A></h2>
						<table border=0 cellspacing=0 cellpadding=0>
						<tr>
                            <td>
                            
                            	<DL><!-- No Bridge issue 2007.05.08 -->
					              <DT><script>show_words(bln_title_Rtrset)</script> 
					              <DD><script>show_words(help305)</script> <script>show_words(help305rt)</script>
					              <DL>
					                <DT><script>show_words(help256)</script> 
					                <DD><script>show_words(help307)</script> 
					                <DT><script>show_words(help703)</script> 
					                <DD><script>show_words(help309)</script> 
					                <DT><script>show_words(DEVICE_NAME)</script> 
					                <DD><script>show_words(DEVICE_DESC)</script>									
					                <DT><script>show_words(_262)</script> 
					                <DD><script>show_words(_1044)</script> <script>show_words(_1044a)</script> 
					                <DT><script>show_words(bln_title_DNSRly)</script> 
					                <DD><script>show_words(help312dr2)</script></DD></DL><!--  No Bridge issue 2007.05.18
																		<p>If WAN Port Mode is set to "Bridge Mode", the following choices are displayed in place of the above choices, because the device is functioning as a bridge in a network that contains another router.</p>
					
																		<dl>
					
																		<dt>Router IP Address</dt>
																			<dd>The IP address of the this device on the local area network. 
																		Assign any unused IP address in the range of IP addresses available for the LAN.
																		For example, 192.168.0.101.</dd>
					
																		<dt>Subnet Mask</dt>
																			<dd>The subnet mask of the local area network.</dd>
					
																		<dt>Gateway</dt>
																			<dd>The IP address of the <span>rou</span><span>ter</span> on the local area network.
																				For example, 192.168.0.1.</dd>
																		<dt>
																			Primary DNS Server, Secondary DNS Server</dt>
																		<dd>
											Enter the IP addresses of the DNS Servers. Leave the field for the secondary server empty if not used.
											</dd>
					
																		</dl>
																		-->
					              <DT><script>show_words(bd_title_DHCPSSt)</script> 
					              <DD>
					              <P><script>show_words(help314)</script> </P>
					              <DL>
					                <DT><script>show_words(bd_EDSv)</script> 
					                <DD>
					                <P><script>show_words(help316)</script> </P>
					                <P><script>show_words(help317)</script> </P>
					                <P><script>show_words(help318)</script> </P>
					                <DT><script>show_words(bd_DIPAR)</script> 
					                <DD><script>show_words(help319)</script> 
					                <P><script>show_words(help320)</script> </P>
					                <P><script>show_words(help321)</script> </P>
					                <DIV class=help_example>
					                <DL>
					                  <DT><script>show_words(help367)</script>: 
					                  <DD><script>show_words(help322)</script> 
					                  <DT><script>show_words(help367)</script>: 
					                  <DD><script>show_words(help323)</script> </DD></DL></DIV>
					                <DT><script>show_words(bd_DLT)</script> 
					                <DD><script>show_words(help324)</script> 
					                <DT><script>show_words(help325)</script> 
					                <DD><script>show_words(help326)</script> 
					                <DT><script>show_words(bd_NETBIOS)</script> 
					                <DD><script>show_words(help400_b)</script> <script>show_words(help400_1)</script> 
					                <DT><script>show_words(bd_NETBIOS_WAN)</script> 
					                <DD><script>show_words(help401_b)</script> <script>show_words(help401_1)</script> 
					
					                <DT><script>show_words(bd_NETBIOS_WINS_1)</script> 
					                <DD><script>show_words(help402_b)</script> <script>show_words(help402_1)</script> <script>show_words(help402_2)</script> 
					                <DT><script>show_words(bd_NETBIOS_WINS_2)</script> 
					                <DD><script>show_words(help403_b)</script> 
					                <script>show_words(help402_2)</script> 
					                <DT><script>show_words(bd_NETBIOS_SCOPE)</script> 
					                <DD><script>show_words(help404_b)</script> <script>show_words(help402_2)</script> 
					                <DT><script>show_words(bd_NETBIOS_REG)</script> 
					                <DD><script>show_words(help405_b)</script><BR><script>show_words(help405_1)</script><BR><script>show_words(help405_2)</script><BR><script>show_words(help405_3)</script><BR><script>show_words(help405_4)</script><BR><script>show_words(help402_2)</script><BR></DD></DL>
					              <DT><A id="Static_DHCP" name="Static_DHCP"><script>show_words(help330)</script></A> 
					              <DD>
					              <P><script>show_words(help331)</script> </P>
					              <DL>
					                <DT><script>show_words(bd_CName)</script> 
					                <DD>
					                <P><script>show_words(help345)</script> <script>show_words(help367)</script>: <CODE><script>show_words(help346)</script></CODE>. </P>
					                <DT><script>show_words(_ipaddr)</script>: 
					                <DD><script>show_words(_1066)</script> 
					                <DT><script>show_words(_macaddr)</script> 
					                <DD>
					                <P></P><script>show_words(help333)</script> </P>
					                <P><script>show_words(help334)</script> </P>
					                <P><script>show_words(help335)</script>: </P>
					                <TABLE summary="">
					                  <TBODY>
					                  <TR>
					                    <TD width="20%"><script>show_words(help336)</script> <BR clear=none><script>show_words(help337)</script> </TD>
					                    <TD><script>show_words(help338)</script> </TD></TR>
					                  <TR>
					                    <TD width="20%"><script>show_words(help339)</script> <BR clear=none><script>show_words(help340)</script> </TD>
					                    <TD><script>show_words(help341)</script> </TD></TR>
					                  <TR>
					                    <TD width="20%"><script>show_words(help342)</script> </TD>
					                    <TD><script>show_words(help343)</script> </TD></TR></TBODY></TABLE></DD></DL>
					              <DT><script>show_words(bd_title_list)</script> 
					              <DD><script>show_words(help348)</script> 
					              <DT><script>show_words(bd_title_clients)</script> 
					              <DD>
					              <P><script>show_words(help327)</script> </P>
					              <DL>
					                <DT><script>show_words(bd_Revoke)</script> 
					                <DD><script>show_words(help329)</script> 
					                <DT><script>show_words(bd_Reserve)</script> 
					                <DD><script>show_words(help329_rsv)</script> </DD></DL></DD></DL>
                            </td>
                        </tr>
					</table>
				</div>
<!--div class="box">
                                                                                    <h2><a id="USB" name="USB"><script>show_words(bln_title_usb)</script></a></h2>
                                                                                    <dl>
                                                                                        <dt><script>show_words(_sharePort)</script></dt>
                                                                                        <dd><script>show_words(usb_network_help)</script>
                                                                                            <dl>
                                                                                                <dt><script>show_words(_support)</script></dt>
                                                                                                <dd><script>show_words(usb_network_support_help)</script></dd>
                                                                                            </dl>
                                                                                        </dd>
                                                                                        <dt><script>show_words(usb_3g)</script></dt>
                                                                                        <dd><script>show_words(usb_3g_help)</script>
                                                                                            <dl>
                                                                                                <dt><script>show_words(_support)</script></dt>
                                                                                                <dd><script>show_words(usb_3g_help_support_help)</script></dd>
                                                                                            </dl>
                                                                                        </dd>
                                                                                        <dt><script>show_words(usb_wcn)</script></dt>
                                                                                        <dd><script>show_words(usb_wcn_help)</script></dd>
                                                                                    </dl>
                                                                              </div-->
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