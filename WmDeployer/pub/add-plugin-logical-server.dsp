<HTML><HEAD>
<TITLE>Add Logical Server</TITLE>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META http-equiv="Expires" content="-1">
<SCRIPT src="webMethods.js"></SCRIPT>
<LINK href="webMethods.css" type="text/css" rel="stylesheet">
<BODY>

<SCRIPT language=JavaScript>
function onAdd(hostLabel, portLabel, userLabel, passwordLabel, extraField1Label, extraField2Label, extraField3Label) {

	// Name is always required
	var name = document.addServerForm.logicalName.value;
	if ( trim(name) == "" ) {
		alert("%value logicalPluginName% Server Name is required.");
		document.addServerForm.logicalName.focus();
		return false;
	} 

	if (!isIllegalName(name)) {
		alert("Invalid Name.\nRefer to Integration Server Administrator's Guide for listed illegal characters.");
		document.addServerForm.logicalName.focus();
		return false;
	}

	// Host
	if (hostLabel.length > 0) {
		value = document.addServerForm.logicalHost.value;
		if ( trim(value) == "" ) {
			alert(hostLabel + " is required.");
			document.addServerForm.logicalHost.focus();
			return false;
		} 
	}

	// Port
	if (portLabel.length > 0) {
		value = document.addServerForm.logicalPort.value;
		if ( trim(value) == "" ) {
			alert(portLabel + " is required.");
			document.addServerForm.logicalPort.focus();
			return false;
		} 
	}

	// User
	if (userLabel.length > 0) {
		value = document.addServerForm.logicalUser.value;
		if ( trim(value) == "" ) {
			alert(userLabel + " is required.");
			document.addServerForm.logicalUser.focus();
			return false;
		} 
	}

	// Password
	if (passwordLabel.length > 0) {
		value = document.addServerForm.logicalPassword.value;
		if ( trim(value) == "" ) {
			alert(passwordLabel + " is required.");
			document.addServerForm.logicalPassword.focus();
			return false;
		} 
	}

	// ExtraField1
	if (extraField1Label.length > 0) {
		value = document.addServerForm.extraField1.value;
		if ( trim(value) == "" ) {
			alert(extraField1Label + " is required.");
			document.addServerForm.extraField1.focus();
			return false;
		} 
	}

	// ExtraField2
	if (extraField2Label.length > 0) {
		value = document.addServerForm.extraField2.value;
		if ( trim(value) == "" ) {
			alert(extraField2Label + " is required.");
			document.addServerForm.extraField2.focus();
			return false;
		} 
	}

	// ExtraField3
	if (extraField3Label.length > 0) {
		value = document.addServerForm.extraField3.value;
		if ( trim(value) == "" ) {
			alert(extraField3Label + " is required.");
			document.addServerForm.extraField3.focus();
			return false;
		} 
	}

  startProgressBar("Defining Logical Server " + name);
	return true;
}
</SCRIPT>

<TABLE width="100%">
	<TR>
		<TD class="menusection-DeployerServers" colspan="3">%value name% > Define %value logicalPluginName% Logical Server</TD>
	</TR>
</TABLE>
<TABLE width="100%">
  <TBODY>

		<TR>
			<TD colspan="2">
     		<UL>	
        	<LI><a onclick="startProgressBar();" href="edit-plugin-server.dsp?pluginType=%value pluginType%&name=%value name%">Return to %value name% > Properties</a>
     		</UL>	
			</TD>
		</TR>

    <TR>
      <TD><IMG height="10" src="images/blank.gif" width="10"></TD>
    </TR>
    <TR>
      <TD><IMG height="0" src="images/blank.gif" width="10"></TD>
      <TD valign="top">
        <TABLE class="tableForm">
          <TBODY>
            <TR>
              <TD class="heading" colspan="2">Define %value logicalPluginName% Logical Server</TD>
            </TR>
            <FORM name="addServerForm" action=edit-plugin-server.dsp method=post>
            <INPUT type="hidden" name="action" VALUE="addLogical">
            <INPUT type="hidden" name="name" VALUE="%value name%">
            <INPUT type="hidden" name="pluginType" VALUE="%value pluginType%">
            <INPUT type="hidden" name="logicalPluginName" VALUE="%value logicalPluginName%">

		%rename logicalPluginName pluginType -copy%
		%invoke wm.deployer.gui.UIPlugin:getPluginServerLabels%
            <TR>
              <TD class="oddrow">* Name</TD>
              <TD class="oddrow-l"><INPUT id="logicalName" name="logicalName" size="28" maxlength="32"></TD>
            </TR>
				%ifvar hostLabel -notempty%
            <TR id="host">
              <TD class="evenrow">* %value hostLabel%</TD>
              <TD class="evenrow-l"><INPUT id="logicalHost" name="logicalHost" size="32"></TD>
            </TR>
				%endif%

				%ifvar portLabel -notempty%
            <TR id="port">
              <TD class="oddrow">* %value portLabel%</TD>
              <TD class="oddrow-l"><INPUT id="logicalPort" name="logicalPort" size="8" maxlength="5"></TD>
            </TR>
				%endif%

				%ifvar userLabel -notempty%
            <TR id="user">
              <TD class="evenrow">* %value userLabel%</TD>
              <TD class="evenrow-l"><INPUT id="logicalUser" name="logicalUser" size="32"></TD>
            </TR>
				%endif%

				%ifvar passwordLabel -notempty%
            <TR id="password">
              <TD class="oddrow">* %value passwordLabel%</TD>
              <TD class="oddrow-l"><INPUT id="logicalPassword" type="password" name="logicalPassword" size="10" maxlength="15"></TD>
            </TR>
				%endif%

				%ifvar extraField1Label -notempty%
            <TR id="extraField1">
              <TD class="evenrow">* %value extraField1Label%</TD>
              <TD class="evenrow-l"><INPUT name="extraField1" size="32"></TD>
            </TR>
				%endif%

				%ifvar extraField2Label -notempty%
            <TR id="extraField2">
              <TD class="oddrow">* %value extraField2Label%</TD>
              <TD class="oddrow-l"><INPUT name="extraField2" size="32"></TD>
            </TR>
				%endif%

				%ifvar extraField3Label -notempty%
            <TR id="extraField3">
              <TD class="evenrow">* %value extraField3Label%</TD>
              <TD class="evenrow-l"><INPUT name="extraField3" size="32"></TD>
            </TR>
				%endif%

						<TR>
              <TD class="oddrow">Use SSL</TD>
              <TD class="oddrow-l"> 
								<input type="radio" name="logicalUseSSL" value="true">Yes</input>
              	<input type="radio" name="logicalUseSSL" value="false" checked>No</input>
							</TD>
						</TR>
		%endinvoke%

         		<TR>
           		<TD class="subheading" colspan="2">Required fields are indicated by *</TD>
         		</TR>
            <TR>
              <TD class="action" colspan="2">
								<INPUT onclick="return onAdd('%value hostLabel%','%value portLabel%','%value userLabel%','%value passwordLabel%','%value extraField1Label%','%value extraField2Label%','%value extraField3Label%');" type="submit" VALUE="Define" name="submit">
							</TD>
            </TR>
    				</FORM>
          </TBODY>
        </TABLE>
      </TD>
    </TR>
  </TBODY>
</TABLE>

</BODY>
</HTML>
