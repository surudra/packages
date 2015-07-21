<HTML><HEAD>
<TITLE>Add Project</TITLE>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META http-equiv="Expires" content="-1">
<SCRIPT src="webMethods.js"></SCRIPT>
<LINK href="webMethods.css" type="text/css" rel="stylesheet">
<BODY>
<SCRIPT language=JavaScript>
function onAdd() {

	var pwdHandle = document.addPassStoreForm.pwdHandle.value;
	var pwdValue = document.addPassStoreForm.pwdValue.value;
	
	if ( trim(pwdHandle) == "" ) {
		alert("Password Handle is required.");
		return false;
	}
	if ( trim(pwdValue) == "" ) {
		alert("Password is required.");
		return false;
	}
	else if (!isIllegalName(pwdHandle)) {
		alert("Invalid Name.\nRefer to Integration Server Administrator's Guide for listed illegal characters.");
		return false;
	}
	return true;
}
</SCRIPT>

<TABLE width="100%">
	<TR>
		<TD class="menusection-Deployer" colspan="3">Create Password Store Entry</TD>
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
              <TD class="heading" colspan="2">Create Password Store Entry</TD>
            </TR>
            <FORM name="addPassStoreForm" target="treeFrame" action=passstore-main.dsp method=post>
            	<INPUT type="hidden" VALUE="add" name="action">
            	<TR>
              		<TD class="oddrow">* Password Handle</TD>
              		<TD class="oddrow-l"><INPUT name="pwdHandle" size="28" maxlength="32"></TD>
            	</TR>
            	<TR>
              		<TD class="evenrow">* Password</TD>
              		<TD class="evenrow-l"><INPUT type="password" name="pwdValue" size="28" maxlength="32"></TD>
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
	document.addPassStoreForm.pwdHandle.focus();
</script>

</BODY>
</HTML>