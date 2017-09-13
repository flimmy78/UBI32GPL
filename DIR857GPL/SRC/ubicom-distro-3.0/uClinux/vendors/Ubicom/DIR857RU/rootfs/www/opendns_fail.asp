<html lang=en-US xml:lang="en-US" xmlns="http://www.w3.org/1999/xhtml">
<head>
<script language="JavaScript" src="lingual_<% CmoGetCfg("lingual","none"); %>.js"></script>
<script language="Javascript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript">
    var count = 70;

    function onPageLoad()
    {
        var temp_count = "<% CmoGetCfg("countdown_time","none"); %>";
        if (temp_count != "") {
            count = parseInt(temp_count);
        }

        get_by_id("html_response_page").value = get_by_id("html_response_return_page").value;
//        do_count_down();
    }

    function confirm_reboot()
    {
// go to login    	
    	document.location.href = "/";
    	return;
//                send_submit("form6");
document.form6.submit();
                return;

        if (login_who == "user") {
            window.location.href ="back.asp";
        }
        else {
            if (confirm(msg[REBOOT_ROUTER])) {
                send_submit("form6");
            }
        }
    }

    function do_count_down()
    {
        get_by_id("show_sec").innerHTML = count;

        if (count == 0) {
            back();
            return;
        }

        if (count > 0) {
            count--;
            setTimeout('do_count_down()', 1000);
        }
    }

    function back()
    {
        if ("<% CmoGetStatus("get_current_user"); %>" == "user")
            window.location.href ="index.asp";
        else
            window.location.href = get_by_id("html_response_page").value;
    }
</script>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<title><% CmoGetStatus("title"); %></title>
<meta http-equiv=Content-Type content="text/html; charset=UTF8">
<style type="text/css">
<!--
.style1 {color: #FF6600}
-->
</style>
</head>
<body onload="onPageLoad();" topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
<div >
<form id="form1" name="form1" method="post">
<input type="hidden" id="html_response_page" name="html_response_page" value="index.asp">
<input type="hidden" id="html_response_message" name="html_response_message" value="<% CmoGetCfg("html_response_message","none"); %>">
<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="<% CmoGetCfg("html_response_return_page","none"); %>">
<input type="hidden" name="reboot_type" value="none">
  <table width="838" height="100" border=0 align="center" cellPadding=0 cellSpacing=0 id=table_shell>
  <tr>
    <td bgcolor="#FFFFFF">
      <div align="center">
        <table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
          <tr>
            <td width="100%">&nbsp;&nbsp;Product Page: <a href="http://support.dlink.com.tw/" onclick="return jump_if();"><% CmoGetCfg("model_number","none"); %></a></td>
            <td align="right" nowrap>Hardware Version: <% CmoGetStatus("hw_version"); %> &nbsp;</td>
            <td align="right" nowrap>Firmware Version: <% CmoGetStatus("version"); %></td>
            <td>&nbsp;</td>
          </tr>
        </table>
        <img src="wlan_masthead.gif" width="836" height="92"></div></td>
    </tr>
  <tr>
    <td>
      <table width="838" border=0 align="center" cellPadding=0 cellSpacing=0 >
        <tr>
          <td bgcolor="#FFFFFF"></td></tr>
        <tr>
          <td bgcolor="#FFFFFF"></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF">
           <table width="650" border="0" align="center">
            <tr>
              <td height="15">
              <div id=box_header>
                  <h1>Parental Controls</h1>

                  <br ><div style="display:none " class="centered">Please wait <span id="show_sec"></span>&nbsp;seconds.</div><br>
                    You have fail configured your router to use OpenDNSR Parental Controls.
                	<br> timeout 30 minutes</br>
  					<br><br>
  					<br>
  							Please press button to continue
                            <input type="button" value="Continue..." name=restart onclick="confirm_reboot()">
 					
  					
              </div><br></td>
            </tr>
          </table>
          </td>
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
        </table>     </td>
    </tr>
  </table></form>

                         <form id="form6" name="form6" method="post" action="reboot.cgi">
                            <input type="hidden" name="html_response_page" value="reboot.asp">
                            <input type="hidden" name="html_response_return_page" value="tools_system.asp">
                            
                        </form>


  <div id="copyright"><% CmoGetStatus("copyright"); %></div>
</div>

<script src=https://www-files.opendns.com/js/router.js></script>

</BODY>
</html>
