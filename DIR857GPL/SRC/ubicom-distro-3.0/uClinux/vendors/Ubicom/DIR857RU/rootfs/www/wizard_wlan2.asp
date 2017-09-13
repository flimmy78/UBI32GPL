<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<title><% CmoGetStatus("title"); %></title>
<script language="JavaScript" src="lingual_<% CmoGetCfg("lingual","none"); %>.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript">
    var submit_button_flag = 0;
	function show_encryption(){
		var security = get_by_id("asp_temp_35").value;
		var security_1 = get_by_id("asp_temp_68").value;
		
		get_by_id("show_disable").style.display = "none";
		get_by_id("show_wep").style.display = "none";
		get_by_id("show_wpa").style.display = "none";
		get_by_id("show_wpa2_auto").style.display = "none";
		get_by_id("show_disable_1").style.display = "none";
		get_by_id("show_wep_1").style.display = "none";
		get_by_id("show_wpa_1").style.display = "none";
		get_by_id("show_wpa2_auto_1").style.display = "none";
		if (security == "1"){
			get_by_id("show_wep").style.display = "";
		}else if (security != "0"){			
			if (security == "3"){
				get_by_id("show_wpa2_auto").style.display = "";
			}else{
				get_by_id("show_wpa").style.display = "";
			}
		}else{
			get_by_id("show_disable").style.display = "";
		}
		
		if (security_1 == "1"){
			get_by_id("show_wep_1").style.display = "";
		}else if (security_1 != "0"){			
			if (security_1 == "3"){
				get_by_id("show_wpa2_auto_1").style.display = "";
			}else{
				get_by_id("show_wpa_1").style.display = "";
			}
		}else{
			get_by_id("show_disable_1").style.display = "";
		}
	}

	function send_request(){
        var security = get_by_id("asp_temp_35").value;
		var security_1 = get_by_id("asp_temp_68").value;
		//2.4G
        if(security == "0"){
            get_by_id("wlan0_security").value= "disable";
            get_by_id("wps_configured_mode").value = 1;
        }else if(security == "1"){
            var key_word = get_by_id("asp_temp_37").value;
            get_by_id("wlan0_wep_default_key").value= "1";
            if(key_word.length > 10){
                get_by_id("wlan0_security").value= "wep_open_128";
                if(get_by_id("asp_temp_36").value == "ascii"){
                    get_by_id("wlan0_wep128_key_1").value= hex_to_a(get_by_id("asp_temp_37").value);
                }else{
                    get_by_id("wlan0_wep128_key_1").value= get_by_id("asp_temp_37").value;
                }
            }else{
                get_by_id("wlan0_security").value= "wep_open_64";
                if(get_by_id("asp_temp_36").value == "ascii"){
                    get_by_id("wlan0_wep64_key_1").value= hex_to_a(get_by_id("asp_temp_37").value);
                }else{
                    get_by_id("wlan0_wep64_key_1").value= get_by_id("asp_temp_37").value;
                }
            }
            get_by_id("wlan0_wep_display").value= "<% CmoGetCfg("asp_temp_36","none"); %>";
			get_by_id("disable_wps_pin").value = 1;
            get_by_id("wps_configured_mode").value = 5;
        }else if(security == "2"){
            get_by_id("wlan0_security").value= "wpa_psk";
            get_by_id("wlan0_psk_pass_phrase").value= get_by_id("asp_temp_37").value;
            get_by_id("wlan0_psk_cipher_type").value= "both";
			get_by_id("disable_wps_pin").value = 1;
            get_by_id("wps_configured_mode").value = 5;
        }else if(security == "3"){
            get_by_id("wlan0_security").value= "wpa2auto_psk";
            get_by_id("wlan0_psk_pass_phrase").value= get_by_id("asp_temp_37").value;
            get_by_id("wlan0_psk_cipher_type").value= "both";
			get_by_id("disable_wps_pin").value = 1;
            get_by_id("wps_configured_mode").value = 5;
        }else{
            alert("security error");
        }
		
        if(get_by_id("asp_temp_36").value=="ascii"){
            get_by_id("asp_temp_37").value = hex_to_a(get_by_id("asp_temp_37").value);
        }

		//5GHz
		
		if(security_1 == "0"){
			get_by_id("wlan1_security").value= "disable";
			get_by_id("wps_configured_mode").value = 1;
		}else if(security_1 == "1"){
			var key_word_1 = get_by_id("asp_temp_70").value;
			get_by_id("wlan1_wep_default_key").value= "1";
			if(key_word_1.length > 10){
				get_by_id("wlan1_security").value= "wep_open_128";
				if(get_by_id("asp_temp_69").value == "ascii"){
					get_by_id("wlan1_wep128_key_1").value= hex_to_a(get_by_id("asp_temp_70").value);
				}else{
					get_by_id("wlan1_wep128_key_1").value= get_by_id("asp_temp_70").value;
				}
			}else{
				get_by_id("wlan1_security").value= "wep_open_64";
				if(get_by_id("asp_temp_69").value == "ascii"){
					get_by_id("wlan1_wep64_key_1").value= hex_to_a(get_by_id("asp_temp_70").value);
				}else{
					get_by_id("wlan1_wep64_key_1").value= get_by_id("asp_temp_70").value;
				}
			}
			get_by_id("wlan1_wep_display").value= "<% CmoGetCfg("asp_temp_69","none"); %>";
                        get_by_id("disable_wps_pin").value = 1;
			get_by_id("wps_configured_mode").value = 5;
		}else if(security_1 == "2"){
			get_by_id("wlan1_security").value= "wpa_psk";
			get_by_id("wlan1_psk_pass_phrase").value= get_by_id("asp_temp_70").value;
			get_by_id("wlan1_psk_cipher_type").value= "both";
                        get_by_id("disable_wps_pin").value = 1;
			get_by_id("wps_configured_mode").value = 5;	
		}else if(security_1 == "3"){
			get_by_id("wlan1_security").value= "wpa2auto_psk";
			get_by_id("wlan1_psk_pass_phrase").value= get_by_id("asp_temp_70").value;
			get_by_id("wlan1_psk_cipher_type").value= "both";
                        get_by_id("disable_wps_pin").value = 1;
			get_by_id("wps_configured_mode").value = 5;
		}else{
			alert("security error");
		}
		if(get_by_id("asp_temp_69").value=="ascii"){
			get_by_id("asp_temp_70").value = hex_to_a(get_by_id("asp_temp_70").value);
		}
		
		
        if(submit_button_flag == 0){
            submit_button_flag = 1;
            get_by_id("wps_enable").value = 1;
            get_by_id("form1").submit();
        }
    }

    function wizard_cancel(){
    if (!is_form_modified("mainform")) {
			if(!confirm(_wizquit)) {
		    	return false;
		}
        }
		window.location.href="wizard_wireless.asp";
    }
    function go_back(){
        window.location.href = get_by_id("html_response_return_page").value;
    }
</script>
<title></title>
<meta http-equiv=Content-Type content="text/html; charset=UTF8">
<style type="text/css">
<!--
.style4 {font-size: 10px}
-->
</style>
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
<table border=0 cellspacing=0 cellpadding=0 align=center width=838>
<tr>
<td></td>
</tr>
<tr>
<td>
<div align=left>
<table width=838 border=0 cellspacing=0 cellpadding=0 align=center height=100>
<tr>
<td bgcolor="#FFFFFF"><div align=center>
  <table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
    <tr>
      <td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://support.dlink.com.tw/"><% CmoGetCfg("model_number","none"); %></a></td>
      <td align="right" nowrap><script>show_words(TA3)</script>: <% CmoGetStatus("hw_version"); %> &nbsp;</td>
      <td align="right" nowrap><script>show_words(sd_FWV)</script>: <% CmoGetStatus("version"); %></td>
      <td>&nbsp;</td>
    </tr>
  </table>
  <div align="center"><img src="wlan_masthead.gif" width="836" height="92" align="middle"></div></td>
</tr>
</table>
</div>
</td>
</tr>
<tr>
  <td bgcolor="#FFFFFF"><p>&nbsp;</p>
  <table width="650" border="0" align="center">
    <tr>
      <td><div class=box>
        <h2 align="left"><script>show_words(_setupdone)</script></h2>
        <div align="left">
          <p class="box_msg"><script>show_words(wwl_intro_end)</script></p>
          <form id="form1" name="form1" method="post" action="apply.cgi">
            <input type="hidden" id="html_response_page" name="html_response_page" value="back_long.asp">
            <input type="hidden" id="html_response_return_page" name="html_response_return_page" value="<% CmoGetCfg("html_response_return_page","none"); %>">
            <input type="hidden" id="reboot_type" name="reboot_type" value="all">
            <input type="hidden" id="asp_temp_35" name="asp_temp_35" value="<% CmoGetCfg("asp_temp_35","none"); %>">
            <input type="hidden" id="asp_temp_37" name="asp_temp_37" value="<% CmoGetCfg("asp_temp_37","none"); %>">
            <input type="hidden" id="asp_temp_36" name="asp_temp_36" value="<% CmoGetCfg("asp_temp_36","none"); %>">
            <input type="hidden" id="asp_temp_50" name="asp_temp_50" value="<% CmoGetCfg("asp_temp_50","none"); %>">

			<input type="hidden" id="asp_temp_68" name="asp_temp_68"value="<% CmoGetCfg("asp_temp_68","none"); %>">
			<input type="hidden" id="asp_temp_69" name="asp_temp_69" value="<% CmoGetCfg("asp_temp_69","none"); %>">
			<input type="hidden" id="asp_temp_70" name="asp_temp_70" value="<% CmoGetCfg("asp_temp_70","none"); %>">
			<input type="hidden" id="asp_temp_71" name="asp_temp_71" value="<% CmoGetCfg("asp_temp_71","none"); %>">
		  
            <input type="hidden" id="wlan0_security" name="wlan0_security">
            <input type="hidden" id="wlan0_ssid" name="wlan0_ssid" value="<% CmoGetCfg("asp_temp_34","none"); %>">
            <input type="hidden" id="wlan0_wep_default_key" name="wlan0_wep_default_key">
            <input type="hidden" id="wlan0_wep_display" name="wlan0_wep_display" value="hex">
            <input type="hidden" id="wlan0_wep128_key_1" name="wlan0_wep128_key_1">
            <input type="hidden" id="wlan0_wep64_key_1" name="wlan0_wep64_key_1">
            <input type="hidden" id="wlan0_psk_pass_phrase" name="wlan0_psk_pass_phrase">
            <input type="hidden" id="wlan0_psk_cipher_type" name="wlan0_psk_cipher_type">
			
			<input type="hidden" id="wlan1_security" name="wlan1_security">
			<input type="hidden" id="wlan1_ssid" name="wlan1_ssid" value="<% CmoGetCfg("asp_temp_67","none"); %>">		  
			<input type="hidden" id="wlan1_wep_default_key" name="wlan1_wep_default_key">
			<input type="hidden" id="wlan1_wep_display" name="wlan1_wep_display" value="hex">
			<input type="hidden" id="wlan1_wep128_key_1" name="wlan1_wep128_key_1">
			<input type="hidden" id="wlan1_wep64_key_1" name="wlan1_wep64_key_1">
			<input type="hidden" id="wlan1_psk_pass_phrase" name="wlan1_psk_pass_phrase">
			<input type="hidden" id="wlan1_psk_cipher_type" name="wlan1_psk_cipher_type">
            <input type="hidden" id="wps_lock" name="wps_lock" value="<% CmoGetCfg("wps_lock","none"); %>">
	    <input type="hidden" id="disable_wps_pin" name="disable_wps_pin" value="<% CmoGetCfg("disable_wps_pin","none"); %>">

            <input type="hidden" id="wps_configured_mode" name="wps_configured_mode" value="<% CmoGetCfg("wps_configured_mode","none"); %>">
            <input type="hidden" id="wps_enable" name="wps_enable">
            <div>
              <div id=w2>
                <table width="650" align="center" class="formarea">
                  <tr id="show_disable" style="display:none">
                    <td class="duple"><script>show_words(GW_WLAN_RADIO_0_NAME)</script> <script>show_words(wwl_wnn)</script>&nbsp;:</td>
                    <td width="263"><% CmoGetCfg("asp_temp_34","none"); %></td>
                    <td width="10">&nbsp;</td>
                  </tr>
				   <tr id="show_disable_1" style="display:none">
                    <td class="duple"> <script>show_words(GW_WLAN_RADIO_1_NAME)</script> <script>show_words(wwl_wnn)</script>&nbsp;:</td>
                    <td width="263"><% CmoGetCfg("asp_temp_67","none"); %></td>
                    <td width="10">&nbsp;</td>
                  </tr>
                  <tr id="show_wep" style="display:none">
                    <td colspan="3">
                      <table width="650" style="word-break:break-all;" class="box">
                              <tr> 
                                <td class="duple"><script>show_words(GW_WLAN_RADIO_0_NAME)</script> <script>show_words(wwl_wnn)</script>&nbsp;:</td>
                                <td> 
                                  <% CmoGetCfg("asp_temp_34","none"); %>
                                </td>
                              </tr>
                              <tr> 
                                <td class="duple"><script>show_words(wwl_WKL)</script>&nbsp;:</td>
                                <td> <script>
                          		var secu_length = get_by_id("asp_temp_50").value;
                          		document.write(key_num_array[secu_length]);
                          	</script>
                                  bits </td>
                              </tr>
                              <tr> 
                                <td class="duple"><script>show_words(wwl_DWKL)</script>&nbsp;:</td>
                                <td>1</td>
                              </tr>
                              <tr> 
                                <td class="duple"><script>show_words(_auth)</script>&nbsp;:</td>
                                <td><script>show_words(_open)</script></td>
                              </tr>
                              <tr id="summary_wep_tr"> 
                                <td class="duple"><script>show_words(wwl_WK)</script>&nbsp;:</td>
                                <td id="summary_wep_td"> <script>
						  	var show_word = get_by_id("asp_temp_37").value;
						  	if(get_by_id("asp_temp_35").value == "1"){
								if(get_by_id("asp_temp_36").value=="ascii"){
									 show_word = hex_to_a(get_by_id("asp_temp_37").value);
								}else if(get_by_id("asp_temp_36").value=="hex"){
									 show_word = get_by_id("asp_temp_37").value;
									}
							}
							document.write(show_word);
						  </script> </td>
                              </tr>
                            </table></td>
                  </tr>
				   <tr id="show_wep_1" style="display:none">
                    <td colspan="3">
                      <table width="650" style="word-break:break-all;" class="box">
                              <tr> 
                                <td class="duple"><script>show_words(GW_WLAN_RADIO_1_NAME)</script> <script>show_words(wwl_wnn)</script>&nbsp;:</td>
                                <td> 
                                  <% CmoGetCfg("asp_temp_67","none"); %>
                                </td>
                              </tr>
                              <tr> 
                                <td class="duple"><script>show_words(wwl_WKL)</script>&nbsp;:</td>
                                <td> <script>
                          		var secu_length_1 = get_by_id("asp_temp_71").value;
                          		document.write(key_num_array[secu_length_1]);
                          	</script>
                                  bits </td>
                              </tr>
                              <tr> 
                                <td class="duple"><script>show_words(wwl_DWKL)</script>&nbsp;:</td>
                                <td>1</td>
                              </tr>
                              <tr> 
                                <td class="duple"><script>show_words(_auth)</script>&nbsp;:</td>
                                <td><script>show_words(_open)</script></td>
                              </tr>
                              <tr id="summary_wep_tr_1"> 
                                <td class="duple"><script>show_words(wwl_WK)</script>&nbsp;:</td>
                                <td id="summary_wep_td_1"> <script>
						  	var show_word_1 = get_by_id("asp_temp_70").value;
						  	if(get_by_id("asp_temp_68").value == "1"){
								if(get_by_id("asp_temp_69").value=="ascii"){
									 show_word_1 = hex_to_a(get_by_id("asp_temp_70").value);
								}else if(get_by_id("asp_temp_69").value=="hex"){
									 show_word_1 = get_by_id("asp_temp_70").value;
									}
							}
							document.write(show_word_1);
						  </script> </td>
                              </tr>
                            </table></td>
                  </tr>
                  <tr id="show_wpa" style="display:none">
                    <td colspan="3">
                      <table width="650" style="word-break:break-all;" class="box">
                              <tr> 
                                <td width="201" class="duple"><script>show_words(GW_WLAN_RADIO_0_NAME)</script> <script>show_words(wwl_wnn)</script>&nbsp;:</td>
                                <td width="437"> 
                                  <% CmoGetCfg("asp_temp_34","none"); %>
                                </td>
                              </tr>
                              <tr> 
                                <td class="duple"><script>show_words(bws_SM)</script>&nbsp;:</td>
                                <td><script>show_words(bws_WPAM_1)</script></td>
                              </tr>
                              <tr> 
                                <td class="duple"><script>show_words(bws_CT)</script>&nbsp;:</td>
                                <td><script>show_words(bws_CT_3)</script></td>
                              </tr>
                              <tr> 
                                <td class="duple"><script>show_words(_psk)</script>&nbsp;:</td>
                                <td> 
                                  <% CmoGetCfg("asp_temp_37","none"); %>
                                </td>
                              </tr>
                            </table></td>
                  </tr>
                  <tr id="show_wpa_1" style="display:none">
                    <td colspan="3">
                      <table width="650" style="word-break:break-all;" class="box">
                              <tr> 
                                <td width="201" class="duple"><script>show_words(GW_WLAN_RADIO_1_NAME)</script> <script>show_words(wwl_wnn)</script>&nbsp;:</td>
                                <td width="446"> 
                                  <% CmoGetCfg("asp_temp_67","none"); %>
                                </td>
                              </tr>
                              <tr> 
                                <td class="duple"><script>show_words(bws_SM)</script>&nbsp;:</td>
                                <td><script>show_words(bws_WPAM_1)</script></td>
                              </tr>
                              <tr> 
                                <td class="duple"><script>show_words(bws_CT)</script>&nbsp;:</td>
                                <td><script>show_words(bws_CT_3)</script></td>
                              </tr>
                              <tr> 
                                <td class="duple"><script>show_words(_psk)</script>&nbsp;:</td>
                                <td>
                                  <% CmoGetCfg("asp_temp_70","none"); %>
                                </td>
                              </tr>
                            </table></td>
                  </tr>
					<tr id="show_wpa2" style="display:none">
                    <td colspan="3">
                      <table width="650" style="word-break:break-all;" class="box">
                              <tr> 
                                <td class="duple"><script>show_words(GW_WLAN_RADIO_0_NAME)</script>
                                  <script>show_words(wwl_wnn)</script>
                                  &nbsp;:</td>
                                <td>
                                  <% CmoGetCfg("asp_temp_34","none"); %>
                                </td>
                              </tr>
                              <tr> 
                                <td class="duple"><script>show_words(bws_SM)</script>&nbsp;:</td>
                                <td width="277"><script>show_words(KR48)</script></td>
                              </tr>
                              <tr> 
                                <td class="duple"><script>show_words(bws_CT)</script>&nbsp;:</td>
                                <td><script>show_words(bws_CT_3)</script></td>
                              </tr>
                              <tr > 
                                <td class="duple"><script>show_words(_psk)</script>&nbsp;:</td>
                                <td> 
                                  <% CmoGetCfg("asp_temp_37","none"); %>
                                </td>
                              </tr>
                            </table></td>
                  </tr>
                  <tr id="show_wpa2_1" style="display:none">
                    <td colspan="3">
                      <table width="650" style="word-break:break-all;" class="box">
                              <tr> 
                                <td class="duple"><script>show_words(GW_WLAN_RADIO_1_NAME)</script>
                                  <script>show_words(wwl_wnn)</script>
                                  &nbsp;:</td>
                                <td>
                                  <% CmoGetCfg("asp_temp_67","none"); %>
                                </td>
                              </tr>
                              <tr> 
                                <td class="duple"><script>show_words(bws_SM)</script>&nbsp;:</td>
                                <td width="277"><script>show_words(KR48)</script></td>
                              </tr>
                              <tr> 
                                <td class="duple"><script>show_words(bws_CT)</script>&nbsp;:</td>
                                <td><script>show_words(bws_CT_3)</script></td>
                              </tr>
                              <tr > 
                                <td class="duple"><script>show_words(_psk)</script>&nbsp;:</td>
                                <td> 
                                  <% CmoGetCfg("asp_temp_70","none"); %>
                                </td>
                              </tr>
                            </table></td>
                  </tr>
                  <tr id="show_wpa2_auto" style="display:none">
                  	<td colspan="3">
                      <table width="650" style="word-break:break-all;" class="box">
                              <tr> 
                                <td width="266" class="duple"><script>show_words(GW_WLAN_RADIO_0_NAME)</script>
                                  <script>show_words(wwl_wnn)</script>
                                  &nbsp;:</td>
                                <td>
                                  <% CmoGetCfg("asp_temp_34","none"); %>
                                </td>
                              </tr>
                              <tr> 
                                <td class="duple"><script>show_words(bws_SM)</script>&nbsp;:</td>
                                <td width="372"><script>show_words(KR48)</script></td>
                              </tr>
                              <tr> 
                                <td class="duple"><script>show_words(bws_CT)</script>&nbsp;:</td>
                                <td><script>show_words(bws_CT_3)</script></td>
                              </tr>
                              <tr > 
                                <td class="duple"><script>show_words(_psk)</script>&nbsp;:</td>
                                <td> 
                                  <% CmoGetCfg("asp_temp_37","none"); %>
                                </td>
                              </tr>
                            </table></td>
                  </tr>
				   <tr id="show_wpa2_auto_1" style="display:none">
                  	<td colspan="3">
                      <table width="650" style="word-break:break-all;" class="box">
                              <tr> 
                                <td width="261" class="duple"><script>show_words(GW_WLAN_RADIO_1_NAME)</script>
                                  <script>show_words(wwl_wnn)</script>
                                  :</td>
                                <td>
                                  <% CmoGetCfg("asp_temp_67","none"); %>
                                </td>
                              </tr>
                              <tr> 
                                <td class="duple"><script>show_words(bws_SM)</script>&nbsp;:</td>
                                <td width="377"><script>show_words(KR48)</script></td>
                              </tr>
                              <tr> 
                                <td class="duple"><script>show_words(bws_CT)</script>&nbsp;:</td>
                                <td><script>show_words(bws_CT_3)</script></td>
                              </tr>
                              <tr > 
                                <td class="duple"><script>show_words(_psk)</script>&nbsp;:</td>
                                <td> 
                                  <% CmoGetCfg("asp_temp_70","none"); %>
                                </td>
                              </tr>
                            </table></td>
                  </tr>
                </table>
                <div align="center"><br>
                        <input type="button" class="button_submit" id="prev_b" name="prev_b" value="" onClick="go_back();">
                        <input type="button" class="button_submit" id="next_b" name="next_b" value="" onClick="send_request()">
                       <input type="button" class="button_submit" id="cancel_b" name="cancel_b" value="" onclick="wizard_cancel();">
                        
						<script>get_by_id("prev_b").value = _prev;</script>
						<script>get_by_id("next_b").value = _next;</script>
						<script>get_by_id("cancel_b").value = _cancel;</script>
                    <br>
                </div>
              </div>
            </div>
          </form>
        </div>
      </div></td>
    </tr>
  </table>
  <p>&nbsp;</p></td>
</tr>
<tr>
  <td bgcolor="#FFFFFF"><table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="836" align="center">
    <tr>
      <td width="125" align="center">&nbsp;&nbsp;<img src="wireless_tail.gif" width="114" height="35"></td>
      <td width="10">&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
  </table></td>
</tr>
</table>
<div id="copyright"><% CmoGetStatus("copyright"); %></div>
</body>
<script>
    show_encryption();
</script>
</html>
