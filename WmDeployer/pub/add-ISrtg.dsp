<HTML><HEAD>
<TITLE>Add IS & TN Target Group</TITLE>
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

function onAdd() {

	// Name is always required
	var name = document.addServerForm.rtgName.value;
	if ( trim(name) == "" ) {
		alert("IS & TN Target Group Name is required.");
		document.addServerForm.rtgName.focus();
		return false;
	} 

	if (!isIllegalName(name)) {
		alert("Invalid Name.\nRefer to Integration Server Administrator's Guide for listed illegal characters.");
		document.addServerForm.rtgName.focus();
		return false;
	}

	


  startProgressBar("Configuring IS & TN Target Group " + name);
	return true;
}
</SCRIPT>

<TABLE width="100%">
	<TR>
		<TD class="menusection-Server" colspan="3">Configure IS & TN Target Group</TD>
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
              <TD class="heading" colspan="2">Create IS & TN Target Group</TD>
            </TR>
            <FORM name="addServerForm" target="treeFrame" action=target-groupsIS.dsp method=post>
            <INPUT type="hidden" VALUE="add" name="action">
			%ifvar pluginType equals('')%
            <INPUT type="hidden" VALUE="IS & TN" name="type">
            <INPUT type="hidden" VALUE="IS & TN" name="pluginType">
			%else%
			<INPUT type="hidden" VALUE="%value pluginType%" name="type">
            <INPUT type="hidden" VALUE="%value pluginType%" name="pluginType">
			%endif%

						<SCRIPT>resetRows();</SCRIPT>
			%invoke wm.deployer.gui.UIPlugin:getPluginServerLabels%
			%endinvoke%

            <TR>
							<script> writeTD("row"); </script>* Name</TD>
							<script> writeTD("rowdata-l"); </script> 
            	<INPUT name="rtgName" size="28" maxlength="32">
            </TR>
						<SCRIPT>swapRows();</SCRIPT>	

			<TR>
							<script> writeTD("row"); </script> Description</TD>
							<script> writeTD("rowdata-l"); </script> 
            	<INPUT name="rtgDescription" size="28">
            </TR>
			
			<TR>
							<script> writeTD("row"); </script> Version</TD>
							<script> writeTD("rowdata-l"); </script> 
				<select onchange="enableSaveProperties();" name="runtimeVersion" id="runtimeVersion">								
				</select>
				<INPUT type="hidden" name="validVersions" id="validVersions" size="8" value="%value validVersions%">				
            </TR>

         		<TR>
           		<TD class="subheading" colspan="2">Required fields are indicated by *</TD>
         		</TR>
            <TR>
              <TD class="action" colspan="2">
								<INPUT onclick="return onAdd();" type="submit" VALUE="Create" name="submit">
							</TD>
            </TR>
		
    				</FORM>
          </TBODY>
        </TABLE>
      </TD>
    </TR>
  </TBODY>
</TABLE>

<script>
	document.addServerForm.rtgName.focus();
</script>

</BODY>
</HTML>
