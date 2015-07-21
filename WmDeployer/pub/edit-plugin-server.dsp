<HTML><HEAD>
 <TITLE>Edit Plugin Server </TITLE>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META http-equiv="Expires" content="-1">
<LINK href="webMethods.css" type="text/css" rel="stylesheet">
<SCRIPT src="webMethods.js"></SCRIPT>
<SCRIPT language=JavaScript>

// Stow the configurable required fields here
var requiredFields = new Array; 
var requiredFieldsLabel = new Array; 
var requiredFieldsType = new Array; 
var sslFields = new Array;
var basicAuthFields = new Array;

function enableSaveProperties() {
	document.getElementById("save").disabled = false;
}

function onLoad() {
	var validVersions = document.getElementById("validVersions").value;
	var selectedVersion = document.getElementById("selectedVersion").value;	
	var validVersionsArray = validVersions.split(",");
	var versionSelectObject = document.getElementById("runtimeVersion");
	versionSelectObject.options.length = validVersionsArray.length;
	for (i=0;i<validVersionsArray.length;i++) {		
		versionSelectObject.options[i].text = validVersionsArray[i];
		versionSelectObject.options[i].value = validVersionsArray[i];
		if(selectedVersion != null && selectedVersion == validVersionsArray[i]) {
			versionSelectObject.options[i].selected = true;
		}
	}
}

function onUpdate(hostLabel, portLabel, userLabel, passwordLabel) {
	// Name is always required
	var value = document.serverForm.name.value;
	if ( trim(value) == "" ) {
		alert("%value pluginType% Server Name is required.");
		document.serverForm.name.focus();
		return false;
	} 

	if (!isIllegalName(value)) {
		alert("Invalid Name.\nRefer to Integration Server Administrator's Guide for listed illegal characters.");
		document.serverForm.name.focus();
		return false;
	}


	// Host
	if (hostLabel.length > 0) {
		value = document.serverForm.host.value;
		if ( trim(value) == "" ) {
			alert(hostLabel + " is required.");
			document.serverForm.host.focus();
			return false;
		} 
	}


	// Port
	if (portLabel.length > 0) {
		value = document.serverForm.port.value;
		if ( trim(value) == "" ) {
			alert(portLabel + " is required.");
			document.serverForm.port.focus();
			return false;
		} 
	}

	// User
	if (userLabel.length > 0) {
		value = document.serverForm.user.value;
		if ( trim(value) == "" ) {
			alert(userLabel + " is required.");
			document.serverForm.user.focus();
			return false;
		} 
	}
	// Password
	if (passwordLabel.length > 0) {
		value = document.serverForm.password.value;
		if ( trim(value) == "" ) {
			alert(passwordLabel + " is required.");
			document.serverForm.password.focus();
			return false;
		} 
	}
	
	// Enumerate over configurable required fields
	for (j in requiredFields) {
		var name = requiredFields[j];
		var label = requiredFieldsLabel[j];
		var type = requiredFieldsType[j];

		// Booleans are radios, so skip them
		if (trim(type) == "STRING") 
		{
			if(name.indexOf("SSL_") == 0 || name.indexOf("BasicAuth_") == 0)
			{
				if(document.getElementById(name).disabled == false)
				{
					if ((trim(document.getElementById(requiredFields[j]).value) == "")&& (label == requiredFieldsLabel[j]) ) 
					{
						alert(label + " is required.");
						document.getElementById(requiredFields[j]).focus();
						return false;
					}
				}
			}
			else
			{
				if ((trim(document.getElementById(requiredFields[j]).value) == "")&& (label == requiredFieldsLabel[j]) ) 
				{
					alert(label + " is required.");
					document.getElementById(requiredFields[j]).focus();
					return false;
				}
			} 
		}
	}

  startProgressBar();
	return true;
}
function enableSSLFields()
{
	for (j in sslFields)
	{
		document.getElementById(sslFields[j]).disabled = false;
	}
}

function disableSSLFields()
{
	for (j in sslFields)
	{
		document.getElementById(sslFields[j]).disabled = true;
	}
}

function enableBasicAuthFields()
{
	for (j in basicAuthFields)
	{
		document.getElementById(basicAuthFields[j]).disabled = false;
	}
}

function disableBasicAuthFields()
{
	for (j in basicAuthFields)
	{
		document.getElementById(basicAuthFields[j]).disabled = true;
	}
}

function onNoneRadioBtnSelect()
{
	disableSSLFields(); 
	disableBasicAuthFields();
}

function onBasicAuthRadioBtnSelect()
{
	disableSSLFields(); 
	enableBasicAuthFields();
}

function onSSLAuthRadioBtnSelect()
{
	enableSSLFields(); 
	disableBasicAuthFields();
}

</SCRIPT>
</HEAD>
<BODY onLoad="javascript:onLoad();">

<TABLE width="100%">
	<TR>
		<TD class="menusection-DeployerServers" colspan="4"> %value name% &gt; Properties 
		</TD>
	</TR>
</TABLE>

<TABLE>
%ifvar action equals('updateServer')%
	%invoke wm.deployer.gui.UIPlugin:updatePluginServer%
		%include error-handler.dsp%

		%ifvar status equals('Success')%
			<script>
			if(is_csrf_guard_enabled && needToInsertToken) {
   			   parent.treeFrame.document.location.href = "plugin-servers.dsp?pluginType=%value -htmlcode pluginType%&pluginLabel=%value -htmlcode pluginLabel%&" + _csrfTokenNm_ + "=" + _csrfTokenVal_;
			} else {
			   parent.treeFrame.document.location.href = "plugin-servers.dsp?pluginType=%value -htmlcode pluginType%&pluginLabel=%value -htmlcode pluginLabel%";
			}
			</script>
		%end if%
	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%endinvoke%
%end if%
</TABLE>

<TABLE>
	<TR>
		<TD colspan="2">
     	<UL>	
        <LI><a onclick="startProgressBar();" href="edit-plugin-server.dsp?pluginType=%value pluginType%&name=%value name%">Refresh this Page</a>
     	</UL>	
		</TD>
	</TR>

<!- Determine if this user is empowered to modify server stuff ->
%invoke wm.deployer.UIAuthorization:isAuthorized%
%endinvoke%

<!- Get Plugin Info: (i) pluginType, (i) name ->
%invoke wm.deployer.gui.UIPlugin:getPluginServerLabels%

	%rename ../pluginType pluginType -copy%
	%invoke wm.deployer.gui.UIPlugin:getPluginServer%
	%endinvoke%

	<TR>
		<TD><IMG height="0" src="images/blank.gif" width="10"></TD>
			<SCRIPT>resetRows();</SCRIPT>
		<TD>
			<TABLE class="tableView">
				<TR>
					<TD class="heading" colspan="2">%value name% Properties</TD>
				</TR>


				<FORM name="serverForm" method="POST" action="edit-plugin-server.dsp">
				<TR>
					<script> writeTD("row"); </script>Name</TD>
					<script> writeTD("rowdata-l"); </script> %value name%</TD>
				</TR>
				<SCRIPT>swapRows();</SCRIPT>
				
				%ifvar /realmURL -notempty%
            <TR>
							<script> writeTD("row"); </script>*Realm URL</TD>
							<script> writeTD("rowdata-l"); </script> 
              %ifvar /isAuth equals('true')% 
						<INPUT onchange="enableSaveProperties();" name="realmURL" value="%value realmURL%" size="32">
					%else%
						%value realmURL%
					%endif%
					</TD>
				</TR>
				<SCRIPT>swapRows();</SCRIPT>	
				%endif%
				
				<!- Host ->
		%ifvar /hostLabel -notempty%
				<TR>
					<script> writeTD("row"); </script>* %value /hostLabel%</TD>
					<script> writeTD("rowdata-l"); </script> 
					%ifvar /isAuth equals('true')% 
						<INPUT onchange="enableSaveProperties();" name="host" value="%value host%" size="32">
					%else%
						%value host%
					%endif%
					</TD>
				</TR>
				<SCRIPT>swapRows();</SCRIPT>
		%endif%

				<!- Port ->
		%ifvar /portLabel -notempty%
				<TR>
					<script> writeTD("row"); </script>* %value /portLabel%</TD>
					<script> writeTD("rowdata-l"); </script> 
					%ifvar /isAuth equals('true')% 
						<INPUT onchange="enableSaveProperties();" name="port" value="%value port%" size="6">
					%else%
						%value port%
					%endif%
					</TD>
				</TR>
				<SCRIPT>swapRows();</SCRIPT>
		%endif%
				<!- User ->
				%ifvar /userLabel -notempty%
				<TR>
					<script> writeTD("row"); </script>* %value /userLabel%</TD>
					<script> writeTD("rowdata-l"); </script> 
					%ifvar /isAuth equals('true')% 
						<INPUT onchange="enableSaveProperties();" name="user" value="%value user%" size="20">
					%else%
						%value user%
					%endif%
					</TD>
				</TR>
				<SCRIPT>swapRows();</SCRIPT>
				%endif%

			   <!- Password ->
				%ifvar /passwordLabel -notempty%
					%ifvar /isAuth equals('true')% 
					<TR>
						<script> writeTD("row", "nowrap"); </script>* %value /passwordLabel%</TD>
						<script> writeTD("rowdata-l"); </script> 
						%ifvar user -notempty%
							<INPUT onchange="enableSaveProperties();" type="password" name="password" value="********" size="10">
						%else%
							<INPUT onchange="enableSaveProperties();" type="password" name="password" value="" size="10">
						%endif%
						
						</TD>
					</TR>
					<SCRIPT>swapRows();</SCRIPT>
					%endif%
				%endif%
								
				%ifvar versionLabel -notempty%
				<TR>
					<script> writeTD("row", "nowrap"); </script>* %value versionLabel%</TD>
					<script> writeTD("rowdata-l"); </script>
					%ifvar /isAuth equals('true')%		
					<INPUT name="validVersions" id="validVersions" type="hidden" value="%value validVersions%">			  
					<INPUT name="selectedVersion" id="selectedVersion" type="hidden" value="%value runtimeVersion%">
					<select onchange="enableSaveProperties();" name="runtimeVersion" id="runtimeVersion">								
					</select>
					%else%
						%value version%
					%endif%
				</TR>
				<SCRIPT>swapRows();</SCRIPT>	
				%endif%

		%ifvar pluginType equals('UniversalMessaging')%
				%loop connectionProperties%
					%ifvar name matches('SSL_Password_*')%
					<TR>
								<script> writeTD("row", "nowrap");</script>
								%ifvar required equals('true')%%endif% %value label%</TD>
								<script> writeTD("rowdata-l"); </script> 
								%ifvar value -notempty%
              						<INPUT onchange="enableSaveProperties();" name="%value name%" id="%value name%" size="32" type="password" value="********" >
								%else%
									<INPUT onchange="enableSaveProperties();" name="%value name%" id="%value name%" size="32" type="password" value="" >
								%endif%
					</TR>
					<SCRIPT>swapRows();</SCRIPT>
							%else%
								%ifvar name matches('SSL_Deployer*store_*')%
								<TR>
									<script> writeTD("row", "nowrap");</script>
									%ifvar required equals('true')%%endif% %value label%</TD>
									<script> writeTD("rowdata-l"); </script> 
									<INPUT onchange="enableSaveProperties();" name="%value name%" id="%value name%" size="50" value="%value value%" >
								%else%
									<script> writeTD("row", "nowrap");</script>
									%ifvar required equals('true')%%endif% %value label%</TD>
									<script> writeTD("rowdata-l"); </script> 
									<INPUT onchange="enableSaveProperties();" name="%value name%" id="%value name%" size="32" value="%value value%" >
								%endif%
								</TR>
					<SCRIPT>swapRows();</SCRIPT>
              		%endif%
				%endloop%
		%else%
		%loop connectionProperties%
			%ifvar name equals('BasicAuth_Password')%
					<TR>
					<script> writeTD("row", "nowrap");</script>
							%ifvar required equals('true')%*%endif% %value label%</TD>
							<script> writeTD("rowdata-l"); </script> 
              				<INPUT onchange="enableSaveProperties();" name="%value name%" id="%value name%" size="32" type="password" value="%value value%" %ifvar authType equals('3')% %else% disabled %endif%>
					</TR>
					<SCRIPT>swapRows();</SCRIPT>
					%else%
					%ifvar name equals('BasicAuth_Username')%
					<TR>
					<script> writeTD("row", "nowrap");</script>
							%ifvar required equals('true')%*%endif% %value label%</TD>
							<script> writeTD("rowdata-l"); </script> 
              				<INPUT onchange="enableSaveProperties();" name="%value name%" id="%value name%" size="32" value="%value value%" %ifvar authType equals('3')% %else% disabled %endif%>
					</TR>
					<SCRIPT>swapRows();</SCRIPT>
					%else%
			%ifvar name matches('SSL_*')%
				<!-- skip -->
			%else%
			<TR>
				%switch type%
				%case 'STRING'%
					<script> writeTD("row", "nowrap");</script>
					%ifvar required equals('true')%*%endif% %value label%</TD>
					<script> writeTD("rowdata-l"); </script> 
           <INPUT onchange="enableSaveProperties();" name="%value name%" id="%value name%" size="32" value="%value value%">
				%case 'BOOLEAN'%
				<script> writeTD("row", "nowrap");</script> %value label%</TD>
				<script> writeTD("rowdata-l"); </script> 
           <INPUT onchange="enableSaveProperties();" type="radio" name="%value name%" id="%value name%" value="TRUE" 
						%ifvar value equals('TRUE')% checked %endif%>Yes
           <INPUT onchange="enableSaveProperties();" type="radio" name="%value name%" id="%value name%" value="FALSE"
						%ifvar value equals('FALSE')% checked %endif%>No
				%endswitch%
			</TR>
			<SCRIPT>swapRows();</SCRIPT>	

			%ifvar required equals('true')%
			<SCRIPT> 
				requiredFields[requiredFields.length] = '%value name%';
				requiredFieldsLabel[requiredFieldsLabel.length] = '%value label%'; 
				requiredFieldsType[requiredFieldsType.length] = '%value type%'; 
			</SCRIPT>
			%endif%
			%endif%
			%endif%
			%endif%
		%endloop%
		
				<!- SSL Option ->
		%ifvar /SSLLabel -notempty%
				%ifvar /SSLLabel equals('Client Authentication')%
				  <TR>
					<script> writeTD("row"); </script>%value /SSLLabel%</TD>
					<script> writeTD("rowdata-l"); </script> 
					%ifvar /isAuth equals('true')% 
						<input onchange="enableSaveProperties();" type="radio" name="Auth" value="1" 
						%ifvar authType equals('1')% checked %endif% onclick="onNoneRadioBtnSelect()">None</input>
              			<input onchange="enableSaveProperties();" type="radio" name="Auth" value="2" 
              			%ifvar authType equals('2')% checked %endif% onclick="onSSLAuthRadioBtnSelect()">SSL</input>
              			<input onchange="enableSaveProperties();" type="radio" name="Auth" value="3" 
              			%ifvar authType equals('3')% checked %endif% onclick="onBasicAuthRadioBtnSelect()">Username/Password</input>
					%endif%
					</TD>
				</TR>
			%else%
				<TR>
					<script> writeTD("row"); </script>%value /SSLLabel%</TD>
					<script> writeTD("rowdata-l"); </script> 
					%ifvar /isAuth equals('true')% 
						<input onchange="enableSaveProperties();" type="radio" name="useSSL" value="true" 
							%ifvar useSSL equals('true')% checked %endif% onclick="enableSSLFields()">Yes</input>
						<input onchange="enableSaveProperties();" type="radio" name="useSSL" value="false"
							%ifvar useSSL equals('false')% checked %endif% onclick="disableSSLFields()">No</input>
					%else%
						%value useSSL%
					%endif%
					</TD>
				</TR>
				%endif%
			%ifvar useSSL equals('true')%
				%loop connectionProperties%
					%ifvar name matches('SSL_*')%
            		<TR>
						%switch type%
						%case 'STRING'%
							%ifvar name matches('SSL_Password_*')%
								<script> writeTD("row", "nowrap");</script>
								%ifvar required equals('true')%*%endif% %value label%</TD>
								<script> writeTD("rowdata-l"); </script> 
              					<INPUT onchange="enableSaveProperties();" name="%value name%" id="%value name%" size="32" type="password" value="********" 
              						%ifvar useSSL equals('false')% disabled %endif% >
							%else%
								%ifvar name matches('SSL_Deployer*store_*')%
									<script> writeTD("row", "nowrap");</script>
									%ifvar required equals('true')%*%endif% %value label%</TD>
									<script> writeTD("rowdata-l"); </script> 
									<INPUT onchange="enableSaveProperties();" name="%value name%" id="%value name%" size="50" value="%value value%" 
											%ifvar useSSL equals('false')% disabled %endif%>
								%else%
									<script> writeTD("row", "nowrap");</script>
									%ifvar required equals('true')%*%endif% %value label%</TD>
									<script> writeTD("rowdata-l"); </script> 
									<INPUT onchange="enableSaveProperties();" name="%value name%" id="%value name%" size="32" value="%value value%" 
											%ifvar useSSL equals('false')% disabled %endif%>
								%endif%
              				%endif%
						%case 'BOOLEAN'%
							<script> writeTD("row", "nowrap");</script> %value label%</TD>
							<script> writeTD("rowdata-l"); </script> 
           					<INPUT onchange="enableSaveProperties();" type="radio" name="%value name%" id="%value name%" value="TRUE" 
							%ifvar value equals('TRUE')% checked %endif% %ifvar useSSL equals('false')% disabled %endif% >Yes
			           		<INPUT onchange="enableSaveProperties();" type="radio" name="%value name%" id="%value name%" value="FALSE"
							%ifvar value equals('FALSE')% checked %endif% %ifvar useSSL equals('false')% disabled %endif% >No
						%case 'SELECT'%
							<script> writeTD("row", "nowrap");</script> %value label%</TD>
							<script> writeTD("rowdata-l"); </script> 
							<select name="%value name%" id="%value name%" %ifvar useSSL equals('false')% disabled %endif%>
								<option value="%value value%">%value value%</option>
							</select>
						%endswitch%
            		</TR>
						<SCRIPT>swapRows();</SCRIPT>	

						%ifvar required equals('true')%
						<SCRIPT> 
							requiredFields[requiredFields.length] = '%value name%';
							requiredFieldsLabel[requiredFieldsLabel.length] = '%value label%'; 
							requiredFieldsType[requiredFieldsType.length] = '%value type%'; 
						</SCRIPT>
						%endif%
						<SCRIPT>
							sslFields[sslFields.length] = '%value name%';
						</SCRIPT>
					%endif%
				%endloop%
		%else%
		
			%loop connectionProperties%
					%ifvar name matches('SSL_*')%
            		<TR>
						%switch type%
						%case 'STRING'%
							%ifvar name matches('SSL_Password_*')%
								<script> writeTD("row", "nowrap");</script>
								%ifvar required equals('true')%*%endif% %value label%</TD>
								<script> writeTD("rowdata-l"); </script> 
              					<INPUT onchange="enableSaveProperties();" name="%value name%" id="%value name%" size="32" type="password" value="********" disabled>
							%else%
								%ifvar name matches('SSL_Deployer*store_*')%
									<script> writeTD("row", "nowrap");</script>
									%ifvar required equals('true')%*%endif% %value label%</TD>
									<script> writeTD("rowdata-l"); </script> 
									<INPUT onchange="enableSaveProperties();" name="%value name%" id="%value name%" size="50" value="%value default%" disabled>
								%else%
									<script> writeTD("row", "nowrap");</script>
									%ifvar required equals('true')%*%endif% %value label%</TD>
									<script> writeTD("rowdata-l"); </script> 
									<INPUT onchange="enableSaveProperties();" name="%value name%" id="%value name%" size="32" value="%value default%" disabled>
								%endif%
              				%endif%
						%case 'BOOLEAN'%
							<script> writeTD("row", "nowrap");</script> %value label%</TD>
							<script> writeTD("rowdata-l"); </script> 
           					<INPUT onchange="enableSaveProperties();" type="radio" name="%value name%" id="%value name%" value="TRUE" 
								%ifvar default equals('TRUE')% checked %endif% disabled>Yes
           					<INPUT onchange="enableSaveProperties();" type="radio" name="%value name%" id="%value name%" value="FALSE"
								%ifvar default equals('FALSE')% checked %endif% disabled>No
						%case 'SELECT'%
							<script> writeTD("row", "nowrap");</script> %value label%</TD>
							<script> writeTD("rowdata-l"); </script> 
							<select name="%value name%" id="%value name%" disabled>
								<option value="%value default%">%value default%</option>
							</select>
						%endswitch%
            		</TR>
						<SCRIPT>swapRows();</SCRIPT>	

						%ifvar required equals('true')%
						<SCRIPT> 
							requiredFields[requiredFields.length] = '%value name%';
							requiredFieldsLabel[requiredFieldsLabel.length] = '%value label%'; 
							requiredFieldsType[requiredFieldsType.length] = '%value type%'; 
						</SCRIPT>
						%endif%
						<SCRIPT>
							sslFields[sslFields.length] = '%value name%';
						</SCRIPT>
					%endif%
					%ifvar name matches('BasicAuth_*')%
						<SCRIPT>
							basicAuthFields[basicAuthFields.length] = '%value name%';
						</SCRIPT>
					%endif%
				%endloop%
			%endif%
		%endif%
	%endif%	
		%ifvar /isAuth equals('true')% 
				<TR>
					<INPUT type="hidden" name="pluginType" value='%value pluginType%'>
					<INPUT type="hidden" name="name" value='%value name%'>
					<INPUT type="hidden" name="action" value="updateServer">
          				<INPUT type="hidden" name="pluginLabel" value="%value pluginLabel%">
					<TD class="action" colspan="2">
						<INPUT disabled title="Click away from the current text field to enable Save button." onclick="return onUpdate('%value hostLabel%','%value portLabel%','%value userLabel%','%value passwordLabel%');" type="submit" VALUE="Save" name="submit" id="save">
					</TD>
				</TR>
			%endif%
		
				</FORM>
			</TABLE>
		</TD>
	</TR>

%endinvoke%
</TABLE>

<script>
stopProgressBar();
document.serverForm.host.focus();
</script>

</BODY>
</HTML>
