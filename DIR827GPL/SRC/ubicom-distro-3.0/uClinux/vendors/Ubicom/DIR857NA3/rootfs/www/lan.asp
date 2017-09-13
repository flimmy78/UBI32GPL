<html>
<head>
<script language="JavaScript" src="lingual_<% CmoGetCfg("lingual","none"); %>_tmp.js"></script>
<script language="JavaScript" src="lingual_<% CmoGetCfg("lingual","none"); %>.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript">
    var submit_button_flag = 0;
    var rule_max_num = 25;
    var resert_rule = rule_max_num;
    var DataArray = new Array();
    var DHCPL_DataArray = new Array();
    var reboot_needed = "<% CmoGetStatus("reboot_needed"); %>";

    //1/dddd/192.168.55.55/112255448877
    function Data(enable, name, ip, mac, onList)
    {
        this.Enable = enable;
        this.Name = name;
        this.IP = ip;
        this.MAC = mac;
        this.OnList = onList;
    }

    function DHCP_Data(name, ip, mac, Exp_time, onList)
    {
        this.Name = name;
        this.IP = ip;
        this.MAC = mac;
        this.EXP_T = Exp_time;
        this.OnList = onList;
    }

    function set_reservation()
    {
        var index = 1;
        for (var i = 0; i < rule_max_num; i++) {
            var temp_dhcp;
            var k = i;
            if (parseInt(i) < 10) {
                k = "0" + i;
            }

            temp_dhcp = (get_by_id("dhcpd_reserve_" + k).value).split("/");
            if (temp_dhcp.length > 1) {
                if (temp_dhcp[1].length > 0) {
                    DataArray[index] = new Data(temp_dhcp[0],temp_dhcp[1], temp_dhcp[2], temp_dhcp[3], index);
                    index++;
                }
            }
        }

        get_by_id("max_row").value = index - 1;
    }

    function set_lan_dhcp_list()
    {
        var index = 0;
        var temp_dhcp_list = get_by_id("dhcp_list").value.split(",");
        for (var i = 0; i < temp_dhcp_list.length; i++) {
            var temp_data = temp_dhcp_list[i].split("/");
            if (temp_data.length > 1) {
                DHCPL_DataArray[DHCPL_DataArray.length++] = new DHCP_Data(temp_data[0], temp_data[1], temp_data[2], temp_data[3], index);
                index++;
            }
        }
        get_by_id("dhcp_num").innerHTML = DHCPL_DataArray.length;
    }

    function onPageLoad()
    {
        set_checked("<% CmoGetCfg("dhcpd_enable","none"); %>", get_by_id("dhcpsvr"));
        set_checked("<% CmoGetCfg("dns_relay","none"); %>", get_by_id("DNSrelay"));
        set_checked("<% CmoGetCfg("dhcpd_always_bcast","none"); %>", get_by_id("always_broadcast"));
        set_checked("<% CmoGetCfg("dhcpd_netbios_enable","none"); %>", get_by_id("netbios_announcement"));
        set_checked("<% CmoGetCfg("dhcpd_netbios_learn","none"); %>", get_by_id("netbios_learn"));
        set_checked("<% CmoGetCfg("dhcpd_static_node_type","none"); %>", get_by_name("netbios_node"));

        var dhcpd_static_wins_server = "<% CmoGetCfg("dhcpd_static_wins_server","none"); %>";
        var wins_server = dhcpd_static_wins_server.split("/");
        if (wins_server.length != "")
            get_by_id("wins_ip1").value = wins_server[0];

        if (wins_server.length > 1)
            get_by_id("wins_ip2").value = wins_server[1];

        disable_ip();
        disable_netbios();

        if ("<% CmoGetStatus("get_current_user"); %>" == "user") {
            DisableEnableForm(document.form1,true);
            get_by_id("show_button").disabled = true;
        }
        else {
        	/*OPENDNS*/	get_by_id("DNSrelay").disabled = (get_by_id("opendns_enable").value==1)	? true: false;
        }
        
		var nb_sel = "<% CmoGetCfg("dhcpd_static_node_type","none"); %>";
		netbios_selector(nb_sel);
		
        set_form_default_values("form1");
    }

    function clone_mac_action()
    {
        get_by_id("reserved_mac").value = get_by_id("mac_clone_addr").value;
    }

    function set_reserved()
    {
        var idx = parseInt(get_by_id("reserved_list").selectedIndex);
        if (idx > 0) {
            get_by_id("reserved_enable").checked = true;
            get_by_id("reserved_name").value = DHCPL_DataArray[idx - 1].Name;
            get_by_id("reserved_ip").value = DHCPL_DataArray[idx - 1].IP;
            get_by_id("reserved_mac").value = DHCPL_DataArray[idx - 1].MAC;
        }
    }

    function set_reserved_enable(idx)
    {
        if (get_by_id("r_enable" + idx).checked) {
            if (confirm(YM92 + DataArray[idx].IP)) {
                DataArray[idx].Enable = 1;
                get_by_id("table1").rows[idx].cells[0].innerHTML = "<center><input type=checkbox id=r_enable" + idx + " name=r_enable" + idx + " onClick='set_reserved_enable(" + idx + ")' checked></center>"
            }
            else {
                get_by_id("table1").rows[idx].cells[0].innerHTML = "<center><input type=checkbox id=r_enable" + idx + " name=r_enable" + idx + " onClick='set_reserved_enable(" + idx + ")'></center>"
            }
        }
        else {
            if (confirm(YM93 + DataArray[idx].IP)) {
                DataArray[idx].Enable = 0;
                get_by_id("table1").rows[idx].cells[0].innerHTML = "<center><input type=checkbox id=r_enable" + idx + " name=r_enable" + idx + " onClick='set_reserved_enable(" + idx + ")'></center>"
            }
            else {
                get_by_id("table1").rows[idx].cells[0].innerHTML = "<center><input type=checkbox id=r_enable" + idx + " name=r_enable" + idx + " onClick='set_reserved_enable(" + idx + ")' checked></center>"
            }
        }
    }

    function edit_dhcp_client(idx)
    {
        get_by_id("reserved_enable").checked = true;
        get_by_id("reserved_name").value = DHCPL_DataArray[idx].Name;
        get_by_id("reserved_ip").value = DHCPL_DataArray[idx].IP;
        get_by_id("reserved_mac").value = DHCPL_DataArray[idx].MAC;
    }

    function edit_row(idx)
    {
        if (DataArray[idx].Enable == 1)
            get_by_id("reserved_enable").checked = true;
        else
            get_by_id("reserved_enable").checked = false;

        get_by_id("reserved_name").value = DataArray[idx].Name;
        get_by_id("reserved_ip").value = DataArray[idx].IP;
        get_by_id("reserved_mac").value = DataArray[idx].MAC;
        get_by_id("edit").value = idx;
    }

    function delete_data()
    {
        var num = parseInt(get_by_id("del").value);
        var DataArray_length = parseInt(DataArray.length) - 1;
        // GraceYang added 2009.07.30
        var newDataArray = new Array();
        newDataArray[0] = new Data("", "", "", "", "");
        nowIndex = 1;
        for (var i=1; i<=DataArray_length; i++) {
            if (i != num) {
                newDataArray[nowIndex] = new Data(DataArray[i].Enable, DataArray[i].Name, DataArray[i].IP, DataArray[i].MAC, DataArray[i].OnList);
                nowIndex ++;
        }
        }
        DataArray = new Array();
        DataArray = newDataArray;
        --DataArray_length;
        get_by_id("max_row").value = parseInt(DataArray_length);
        clear_reserved();
    }

    function delete_row()
    {
        var del_index = parseInt(get_by_id("del").value);
        var tb1 = get_by_id("table1");
        var DataArray_length = parseInt(DataArray.length) - 1;

        if (del_index >= DataArray_length) {
            tb1.deleteRow(del_index);
        }
        else {
            for (var i = del_index; i < DataArray_length; i++) {
                var is_checked = "";
                if (parseInt(DataArray[i+1].Enable)) {
                    is_checked = " checked";
                }

                var edit = i + 1;
                get_by_id("table1").rows[i].cells[0].innerHTML = "<center><input type=checkbox id=r_enable" + i + " name=r_enable" + i + " onClick='set_reserved_enable(" + edit + ")' " + is_enable + "></center>"
                get_by_id("table1").rows[i].cells[1].innerHTML = "<center>" + DataArray[edit].Name +"</center>"
                get_by_id("table1").rows[i].cells[2].innerHTML = "<center>" + DataArray[edit].MAC +"</center>"
                get_by_id("table1").rows[i].cells[3].innerHTML = "<center>" + DataArray[edit].IP +"</center>"
                get_by_id("table1").rows[i].cells[4].innerHTML = "<center><a href=\"javascript:edit_row("+ i +")\"><img src=\"edit.jpg\" border=\"0\" alt=\"edit\"></a></center>";
                get_by_id("table1").rows[i].cells[5].innerHTML = "<center><a href=\"javascript:del_row("+ i +")\"><img src=\"delete.jpg\"  border=\"0\" alt=\"delete\"></a></center>";
            }
            tb1.deleteRow(DataArray_length);
        }
        delete_data();
    }

    function del_row(idx)
    {
        edit_row(idx);
        if (confirm(YM25 + DataArray[idx].IP)) {
            get_by_id("del").value = idx;
            delete_row();
        }
    }

    function update_DataArray()
    {
        var index = parseInt(get_by_id("edit").value);
        var insert = false;
        var is_enable = "0";

        if (index == "-1") {      //save
            if (get_by_id("max_row").value == rule_max_num) {
			alert(TEXT015);
		}
        else {
                index = parseInt(get_by_id("max_row").value) + 1;
                get_by_id("max_row").value = index;
                insert = true;
            }
        }

        if (get_by_id("reserved_enable").checked)
            is_enable = "1";
        else
            is_enable = "0";

        if (insert) {
            DataArray[index] = new Data(is_enable, get_by_id("reserved_name").value, get_by_id("reserved_ip").value, get_by_id("reserved_mac").value, index, index+1);
        }
        else if (index != -1) {
            DataArray[index].Enable = is_enable;
            DataArray[index].Name = get_by_id("reserved_name").value;
            DataArray[index].IP = get_by_id("reserved_ip").value;
            DataArray[index].MAC = get_by_id("reserved_mac").value;
            DataArray[index].OnList = index;
        }

        return true;
    }

    function save_reserved(bufferSaveFlag)
    {
        var index = 0;
        var ip = get_by_id("lan_ipaddr").value;
        var mask = get_by_id("lan_netmask").value;
        var reserved_name = get_by_id("reserved_name").value;
        var reserved_ip = get_by_id("reserved_ip").value;
        var reserved_mac = get_by_id("reserved_mac").value;
        var start_ip = get_by_id("dhcpd_start").value;
        var end_ip = get_by_id("dhcpd_end").value;

        var ip_addr_msg = replace_msg(all_ip_addr_msg,_ipaddr);
        var Res_ip_addr_msg = replace_msg(all_ip_addr_msg,"Reservation IP");
        var start_ip_addr_msg = replace_msg(all_ip_addr_msg,"Start IP address");
        var end_ip_addr_msg = replace_msg(all_ip_addr_msg,"End IP address");

        var temp_ip_obj = new addr_obj(ip.split("."), ip_addr_msg, false, false);
        var temp_mask_obj = new addr_obj(mask.split("."), subnet_mask_msg, false, false);
        var temp_res_ip_obj = new addr_obj(reserved_ip.split("."), Res_ip_addr_msg, false, false);
        var start_obj = new addr_obj(start_ip.split("."), start_ip_addr_msg, false, false);
        var end_obj = new addr_obj(end_ip.split("."), end_ip_addr_msg, false, false);
	var reg = /[^A-Za-z0-9_.:-]/;
		var k = get_by_id("max_row").value;

        //graceyang 20090818 check "lan ip" & "reservation dhcp list ip" domain
        for (j=0;j<rule_max_num;j++) {  // get reservation DHCP list rule value
            var rule_value;
            if (j > 9)
                rule_value = (get_by_id("dhcpd_reserve_" + j).value);
            else
                rule_value = (get_by_id("dhcpd_reserve_0" + j).value);				

            if (rule_value == "") {
                continue;
            }
            temp_reserv = rule_value.split("/");
            var temp_res_ip2_obj = new addr_obj(temp_reserv[2].split("."), Res_ip_addr_msg, false, false);
            if (temp_reserv[0] == "1") {
		  		if (!check_domain(temp_res_ip2_obj, temp_mask_obj, temp_ip_obj) && k != "0"){
		  			alert(TEXT033+" " + temp_reserv[2] + " "+GW_DHCP_SERVER_RESERVED_IP_IN_POOL_INVALID_a);
					return false;
				}	
			}				
        }

        if (bufferSaveFlag == "N" && reserved_name == "") {
            clear_reserved();
            return true;
        }
        else {
            if (reserved_name == "") {
                alert(GW_INET_ACL_NAME_INVALID);
                return false;
            }
           else if(reg.test(reserved_name)) {
				alert(check_name_invalid);
				return false;
			}
			
	   else if (get_by_id("reserved_name").value.length > 95) {
				var up_gS_1_tmp = up_gS_1.replace("' + value + '",get_by_id("reserved_name").value);
				up_gS_1_tmp = up_gS_1_tmp.replace("' + length + '","95");
                alert(up_gS_1_tmp);
                return false;
			}
            else if (!check_LAN_ip(temp_ip_obj.addr, temp_res_ip_obj.addr, TEXT033)) {
                return false;
            }
            else if (!check_address(temp_res_ip_obj, temp_mask_obj, temp_ip_obj)) {
                return false;
            }
            else if (!check_domain(temp_res_ip_obj, temp_mask_obj, temp_ip_obj)){
                alert(TEXT033+" " + reserved_ip + " "+GW_DHCP_SERVER_RESERVED_IP_IN_POOL_INVALID_a);
                return false;
            }
            else if (!check_mac(reserved_mac)){
                alert(KR3);
                return false;
            }
        }

        if (check_resip_order(temp_res_ip_obj,start_obj, end_obj)) {
			alert(TEXT033+" " + reserved_ip + " "+GW_DHCP_SERVER_RESERVED_IP_IN_POOL_INVALID_a);
            return false;
        }

        //check same ip/mac start
        var index = parseInt(get_by_id("edit").value);
        var edit_tmp = get_by_id("edit").value;

        for (m=1; m < DataArray.length; m++) {
            if (m == index) {
                continue;
            }
            else {
                if (get_by_id("reserved_name").value.length > 0) {
                    if ((get_by_id("reserved_name").value == DataArray[m].Name)) {
						alert(sp_name+" ("+ get_by_id("reserved_name").value +") "+sp_alreadyused);
                        return false;
                    }
                }

                if (reserved_ip.length > 0) {
                    if ((reserved_ip == DataArray[m].IP)) {
					alert(TEXT033+" ("+ reserved_ip +") "+sp_alreadyused);
                        return false;
                    }
                }

                if (reserved_mac.length > 0) {
                    if ((reserved_mac.toUpperCase() == DataArray[m].MAC.toUpperCase())) {
						alert(GW_DHCP_SERVER_RESERVED_MAC_UNIQUENESS_INVALID_a+" "+ reserved_mac +" "+GW_DHCP_SERVER_RESERVED_MAC_UNIQUENESS_INVALID_b);
                        return false;
                    }
                }
            }
        }
        //check same ip/mac end

        update_DataArray();

        var is_enable = "";
        if (get_by_id("edit").value == "-1") {     //add
            var i = get_by_id("max_row").value;
            var tb1 = get_by_id("table1");
            var oTr = tb1.insertRow(-1);
            var oTd1 = oTr.insertCell(-1);
            var oTd2 = oTr.insertCell(-1);
            var oTd3 = oTr.insertCell(-1);
            var oTd4 = oTr.insertCell(-1);
            var oTd5 = oTr.insertCell(-1);
            var oTd6 = oTr.insertCell(-1);

            if (parseInt(DataArray[i].Enable))
                is_enable = "checked";
            else
                is_enable = "";

            oTd1.innerHTML = "<center><input type=checkbox id=r_enable" + i + " name=r_enable" + i + " onClick='set_reserved_enable(" + i + ")' " + is_enable + "></center>"
            oTd2.innerHTML = "<center>" + DataArray[i].Name +"</center>"
            oTd3.innerHTML = "<center>" + DataArray[i].MAC +"</center>"
            oTd4.innerHTML = "<center>" + DataArray[i].IP +"</center>"
            oTd5.innerHTML = "<center><a href=\"javascript:edit_row("+ i +")\"><img src=\"edit.jpg\" border=\"0\" alt=\"edit\"></a></center>";
            oTd6.innerHTML = "<center><a href=\"javascript:del_row("+ i +")\"><img src=\"delete.jpg\"  border=\"0\" alt=\"delete\"></a></center>";
        }
        else {    //update
            var i = parseInt(get_by_id("edit").value);
            if (parseInt(DataArray[i].Enable))
                is_enable = "checked";
            else
                is_enable = "";

            get_by_id("table1").rows[i].cells[0].innerHTML = "<center><input type=checkbox id=r_enable" + i + " name=r_enable" + i + " onClick='set_reserved_enable(" + i + ")' " + is_enable + "></center>"
            get_by_id("table1").rows[i].cells[1].innerHTML = "<center>" + DataArray[i].Name +"</center>"
            get_by_id("table1").rows[i].cells[2].innerHTML = "<center>" + DataArray[i].MAC +"</center>"
            get_by_id("table1").rows[i].cells[3].innerHTML = "<center>" + DataArray[i].IP +"</center>"
            get_by_id("table1").rows[i].cells[4].innerHTML = "<center><a href=\"javascript:edit_row("+ i +")\"><img src=\"edit.jpg\" border=\"0\" alt=\"edit\"></a></center>";
            get_by_id("table1").rows[i].cells[5].innerHTML = "<center><a href=\"javascript:del_row("+ i +")\"><img src=\"delete.jpg\"  border=\"0\" alt=\"delete\"></a></center>";
        }

        clear_reserved();
        return true;
    }

    function clear_reserved()
    {
        get_by_id("reserved_enable").checked = false;
        get_by_id("reserved_name").value = "";
        get_by_id("reserved_ip").value = "";
        get_by_id("reserved_mac").value = "";
        get_by_id("edit").value = -1;
     }

    function disable_ip()
    {
        var dhcpsvr = get_by_id("dhcpsvr");
        var is_hidden = "";

        if (dhcpsvr.checked)
            is_hidden = "";
        else
            is_hidden = "none";

        get_by_id("dhcpd_start").disabled = !dhcpsvr.checked;
        get_by_id("dhcpd_end").disabled = !dhcpsvr.checked;
        get_by_id("dhcpd_lease_time").disabled = !dhcpsvr.checked;
        get_by_id("always_broadcast").disabled = !dhcpsvr.checked;
        get_by_id("netbios_announcement").disabled = !dhcpsvr.checked;
        get_by_id("add_reserved").style.display = is_hidden;
        get_by_id("reservation_list").style.display = is_hidden;
        get_by_id("dhcpd_list").style.display = is_hidden;
    }

    function disable_netbios()
    {
        if (get_by_id("dhcpsvr").checked) {
            get_by_id("netbios_learn").disabled = !get_by_id("netbios_announcement").checked;
            disable_netbios_option(get_by_id("netbios_learn").disabled);
            if (get_by_id("netbios_announcement").checked) {
                disable_netbios_option(get_by_id("netbios_learn").checked);
            }
        }
        else {
            get_by_id("netbios_learn").disabled = true;
            disable_netbios_option(get_by_id("netbios_learn").disabled);
        }
    }

    function disable_netbios_option(flag)
    {
        get_by_id("dhcpd_static_scope").disabled = flag;
        for (var i = 0; i < 4; i++) {
            get_by_name("netbios_node")[i].disabled = flag;
        }
        get_by_id("wins_ip1").disabled = flag;
        get_by_id("wins_ip2").disabled = flag;
    }
	function netbios_selector(value)	
	{
		value = value * 1;
		if(value == 1)
		{
			get_by_id("wins_ip1").disabled = true;
			get_by_id("wins_ip2").disabled = true;
		}else{
			get_by_id("wins_ip1").disabled = false;
			get_by_id("wins_ip2").disabled = false;
		}
	}

    function update_data()
    {
        var max_row = parseInt(get_by_id("max_row").value) + 1;
        for (var ii = 0; ii < rule_max_num; ii++) {
            if (ii < 10)
                get_by_id("dhcpd_reserve_0" + ii).value = "";
            else
                get_by_id("dhcpd_reserve_" + ii).value = "";
        }

        for (var ii = 1; ii < max_row; ii++) {
            if (DataArray[ii].Name != "") {
                var dat = DataArray[ii].Enable +"/"+ DataArray[ii].Name +"/"+ DataArray[ii].IP +"/"+ DataArray[ii].MAC;
                if ((ii-1) < 10)
                    get_by_id("dhcpd_reserve_0" + (ii-1)).value = dat;
                else
                    get_by_id("dhcpd_reserve_" + (ii-1)).value = dat;
            }
        }
    }

    function check_dhcp_range()
    {
        var lan_ip = get_by_id("lan_ipaddr").value.split(".");
        var start_ip3 = get_by_id("dhcpd_start").value.split(".");
        var end_ip3 = get_by_id("dhcpd_end").value.split(".");
        var enrty_IP = lan_ip[2];
        get_by_id("dhcpd_start").value = lan_ip[0] +"."+lan_ip[1]+"." + enrty_IP +"." + start_ip3[3];
        get_by_id("dhcpd_end").value = lan_ip[0] +"."+lan_ip[1]+"." + enrty_IP +"." + end_ip3[3];
    }

    function send_request()
    {
        if (!save_reserved('N')) {
            return false;
        }

        if (!is_form_modified("form1") && !confirm(_ask_nochange)) {
            return false;
        }

        var dhcpsvr = get_by_id("dhcpsvr");
        var start_obj, end_obj;
        var temp_mac = "";
        var ip = get_by_id("lan_ipaddr").value;
        var mask = get_by_id("lan_netmask").value;
        var winsip1 = get_by_id("wins_ip1").value;
        var winsip2 = get_by_id("wins_ip2").value;

        var ip_addr_msg = replace_msg(all_ip_addr_msg,_ipaddr);
        var wan_ip_addr_msg = replace_msg(all_ip_addr_msg,_ipaddr);

        var temp_ip_obj = new addr_obj(ip.split("."), ip_addr_msg, false, false);
        var temp_mask_obj = new addr_obj(mask.split("."), subnet_mask_msg, false, false);
        var dhcp_les = get_by_id("dhcpd_lease_time").value;
        var dhcpd_domain_name = get_by_id("dhcpd_domain_name").value;
        var lan_device_name = get_by_id("lan_device_name").value;

        var wan_proto = "<% CmoGetCfg("wan_proto","none"); %>";
        var wan_port_status = "<% CmoGetStatus("wan_port_status"); %>";

        var wan_ip_addr_msg = replace_msg(all_ip_addr_msg,_ipaddr);
        var wan_proto = "<% CmoGetCfg("wan_proto","none"); %>";
        var wan_ip_addr;

        var temp_wins_ip1_obj = new addr_obj(winsip1.split("."), all_ip_addr_msg, false, false);
        var temp_wins_ip2_obj = new addr_obj(winsip2.split("."), all_ip_addr_msg, false, false);
        var netbios_scope = get_by_id("dhcpd_static_scope").value;

        if (!check_address(temp_ip_obj, temp_mask_obj) || !check_mask(temp_mask_obj)) {
            return false;
        }
        var k = get_by_id("max_row").value;
        if (k !="0") {
            var Res_ip_addr_msg = replace_msg(all_ip_addr_msg,"Reservation IP");
            var temp_data_rep_ip=DataArray[k].IP;
            var temp_data_res_ip_obj = new addr_obj(temp_data_rep_ip.split("."), Res_ip_addr_msg, false, false);

            if (!check_domain(temp_data_res_ip_obj, temp_mask_obj, temp_ip_obj)){
                alert(TEXT033+" " + temp_data_rep_ip + " "+GW_DHCP_SERVER_RESERVED_IP_IN_POOL_INVALID_a);
                return false;
            }	
        }	
        //check lan and wan is same subnet

        //get from nvram
        if (wan_proto == "static")
            wan_ip_addr= "<% CmoGetCfg("wan_static_ipaddr"); %>";
        else if (wan_proto == "pppoe")
            wan_ip_addr= "<% CmoGetCfg("wan_pppoe_ipaddr_00"); %>";
        else if (wan_proto == "pptp")
            wan_ip_addr= "<% CmoGetCfg("wan_pptp_ipaddr"); %>";
        else if (wan_proto == "l2tp")
            wan_ip_addr= "<% CmoGetCfg("wan_l2tp_ipaddr"); %>";
        else {
            var wan_ip_addr1 = get_by_id("wan_current_ipaddr").value.split("/");
            wan_ip_addr = wan_ip_addr1[0];
        }
        var wan_ip_addr_obj = new addr_obj(wan_ip_addr.split("."), wan_ip_addr_msg, false, false);

        if (wan_proto == "static" && wan_ip_addr != "0.0.0.0"){ // when wan static ip doesn't empty
            if (check_domain(temp_ip_obj, temp_mask_obj, wan_ip_addr_obj)) {
                alert(bln_alert_3);
                return false;
            }
        }
        else if (wan_proto != "static" & get_by_id("wan_current_ipaddr").value != "0.0.0.0/0.0.0.0/0.0.0.0/0.0.0.0/0.0.0.0") { // /PPTP/L2TP/PPPoE plug in WAN port
            if (check_domain(temp_ip_obj, temp_mask_obj, wan_ip_addr_obj)) {
                alert(bln_alert_3);
                return false;
            }
        }
        else if (wan_proto == "pppoe" && wan_ip_addr != "0.0.0.0") { // when wan pppoe ip doesn't empty
            if (check_domain(temp_ip_obj, temp_mask_obj, wan_ip_addr_obj)) {
                alert(bln_alert_3);
                return false;
            }
        }
        else if (wan_proto == "pptp" && wan_ip_addr != "0.0.0.0") { // when wan pptp ip doesn't empty
            if (check_domain(temp_ip_obj, temp_mask_obj, wan_ip_addr_obj)) {
                alert(bln_alert_3);
                return false;
            }
        }
        else if (wan_proto == "l2tp" && wan_ip_addr != "0.0.0.0") { // when wan l2tp ip doesn't empty
            if (check_domain(temp_ip_obj, temp_mask_obj, wan_ip_addr_obj)) {
                alert(bln_alert_3);
                return false;
            }
        }

        /* Check Device Name / Domain Name cannot entry  ~!@#$%^&*()_+}{[]\|"?></  */
        var re = /[^A-Za-z0-9_.\-]/;
        if (re.test(dhcpd_domain_name)) {
            alert(GW_LAN_DOMAIN_NAME_INVALID);
            return false;
        }

        re=/^\W/;
        if (re.test(lan_device_name) || is_number(lan_device_name)) {
            alert(GW_LAN_DEVICE_NAME_INVALID);
            return false;
        }

        if (check_DeviceName(lan_device_name)) {
            return false;
        }

        if (re.test(netbios_scope)) {
            alert(GW_LAN_NETBIOS_SCOPE_INVALID);
            return false;
        }

        if (dhcpd_domain_name.length == 1) {
            alert("Domain name given is invalid");
            return false;
        }

        if (dhcpd_domain_name.indexOf(".") != -1) {
            if (dhcpd_domain_name.lastIndexOf(".") == dhcpd_domain_name.length - 1 || dhcpd_domain_name.lastIndexOf(".") == 0) {
                alert("Domain name given is invalid");
                return false;
            }

            var i = dhcpd_domain_name.lastIndexOf(".") + 1;
            var ch = /[^A-Za-z]/;
            if (ch.test(dhcpd_domain_name.charAt(i))) {
                alert("Domain name given is invalid");
                return false;
            }
        }

        if (dhcpsvr.checked) {
            var start_ip = get_by_id("dhcpd_start").value;
            var end_ip = get_by_id("dhcpd_end").value;

            var start_ip_addr_msg = replace_msg(all_ip_addr_msg,TEXT035);
            var end_ip_addr_msg = replace_msg(all_ip_addr_msg,TEXT036);

            var start_obj = new addr_obj(start_ip.split("."), start_ip_addr_msg, false, false);
            var end_obj = new addr_obj(end_ip.split("."), end_ip_addr_msg, false, false);

            //check dhcp ip range equal to lan-ip or not?
            if (!check_LAN_ip(temp_ip_obj.addr, start_obj.addr, TEXT035)) {
                return false;
            }

            if (!check_LAN_ip(temp_ip_obj.addr, end_obj.addr, TEXT036)) {
                return false;
            }

            if (!check_LAN_ip(temp_ip_obj.addr, temp_wins_ip1_obj.addr, bd_NETBIOS_PRI_WINS)) {
                return false;
            }

            if(!check_LAN_ip(temp_ip_obj.addr, temp_wins_ip2_obj.addr,  bd_NETBIOS_SEC_WINS)) {
                return false;
            }

            //check dhcp ip range and lan ip the same mask or not?
            if (!check_address(start_obj, temp_mask_obj, temp_ip_obj) || !check_address(end_obj, temp_mask_obj, temp_ip_obj)) {
                return false;
            }

            if (!check_domain(temp_ip_obj, temp_mask_obj, start_obj)) {
                alert(TEXT037);
                return false;
            }

            if (!check_domain(temp_ip_obj, temp_mask_obj, end_obj)) {
                alert(TEXT038);
                return false;
            }

            if (!check_ip_order(start_obj, end_obj)) {
                alert(TEXT039);
                return false;
            }

            if (check_lanip_order(temp_ip_obj,start_obj, end_obj)) {
                alert(network_dhcp_ip_in_server);
                return false;
            }

            var less_msg = replace_msg(check_num_msg, bd_DLT, 1, 999999);
            var temp_less = new varible_obj(dhcp_les, less_msg, 1, 999999, false);
            if (!check_varible(temp_less)) {
                return false;
            }

            if (get_by_id("netbios_announcement").checked && !get_by_id("netbios_learn").checked) {
                var wins_ip1 = get_by_id("wins_ip1").value;
                var wins_ip2 = get_by_id("wins_ip2").value;
                var wins_ip1_addr_msg = replace_msg(all_ip_addr_msg,bd_NETBIOS_PRI_WINS);
                var wins_ip2_addr_msg = replace_msg(all_ip_addr_msg,bd_NETBIOS_SEC_WINS);
                var wins_ip1_obj = new addr_obj(wins_ip1.split("."), wins_ip1_addr_msg, false, false);
                var wins_ip2_obj = new addr_obj(wins_ip2.split("."), wins_ip2_addr_msg, false, false);

                if (!get_by_name("netbios_node")[0].checked && (!check_address(wins_ip1_obj) || !check_address(wins_ip2_obj))) {
                    return false;
                }
                else if (get_by_name("netbios_node")[0].checked) {
                    if (wins_ip1 !="" && !check_address(wins_ip1_obj))
                        return false;

                    if (wins_ip2 !="" && !check_address(wins_ip2_obj))
                        return false;
                }
            }
        }

        //decide reboot type
	if ( !are_values_equal(get_by_id("dhcpd_domain_name").getAttribute('default'), dhcpd_domain_name) )
	{
		get_by_id("reboot_type").value = "wan";
	}
        if ((get_by_id("dhcpd_netbios_enable").value == 1) && (get_by_id("dhcpd_netbios_learn").value == 1)) {   //It enables learn NETBIOS from WAN originally.
            if (!(get_checked_value(get_by_id("netbios_announcement")) && get_checked_value(get_by_id("netbios_learn")))) //But, it disables learn NETBIOS from WAN now.
                get_by_id("reboot_type").value = "all";
        }
        else {   //It disables learn NETBIOS from WAN originally.
            if (get_checked_value(get_by_id("netbios_announcement")) && get_checked_value(get_by_id("netbios_learn")))  //But, it enables learn NETBIOS from WAN now.
                get_by_id("reboot_type").value = "all";
        }

        if (check_address(temp_ip_obj, temp_mask_obj) && check_mask(temp_mask_obj)) {
            update_data();

            get_by_id("dhcpd_enable").value = get_checked_value(get_by_id("dhcpsvr"));
            get_by_id("dns_relay").value = get_checked_value(get_by_id("DNSrelay"));

            get_by_id("dhcpd_always_bcast").value = get_checked_value(get_by_id("always_broadcast"));
            get_by_id("dhcpd_netbios_enable").value = get_checked_value(get_by_id("netbios_announcement"));
            get_by_id("dns_relay").value = get_checked_value(get_by_id("DNSrelay"));
            get_by_id("dhcpd_netbios_learn").value = get_checked_value(get_by_id("netbios_learn"));
            get_by_id("dhcpd_static_node_type").value = get_checked_value(get_by_name("netbios_node"));

            get_by_id("dhcpd_static_wins_server").value = get_by_id("wins_ip1").value + "/" + get_by_id("wins_ip2").value;

            if (get_by_id("lan_ipaddr").value == "<% CmoGetCfg("lan_ipaddr","none"); %>") {
                document.form1.html_response_page.value = "back.asp";
            }

            if (submit_button_flag == 0) {
                submit_button_flag = 1;
                return true;
            }
        }

        return false;
    }

    function revoke(idx)
    {
        get_by_id("revoke_ip").value = DHCPL_DataArray[idx].IP;
        get_by_id("revoke_mac").value = DHCPL_DataArray[idx].MAC;
        send_submit("form2");
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
																	<script>
																		show_side_bar(2);
																	</script>
                                </ul>
                            </div>
                        </td>
                    </tr>
                </table>
            </td>

            <input type="hidden" id="wan_current_ipaddr" name="wan_current_ipaddr" value="<% CmoGetStatus("wan_current_ipaddr_00"); %>">
            <input type="hidden" id="dhcp_list" name="dhcp_list" value="<% CmoGetList("dhcpd_leased_table"); %>">

            <form id="form2" name="form2" method="post" action="dhcp_revoke.cgi">
            <input type="hidden" id="html_response_page" name="html_response_page" value="lan.asp">
            <input type="hidden" id="html_response_return_page" name="html_response_return_page" value="lan.asp">
            <input type="hidden" id="revoke_ip" name="revoke_ip">
            <input type="hidden" id="revoke_mac" name="revoke_mac">
            </form>

            <form id="form1" name="form1" method="post" action="apply.cgi">
            <input type="hidden" id="html_response_page" name="html_response_page" value="back_lan.asp">
            <input type="hidden" id="html_response_message" name="html_response_message" value="">
            <script>get_by_id("html_response_message").value = sc_intro_sv;</script>
            <input type="hidden" id="html_response_return_page" name="html_response_return_page" value="lan.asp">
            <input type="hidden" id="reboot_type" name="reboot_type" value="lan">
            <input type="hidden" id="del" name="del" value="-1">
            <input type="hidden" id="edit" name="edit" value="-1">
            <input type="hidden" id="max_row" name="max_row" value="-1">
	    <input type="hidden" id="opendns_enable" name="opendns_enable" value="<% CmoGetCfg("opendns_enable","none"); %>">
            <input type="hidden" id="mac_clone_addr" name="mac_clone_addr" value="<% CmoGetStatus("mac_clone_addr"); %>">
            <input type="hidden" id="dhcpd_reserve_00" name="dhcpd_reserve_00" value="<% CmoGetCfg("dhcpd_reserve_00","none"); %>">
            <input type="hidden" id="dhcpd_reserve_01" name="dhcpd_reserve_01" value="<% CmoGetCfg("dhcpd_reserve_01","none"); %>">
            <input type="hidden" id="dhcpd_reserve_02" name="dhcpd_reserve_02" value="<% CmoGetCfg("dhcpd_reserve_02","none"); %>">
            <input type="hidden" id="dhcpd_reserve_03" name="dhcpd_reserve_03" value="<% CmoGetCfg("dhcpd_reserve_03","none"); %>">
            <input type="hidden" id="dhcpd_reserve_04" name="dhcpd_reserve_04" value="<% CmoGetCfg("dhcpd_reserve_04","none"); %>">
            <input type="hidden" id="dhcpd_reserve_05" name="dhcpd_reserve_05" value="<% CmoGetCfg("dhcpd_reserve_05","none"); %>">
            <input type="hidden" id="dhcpd_reserve_06" name="dhcpd_reserve_06" value="<% CmoGetCfg("dhcpd_reserve_06","none"); %>">
            <input type="hidden" id="dhcpd_reserve_07" name="dhcpd_reserve_07" value="<% CmoGetCfg("dhcpd_reserve_07","none"); %>">
            <input type="hidden" id="dhcpd_reserve_08" name="dhcpd_reserve_08" value="<% CmoGetCfg("dhcpd_reserve_08","none"); %>">
            <input type="hidden" id="dhcpd_reserve_09" name="dhcpd_reserve_09" value="<% CmoGetCfg("dhcpd_reserve_09","none"); %>">
            <input type="hidden" id="dhcpd_reserve_10" name="dhcpd_reserve_10" value="<% CmoGetCfg("dhcpd_reserve_10","none"); %>">
            <input type="hidden" id="dhcpd_reserve_11" name="dhcpd_reserve_11" value="<% CmoGetCfg("dhcpd_reserve_11","none"); %>">
            <input type="hidden" id="dhcpd_reserve_12" name="dhcpd_reserve_12" value="<% CmoGetCfg("dhcpd_reserve_12","none"); %>">
            <input type="hidden" id="dhcpd_reserve_13" name="dhcpd_reserve_13" value="<% CmoGetCfg("dhcpd_reserve_13","none"); %>">
            <input type="hidden" id="dhcpd_reserve_14" name="dhcpd_reserve_14" value="<% CmoGetCfg("dhcpd_reserve_14","none"); %>">
            <input type="hidden" id="dhcpd_reserve_15" name="dhcpd_reserve_15" value="<% CmoGetCfg("dhcpd_reserve_15","none"); %>">
            <input type="hidden" id="dhcpd_reserve_16" name="dhcpd_reserve_16" value="<% CmoGetCfg("dhcpd_reserve_16","none"); %>">
            <input type="hidden" id="dhcpd_reserve_17" name="dhcpd_reserve_17" value="<% CmoGetCfg("dhcpd_reserve_17","none"); %>">
            <input type="hidden" id="dhcpd_reserve_18" name="dhcpd_reserve_18" value="<% CmoGetCfg("dhcpd_reserve_18","none"); %>">
            <input type="hidden" id="dhcpd_reserve_19" name="dhcpd_reserve_19" value="<% CmoGetCfg("dhcpd_reserve_19","none"); %>">
            <input type="hidden" id="dhcpd_reserve_20" name="dhcpd_reserve_20" value="<% CmoGetCfg("dhcpd_reserve_20","none"); %>">
            <input type="hidden" id="dhcpd_reserve_21" name="dhcpd_reserve_21" value="<% CmoGetCfg("dhcpd_reserve_21","none"); %>">
            <input type="hidden" id="dhcpd_reserve_22" name="dhcpd_reserve_22" value="<% CmoGetCfg("dhcpd_reserve_22","none"); %>">
            <input type="hidden" id="dhcpd_reserve_23" name="dhcpd_reserve_23" value="<% CmoGetCfg("dhcpd_reserve_23","none"); %>">
            <input type="hidden" id="dhcpd_reserve_24" name="dhcpd_reserve_24" value="<% CmoGetCfg("dhcpd_reserve_24","none"); %>">

            <td valign="top" id="maincontent_container">
                <div id="maincontent">
                  <div id="box_header">
            <h1>
              <script>show_words(bln_title_NetSt)</script>
            </h1>
            <script>show_words(ns_intro_)</script>
            <br>
                  <br>
             <input name="button" id="button" type="submit" class=button_submit value="" onClick="return send_request()">
			<input name="button2" id="button2" type="button" class=button_submit value="" onclick="page_cancel('form1', 'lan.asp');">
			<script>check_reboot();</script>
			<script>get_by_id("button").value = _savesettings;</script>
			<script>get_by_id("button2").value = _dontsavesettings;</script>
		    </div>
                  <div class="box">
            <h2>
              <script>show_words(bln_title_Rtrset)</script>
            </h2>

            <p>
              <script>show_words(YM97)</script>
            </p>
                            <table cellpadding="1" cellspacing="1" border="0" width="525">
                                <tr>

                <td class="duple">
                  <script>show_words(_ripaddr)</script>
                  :</td>
                                    <td width="340">&nbsp;&nbsp;&nbsp;<input name="lan_ipaddr" type="text" id="lan_ipaddr" size="20" maxlength="15" onChange="check_dhcp_range()" value='<% CmoGetCfg("lan_ipaddr","none"); %>'></td>
                                </tr>
                                <tr>

                <td class="duple">
                  <script>show_words(_subnet)</script>
                  :</td>
                                    <td width="340">&nbsp;&nbsp;&nbsp;<input name="lan_netmask" type="text" id="lan_netmask" size="20" maxlength="15" value="<% CmoGetCfg("lan_netmask","none"); %>"></td>
                                </tr>
                                <tr>
									<td class="duple"><script>show_words(DEVICE_NAME)</script> :</td>
                                    <td width="340">&nbsp;&nbsp;&nbsp;<input name="lan_device_name" type="text" id="lan_device_name" size="20" maxlength="15" value='<% CmoGetCfg("lan_device_name","none"); %>'></td>
                                </tr>
                                <tr>

                <td class="duple">
                  <script>show_words(_262)</script>
                  :</td>
                                  <td width="340">&nbsp;&nbsp;
                                  <input name="dhcpd_domain_name" type="text" id="dhcpd_domain_name" size="40" maxlength="30" value="<% CmoGetCfg("dhcpd_domain_name","none"); %>"></td>
                                </tr>
                                <tr>

                <td class="duple">
                  <script>show_words(bln_EnDNSRelay)</script>
                  :</td>
                                    <td width="340">&nbsp;
                                    <input name="DNSrelay" type=checkbox id="DNSrelay" value="1">
                                    <input type="hidden" id="dns_relay" name="dns_relay" value="<% CmoGetCfg("dns_relay","none"); %>">
                                    </td>
                                </tr>
                      </table>
                  </div>
                  <div class="box">
            <h2>
              <script>show_words(bd_title_DHCPSSt)</script>
            </h2>
							<p>
              <script>show_words(bd_intro_)</script>
            </p>
                          <table width="525" border=0 cellPadding=1 cellSpacing=1 class=formarea summary="">
                                <tr>

                <td class="duple">
                  <script>show_words(bd_EDSv)</script>
                  :</td>
                                  <input type="hidden" id="dhcpd_enable" name="dhcpd_enable" value="<% CmoGetCfg("dhcpd_enable","none"); %>">
                                  <td width="340">&nbsp;<input name="dhcpsvr" type=checkbox id="dhcpsvr" onClick="disable_ip()" value="1"></td>
                                </tr>
                                <tr>

                <td class="duple">
                  <script>show_words(bd_DIPAR)</script>
                  :</td>
                                  <td width="340">&nbsp;
                                    <input type="text" id="dhcpd_start" name="dhcpd_start" value="<% CmoGetCfg("dhcpd_start","none"); %>" size="20" maxlength="15">
                  &nbsp;
                  <script>show_words(_to)</script>
                                    <input type="text" id="dhcpd_end" name="dhcpd_end" value="<% CmoGetCfg("dhcpd_end","none"); %>" size="20" maxlength="15">
                                  </td>
                                </tr>
                                <tr>

                <td class="duple">
                  <script>show_words(bd_DLT)</script>
                  :</td>
                                  <td width="340">&nbsp;&nbsp;<input type="text" id="dhcpd_lease_time" name="dhcpd_lease_time" size="6" maxlength="6" value="<% CmoGetCfg("dhcpd_lease_time","none"); %>">
                  &nbsp;&nbsp;
                  <script>show_words(_minutes)</script>
                </td>
                                </tr>
                                <tr>

                <td class="duple">
                  <script>show_words(bd_DAB)</script>
                  :</td>
                                  <input type="hidden" id="dhcpd_always_bcast" name="dhcpd_always_bcast" value="<% CmoGetCfg("dhcpd_always_bcast","none"); %>">
                                  <td width="340">&nbsp;<input name="always_broadcast" type=checkbox id="always_broadcast" value="1">
                  <script>show_words(bd_DAB_note)</script>
                </td>
                                </tr>
                                <tr>

                <td class="duple">
                  <script>show_words(bd_NETBIOS_ENABLE)</script>
                  :</td>
                                  <input type="hidden" id="dhcpd_netbios_enable" name="dhcpd_netbios_enable" value="<% CmoGetCfg("dhcpd_netbios_enable","none"); %>">
                                  <td width="340">&nbsp;<input type=checkbox id="netbios_announcement" name="netbios_announcement" value="1" onClick="disable_netbios();"></td>
                                </tr>
                                <tr>

                <td class="duple">
                  <script>show_words(bd_NETBIOS_LEARN_FROM_WAN_ENABLE)</script>
                  :</td>
                                  <input type="hidden" id="dhcpd_netbios_learn" name="dhcpd_netbios_learn" value="<% CmoGetCfg("dhcpd_netbios_learn","none"); %>">
                                  <td width="340">&nbsp;<input type=checkbox id="netbios_learn" name="netbios_learn" value="1" onClick="disable_netbios();"></td>
                                </tr>
                                <tr>

                <td class="duple">
                  <script>show_words(bd_NETBIOS_SCOPE)</script>
                  :</td>
                                  <td width="340">&nbsp;&nbsp;<input type="text" id="dhcpd_static_scope"  name="dhcpd_static_scope" maxlength="30" value="<% CmoGetCfg("dhcpd_static_scope","none"); %>">
                  (
                  <script>show_words(LT124)</script>
                  )</td>
                                </tr>
                                <tr>

                <td class="duple" valign="top">
                  <script>show_words(bd_NETBIOS_REG_TYPE)</script>
                  :</td>
                                  <input type="hidden" id="dhcpd_static_node_type" name="dhcpd_static_node_type" value="<% CmoGetCfg("dhcpd_static_node_type","none"); %>">
                                  <td width="340">
								  &nbsp;<input type="radio" id="netbios_node"  name="netbios_node" value="1" onClick="netbios_selector(this.value);">
                  						<script>show_words(bd_NETBIOS_REG_TYPE_B)</script>
                 						 <br>
								  &nbsp;<input type="radio" name="netbios_node" value="2" onClick="netbios_selector(this.value);">
										  <script>show_words(bd_NETBIOS_REG_TYPE_P)</script>
										  <br>
								  &nbsp;<input type="radio" name="netbios_node" value="4" onClick="netbios_selector(this.value);">
										  <script>show_words(bd_NETBIOS_REG_TYPE_M)</script>
										  <br>
								  &nbsp;<input type="radio" name="netbios_node" value="8" onClick="netbios_selector(this.value);">
										  <script>show_words(bd_NETBIOS_REG_TYPE_H)</script>
                                  </td>
                                </tr>
                                <tr>

                <td class="duple">
                  <script>show_words(bd_NETBIOS_PRI_WINS)</script>
                  :</td>
                                  <td width="340">&nbsp;&nbsp;<input type="text" id="wins_ip1"  name="wins_ip1" size="20" maxlength="15"></td>
                                </tr>
                                <tr>

                <td class="duple">
                  <script>show_words(bd_NETBIOS_SEC_WINS)</script>
                  :</td>
                                  <td width="340">&nbsp;&nbsp;<input type="text" id="wins_ip2"  name="wins_ip2" size="20" maxlength="15">
                                  <input type="hidden" id="dhcpd_static_wins_server" name="dhcpd_static_wins_server" value="<% CmoGetCfg("dhcpd_static_wins_server","none"); %>">
                                  </td>
                                </tr>
                    </table>
                  </div>
                  <div class="box" id="add_reserved">
						<h2><script>show_words(_add)</script> <script>show_words(bd_title_SDC)</script></h2>
                          <table width="525" border=0 cellPadding=1 cellSpacing=1 class=formarea summary="">
                                <tr>
                                  <td class="duple"><script>show_words(_enable)</script> :</td>
                                  <td width="340">&nbsp;<input type=checkbox id="reserved_enable" name="reserved_enable"></td>
                                </tr>
                                <tr>
                                  <td class="duple"><script>show_words(bd_CName)</script> :</td>
                                  <td width="340">&nbsp;
                                    <input type=text id="reserved_name" name="reserved_name" size="20" maxlength="95">
                                    &lt;&lt;
                                    <select id="reserved_list" name="reserved_list" onChange="set_reserved()">
										<option value=-1><script>show_words(bd_CName)</script></option>
                                        <script>
                                        set_mac_list("name");
                                        </script>
                                    </select>
                                  </td>
                                </tr>
                                <tr>
                                  <td class="duple"><script>show_words(_ipaddr)</script> :</td>
                                  <td width="340">&nbsp;&nbsp;<input type=text id="reserved_ip" name="reserved_ip" size="20" maxlength="15"></td>
                                </tr>
                                <tr>
                                  <td class="duple"><script>show_words(_macaddr)</script> :</td>
                                  <td width="340">&nbsp;&nbsp;<input type=text id="reserved_mac" name="reserved_mac" size="20" maxlength="17"></td>
                                </tr>
                                <tr>
                                    <td class="duple">&nbsp;</td>
                                    <td width="340">&nbsp;
									 <script>document.write('<input id="clone" name="clone" type="button" class=button_submit value="'+_clone+'" onClick="clone_mac_action();">')</script>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="duple">&nbsp;</td>
                                    <td width="340">&nbsp;
									<input id="save" name="save" type="button" class=button_submit value="" onClick="save_reserved('Y');">
                  					<input id="clear" name="clear" type="button" class=button_submit value="" onClick="clear_reserved();">
               						<script>get_by_id("save").value = _save;</script>
									<script>get_by_id("clear").value = _clear;</script>

                                    </td>
                                </tr>
                          </table>
                  </div>
                  <div class=box id="reservation_list">
            <h2>
              <script>show_words(bd_title_list)</script>
            </h2>
                      <table id="table1" width="525" border=1 cellPadding=1 cellSpacing=1 bgcolor="#DFDFDF" bordercolor="#FFFFFF">
                          <tr>
							<td><script>show_words(_enable)</script></td>
	                        <td><script>show_words(help260)</script></td>
	                        <td><script>show_words(_macaddr)</script></td>
	                        <td><script>show_words(_ipaddr)</script></td>
                            <td></td>
                            <td></td>
                          </tr>
                        <script>
                            set_reservation();
                            var is_enable = "";
                            for(i = 1; i < DataArray.length; i++){
                                if(parseInt(DataArray[i].Enable)){
                                    is_enable = "checked";
                                }else{
                                    is_enable = "";
                                }
                                document.write("<tr><td><center><input type=checkbox id=r_enable" + i + " name=r_enable" + i + " onClick='set_reserved_enable(" + i + ")' " + is_enable + "></center></td><td><center>" + DataArray[i].Name +"</td><td><center>" + DataArray[i].MAC +"</center></td><td><center>"+ DataArray[i].IP +"</center></td><td><center><a href=\"javascript:edit_row("+ i +")\"><img src=\"edit.jpg\" border=\"0\" alt=\"edit\"></a></center></td><td><center><a href=\"javascript:del_row(" + i +")\"><img src=\"delete.jpg\"  border=\"0\" alt=\"delete\"></a></center></td></tr>");
                            }
                        </script>
                      </table>
                  </div>
                  <div class=box id="dhcpd_list">
	                  <h2><script>show_words(bd_title_clients)</script> <span id="dhcp_num"></span></h2>
                      <table id="table1" width="525" border=1 cellPadding=1 cellSpacing=1 bgcolor="#DFDFDF" bordercolor="#FFFFFF">
                          <tr>
	                        <td><script>show_words(LS422)</script></td>
	                        <td><script>show_words(LS423)</script></td>
	                        <td><script>show_words(LS424)</script></td>
	                        <td><script>show_words(LS425)</script></td>
                            <td></td>
                            <td></td>
                          </tr>
                        <script>
                            set_lan_dhcp_list();
                            for(i=0;i<DHCPL_DataArray.length;i++){
                                document.write("<tr><td><center>"+ DHCPL_DataArray[i].MAC +"</center></td><td><center>"+ DHCPL_DataArray[i].IP +"</center></td><td><center>"+ DHCPL_DataArray[i].Name +"</center></td><td><center>"+ DHCPL_DataArray[i].EXP_T +"</center></td><td><center><a href='javascript:revoke(" + i + ")'>Revoke</a></center></td><td><center><a href='javascript:edit_dhcp_client(" + i + ")'>Reserve</a></center></td></tr>");
                            }
                        </script>
                      </table>
                  </div>
            </div>
            </td></form>
            <td valign="top" width="150" id="sidehelp_container" align="left">
                <table cellSpacing=0 cellPadding=2 bgColor=#ffffff border=0>
                    <tr>

          <td id=help_text><strong>
            <script>show_words(_hints)</script>
            &hellip;</strong> <p>
              <script>show_words(TA7)</script>
            </p>

            <p>
              <script>show_words(TA8)</script>
            </p>
						 <p><a href="support_internet.asp#Network" onclick="return jump_if();"><script>show_words(_more)</script>&hellip;</a></p>
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
