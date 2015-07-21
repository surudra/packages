<HTML><HEAD>
<TITLE>Add Server</TITLE>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META http-equiv="Expires" content="-1">
<SCRIPT src="webMethods.js"></SCRIPT>
<SCRIPT>
function onLoad() {
	var validVersions = document.getElementById("validVersions").value;
	var validVersionsArray = validVersions.split(",");
	var versionSelectObject = document.getElementById("runtimeVersion");
	versionSelectObject.options.length = validVersionsArray.length;
	for (i=0;i<validVersionsArray.length;i++) {		
		versionSelectObject.options[i].text = validVersionsArray[i];
		versionSelectObject.options[i].value = validVersionsArray[i];
	}
}
</SCRIPT>
<LINK href="webMethods.css" type="text/css" rel="stylesheet">
<BODY onLoad="javascript:onLoad();">

<SCRIPT language=JavaScript>

// Stow the configurable required fields here
var requiredFields = new Array; 
var requiredFieldsLabel = new Array; 
var requiredFieldsType = new Array;
var sslFields = new Array;
var basicAuthFields = new Array;

function onAdd(hostLabel, portLabel, userLabel, passwordLabel) {

	// Name is always required
	var name = document.addServerForm.name.value;
	if ( trim(name) == "" ) {
		alert("%value pluginType% Server Name is required.");
		document.addServerForm.name.focus();
		return false;
	} 

	if (!isIllegalName(name)) {
		alert("Invalid Name.\nRefer to Integration Server Administrator's Guide for listed illegal characters.");
		document.addServerForm.name.focus();
		return false;
	}

	// Host
	if (hostLabel.length > 0) {
		value = document.addServerForm.host.value;
		if ( trim(value) == "" ) {
			alert(hostLabel + " is required.");
			document.addServerForm.host.focus();
			return false;
		} 
	}

	// Port
	if (portLabel.length > 0) {
		value = document.addServerForm.port.value;
		if ( trim(value) == "" ) {
			alert(portLabel + " is required.");
			document.addServerForm.port.focus();
			return false;
		} 
	}

	// User
	if (userLabel.length > 0) {
		value = document.addServerForm.user.value;
		if ( trim(value) == "" ) {
			alert(userLabel + " is required.");
			document.addServerForm.user.focus();
			return false;
		} 
	}

	// Password
	if (passwordLabel.length > 0) {
		value = document.addServerForm.password.value;
		if ( trim(value) == "" ) {
			alert(passwordLabel + " is required.");
			document.addServerForm.password.focus();
			return false;
		} 
	}

	// Enumerate over configurable required fields
	for (j in requiredFields) {
		var name = requiredFields[j];
		var label = requiredFieldsLabel[j];
		var type = requiredFieldsType[j];
//start: Anurag Trax Id # 1-1JL4XX
		// Booleans are exempt
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
//End: Anurag Trax Id # 1-1JL4XX
			/*value = document.addServerForm.all[name].value;

			if ( trim(value) == "" ) {
				alert(label + " is required.");
				document.addServerForm.all[name].focus();
				return false;
			} */
		} //end if
	}//end for

  startProgressBar("Configuring %value pluginType% Server " + name);
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

<TABLE width="100%">
	<TR>
		<TD class="menusection-DeployerServers" colspan="3">Configure %value pluginLabel% Server</TD>
	</TR>
</TABLE>
<TABLE width="100%">
  <TBODY>
    <TR>
      <TD><IMG height="10" src="images/blank.gif" width="10"></TD>
    </TR>
    <TR>
      <TD><IMG height="0" src="images/blank.gif" width="10"></TD>
      <TD valign="top">
        <TABLE class="tableForm">
          <TBODY>
            <TR>
              <TD class="heading" colspan="2">Configure %value pluginLabel% Server</TD>
            </TR>
            <FORM name="addServerForm" target="treeFrame" action=plugin-servers.dsp method=post>
						%comment%
            <FORM name="addServerForm" target="treeFrame" action=under-construction.dsp method=post>
						%endcomment%
            <INPUT type="hidden" VALUE="add" name="action">
            <INPUT type="hidden" VALUE="%value pluginType%" name="type">
            <INPUT type="hidden" VALUE="%value pluginType%" name="pluginType">

						<SCRIPT>resetRows();</SCRIPT>
		%invoke wm.deployer.gui.UIPlugin:getPluginServerLabels%

            <TR>
							<script> writeTD("row"); </script>* Name</TD>
							<script> writeTD("rowdata-l"); </script> 
            	<INPUT name="name" size="28" maxlength="32">
            </TR>
						<SCRIPT>swapRows();</SCRIPT>	

				%ifvar realmURL -notempty%
            <TR>
							<script> writeTD("row"); </script>* %value realmURL%</TD>
							<script> writeTD("rowdata-l"); </script> 
              <INPUT name="realmURL" size="32">
            </TR>
						<SCRIPT>swapRows();</SCRIPT>	
				%endif%
				
				%ifvar hostLabel -notempty%
            <TR>
							<script> writeTD("row"); </script>* %value hostLabel%</TD>
							<script> writeTD("rowdata-l"); </script> 
              <INPUT name="host" size="32">
            </TR>
						<SCRIPT>swapRows();</SCRIPT>	
				%endif%

				%ifvar portLabel -notempty%
            <TR>
							<script> writeTD("row"); </script>* %value portLabel%</TD>
							<script> writeTD("rowdata-l"); </script> 
              <INPUT name="port" size="8" maxlength="5"></TD>
            </TR>
						<SCRIPT>swapRows();</SCRIPT>	
				%endif%

			%ifvar userLabel -notempty%
            <TR>
							<script> writeTD("row"); </script>* %value userLabel%</TD>
							<script> writeTD("rowdata-l"); </script> 
              <INPUT name="user" size="32"></TD>
            </TR>
						<SCRIPT>swapRows();</SCRIPT>	
			%endif%			
			
			%ifvar passwordLabel -notempty%
            <TR>
							<script> writeTD("row", "nowrap"); </script>* %value passwordLabel%</TD>
							<script> writeTD("rowdata-l"); </script> 
              <INPUT type="password" name="password" size="10" maxlength="15">
            </TR>
						<SCRIPT>swapRows();</SCRIPT>	
			%endif%

			%ifvar versionLabel -notempty%
            <TR>
							<script> writeTD("row", "nowrap"); </script>* %value versionLabel%</TD>
							<script> writeTD("rowdata-l"); </script>							
              <INPUT name="validVersions" id="validVersions" type="hidden" value="%value validVersions%">			  
			  <select name="runtimeVersion" id="runtimeVersion">								
			  </select>
            </TR>
						<SCRIPT>swapRows();</SCRIPT>	
			%endif%			
			
			%ifvar pluginType equals('UniversalMessaging')%
			<TR>
				%loop connectionProperties%
					%ifvar name matches('SSL_Password_*')%
								<script> writeTD("row", "nowrap");</script>
								%ifvar required equals('true')%%endif% %value label%</TD>
								<script> writeTD("rowdata-l"); </script> 
              					<INPUT name="%value name%" id="%value name%" size="32" type="password" value="%value default%" >
							%else%
								%ifvar name matches('SSL_Deployer*store_*')%
									<script> writeTD("row", "nowrap");</script>
									%ifvar required equals('true')%%endif% %value label%</TD>
									<script> writeTD("rowdata-l"); </script> 
									<INPUT name="%value name%" id="%value name%" size="50" value="%value default%" >
								%else%
									<script> writeTD("row", "nowrap");</script>
									%ifvar required equals('true')%%endif% %value label%</TD>
									<script> writeTD("rowdata-l"); </script> 
									<INPUT name="%value name%" id="%value name%" size="32" value="%value default%" >
								%endif%
              		%endif%
              	</TR>
					<SCRIPT>swapRows();</SCRIPT>
				%endloop%
			%else%
				%loop connectionProperties%
					%ifvar name equals('BasicAuth_Password')%
					<TR>
					<script> writeTD("row", "nowrap");</script>
							%ifvar required equals('true')%*%endif% %value label%</TD>
							<script> writeTD("rowdata-l"); </script> 
              				<INPUT name="%value name%" id="%value name%" size="32" type="password" value="%value default%" disabled>
					</TR>
					<SCRIPT>swapRows();</SCRIPT>
					%else%
					%ifvar name equals('BasicAuth_Username')%
					<TR>
					<script> writeTD("row", "nowrap");</script>
							%ifvar required equals('true')%*%endif% %value label%</TD>
							<script> writeTD("rowdata-l"); </script> 
              				<INPUT name="%value name%" id="%value name%" size="32" value="%value default%" disabled>
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
              <INPUT name="%value name%" id="%value name%" size="32" value="%value default%">
						%case 'BOOLEAN'%
							<script> writeTD("row", "nowrap");</script> %value label%</TD>
							<script> writeTD("rowdata-l"); </script> 
           		<INPUT type="radio" name="%value name%" id="%value name%" value="TRUE" 
								%ifvar default equals('TRUE')% checked %endif%>Yes
           		<INPUT type="radio" name="%value name%" id="%value name%" value="FALSE"
								%ifvar default equals('FALSE')% checked %endif%>No
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
				%ifvar SSLLabel -notempty%
						%ifvar SSLLabel equals('Client Authentication')%
						<TR>
              				<TD class="evenrow">%value SSLLabel%</TD>
              				<TD class="evenrow-l"> 								
              					<input type="radio" name="Auth" value="1" checked onclick="onNoneRadioBtnSelect()">None</input>
              					<input type="radio" name="Auth" value="2" onclick="onSSLAuthRadioBtnSelect()">SSL</input>
              					<input type="radio" name="Auth" value="3" onclick="onBasicAuthRadioBtnSelect()">Username/Password</input>
							</TD>
						</TR>
						<SCRIPT>swapRows();</SCRIPT>
						%else%
						<TR>
              				<TD class="evenrow">%value SSLLabel%</TD>
              				<TD class="evenrow-l"> 
								<input type="radio" name="useSSL" value="true" onclick="enableSSLFields()">Yes</input>
              					<input type="radio" id="useSSL" name="useSSL" value="false" checked onclick="disableSSLFields()">No</input>
							</TD>
						</TR>
						<SCRIPT>swapRows();</SCRIPT>						
						%endif%
						
				%endif%

				%loop connectionProperties%
					%ifvar name matches('SSL_*')%
            		<TR>
						%switch type%
						%case 'STRING'%
							%ifvar name matches('SSL_Password_*')%
								<script> writeTD("row", "nowrap");</script>
								%ifvar required equals('true')%*%endif% %value label%</TD>
								<script> writeTD("rowdata-l"); </script> 
              					<INPUT name="%value name%" id="%value name%" size="32" type="password" value="%value default%" disabled>
							%else%
								%ifvar name matches('SSL_Deployer*store_*')%
									<script> writeTD("row", "nowrap");</script>
									%ifvar required equals('true')%*%endif% %value label%</TD>
									<script> writeTD("rowdata-l"); </script> 
									<INPUT name="%value name%" id="%value name%" size="50" value="%value default%" disabled>
								%else%
									<script> writeTD("row", "nowrap");</script>
									%ifvar required equals('true')%*%endif% %value label%</TD>
									<script> writeTD("rowdata-l"); </script> 
									<INPUT name="%value name%" id="%value name%" size="32" value="%value default%" disabled>
								%endif%
              				%endif%
						%case 'BOOLEAN'%
							<script> writeTD("row", "nowrap");</script> %value label%</TD>
							<script> writeTD("rowdata-l"); </script> 
           					<INPUT type="radio" name="%value name%" id="%value name%" value="TRUE" 
								%ifvar default equals('TRUE')% checked %endif% disabled>Yes
           					<INPUT type="radio" name="%value name%" id="%value name%" value="FALSE"
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
         		<TR>
           		<TD class="subheading" colspan="2">Required fields are indicated by *</TD>
         		</TR>
            <TR>
              <TD class="action" colspan="2">
								<INPUT onclick="return onAdd('%value hostLabel%','%value portLabel%','%value userLabel%','%value passwordLabel%');" type="submit" VALUE="Configure" name="submit">
							</TD>
            </TR>
		%endinvoke%
    				</FORM>
          </TBODY>
        </TABLE>
      </TD>
    </TR>
  </TBODY>
</TABLE>

<script>
	document.addServerForm.name.focus();
</script>

</BODY>
</HTML>
