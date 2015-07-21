<HTML><HEAD>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META http-equiv="Expires" content="-1">
<SCRIPT src="webMethods.js"></SCRIPT>
<LINK href="webMethods.css" type="text/css" rel="stylesheet">
<BODY>

<SCRIPT language=JavaScript>

function onAdd(buildName, mapSetName) {
	var n = document.addForm.deploymentName.value;
	var b = buildName.options[buildName.selectedIndex].value;
	var m = mapSetName.options[mapSetName.selectedIndex].value;

	if ( trim(n) == "" ) {
		alert("Deployment Candidate Name is required.");
		return false;
	} 
	else if (!isIllegalName(n)) {
		alert("Invalid Name.\nRefer to Integration Server Administrator's Guide for listed illegal characters.");
		return false;
	}

	if (b == "--NONE--" || b == null || b == "") {
		alert("Build is required.");
		return false;
	}

	if (m == "--NONE--" || m == null || m == "") {
		alert("Deployment Map is required.");
		return false;
	}

	startProgressBar("Creating Deployment Candidate " + n);
	return true;
}

</SCRIPT>

<TABLE width="100%">
	<TR>
		<TD class="menusection-Deployer" colspan="4">
			Projects &gt; %value projectName% &gt; Create Deployment Candidate
		</TD>
	</TR>
</TABLE>

<TABLE>
	<TR>
		<TD colspan="2"><IMG height="10" src="images/blank.gif" width="10"></TD>
	</TR>
	<TR>
		<TD><IMG height="10" src="images/blank.gif" width="10"></TD>
		<TD valign="top">
			<TABLE class="tableForm">
				<TR>
					<TD class="heading" colspan="2">Create Deployment Candidate</TD>
				</TR>

				<FORM name=addForm method="POST" target="treeFrame" action="deploy-list.dsp">
					<INPUT type="hidden" value="%value projectName%" name="projectName">
					<INPUT type="hidden" value="%value projectType%" name="projectType">					
         	<INPUT type="hidden" VALUE="add" name="action">

				<TR>
					<TD class="oddrow">* Name</TD>
					<TD class="oddrow-l"><INPUT name="deploymentName" size="32" maxlength="32"></TD>
				</TR>
				<TR>
					<TD class="evenrow">Description</TD>
					<TD class="evenrow-l"><INPUT name="deploymentDescription" size="32"></TD>
				</TR>
				%ifvar projectType equals('Repository')%
				%else%
				<TR>
					<TD width="25%" class="oddrow">* Project Build</TD>
					<TD class="oddrow-l">
						<P><SELECT size="1" name="buildName">
						<!- projectName ->
						<script> var buildExists = false; </script>
						%invoke wm.deployer.gui.UIRelease:listReleases%
							%loop releases%
								%ifvar releaseStatus equals('Error')%
								%else%
								<OPTION VALUE="%value releaseName%">%value releaseName%</OPTION>
								<script> buildExists = true; </script>
								%endif%
							%endloop%
						%endinvoke%
						<script> 
						if (buildExists == false)
								w("<OPTION VALUE='--NONE--'>No Builds available</OPTION>");
						</script>
					</SELECT></P>
					</TD>
				</TR>
				%endif%
				<TR>
					<TD nowrap class="evenrow">* Deployment Map</TD>
					<TD class="evenrow-l">
						<P><SELECT size="1" name="mapSetName">
						<!- projectName ->
						%invoke wm.deployer.gui.UITarget:listProjectMapSets%
						%ifvar mapSets -notempty%
							%loop mapSets%
								%ifvar canBeDeployed equals('false')%
									<OPTION VALUE="%value mapSetName%">%value mapSetName% (may be missing referenced assets)</OPTION>
								%else%
									%ifvar isMapValid equals('false')%
										<OPTION VALUE="%value mapSetName%">%value mapSetName% (invalid map)</OPTION>
									%else%
										<OPTION VALUE="%value mapSetName%">%value mapSetName%</OPTION>
									%endif%
								%endif%
							%endloop%
						%else%
								<OPTION VALUE="--NONE--">No Deployment Maps available</OPTION>
						%endif%
						%endinvoke%
						</SELECT></P>
					</TD>
				</TR>

         <TR>
           <TD class="subheading" colspan="2">Required fields are indicated by *</TD>
         </TR>
				<TR>
					<TD class="action" colspan="2">
					<INPUT onclick="return onAdd(buildName, mapSetName);" type="submit" value="Create">
					</TD>
				</TR>
			</TABLE>
		</TD>
	</TR>
	</FORM>
</TABLE>

<script>
	%invoke wm.deployer.gui.UISuggest:suggestDeploymentName%
		document.addForm.deploymentName.value = "%value deploymentName%";
	%endinvoke%
	document.addForm.deploymentName.focus();
  stopProgressBar();
</script>

</BODY>
</HTML>
