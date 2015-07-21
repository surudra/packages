<HTML>
<HEAD>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">


<LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
<SCRIPT SRC="webMethods.js.txt"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">
  
  function confirmDelete (alias) {
    var msg = "OK to delete the proxy alias '"+alias+"'?";
    if (confirm (msg)) {
        document.settingsNetwork.proxyAlias.value = alias;
        document.settingsNetwork.action.value = "delete";
        document.settingsNetwork.submit();
        return false;
    } 
	else 
		return false;
  }

  function confirmStatusChange(alias, action)
  {
    var msg = "";
    if ( action == "enable") {
		msg = "Are you sure you want to enable the proxy alias '"+alias+"'?";
    }
    else if ( action == "disable") {
		msg = "Are you sure you want to disable the proxy alias '"+alias+"'?";
    }

    if (confirm (msg)) {
		document.settingsNetwork.proxyAlias.value = alias;
		document.settingsNetwork.action.value = action;
        document.settingsNetwork.submit();
        return false;
    } 
    else 
        return false;
  }
  
</SCRIPT>
<base target="_self">
	<style>
	  .listbox  { width: 50%; }
	</style>
</HEAD>
<BODY onLoad="setNavigation('settings-network.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_ProxyServersScrn');">
<FORM name="settingsNetwork" action="settings-network.dsp" method="POST">
  <INPUT type="hidden" name="action" value="">
  <INPUT type="hidden" name="proxyAlias">
  <TABLE width="100%">
	<TR>
	    <TD class="menusection-Settings" colspan="2">
	    Settings &gt;
	    Proxy Servers </TD>
	</TR>

	%ifvar action%
		%switch action%
		%case 'add'%
			%invoke wm.server.proxy:createProxyServerAlias%
				%ifvar message%
				  <tr><td colspan="2">&nbsp;</td></tr>
				  <TR><TD class="message" colspan="2">%value message%</TD></TR>
				%endif%
				%onerror%
					%ifvar errorMessage%
						<tr><td colspan="2">&nbsp;</td></tr>
						<tr><td class="message" colspan=2>%value errorMessage%</td></tr>
					%endif%
			%endinvoke%
		%case 'edit'%
			%invoke wm.server.proxy:createProxyServerAlias%
				%ifvar message%
				  <tr><td colspan="2">&nbsp;</td></tr>
				  <TR><TD class="message" colspan="2">%value message%</TD></TR>
				%endif%
				%onerror%
					%ifvar errorMessage%
						<tr><td colspan="2">&nbsp;</td></tr>
						<tr><td class="message" colspan=2>%value errorMessage%</td></tr>
					%endif%
			%endinvoke%
		%case 'editBypass'%
			%invoke wm.server.admin:setSettings%
				%ifvar message%
				  <tr><td colspan="2">&nbsp;</td></tr>
				  <TR><TD class="message" colspan="2">%value message%</TD></TR>
				%endif%
				%onerror%
					%ifvar errorMessage%
						<tr><td colspan="2">&nbsp;</td></tr>
						<tr><td class="message" colspan=2>%value errorMessage%</td></tr>
					%endif%
			%endinvoke%
		%case 'delete'%
			%invoke wm.server.proxy:deleteProxyServerAlias%
				%ifvar message%
					<tr><td colspan="2">&nbsp;</td></tr>
					<TR><TD class="message" colspan="2">%value message%</TD></TR>
				%endif%
				%onerror%
					%ifvar errorMessage%
						<tr><td colspan="2">&nbsp;</td></tr>
						<tr><td class="message" colspan=2>%value errorMessage%</td></tr>
					%endif%
			%endinvoke%
		%case 'disable'%
			%invoke wm.server.proxy:disableProxyServerAlias%
				%ifvar message%
				  <tr><td colspan="2">&nbsp;</td></tr>
				  <TR><TD class="message" colspan="2">%value message%</TD></TR>
				%endif%
				%onerror%
					%ifvar errorMessage%
						<tr><td colspan="2">&nbsp;</td></tr>
						<tr><td class="message" colspan=2>%value errorMessage%</td></tr>
					%endif%
			%endinvoke%	  
		%case 'enable'%
			%invoke wm.server.proxy:enableProxyServerAlias%
				%ifvar message%
				  <tr><td colspan="2">&nbsp;</td></tr>
				  <TR><TD class="message" colspan="2">%value message%</TD></TR>
				%endif%
				%onerror%
					%ifvar errorMessage%
						<tr><td colspan="2">&nbsp;</td></tr>
						<tr><td class="message" colspan=2>%value errorMessage%</td></tr>
					%endif%
			%endinvoke%	  
		%endswitch%
	%endif%
		
	<TR>
	    <TD colspan="2">
	        <UL>
	            <LI><A HREF="settings-proxy-addedit.dsp?action=add">Create Proxy Server Alias</A></LI>
	            <LI><A HREF="settings-proxy-addedit.dsp?action=editBypass">Edit Proxy Bypass</A></LI>	            
	        </UL>
	    </TD>
	</TR>
	%invoke wm.server.proxy:getProxyServerList%
	<TR>
	    <TD></TD>
	    <TD>
	    <TABLE class="tableView" width=100%>
		    <TR>
		        <TD class="heading" colspan=8>Proxy Servers List</TD>
		    </TR>
			<TR>
			   <TD class="oddcol">Default</TD>	
			   <TD class="oddcol-l">Alias</TD>
			   <TD class="oddcol">Protocol</TD>			   
			   <TD class="oddcol">Host</TD>
			   <TD class="oddcol">Port</TD>
			   <TD class="oddcol">User</TD>   
   			   <TD class="oddcol">Enabled</TD>   
			   <TD class="oddcol">Delete</TD>
			</TR>
			%loop -struct proxyServerList%
			%scope #$key%
			<TR>
					<script>writeTD("rowdata");</script>
				    	%ifvar isDefault equals('Y')%
				    		<IMG SRC="images/green_check.gif">
				    	%endif%
				    </TD>			    
				    <script>writeTD("rowdata-l");</script>
				        <a href="settings-proxy-addedit.dsp?action=edit&isDefault=%value isDefault%&protocol=%value protocol%&ftpType=%value ftpType%&proxyAlias=%value -urlencode proxyAlias%&status=%value -urlencode status%&host=%value -urlencode host%&port=%value -urlencode port%&username=%value -urlencode username%&password=%value -urlencode password%"
				        >%value proxyAlias%</a>
				    </TD>
				    <script>writeTD("rowdata");</script>%value protocol%</TD>					    
				    <script>writeTD("rowdata");</script>%value host%</TD>
				    <script>writeTD("rowdata");</script>%value port%</TD>
				    <script>writeTD("rowdata");</script>%value username%</TD>
				    <script>writeTD("rowdata");</script>
						%ifvar status equals('Disabled')%
						   	<a href="settings-network.dsp" onClick="return confirmStatusChange('%value proxyAlias%', 'enable');">No</a>
						%else%
						    <a href="settings-network.dsp" onClick="return confirmStatusChange('%value proxyAlias%', 'disable');">Yes</a>
						%endif%
					<script>writeTD("rowdata");</script>
						<a class="imagelink" onClick="return confirmDelete('%value proxyAlias%');">
							<img src="icons/delete.gif" alt="Delete alias : %value proxyAlias%" border=0>
						</a>
					</TD>
			%endscope%
			</TR>
			<script>swapRows();</script>
			%endloop%
		%endinvoke%	  
		</TABLE>
		</TD>
	</TR>
	
	%invoke wm.server.query:getSettings%	
	<TR><TD colspan="2"/><TD><IMG SRC="images/blank.gif" height=10 width=5 border=0></TD></TR>
	<TR><TD/><TD class="heading">Proxy Bypass</TD></TR>
	<tr>
		<td/>
        <td class="oddrowdata-l"><script>
            writeEdit("%value ../doc%", "watt.net.proxySkipList",
                "%value -code watt.net.proxySkipList%");
        </script></td>
    </tr>
	%endinvoke%
</TABLE>
</FORM>
</BODY>
</HTML>
