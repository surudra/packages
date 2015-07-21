<HTML><HEAD>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META http-equiv="Expires" content="-1">
<SCRIPT src="webMethods.js"></SCRIPT>
<LINK href="webMethods.css" type="text/css" rel="stylesheet">
<BODY>

<SCRIPT language=JavaScript>

function onAdd() {
	var n = document.addMapForm.mapSetName.value;

	if ( trim(n) == "" ) {
		alert("Deployment Map Name is required.");
		return false;
	} 
	else if (!isIllegalName(n)) {
		alert("Invalid Name.\nRefer to Integration Server Administrator's Guide for listed illegal characters.");
		return false;
	}

	startProgressBar("Creating Deployment Map " + n);
	return true;
}

</SCRIPT>

<TABLE width="100%">
	<TR>
		<TD class="menusection-Deployer" colspan="3">Create Deployment Map</TD>
	</TR>
</TABLE>

<TABLE width="100%">
	<TBODY>
		<TR>
			<TD colspan="2"> <IMG height="10" src="images/blank.gif" width="10"></TD>
    </TR>
    <TR>
      <TD><IMG height="10" src="images/blank.gif" width="10"></TD>
      <TD valign="top">
        <TABLE class="tableForm"">
          <TBODY>
            <TR>
              <TD class="heading" colspan="2">Create Deployment Map</TD>
            </TR>
						<FORM name="addMapForm" target="treeFrame" action=map-list.dsp method=post>            
						<INPUT type="hidden" VALUE="%value projectName%" name="projectName">
						<INPUT type="hidden" VALUE="%value projectType%" name="projectType">						
						<INPUT type="hidden" VALUE="add" name="action">
            <TR>
              <TD nowrap class="oddrow">* Name</TD>
              <TD class="oddrow-l"><INPUT name="mapSetName" size="32" maxlength="32"></TD>
            </TR>
            <TR>
              <TD nowrap class="evenrow">Description</TD>
              <TD class="evenrow-l"><INPUT name="mapSetDescription" size="32"></TD>
            </TR>
         		<TR>
           		<TD class="subheading" colspan="2">Required fields are indicated by *</TD>
         		</TR>
            <TR>
              <TD class="action" colspan="2">
                <INPUT onclick="return onAdd();" type="submit" value="Create">
              </TD>
            </TR>
          </TBODY>
        </TABLE>
      </TD>
    </TR>
    </FORM>
  </TBODY>
</TABLE>

<script>
	%invoke wm.deployer.gui.UISuggest:suggestMapSetName%
		document.addMapForm.mapSetName.value = "%value mapSetName%";
	%endinvoke%
	document.addMapForm.mapSetName.focus();
</script>

</BODY>
</HTML>
