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
									<li><div><a href="support_adv.asp"><script>show_words(_advanced)</script></a></div></li>
									<li><div id="sidenavoff"><script>show_words(_tools)</script></div></li>
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
          <h1>
            <script>show_words(help770)</script>
          </h1>
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
          <h2><A name=Admin>
            <script>show_words(_admin)</script>
            </A></h2>
				  	<table border=0 cellspacing=0 cellpadding=0>
				  		<tr>

              <td> <P>
                  <script>show_words(ta_intro_Adm)</script>
                </P>

                <DL>
                  <DT>
                    <script>show_words(_password_admin)</script>
                  <DD>
                    <script>show_words(help824)</script>
                  <DT>
                    <script>show_words(_password_user)</script>
                  <DD>
                    <script>show_words(help825)</script>
                  <DT>
                    <script>show_words(ta_GWN)</script>
                  <DD>
                    <script>show_words(help827)</script>
                  <DT>
                    <script>show_words(ta_ERM)</script>
                  <DD>
                    <script>show_words(help828)</script>
                  <DT>
                    <script>show_words(ta_RAP)</script>
                  <DD>
                    <script>show_words(help829)</script>
                  <DT>
                    <script>show_words(help830)</script>
<DD>
                    <script>show_words(help831)</script>
                  </DD>
                </DL>
				  			</td>
                      </tr>
                    </table>
				  </div>
				 <div class="box">
				  <h2><A name=Time><script>show_words(_time)</script></A></h2>
				  	<table border=0 cellspacing=0 cellpadding=0>
				  		<tr>

              <td> <P>
                  <script>show_words(help840)</script>
                </P>

                <DL>
                  <DT>
                    <script>show_words(tt_TimeConf)</script>
                  <DD>
                    <DL>
                      <DT>
                        <script>show_words(tt_CurTime)</script>
                      <DD>
                        <script>show_words(help841a)</script>
                      <DT>
                        <script>show_words(tt_TimeZ)</script>
                      <DD>
                        <script>show_words(help841)</script>
                      <DT>
                        <script>show_words(tt_dsen2)</script>
                      <DD>
                        <script>show_words(help843)</script>
                      <DT>
                        <script>show_words(tt_dsoffs)</script>
                      <DD>
                        <script>show_words(help844)</script>
                      <DT>
                        <script>show_words(help845)</script>
                      <DD>
                        <script>show_words(help846)</script>
                      </DD>
                    </DL>
                  <DT>
                    <script>show_words(tt_auto)</script>
                  <DD>
                    <DL>
                      <DT>
                        <script>show_words(tt_EnNTP)</script>
                      <DD>
                        <script>show_words(help848)</script>
                        <P>
                          <script>show_words(YM163)</script>
                        </P>
                      <DT>
                        <script>show_words(tt_NTPSrvU)</script>
                      <DD>
                        <script>show_words(help850)</script>
                      </DD>
                    </DL>
                  <DT>
                    <script>show_words(tt_StDT)</script>
                  <DD>
                    <script>show_words(help851)</script>
                  </DD>
                </DL>

                <P><B>
                  <script>show_words(help119)</script>
                   </B>
                  <script>show_words(help852)</script>
                </P>
				  			</td>
				  		</tr>
					</table>
				  </div>

				 <div class="box">
				  <h2><A name=SysLog><script>show_words(help704)</script></A></h2>
				  	<table border=0 cellspacing=0 cellpadding=0>
					     <tr>

              <td> <P>
                  <script>show_words(help856)</script>
                </P>

                <DL>
                  <DT>
                    <script>show_words(help857)</script>
                  <DD>
                    <script>show_words(help858)</script>
                  <DT>
                    <script>show_words(tsl_SLSIPA)</script>
                  <DD>
                    <script>show_words(help859)</script>
                  </DD>
                </DL>
                            </td>
                      </tr>
					</table>
				  </div>

				  <div class="box">
				  <h2><A name=EMail><script>show_words(te_EmSt)</script></A></h2>
				  	<table border=0 cellspacing=0 cellpadding=0>
					  <tr>

              <td> <P>
                  <script>show_words(te_intro_Em)</script>
                </P>

                <DL>
                  <DT>
                    <script>show_words(_enable)</script>
                  <DD>
                    <DL>
                      <DT>
                        <script>show_words(te_EnEmN)</script>
                      <DD>
                        <script>show_words(help860)</script>
                      </DD>
                    </DL>
                  <DT>
                    <script>show_words(te_EmSt)</script>
                  <DD>
                    <DL>
                      <DT>
                        <script>show_words(te_FromEm)</script>
                      <DD>
                        <script>show_words(help861)</script>
                      <DT>
                        <script>show_words(te_ToEm)</script>
                      <DD>
                        <script>show_words(help862)</script>
                      <DT>
                        <script>show_words(te_SMTPSv)</script>
                      <DD>
                        <script>show_words(help863)</script>
                      <DT>
                        <script>show_words(te_EnAuth)</script>
                      <DD>
                        <script>show_words(help864)</script>
                      <DT>
                        <script>show_words(te_Acct)</script>
                      <DD>
                        <script>show_words(help865)</script>
                      <DT>
                        <script>show_words(_password)</script>
                      <DD>
                        <script>show_words(help866)</script>
                      <DT>
                        <script>show_words(_verifypw)</script>
                      <DD>
                        <script>show_words(help867)</script>
                      </DD>
                    </DL>
                  <DT>
                    <script>show_words(help868)</script>
                  <DD>
                    <DL>
                      <DT>
                        <script>show_words(te_OnFull)</script>
                      <DD>
                        <script>show_words(help869)</script>
                      <DT>
                        <script>show_words(te_OnSch)</script>
                      <DD>
                        <script>show_words(help870)</script>
                      <DT>
                        <script>show_words(_sched)</script>
                      <DD>
                        <script>show_words(help872)</script>
                        <P><B>
                          <script>show_words(help119)</script>
                          : </B>
                          <script>show_words(help873)</script>
                        </P>
                      </DD>
                    </DL>
                  </DD>
                </DL>
						 </td>
                      </tr>
					</table>
				  </div>

				  <div class="box">
				  <h2><A name=System><script>show_words(_system)</script></A></h2>
				  	<table border=0 cellspacing=0 cellpadding=0>
				  		<tr>

              <td> <P>
                  <script>show_words(help874)</script>
                </P>

                <DL>
                  <DT>
                    <script>show_words(help_ts_ss)</script>
                  <DD>
                    <script>show_words(help833)</script>
                  <DT>
                    <script>show_words(help_ts_ls)</script>
                  <DD>
                    <script>show_words(help834)</script>
                  <DT>
                    <script>show_words(help_ts_rfd)</script>
                  <DD>
                    <script>show_words(help876)</script>
                  <DT>
                    <script>show_words(ts_rd)</script>
                  <DD>
                    <script>show_words(help875)</script>
                  </DD>
                </DL>
                            </td>
                      </tr>
					</table>
				  </div>

				  <div class="box">
				  <h2><A name=Firmware><script>show_words(_firmware)</script></A></h2>
				  	<table border=0 cellspacing=0 cellpadding=0>
				  		<tr>

              <td>
                <P>
                  <script>show_words(tf_intro_FWU)</script>
                  <!--<script>show_words(help877)</script>
                  <script>show_words(help877a)</script>-->
                </P>

                <P>
                  <script>show_words(help878)</script>
                  : </P>

                <OL>
                  <LI>
                    <script>show_words(help879)</script>
                  <LI>
                    <script>show_words(help880)</script>
                  <LI>
                    <script>show_words(help881)</script>
                  <LI>
                    <script>show_words(help882)</script>
                  </LI>
                </OL>

                <DL>
                  <DT>
                    <script>show_words(help882)</script>
                  <DD>
                    <P>
                      <script>show_words(help883)</script>
                    </P>
                  <DT>
                    <script>show_words(tf_FWUg)</script>
                  <DD>
                    <P><B>
                      <script>show_words(help119)</script>
                      : </B>
                      <script>show_words(help886)</script>
                    </P>
                    <P><B>
                      <script>show_words(help119)</script>
                      : </B>
                      <script>show_words(help887)</script>
                    </P>
                    <DL>
                      <DT>
                        <script>show_words(tf_Upload)</script>
                      <DD>
                        <script>show_words(help888)</script>
                      </DD>
                    </DL>
                  <!--DT>
                    <script>show_words(tf_FUNO)</script>
                  <DD>
                    <DL>
                      <DT>
                        <script>show_words(tf_AutoCh)</script>

                      <DD>
                        <script>show_words(help889)</script>
                      <DT>
                        <script>show_words(tf_EmNew)</script>

                      <DD>
                        <script>show_words(help890)</script>
                      </DD>
                    </DL>
                  </DD>
                </DL-->
				  			</td>
                      </tr>
					</table>
				  </div>

				  <div class="box">
				  <h2><A name=Dynamic_DNS><script>show_words(_dyndns)</script></A></h2>
				  	<table border=0 cellspacing=0 cellpadding=0>
				  		<tr>

              <td> <P>
                  <script>show_words(help891)</script>
                </P>

                <DL>
                  <DT>
                    <script>show_words(td_EnDDNS)</script>
                  <DD>
                    <script>show_words(help892)</script>
                  <DT>
                    <script>show_words(td_SvAd)</script>
                  <DD>
                    <script>show_words(help893)</script>
                  <DT>
                    <script>show_words(_hostname)</script>
                  <DD>
                    <script>show_words(help894)</script>
                  <DT>
                    <script>show_words(td_UNK)</script>
                  <DD>
                    <script>show_words(help895)</script>
                  <DT>
                    <script>show_words(td_PWK)</script>
                  <DD>
                    <script>show_words(help896)</script>
                  <DT>
                    <script>show_words(td_VPWK)</script>
                  <DD>
                    <script>show_words(help897)</script>
                  <DT>
                    <script>show_words(td_Timeout)</script>
                  <DD>
                    <script>show_words(help898)</script>
                  </DD>
                  <DT>
                    <script>show_words(_status)</script>
                  <DD>
                    <script>show_words(help901)</script>
                  </DD>                  
                </DL>

                <P><B>
                  <script>show_words(help119)</script>
                  :
                  <script>show_words(help899)</script>
                  </B></P>

                <P><B>
                  <script>show_words(help119)</script>
                  : </B>
                  <script>show_words(help900)</script>
                </P>
				  			</td>
                      </tr>
					</table>
				  </div>

				  <div class="box">
				  <h2><A name=System_Check><script>show_words(_syscheck)</script></A></h2>
				  	<table border=0 cellspacing=0 cellpadding=0>
					  <tr>

              <td> <dl>
                  <dt>
                    <script>show_words(tsc_pingt)</script>
                  </dt>
                  <dd>
                    <p>
                      <script>show_words(htsc_intro)</script>
                    </p>
                    <dl>
                      <dt>
                        <script>show_words(tsc_pingt_h)</script>
                      </dt>
                      <dd>
                        <script>show_words(htsc_pingt_h)</script>
                      </dd>
                      <dt>
                        <script>show_words(_ping)</script>
                      </dt>
                      <dd>
                        <script>show_words(htsc_pingt_p)</script>
                      </dd>
                      <dt>
                        <script>show_words(_stop)</script>
                      </dt>
                      <dd>
                        <script>show_words(htsc_pingt_s)</script>
                      </dd>
                    </dl>
                    <div class="help_example">
                      <dl>
                        <dt>
                          <script>show_words(help367)</script>
                          : </dt>
                        <dd>
                          <dl>
                            <dt>
                              <script>show_words(tsc_pingt_h)</script>
                            </dt>
                            <dd>www.whitehouse.gov</dd>
                            <dt>
                              <script>show_words(tsc_pingr)</script>
                            </dt>
                            <dd>
                              <pre xml:space="preserve">
	<script>show_words(_success)</script> </pre>
                            </dd>
                          </dl>
                        </dd>
                      </dl>
                    </div>
                  </dd>
                </dl>
                        </td>
                      </tr>
					</table>
				  </div>

				  <div class="box">
				  <h2><A name=Schedules><script>show_words(_scheds)</script></A></h2>
				  <table border=0 cellspacing=0 cellpadding=0>
				  	<tr>

              <td> <P>
                  <script>show_words(help190)</script>
                </P>

                <DL>
                  <DT>
                    <script>show_words(KR95)</script>
                  <DD>
                    <script>show_words(help192)</script>
                    <DL>
                      <DT>
                        <script>show_words(_name)</script>
                      <DD>
                        <script>show_words(help193)</script>
                      <DT>
                        <script>show_words(tsc_Days)</script>
                      <DD>
                        <script>show_words(help194)</script>
                      <DT>
                        <script>show_words(tsc_24hrs)</script>
                      <DD>
                        <script>show_words(help195)</script>
                      <DT>
                        <script>show_words(tsc_StrTime)</script>
                      <DD>
                        <script>show_words(help196)</script>
                      <DT>
                        <script>show_words(tsc_EndTime)</script>
                      <DD>
                        <script>show_words(help197)</script>
                      <DT>
                        <script>show_words(_save)</script>
                      <DD>
                        <script>show_words(KR96)</script>
                      </DD>
                    </DL>
                  <DT>
                    <script>show_words(tsc_SchRuLs)</script>
                  <DD>
                    <script>show_words(help199)</script>
                  </DD>
                </DL>
				  		</td>
                    </tr>
                   </table>
				  </div>

					<!-- === END MAINCONTENT === -->
                </div></td>
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