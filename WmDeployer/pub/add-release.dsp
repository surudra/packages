<HTML><HEAD>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META http-equiv="Expires" content="-1">
<SCRIPT src="webMethods.js"></SCRIPT>
<LINK href="webMethods.css" type="text/css" rel="stylesheet">
<BODY>

<SCRIPT language=JavaScript>
var releaseName = null;
function onAdd() {
	var n = document.addReleaseForm.buildName.value;

	if ( trim(n) == "" ) {
		alert("Build Name is required.");
		return false;
	} 
	else if (!isIllegalName(n)) {
		alert("Invalid Name.\nRefer to Integration Server Administrator's Guide for listed illegal characters.");
		return false;
	} 

	startProgressBar("Creating Build " + n);
	releaseName = n;
	return true;
}

function viewProgress()
{
	if(releaseName == null || releaseName == "")
	{
		alert("You have not started the build yet");
		return;
	}
	
	if(is_csrf_guard_enabled && needToInsertToken) {
	   window.open("progress-report.dsp?type=build&projectName=%value projectName%&releaseName=" + releaseName + "&" + _csrfTokenNm_ + "=" + _csrfTokenVal_);
   	} else {
	   window.open("progress-report.dsp?type=build&projectName=%value projectName%&releaseName=" + releaseName);
	}	
}
</SCRIPT>

<TABLE width="100%">
	<TR>
		<TD class="menusection-Deployer" colspan="3">Create Build</TD>
	</TR>
</TABLE>

<TABLE width="100%">
	<TR>
		<TD colspan="2"> <IMG height="10" src="images/blank.gif" width="10"></TD>
	</TR>
	<TR>
		<TD><IMG height="10" src="images/blank.gif" width="10"></TD>
		<TD valign="top">
			<TABLE class="tableForm">
			<TBODY>
				<TR>
					<TD class="heading" colspan="2">Create Build</TD>
				</TR>
%comment%
				<FORM name="addReleaseForm" target="treeFrame" action=under-construction.dsp method=post>
%endcomment%
				<FORM name="addReleaseForm" target="treeFrame" action=release-list.dsp method=post>
				<INPUT type="hidden" VALUE="%value projectName%" name="projectName">
				<INPUT type="hidden" VALUE="add" name="action">
				<TR>
					<TD class="oddrow">* Name</TD>
					<TD class="oddrow-l"><INPUT name="buildName" size="32" maxlength="32"></TD>
				</TR>

				<TR>
					<TD class="evenrow">Description</TD>
					<TD class="evenrow-l"><INPUT name="buildDescription" size="32" maxlength="60"></TD>
				</TR>

        <TR>
          <TD class="subheading" colspan="2">Required fields are indicated by *</TD>
        </TR>

				<TR>
					<TD class="action" colspan="2">
						<INPUT onclick="return onAdd();" type="submit" value="Create" name="submit">
					</TD>
				</TR>
				<TR>
				<TD colspan="2">
								<BR>
				</TD>
				</TR>

				<TR>
				<TD>
					<A href="javascript:viewProgress();">View Progress Report</A>

				</TD>
				</TR>
				</FORM>
			</TBODY>
			</TABLE>
		</TD>
	</TR>
</TABLE>

<script>
	%invoke wm.deployer.gui.UISuggest:suggestBuildName%
		document.addReleaseForm.buildName.value = "%value buildName%";
	%endinvoke%
	document.addReleaseForm.buildName.focus();
</script>

</BODY>
</HTML>
