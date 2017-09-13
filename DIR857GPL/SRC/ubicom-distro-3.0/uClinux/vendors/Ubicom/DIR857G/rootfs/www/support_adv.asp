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
									<li><div><a href="support_internet.asp"><script>show_words(_setup)</script></a></div></li>
									<li><div id="sidenavoff"><script>show_words(_advanced)</script></div></li>
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
				 <div id="box_header">
						<h1><script>show_words(help767s)</script></h1>
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
                                <li><a href=support_adv.asp#WISH><script>show_words(YM63)</script></a></li>
                                <li><a href=support_adv.asp#Protected_Setup><script>show_words(LW65)</script></a></li>
                                <li><a href=support_adv.asp#Network><script>show_words(_advnetwork)</script></a></li>
								<li><a href=support_adv.asp#GuestZone><script>show_words(_guestzone)</script></a></li>
								<li><a href=support_adv.asp#ipv6>IPv6</a></li>
								<li><a href=support_adv.asp#firewallv6><script>show_words(Tag05762)</script></a></li>
								<li><a href=support_adv.asp#Routing><script>show_words(IPV6_routing)</script></a></li>
							</ul></td>
                          </tr>
                        </table>
				  </div>
				  <div class="box">
				  <h2><A name=Virtual_Server><script>show_words(_virtserv)</script></A></h2>
				  <table border=0 cellspacing=0 cellpadding=0>
				  	<tr>
				  		<td>
				  		<P><script>show_words(help2)</script> </P>
			            <DIV class=help_example>
			            <DL>
			              <DT><script>show_words(help3)</script>:
			              <DD><script>show_words(help4)</script>
			              <OL>
			                <LI><script>show_words(help5)</script>
			                <LI><script>show_words(help6)</script>
			                <LI><script>show_words(help7)</script>
			                <LI><script>show_words(help8)</script>
			                <LI><script>show_words(help9)</script>
			                <LI><script>show_words(help10)</script>
			                <LI><script>show_words(help11)</script>
			                <LI><script>show_words(help12)</script>
			                </LI></OL><script>show_words(help13)</script></DD></DL></DIV>
			            <DL>
			              <DT><script>show_words(help14_p)</script>
			              <DD>
			              <DL>
			                <DT><script>show_words(_name)</script>
			                <DD><script>show_words(help17)</script>
			                <DT><script>show_words(_ipaddr)</script>
			                <DD><script>show_words(help18)</script><script>show_words(help18_a)</script>
			                <DT><script>show_words(av_traftype)</script>
			                <DD><script>show_words(help19)</script><script>show_words(help19x1)</script><script>show_words(help19x2)</script>
			                <DT><script>show_words(av_PriP)</script>
			                <DD><script>show_words(help20)</script>
			                <DT><script>show_words(av_PubP)</script>
			                <DD><script>show_words(help21)</script>
			                <DT><script>show_words(_inboundfilter)</script>
			                <DD><script>show_words(help22)</script>
			                <DT><script>show_words(_sched)</script>
			                <DD><script>show_words(help23)</script></DD>
			              </DL>
			              <DT>24 -- <script>show_words(av_title_VSL)</script>
			              <DD><script>show_words(help25_b)</script> </DD></DL>
			            <P><B><script>show_words(help26)</script>:</B> <script>show_words(help27)</script>
			            </P>
			            <P><script>show_words(help28)</script></P>
			            <P><script>show_words(help29)</script>
			            </P>
			            <P><script>show_words(help30)</script></P>
				  		</td>
                    </tr>
				  </table>
				  </div>
				  <div class="box">
				  <h2><A name=Gaming><script>show_words(_pf)</script></A></h2>
				  <table border=0 cellspacing=0 cellpadding=0>
				  	<tr>
				  		<td>
				  		<P><script>show_words(help57)</script></P>
			            <P><script>show_words(help58)</script> <BR clear=none><script>show_words(help59)</script>
						 <BR clear=none><script>show_words(help60)</script> </P>
			            <DIV class=help_example>
			            <DL>
			              <DT><script>show_words(help3)</script>:
			              <DD><script>show_words(help63)</script> </DD></DL></DIV>
			            <DL>
			              <DT><script>show_words(help60f)</script>
			              <DD>
			              <DL>
			                <DT><script>show_words(_name)</script>
			                <DD><script>show_words(help65)</script>
			                <DT><script>show_words(_ipaddr)</script>
			                <DD><script>show_words(help66)</script>
			                <DT><script>show_words(help67)</script>
			                <DD><script>show_words(help68)</script>
			                <DT><script>show_words(help69)</script>
			                <DD><script>show_words(help70)</script>
			                <DT><script>show_words(_inboundfilter)</script>
			                <DD><script>show_words(help71)</script>
			                <DT><script>show_words(_sched)</script>
			                <DD><script>show_words(help72)</script>
			                </DD></DL>
			              <DIV class=help_example>
			              <P><script>show_words(help74)</script></P></DIV>
			              <P><script>show_words(KR53)</script> </P>
			              <DT>24 -- <script>show_words(ag_title_4)</script>
			              <DD><script>show_words(help75a)</script> </DD></DL>
				  		</td>
				  	</tr>
				  </table>
				  </div>
				  <div class="box">
				  <h2><A name=Special_Applications> <script>show_words(_specappsr)</script></A></h2>
				  <table border=0 cellspacing=0 cellpadding=0>
				  	<tr>
				  		<td>
				  			<P><script>show_words(help46)</script> </P>
				            <DL>
				              <DT><script>show_words(haar_p)</script>
				              <DD>
				              <DIV class=help_example>
				              <DL>
				                <DT><script>show_words(help3)</script>:
				                <DD><script>show_words(help47)</script>
				              </DD></DL></DIV>
				              <DL>
				                <dt><script>show_words(_name)</script></dt>
				                <dd>
                                  <script>show_words(help48)</script>
                                   </dd>
				                <dt>
				                  <script>show_words(_app)</script>
				                  </dt>
				                <dd>
                                  <script>show_words(help48a)</script>
                                   </dd>
				                <dt>
				                  <script>show_words(as_TPRange_b)</script>
				                  </dt>
				                <dd>
                                  <script>show_words(help49)</script>
                                   </dd>
				                <dt>
				                  <script>show_words(as_TPrt)</script>
				                 </dt>
				                <dd>
                                  <script>show_words(help50)</script>
                                   </dd>
				                <dt>
				                  <script>show_words(as_IPR_b)</script>
				                  </dt>
				                <dd>
                                  <script>show_words(help51)</script>
                                   </dd>
				                <DT>
				                <dt><script>show_words(as_FPrt)</script></dt>
				                <dd>
                                  <script>show_words(help52)</script>
                                  </dd>
				                <dt>
				                  <script>show_words(_sched)</script>
				                  </dt>

				                <DD><script>show_words(help53)</script> </DD></DL>
				              <DIV class=help_example>
				              <P><script>show_words(help55)</script></P></DIV></DD></DL>
				            <DL>
				              <DT>24 -- <script>show_words(_specappsr)</script>
				              <DD><script>show_words(help56_a)</script>
								<script>show_words(help75a)</script>
				            </DD></DL>
				  		</td>
                    </tr>
				  </table>
				  </div>
				  <div class="box">
				  <h2><A name=Traffic_Shaping><script>show_words(YM48)</script></A></h2>
				  <table border=0 cellspacing=0 cellpadding=0>
				  	<tr>
				  		<td>
				  			<P><script>show_words(help76)</script> </P>
            <DL>
              <DT><script>show_words(at_title_Traff)</script>
              <DD>
              <DL>
                <dt><script>show_words(at_ETS)</script> </dt>
                <dd>
                  <script>show_words(KR107)</script>
                   </dd>
                <dt>
                  <script>show_words(at_AUS)</script>
                  </dt>
                <dd>
                  <script>show_words(help81)</script>
                  </dd>
                <dt>
                  <script>show_words(at_MUS)</script>
                  </dt>
                <dd>
                  <script>show_words(help82)</script>
                   </dd>
                <dt>
                  <script>show_words(at_UpSp)</script>
                  </dt>
                <dd>
                  <script>show_words(help83)</script>
                  </dd>
                <DT><!--DT><script>show_words(_contype)</script>
                <DD><script>show_words(help84)</script>
                <DT><script>show_words(help85)</script>
                <DD><script>show_words(help86)</script> </DD--></DL>
              <dt><script>show_words(at_title_SESet)</script></dt>
              <dd>
                <dl>
                  <dt>
                    <script>show_words(at_ESE)</script>
                    </dt>
                  <dd>
                    <script>show_words(help78)</script>
                     </dd>
                  <dt>
                    <script>show_words(at_AC)</script>
                    </dt>
                  <dd>
                    <script>show_words(help79)</script>

                    <script>show_words(at_intro_2)</script>
                     </dd>
                  <dt>
                    <script>show_words(at_DF)</script>
                    </dt>
                  <dd>
                    <script>show_words(help80)</script>
                    </dd>
                </dl>
              </dd>
              <DT><DD>
              <dt><script>show_words(at_title_SERules)</script></dt>
              <dd>
                <script>show_words(help88)</script>
                <script>show_words(help88b)</script>

                <p>
                  <script>show_words(help88c)</script>
                   </p>
              </dd>
              <DT><DD><DL>
                <dt><script>show_words(_name)</script></dt>
                <dd>
                  <script>show_words(help90)</script>
                  </dd>
                <dt>
                  <script>show_words(_priority)</script>
                  </dt>
                <dd>
                  <script>show_words(help91)</script>
                   </dd>
                <dt>
                  <script>show_words(_protocol)</script>
                  </dt>
                <dd>
                  <script>show_words(help92)</script>
                  </dd>
                <dt>
                  <script>show_words(at_LoIPR)</script>
                  </dt>
                <dd>
                  <script>show_words(help93)</script>
                  </dd>
                <dt>
                  <script>show_words(at_LoPortR)</script>
                  </dt>
                <dd>
                  <script>show_words(help94)</script>
                  </dd>
                <dt>
                  <script>show_words(at_ReIPR)</script>
                 </dt>
                <dd>
                  <script>show_words(help95)</script>
                  </dd>
                <dt>
                  <script>show_words(at_RePortR)</script>
                  </dt>
                <dd>
                  <script>show_words(help96)</script>
                 </dd>
                <DT></DL>
              <DT>10 -- <script>show_words(at_title_SERules)</script>
              <DD><script>show_words(help99_s)</script>
  				  <script>show_words(help75a)</script>
            	</DD></DL>
				  		</td>
                    </tr>
				  </table>
				  </div>
				  <div class="box">
				  <h2><A name=MAC_Address_Filter><script>show_words(_macfilt)</script> (<script>show_words(_netfilt)</script>)</A></h2>
				  <table border=0 cellspacing=0 cellpadding=0>
				  	<tr>
				  		<td>
				  			<P><script>show_words(help149)</script></P>

                <DL>
                  <DT>24 --
                    <script>show_words(am_MACFILT)</script>

                  <DD>
                    <DL>
                      <DT>
                        <script>show_words(am_intro_2)</script>

                      <DD>
                        <script>show_words(help155_2)</script>

                      <DT>
                        <script>show_words(_macaddr)</script>

                      <DD>
                        <script>show_words(help161_2)</script>

                        <script>show_words(hham_add)</script>

                      <DT>
                        <script>show_words(_clear)</script>

                      <DD>
                        <script>show_words(ham_del)</script>
                        </DD>
                    </DL>
                  </DD>
                </DL>
				  		</td>
				  	</tr>
				  </table>
				  </div>

        <div class="box">
          <h2><A name=Access_Control>
            <script>show_words(_acccon)</script>
            </A></h2>
				  <table border=0 cellspacing=0 cellpadding=0>
				  <tr>

              <td> <P>
                  <script>show_words(help117)</script>
                </P>

                <DL>
                  <DT>
                    <script>show_words(_enable)</script>
                  <DD>
                    <script>show_words(help118)</script>
                    <P><B>
                      <script>show_words(help119)</script>
                      : </B>
                      <script>show_words(help120)</script>
                    </P>
                  <DT>
                    <script>show_words(_aa_pol_wiz)</script>
                  <DD>
                    <script>show_words(help121)</script>
                    <DL>
                      <DT>
                        <script>show_words(_aa_pol_add)</script>
                      <DD>
                        <script>show_words(_501_12)</script>
                      </DD>
                    </DL>
                  <DT>
                    <script>show_words(aa_Policy_Table)</script>
                  <DD>
                    <script>show_words(help140)</script>
                  </DD>
                </DL>
				  	</td>
                    </tr>
				  </table>
				  </div>

        <div class="box">
          <h2><A name=Web_Filter>
            <script>show_words(_websfilter)</script>
            </A></h2>
				  <table border=0 cellspacing=0 cellpadding=0>
				  	<tr>

              <td> <P>
                  <script>show_words(help141)</script>
                  <script>show_words(help141_a)</script>
                  </P>

                <DL>
                  <DT>
                    <script>show_words(awsf_p)</script>
                    <DD>
                    <DL>
                      <DT>
                        <script>show_words(aa_WebSite_Domain)</script>

                      <DD>
                        <script>show_words(dlink_help145)</script>

                        <P><B>
                          <script>show_words(help119)</script>
                         </B>
                          <script>show_words(dlink_help146)</script>

                        </P>
                      </DD>
                    </DL>
                  </DD>
                </DL>

                <DL>
                  <DT>40 --
                    <script>show_words(awf_title_WSFR)</script>

                  <DD>
                    <script>show_words(dlink_help148)</script>

                  </DD>
                </DL>			  		  </td>
                    </tr>
				  </table>
				  </div>

        <div class="box">
          <h2><A name=Inbound_Filter>
            <script>show_words(_inboundfilter)</script>
           </A></h2>
				  <table border=0 cellspacing=0 cellpadding=0>
				  	<tr>

              <td> <p>
                  <script>show_words(help168a)</script>
                   </p>

                <p>
                  <script>show_words(help169)</script>
                   </p>

                <dl>
                  <dt>
                    <script>show_words(help170)</script>

                  <dd>
                    <script>show_words(help171)</script>

                    <dl>
                      <dt>
                        <script>show_words(_name)</script>

                      <dd>
                        <script>show_words(help172)</script>

                      <dt>
                        <script>show_words(ai_Action)</script>

                      <dd>
                        <script>show_words(help173)</script>

                      <dt>
                        <script>show_words(at_ReIPR)</script>

                      <dd>
                        <script>show_words(help174)</script>

                      <dt>
                        <script>show_words(KR56)</script>

                      <dd>
                        <script>show_words(help175)</script>

                      <dt>
                        <script>show_words(_clear)</script>

                      <dd>
                        <script>show_words(KR57)</script>
                         </dd>
                    </dl>
                  <dt>
                    <script>show_words(ai_title_IFRL)</script>

                  <dd>
                    <script>show_words(help176)</script>

                    <p>
                      <script>show_words(help177)</script>
                      </p>
                    <dl>
                      <dt>
                        <script>show_words(_allowall)</script>

                      <dd>
                        <script>show_words(help178)</script>

                      <dt>
                        <script>show_words(_denyall)</script>

                      <dd>
                        <script>show_words(help179)</script>

                      </dd>
                    </dl>
                  </dd>
                </dl></td>
				  	</tr>
				  </table>
				  </div>

        <div class="box">
          <h2><A id=Firewall name=Firewall>
            <script>show_words(_firewalls)</script>
           </A></h2>
				  <table border=0 cellspacing=0 cellpadding=0>
				  	<tr>

              <td> <P>
                  <script>show_words(haf_intro_1)</script>

                  <script>show_words(haf_intro_2)</script>
                  </P>

                <DT>
                  <script>show_words(af_ES)</script>

                <DD>
                  <script>show_words(help164)</script>
                  <script>show_words(help164_1)</script>

                  <P>
                  <script>show_words(help164_2)</script>
                  </P>
                </DD>

                <!-- DT>
                  <script>show_words(_neft)</script>

                <DD>
                  <P>
                    <script>show_words(YM133)</script>
                    </P>
                  <DL>
                    <DT>
                      <script>show_words(af_EFT_0)</script>

                    <DD>
                      <script>show_words(YM134)</script>

                    <DT>
                      <script>show_words(af_EFT_1)</script>

                    <DD>
                      <script>show_words(YM135)</script>

                    <DT>
                      <script>show_words(af_EFT_2)</script>

                    <DD>
                      <script>show_words(YM136)</script>

                    </DD>
                  </DL>
                  <P>
                    <script>show_words(YM137)</script>
                     </P>
                  <DL>
                    <DT>
                      <script>show_words(af_UEFT)</script>

                    <DD>
                      <script>show_words(YM138)</script>

                    <DT>
                      <script>show_words(af_TEFT)</script>

                    <DD>
                      <script>show_words(YM139)</script>

                    </DD>
                  </DL>
                  <P>
                    <script>show_words(KR54)</script>

                    <script>show_words(KR55)</script>
                     </P -->
                <DT>
                  <script>show_words(KR105)</script>

                <DD>
                  <P>
                    <script>show_words(KR108)</script>
                    </P>
                <DT>
                  <script>show_words(_dmzh)</script>

                <DD>
                  <P>
                    <script>show_words(help165)</script>

                  </P>
                  <P>
                    <script>show_words(haf_dmz_10)</script>
                   </P>
                  <P>
                    <script>show_words(haf_dmz_20)</script>

                  </P>
                  <P>
                    <script>show_words(haf_dmz_30)</script>
                     </P>
                  <P>
                    <script>show_words(haf_dmz_40)</script>

                  </P>
                  <P>
                    <script>show_words(haf_dmz_50)</script>
                    </P>
                  <UL>
                    <LI>
                      <script>show_words(haf_dmz_60)</script>

                    <LI>
                      <script>show_words(haf_dmz_70)</script>
                      </LI>
                  </UL>
                  <DL>
                    <DT>
                      <script>show_words(af_ED)</script>

                    <DD>
                      <P><B>
                        <script>show_words(help26)</script>
                        </B>
                        <script>show_words(help166)</script>
                         </P>
                    <DT>
                      <script>show_words(af_DI)</script>

                    <DD>
                      <script>show_words(help167)</script>
                       </DD>
                  </DL>
                  <!--DT><script>show_words(af_gss)</script>Non-UDP/TCP/ICMP LAN Sessions
			              <DD>
			              <P><script>show_words(LW48)</script>When a LAN application that uses a protocol other than UDP,
			              TCP, or ICMP initiates a session to the Internet, the router's NAT
			              can track such a session, even though it does not recognize the
			              protocol. This feature is useful because it enables certain
			              applications (most importantly a single VPN connection to a remote
			              host) without the need for an ALG. </P>
			              <P>Note that this feature does not apply to the DMZ host (if one
			              is enabled). The DMZ host always handles these kinds of sessions.
			              </P>
			              <DL>
			                <DT>Enable
			                <DD>Enabling this option (the default setting) enables single
			                VPN connections to a remote host. (But, for multiple VPN
			                connections, the appropriate VPN ALG must be used.) Disabling
			                this option, however, only disables VPN if the appropriate VPN
			                ALG is also disabled. </DD></DL-->

			              <DT><script>show_words(af_algconfig)</script>
			              <DD><script>show_words(help32)</script>
			              <DL>
			                <DT><script>show_words(_PPTP)</script>
			                <DD><script>show_words(help33)</script>
			                 <script>show_words(help33b)</script>
							<DT><script>show_words(as_IPSec)</script>
			                <DD><script>show_words(help34)</script>
			                <P><script>show_words(help35)</script></P>
			                <P><script>show_words(help34b)</script></P>
			                <DT><script>show_words(as_RTSP)</script>
			                <DD><script>show_words(help36)</script>
			                <!--DT>Windows/MSN Messenger
			                <DD>Supports use on LAN computers of Microsoft Windows Messenger
			                (the Internet messaging client that ships with Microsoft
			                Windows) and MSN Messenger. The SIP ALG must also be enabled
			                when the Windows Messenger ALG is enabled.
			                <DT>FTP
			                <DD>Allows FTP clients and servers to transfer data across NAT.
			                Refer to the
                              <a href="adv_virtual.asp">Advanced&rarr;Virtual&nbsp;Server</a>
			                page if you want to host an FTP server.
			                <DT>H.323 (Netmeeting)
			                <DD>Allows H.323 (specifically Microsoft Netmeeting) clients to
			                communicate across NAT. Note that if you want your buddies to
			                call you, you should also set up a virtual server for
			                NetMeeting. Refer to the <A
			                href="adv_virtual.asp">Advanced&rarr;Virtual Server</A> page for information on how to set up a
			                virtual server.<-->
			                <DT><script>show_words(as_SIP)</script>
			                <DD><script>show_words(help40)</script>
			                <!--DT>Wake-On-LAN
			                <DD>This feature enables forwarding of "magic packets" (that is,
			                specially formatted wake-up packets) from the WAN to a LAN
			                computer or other device that is "Wake on LAN" (WOL) capable.
			                The WOL device must be defined as such on the <A
			                href="adv_virtual.asp">Advanced&rarr;Virtual Server</A> page. The LAN IP address for the virtual
			                server is typically set to the broadcast address 192.168.0.255.
			                The computer on the LAN whose MAC address is contained in the
			                magic packet will be awakened.
			                <DT>MMS
			                <DD>Allows Windows Media Player, using MMS protocol, to receive
	                  streaming media from the internet. </DD></DL></DD></DL-->
              </td>
                    </tr>
                  </table>
				  </div>
				  <div class="box">
				  <h2><A name=Routing><script>show_words(_routing)</script></A></h2>
				  <table border=0 cellspacing=0 cellpadding=0>
				  <tr>
				  	<td>
				  		  <DT><script>show_words(_enable)</script>
			              <DD><script>show_words(help103)</script>
			              <DT><script>show_words(help104)</script>
			              <DD><script>show_words(help105)</script>
			              <!--DT><script>show_words(aw_RT)</script>
			              <DD>
			              <script>show_words(LW51)</script>
			              <script>show_words(LW52)</script>
			              <script>show_words(help180)</script-->
			              <DT><script>show_words(_netmask)</script>
			              <DD><script>show_words(help107)</script>
			              <DT><script>show_words(_gateway)</script>
			              <DD><script>show_words(help109)</script>

			              <DT><script>show_words(_metric)</script>
			              <DD><script>show_words(help113)</script>
			              <DT><script>show_words(help110)</script>

                <DD><script>show_words(help111)</script>
                 </td>
                    </tr>
				  </table>
				  </div>
        <div class="box">
          <h2><A name=Advanced_Wireless>
            <script>show_words(_adwwls)</script>
            </A></h2>
				  <table border=0 cellspacing=0 cellpadding=0>
				  <tr>

              <td> <DL>
                  <DT>
                    <script>show_words(aw_TP)</script>

                  <DD>
                    <script>show_words(help187)</script>

                  <!--
                  <DT>
                    <script>show_words(aw_BP)</script>

                  <DD>
                    <script>show_words(help184)</script>

                  <DT>
                    <script>show_words(aw_RT)</script>

                  <DD>
                    <script>show_words(LW51)</script>

                  <DT>
                    <script>show_words(aw_FT)</script>

                  <DD>
                    <script>show_words(LW53)</script>

                    <script>show_words(LW54)</script>

                    <script>show_words(help180)</script>

                    <script>show_words(help181)</script>

                  <DT>
                    <script>show_words(aw_DI)</script>

                  <DD>
                    <script>show_words(help185)</script>
                  -->

                    <!-- <DT><script>show_words(aw_dE)</script>802.11d Enable
			              <DD><script>show_words(help186)</script>Enables 802.11d operation. 802.11d is a wireless specification
			              for operation in additional regulatory domains. This supplement to
			              the 802.11 specifications defines the physical layer requirements
			              (channelization, hopping patterns, new values for current MIB
			              attributes, and other requirements to extend the operation of
			              802.11 WLANs to new regulatory domains (countries). The current
			              802.11 standard defines operation in only a few regulatory domains
			              (countries). This supplement adds the requirements and definitions
			              necessary to allow 802.11 WLAN equipment to operate in markets not
			              served by the current standard. Enable this option if you are
			              operating in one of these "additional regulatory domains". -->
                  <DT>
                    <script>show_words(KR4_ww)</script>

                  <DD>
                    <script>show_words(KR58_ww)</script>

                  <DT>
                    <script>show_words(aw_WE)</script>

                  <DD>
                    <script>show_words(help188_wmm)</script>

                  <DT>
                    <script>show_words(aw_sgi)</script>

                  <DD>
                    <script>show_words(aw_sgi_h1)</script>

                    <script>show_words(_worksbest)</script>

                  <!--DT>
                    <script>show_words(aw_erpe)</script>

                  <DD>
                    <script>show_words(aw_erpe_h)</script>

                    <script>show_words(aw_erpe_h2)</script>
                     <script>show_words(aw_erpe_h3)</script> </DD-->
                </DL>
				  	</td>
                    </tr>
				  </table>
				  </div>
				
				  <div class="box">
                    <h2><A name=WISH><script>show_words(YM63)</script></A></h2>
                    <table border=0 cellspacing=0 cellpadding=0>
                      <tr>

              <td> <P>
                  <script>show_words(YM140)</script>
                   </P>

                <DL>
                  <DT>
                    <script>show_words(YM63)</script>

                  <DD>
                    <DL>
                      <DT>
                        <script>show_words(YM73)</script>

                      <DD><script>show_words(YM141)</script>
                         </DD>
                    </DL>
                  <DT>
                    <script>show_words(YM74)</script>

                  <DD>
                    <DL>
                      <DT>
                        <script>show_words(gw_vs_1)</script>

                      <DD>
                        <script>show_words(YM142)</script>

                      <DT>
                        <script>show_words(YM75)</script>

                      <DD>
                        <script>show_words(help80b)</script>

                      <DT>
                        <script>show_words(YM76)</script>

                      <DD>
                        <script>show_words(YM143)</script>
                         </DD>
                    </DL>
                  <DT>
                    <script>show_words(YM77)</script>

                  <DD>
                    <script>show_words(YM144)</script>

                    <script>show_words(YM145)</script>

                    <P>
                      <script>show_words(YM146)</script>
                     </P>
                    <DL>
                      <DT>
                        <script>show_words(_name)</script>

                      <DD>
                        <script>show_words(help90)</script>

                      <DT>
                        <script>show_words(_priority)</script>

                      <DD>
                        <script>show_words(YM147)</script>

                        <UL>
                          <LI>BK:
                            <script>show_words(YM148)</script>

                          <LI>BE:
                            <script>show_words(YM149)</script>

                          <LI>VI:
                            <script>show_words(YM150)</script>

                          <LI>VO:
                            <script>show_words(YM151)</script>
                           </LI>
                        </UL>
                      <DT>
                        <script>show_words(_protocol)</script>

                      <DD>
                        <script>show_words(help92)</script>

                      <DT>
                        <script>show_words(YM82)</script>

                      <DD>
                        <script>show_words(YM152)</script>

                      <DT>
                        <script>show_words(YM83)</script>

                      <DD>
                        <script>show_words(YM153)</script>

                      <DT>
                        <script>show_words(YM84)</script>

                      <DD>
                        <script>show_words(YM154)</script>

                      <DT>
                        <script>show_words(YM85)</script>

                      <DD>
                        <script>show_words(YM155)</script>
                        </DD>
                    </DL>
                  <DT>24 --
                    <script>show_words(YM77)</script>

                  <DD>
                    <script>show_words(YM156)</script>

                    <script>show_words(help75a)</script>
                     </DD>
                </DL></td>
                      </tr>
                    </table>
			      </div> 
				  <div class="box">
				  <h2><A name=Protected_Setup><script>show_words(LW4)</script></A></h2>
				  <table border=0 cellspacing=0 cellpadding=0>
				  <tr>

            <td> <DL>
                <DT>
                  <script>show_words(LW4)</script>

                <DD>
                  <DL>
                    <DT>
                      <script>show_words(_enable)</script>

                    <DD>
                      <script>show_words(LW55)</script>

                    <DT>
                      <script>show_words(LY4)</script>

                    <DD>
                      <script>show_words(LY29)</script>
                       </DD>
                  </DL>
                <DT>
                  <script>show_words(LW7)</script>

                <DD>
                  <P>
                    <script>show_words(LW57)</script>
                    </P>
                  <DL>
                    <DT>
                      <script>show_words(LW9)</script>

                    <DD>
                      <script>show_words(LW58)</script>

                    <DT>
                      <script>show_words(LW10)</script>

                    <DD>
                      <script>show_words(LW59)</script>

                    <DT>
                      <script>show_words(LW11)</script>

                    <DD>
                      <script>show_words(LW60)</script>
                      </DD>
                  </DL>
                <DT>
                  <script>show_words(LW12)</script>

                <DD>
                  <P>
                    <script>show_words(LW61)</script>
                    </P>
                  <P>
                    <script>show_words(LW62)</script>
                   </P>
                  <P>
                    <script>show_words(LW63)</script>
                    </P>
                  <DL>
                    <DT>
                      <script>show_words(LW13)</script>

                    <DD>
                      <script>show_words(LW64)</script>
                      </DD>
                  </DL>
                </DD>
              </DL>
				  	</td>
                    </tr>
				  </table>
				  </div-->




					<!-- === END MAINCONTENT === -->
                </div>

				<div class="box">
				  <h2><A name=Network><script>show_words(_advnetwork)</script></A></h2>
				  <table border=0 cellspacing=0 cellpadding=0>
				  <tr>

              <td> <DL>
                  <DT>
                    <script>show_words(ta_upnp)</script>

                  <DD>
                    <script>show_words(help_upnp_1)</script>

                    <DL>
                      <DT>
                        <script>show_words(ta_EUPNP)</script>

                      <DD>
                        <script>show_words(help_upnp_2)</script>
                       </DD>
                    </DL>
                  <DT>
                    <script>show_words(anet_wan_ping)</script>

                  <DD>
                    <script>show_words(anet_wan_ping_1)</script>

                    <DL>
                      <DT>
                        <script>show_words(bwn_RPing)</script>

                      <DD>
                        <script>show_words(anet_wan_ping_2)</script>
                       </DD>
                    </DL>
                  <DT>
                    <script>show_words(anet_wan_phyrate)</script>

                  <DD>
                    <script>show_words(help296)</script>

                  <DT>
                    <script>show_words(anet_multicast)</script>

                  <DD>
                    <script>show_words(bln_IGMP_title_h)</script>

                    <DL>
                      <DT>
                        <script>show_words(anet_multicast_enable)</script>

                      <DD>
                        <script>show_words(igmp_e_h)</script>
                        </DD>
                    </DL>
                  </DD>
                </DL>
				  	</td>
                    </tr>
				  </table>
				  </div>
				  <div class="box">
            <h2><a name="GuestZone"><script>show_words(_guestzone)</script></a></h2>
            <dl>
                <dt><script>show_words(guestzone_title_1)</script></dt>
                <dd>
                    <p><script>show_words(IPV6_TEXT5)</script></p>
                    <dl>
                        <dt><script>show_words(guestzone_enable)</script></dt>
                        <dd><script>show_words(IPV6_TEXT6)</script></dd>

                        <dt><script>show_words(bwl_NN)</script></dt>
                        <dd><script>show_words(IPV6_TEXT7)</script></dd>
                        <dt><script>show_words(IPV6_TEXT3)</script></dt>
                        <dd><script>show_words(IPV6_TEXT8)</script></dd>
                        <dt><script>show_words(bws_WSMode)</script></dt>
                        <dd><script>show_words(IPV6_TEXT9)</script></dd>
                        <dt><script>show_words(_WEP)</script></dt>
                        <dd><script>show_words(IPV6_TEXT10)</script></dd>
                        <dl>
                            <dt><script>show_words(auth)</script></dt>
                            <dd><script>show_words(IPV6_TEXT11)</script></dd>
                            <dt><script>show_words(_both)</script></dt>
                            <dd><script>show_words(IPV6_TEXT12)</script></dd>
                            <dt><script>show_words(bws_Auth_2)</script></dt>
                            <dd><script>show_words(IPV6_TEXT13)</script></dd>
                            <dt><script>show_words(IPV6_TEXT19)</script></dt>
                            <dd><script>show_words(IPV6_TEXT14)</script></dd>
                            <dt><script>show_words(IPV6_TEXT18)</script></dt>
                            <dd><script>show_words(IPV6_TEXT15)</script></dd>
                            <dt><script>show_words(IPV6_TEXT16)</script></dt>
                            <dd><script>show_words(IPV6_TEXT17)</script></dd>
                        </dl>
                                <p><script>show_words(help371_n)</script></p>
                        </dd>
                        <dt><script>show_words(help372)</script></dt>
                        <dd>
                            <p><script>show_words(help373)</script></p>
                            <p>
                                <span class="option"><script>show_words(help374)</script>: </span>
                                <script>show_words(help375)</script>
                            </p>
                            <p>
                                <span class="option"><script>show_words(help376)</script>: </span>
                                <script>show_words(help377)</script>
                            </p>
                            <p>
                                <span class="option"><script>show_words(bws_GKUI)</script>: </span>
                                <script>show_words(help379)</script>
                             </p>
                        </dd>
                        <dt><script>show_words(_WPApersonal)</script></dt>
                        <dd>
                            <p><script>show_words(help380)</script> </p>
                            <p>
                                <span class="option"><script>show_words(_psk)</script>: </span>
                                <script>show_words(help382)</script>
                            </p>
                            <div class="help_example">
                        <dl>
                                    <dt><script>show_words(help367)</script>: </dt>
                                    <dd><code><script>show_words(help383)</script></code></dd>
                        </dl>
                            </div>
                        </dd>
                        <dt><script>show_words(_WPAenterprise)</script></dt>
                        <dd>
                            <p><script>show_words(help384)</script> </p>
                            <p>
                                <span class="option"><script>show_words(help385)</script>: </span>
                                <script>show_words(help386)</script>
                            </p>
                            <p>
                                <span class="option"><script>show_words(help387)</script>: </span>
                                <script>show_words(help388)</script>
                            </p>
                            <p>
                                <span class="option"><script>show_words(bws_RSP)</script>: </span>
                                <script>show_words(help390)</script>
                            </p>
                            <p>
                                 <span class="option"><script>show_words(bws_RSSs)</script>: </span>
                                <script>show_words(help392)</script>
                            </p>
                            <p>
                                <span class="option"><script>show_words(bws_RMAA)</script>: </span>
                                <script>show_words(help394)</script>
                            </p>
                            <p><span class="option"><script>show_words(help395)</script>: </span></p>
                        <dl>
                                <dt><script>show_words(help396)</script></dt>
                                <dd>
                                    <script>show_words(help397)</script>
                                </dd>
                        </dl>
                        </dd>
                    </dl>
                </dd>

            </dl>
        </div>
				  <div class="box">

          <h2><A name=ipv6>Ipv6</A></h2>
				  <table border=0 cellspacing=0 cellpadding=0>
				  <tr>

              <td>
                  <DT>IPv6
                  <DD><script>show_words(IPV6_TEXT76)</script>

                  <DT><script>show_words(IPV6_TEXT29a)</script>

                <DD><script>show_words(IPV6_TEXT77)</script>
                  <DL>
                    <DT><script>show_words(IPV6_TEXT78)</script>
                    <DD><script>show_words(IPV6_TEXT79)</script> </DD>
                  </DL>
                  <DL>
                    <DT><script>show_words(IPV6_TEXT80)</script>
                    <DD><script>show_words(IPV6_TEXT81)</script> </DD>
                  </DL>
                  <DL>
                    <DT><script>show_words(IPV6_TEXT82)</script>
                    <DD><script>show_words(IPV6_TEXT83)</script> </DD>
                  </DL>
                  <!--DL>
                      <DT><script>show_words(IPV6_TEXT84)</script>
                      <DD><script>show_words(IPV6_TEXT85)</script> </DD>
                    </DL-->
                  <DL>
                    <DT><script>show_words(_PPPoE)</script>
                    <DD><script>show_words(IPV6_TEXT86)</script> </DD>
                    <DD>
                      <P><SPAN class=option><script>show_words(carriertype_ct_0)</script>: </SPAN><script>show_words(IPV6_TEXT87)</script> </P>
                    <DD>
                      <P><SPAN class=option><script>show_words(_sdi_staticip)</script>: </SPAN><script>show_words(IPV6_TEXT88)</script></SPAN> </P>
                    <DD>
                      <P><SPAN class=option><script>show_words(_srvname)</script>: </SPAN><script>show_words(help267)</script> </P>
                    <DD>
                      <P><SPAN class=option><script>show_words(bwn_RM)</script>: </SPAN><script>show_words(help269)</script>: </P>
                      <UL>
                        <LI><SPAN class=option><script>show_words(bwn_RM_0)</script>: </SPAN><script>show_words(help271)</script>
                        <LI><SPAN class=option><script>show_words(bwn_RM_1)</script>: </SPAN><script>show_words(help273)</script>
                        <LI><SPAN class=option><script>show_words(bwn_RM_2)</script>: </SPAN><script>show_words(help275)</script> </LI>
                      </UL>
                      <P><SPAN class=option><script>show_words(help276)</script>: </SPAN><script>show_words(IPV6_TEXT89)</script> </P>
                    <dt>&nbsp; </dt>
                  </DL>
                  <DL>
                  <DT><script>show_words(IPV6_TEXT90);</script> 
                  <DD><script>show_words(IPV6_TEXT91);</script> 
                  </DL>
                  <DL>
                    <DT><script>show_words(IPV6_TEXT92);</script>
                    <DD><script>show_words(IPV6_TEXT93);</script> </DD>
                    <br>
                    <DD><script>show_words(help288);</script></DD>
                    <br>
                    <DD><script>show_words(IPV6_TEXT94)</script></DD>
                  </DL>
                <DT><script>show_words(IPV6_TEXT44)</script>

                <DD><script>show_words(IPV6_TEXT95)</script></DD>
                <DT><script>show_words(_LAN)</script> <script>show_words(IPV6_TEXT48)</script>

                <DD><script>show_words(IPV6_TEXT96)</script></DD>
                <DD>
                  <dl>
                    <DT><script>show_words(IPV6_TEXT50)</script>
                    <DD><script>show_words(IPV6_TEXT97)</script> </DD>
                    <DD><script>show_words(IPV6_TEXT98)</script></DD>
                    <DD><script>show_words(IPV6_TEXT99)</script></DD>
                    <DT><script>show_words(IPV6_TEXT100)</script>
                    <DD><script>show_words(IPV6_TEXT101)</script> </DD>
                    <DD><script>show_words(IPV6_TEXT102)</script> </DD>
                    <DT><script>show_words(IPV6_TEXT56)</script>
                    <DD><script>show_words(IPV6_TEXT103)</script></DD>
                  </dl>
                </DD>


				  	</td>
                    </tr>
				  </table>
				  </div>
				  
				   <div class="box">

          <h2><A name=firewallv6>IPv6</A></h2>
				  <table border=0 cellspacing=0 cellpadding=0>
				  <tr>

              <td>
                  <DT>IPv6 FIREWALL
                  <DD>For each rule you can create a name and control the direction of traffic. You can also allow or deny a range of IP Addresses, the protocol and a port range.In order to apply a schedule to a firewall rule, your must first define a schedule on the Tools &rarr; Schedules page
                  </DD>
				  	  </td>
         </tr>
				  </table>
				  </div>
				  
				  
				</td>
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
</html>
