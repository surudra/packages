<html>
<head>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <meta http-equiv="Expires" content="-1">
  <link rel="stylesheet" TYPE="text/css" href="webMethods.css">
  <script src="webMethods.js.txt"></script>
  <script language="JavaScript">

	function validate( oper)
	{
		if(oper == 'edit')
		{
		var host = trimStr(document.htmlform_saConfig.hostName.value);
			document.htmlform_saConfig.hostName.value = host;
			var port = trimStr(document.htmlform_saConfig.port.value);
			document.htmlform_saConfig.port.value = port;
			if(0 == host.length)
			{
				alert("You must specify a valid value for the field : 'hostName'")
				document.htmlform_saConfig.hostName.focus();
				return false;
			} 
			if(validatePort(port))
			{
				alert("You must specify a valid value for the field : 'port'")
				document.htmlform_saConfig.port.focus();
				return false;
			}
			document.htmlform_saConfig.operation.value= 'edit';
		}
		else
		{
			var svrAlias = trimStr(document.htmlform_saConfig.alias.value);
			document.htmlform_saConfig.alias.value = svrAlias;
			var host = trimStr(document.htmlform_saConfig.hostName.value);
			document.htmlform_saConfig.hostName.value = host;
			var port = trimStr(document.htmlform_saConfig.port.value);
			document.htmlform_saConfig.port.value = port;
			var hostkeyloc = trimStr(document.htmlform_saConfig.hostKeyLocation.value);
			document.htmlform_saConfig.hostKeyLocation.value = hostkeyloc;
			if(0 == svrAlias.length)
			{
				alert("You must specify a valid value for the field : 'alias'")
				document.htmlform_saConfig.alias.focus();
				return false;
			} 
			if(0 == host.length)
			{
				alert("You must specify a valid value for the field : 'hostName'")
				document.htmlform_saConfig.hostName.focus();
				return false;
			} 
			if(validatePort(port))
			{
				alert("You must specify a valid value for the field : 'port'")
				document.htmlform_saConfig.port.focus();
				return false;
			} 
			if(0 == hostkeyloc.length)
			{
				alert("You must specify a valid value for the field : 'hostKeyLocation'")
				document.htmlform_saConfig.hostKeyLocation.focus();
				return false;
			} 
			
			document.htmlform_saConfig.operation.value= 'add';
		}
		return true;
	}
	
	function validatePort(port){
		if((0 == port.length) || (isNaN(port)) || (0> port) || (65535 > port))
			return false;
		return true;
	}
	function trimStr(str) {
	  return str.replace(/^\s+|\s+$/g, '');
	}
	
	function populateForm(destForm , srcForm, oper)
	{
		destForm.operation.value = oper;
		destForm.user_action.value = 'gethostkey';
		destForm.alias.value = srcForm.alias.value;
		destForm.hostName.value = srcForm.hostName.value;
		destForm.port.value = srcForm.port.value;
		destForm.hostKeyLocation.value = srcForm.hostKeyLocation.value;
		if('edit' == oper){
			destForm.fingerprint.value = srcForm.fingerprint.value;
		}
		destForm.submit();
	}
  </script>
 
  %ifvar operation equals('edit')%
	<body onLoad="setNavigation('settings-sftp-client-server-addedit.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_SFTP_ServerAliasSettings_Edit');">
  %else%
	<body onLoad="setNavigation('settings-sftp-client-server-addedit.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_SFTP_ServerAliasSettings_Create');">
  %endif%
    <table width="100%">
		<tr>
			<td class="menusection-Settings" colspan="2"> 
				Settings &gt; SFTP &gt; %ifvar operation equals('edit')%%value alias%&nbsp;&gt;&nbsp;Edit%else%Create Server Alias%endif%
			</td>
		</tr>
		%ifvar user_action equals('gethostkey')%
			%invoke wm.server.sftpclient:getServerHostKey%
				%ifvar message%
					<tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan="2">%value message%</td></tr>
				%endif%
				%onerror%
					<tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan=2>%value errorMessage%</td></tr>
			%endinvoke%
		%else%
			%ifvar operation equals('edit')%
				%invoke wm.server.sftpclient:getServerAliasInfo%
					%ifvar message%
						<tr><td colspan="2">&nbsp;</td></tr>
						<tr><td class="message" colspan="2">%value message%</td></tr>
					%endif%
					%onerror%
						<tr><td colspan="2">&nbsp;</td></tr>
						<tr><td class="message" colspan=2>%value errorMessage%</td></tr>
					%endinvoke%
			%endif%	
		%endif%
		<tr>
			<td colspan="2">
				<ul>
					<li><a href="settings-sftp-client.dsp">Return to SFTP</a></li>
				</ul>
			</td>
		</tr>
		<tr>
			<td>
			<form name="htmlform_saConfig" action="settings-sftp-client.dsp" method="POST">
			<input type="hidden" name="operation" value="%value encode(htmlattr) operation%">
			<input type="hidden" name="user_action" value="%value user_action%">
			<table>
				<tr>
					<td width="10px">
						<img src="images/blank.gif"  border=0>
					</td>
					<td>	
						<table class="tableView" width="100%">
							<tr>
								<td class="heading" colspan="2">SFTP Server Alias Properties</td>
							</tr>
							<tr>
								<td class="oddrow">Alias</td>	
								<td class="oddrow-l">
									%ifvar operation equals('add')%
										<input type="text" size="50" name="alias" id="alias" %ifvar user_action equals('gethostkey')% value="%value alias%" %endif%>
									%endif%	
									%ifvar operation equals('edit')%
										<input type="text" size="50" name="alias" id="alias" value="%value alias%" readonly="true" style="color:#808080;">
									%endif%
									
								</td>
							</tr>
							<tr>
								<td class="evenrow" >Host Name or IP Address</td>
								<td class="evenrow-l" >
									%ifvar operation equals('add')%
										<input type="text" size="50" name="hostName" id="hostName" %ifvar user_action equals('gethostkey')% value="%value hostName%" %endif%>
									%endif%	
									%ifvar operation equals('edit')%
										<input type="text" size="50" name="hostName" id="hostName" value="%value hostName%">
									%endif%
								</td>
							</tr>
							<tr>
								<td class="oddrow">Port Number</td>	
								<td class="oddrow-l">
									%ifvar operation equals('add')%
										<input type="text" size="5" maxlength="5" name="port" id="port" %ifvar user_action equals('gethostkey')% value="%value port%" %endif%>
									%endif%	
									%ifvar operation equals('edit')%
										<input type="text" size="5" maxlength="5" name="port" id="port" value="%value port%" >	
									%endif%
								</td>
							</tr>
		         			<tr>
								<td class="evenrow" >%ifvar operation equals('add')% Host Key Location %endif% %ifvar operation equals('edit')% Host Key Fingerprint %endif%	</td>
								<td class="evenrow-l" >
								    
									%ifvar operation equals('add')%
										<input type="text" size="50" name="hostKeyLocation" id="hostKeyLocation" %ifvar user_action equals('gethostkey')% value="%value hostKeyLocation%" %endif%>
										<input type="button" name="getHostKeyLocation" id="getHostKeyLocation" value="Get Host Key" onclick="populateForm(document.htmlform_gethostkey, document.htmlform_saConfig, '%value operation%')">
									%endif%	
									%ifvar operation equals('edit')%
										<input type="text" size="50" name="fingerprint" id="fingerprint" value="%value fingerprint%" disabled>
									%endif%
								</td>
							</tr>
							%ifvar operation equals('edit')%
							<tr>
								<td class="oddrow" >Host Key Location</td>
								<td class="oddrow-l" >
										<input type="text" size="50" name="hostKeyLocation" id="hostKeyLocation" value="%value hostKeyLocation%">
										<input type="button" name="getHostKeyLocation" id="getHostKeyLocation" value="Get Host Key" onclick="populateForm(document.htmlform_gethostkey, document.htmlform_saConfig, '%value operation%');">
								</td>
							</tr>
							%endif%
							<tr>
								<td class="action" colspan=4>
									<input type="submit" name="submit" value="Save Changes" onclick="return validate("%value encode(htmlattr) operation%");">&nbsp;&nbsp;
								</td>
							</tr>
						</table>
					</td>
				
				</tr>
			</form>
			<form name="htmlform_gethostkey" action="settings-sftp-client-serveralias-addedit.dsp" method="POST">
				<input type="hidden" name="operation">
				<input type="hidden" name="user_action">
				<input type="hidden" name="alias">
				<input type="hidden" name="hostName">
				<input type="hidden" name="port">
				<input type="hidden" name="fingerprint">
				<input type="hidden" name="hostKeyLocation">
			</form>
			</table>
			</td>
		</tr>
		
    </table>
	
  </body> 	
</head>
