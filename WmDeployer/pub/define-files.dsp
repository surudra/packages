<HTML><HEAD><TITLE>Define Files</TITLE>
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META http-equiv=Pragma content=no-cache>
<META http-equiv=Expires content=-1>
<LINK href="webMethods.css" type=text/css rel=stylesheet>
<LINK href="xtree.css" type=text/css rel=stylesheet>
<SCRIPT src="webMethods.js"></SCRIPT>
<script type="text/javascript" src="xtree.js"></script>
<script type="text/javascript" src="xtreecheckbox.js"></script>
</HEAD>
<BODY>

<SCRIPT LANGUAGE="JavaScript">

function setRadios(x) {
	if (x == 0) {
		var j = document.fForm.file.options.length;
		for (k = 0; k < j; k++)
			document.fForm.file.options[k].selected = false;
	}

	if (x == 1) {
		var j = document.fForm.file.options.length;
		for (k = 0; k < j; k++)
			document.fForm.file.options[k].selected = true;
	}

	if ((x == 0) || (x == 1) || (x == 4) || (x == 5))
		document.fForm.file.disabled = true;
	else
		document.fForm.file.disabled = false;

	if ((x == 0) || (x == 1) || (x == 2) || (x == 3)) {
		document.fForm.fileNamePattern[0].disabled = true;
		document.fForm.fileNamePattern[1].disabled = true;
	}
	else if (x == 4) {
		document.fForm.fileNamePattern[0].disabled = false;
		document.fForm.fileNamePattern[1].disabled = true;
	}
	else if (x == 5) {
		document.fForm.fileNamePattern[0].disabled = true;
		document.fForm.fileNamePattern[1].disabled = false;
	}

}

function componentConfig() {

		document.fForm.filter[0].disabled = true;
		document.fForm.filter[1].disabled = true;
		document.fForm.filter[3].disabled = true;
		document.fForm.filter[4].disabled = true;
		document.fForm.filter[5].disabled = true;
		document.fForm.fileNamePattern[0].disabled = true;
		document.fForm.fileNamePattern[1].disabled = true;
}

// Click the parent Frame's hidden field to start the Progress Bar
function updateDS() {
	startProgressBar("Saving Package files");
	return true;
}

</SCRIPT>

<TABLE width="100%">
  <TR>
    <TD class=menusection-Deployer>%value bundleName% > Packages > %value serverAliasName%:%value packageName% > Files</TD>
  </TR>
</TABLE>

<TABLE width="100%">
  <TR>
    <TD>
      <UL>
    		<LI> <A onClick="startProgressBar();" href="define-files.dsp?projectName=%value projectName%&bundleName=%value bundleName%&serverAliasName=%value serverAliasName%&packageName=%value packageName%&mode=%value mode%">Refresh this Page</A> </LI>
				<LI> <A href="define-component.dsp?projectName=%value -htmlcode projectName%&bundleName=%value -htmlcode bundleName%&serverAliasName=%value -htmlcode serverAliasName%&packageName=%value -htmlcode packageName%&mode=%value -htmlcode mode%">Select Components</A> </LI>
	%ifvar mode equals('properties')%
				<LI> <A href="package-properties.dsp?projectName=%value -htmlcode projectName%&bundleName=%value -htmlcode bundleName%&serverAliasName=%value -htmlcode serverAliasName%&packageName=%value -htmlcode packageName%">Return to %value serverAliasName%:%value packageName% Properties</A> </LI>
	%else%
		%ifvar mode equals('plugin')%
    		<LI> <A href="define-plugin-packages.dsp?projectName=%value -htmlcode projectName%&bundleName=%value -htmlcode bundleName%&parentServerAliasName=%value -htmlcode serverAliasName%">Return to %value serverAliasName%:Packages</A> </LI>
		%else%
    		<LI> <A href="define-developer.dsp?projectName=%value -htmlcode projectName%&bundleName=%value -htmlcode bundleName%">Return to Packages</A> </LI>
		%endif%
	%endif%
       </UL>
    </TD>
  </TR>
</TABLE>

<!- projectName*, bundleName*, serverAlias, packageName* ->
%rename serverAliasName serverAlias -copy%
%invoke wm.deployer.gui.UIBundle:getBundlePackageInfo%
%endinvoke%

<TABLE class="tableView" width="100%">
  <TR>
		<TD><img border="0" src="images/blank.gif" width="20" height="1"></TD>
    <TD class="heading" valign="top" colspan="2"> Select Files </TD>
		<TD valign="top"> <img border="0" src="images/blank.gif" width="20" height="1"></td>
  </TR>

%comment%
	<FORM id="fForm" name="fForm" method="POST" target="treeFrame" action="under-construction.dsp">
%endcomment%
	<FORM id="fForm" name="fForm" method="POST" target="treeFrame" action="bundle-list.dsp">

	<!- Submit Button, placed at top for convenience ->
	<TR>
 		<TD valign="top"></td>
		<TD class="action" colspan="2">
			<INPUT onclick="return updateDS();" align="center" type="submit" VALUE="Save" name="submit"> </TD>
 		<TD valign="top"></td>
		<INPUT type="hidden" name="projectName" value='%value projectName%'>
		<INPUT type="hidden" name="bundleName" value='%value bundleName%'>
		<INPUT type="hidden" name="serverAliasName" value='%value serverAliasName%'>
		<INPUT type="hidden" name="packageName" value='%value packageName%'>
		<INPUT type="hidden" name="mode" value='%value mode%'>
		<INPUT type="hidden" name="action" value="updateFile">
	</TR>

<SCRIPT>resetRows();</SCRIPT>
<SCRIPT>swapRows();</SCRIPT>
<TR>
 		<TD valign="top"></td>
		<script>writeTDspan("col-l","2");</script>NOTE: If you have selected components, you may only select files from the list below.
 		<TD valign="top"></td>
</TR>

<TR>
	<TD valign="top"></td>
	<TD class="evenrow-l" colspan="2">
		<TABLE cellspacing="0" cellpadding="0" >
			<tr><td class="evenrow-l">Files available in %value packageName%:</td></tr>
			<TR>
				<TD class="evenrow-l">
					
					<!- serverAliasName*, packageName* ->
					%invoke wm.deployer.gui.server.IS:listPackageFiles%
					<SELECT name="file" size="10" multiple>
						%loop files%
							<OPTION ID="id_%value fileName -urlencode%" value="%value fileName%"> %value fileName% </OPTION>
						%endloop%
					</SELECT>
					%endinvoke%  
				</TD>
			</TR>
		</TABLE> 
	</TD>
	<TD valign="top"></td>
</TR>

<TR>
	<TD valign="top"></td>
	<TD valign=top  class="oddrow">Files to Include </td>
	<TD valign=top class="oddrow-l" colspan="1">
		<TABLE cellspacing="0" cellpadding="0">

			<tr><td nowrap class="oddrow-l">
				<INPUT onclick="setRadios(0);" type="radio" name="filter" value="include" checked>None</td></tr>

			<tr><td nowrap class="oddrow-l">
				<INPUT onclick="setRadios(1);" type="radio" name="filter" value="includeall">All Files</td></tr>

			<tr><td nowrap class="oddrow-l">
				<INPUT onclick="setRadios(2);" type="radio" name="filter" value="include">Selected files </td></tr>

			<tr><td nowrap class="oddrow-l">
				<INPUT onclick="setRadios(3);" type="radio" name="filter" value="exclude">All <i>except</i> selected files </td></tr>

			<tr>
				<td nowrap class="oddrow-l">
					<INPUT onclick="setRadios(4);" type="radio" name="filter" value="include">Files specified by:</td>
				<td class="oddrow-l">
					<INPUT name="fileNamePattern"><BR>(ex: *.java, *.class) </td>
			</tr>

			<tr>
				<td nowrap class="oddrow-l">
					<INPUT onclick="setRadios(5);" type="radio" name="filter" value="exclude">All <i>except</i> files specified by:</td>
				<td nowrap class="oddrow-l">
					<INPUT name="fileNamePattern"><BR>(ex: *.java, *.class) </td>
			</tr>
		</TABLE>
	</TD>
	<TD valign="top"></td>
</TR>

<SCRIPT>swapRows();</SCRIPT>

<TR>
	<TD valign="top"></td>
	<TD valign="top" class="evenrow">Files to Delete from Target<BR>Use ";" to separate file names.</td>
	<td  class="evenrow-l" colspan="1">
		<textarea style="width:100%;" wrap="off" rows="5" name="deleteFile" cols="20"></textarea>
	</td>
	<TD valign="top"></td>
</TR>

<script>
// This bit selects files from the current definition of the project ->
// projectName*, bundleName*, serverAliasName*, packageName*
%invoke wm.deployer.gui.UIBundle:getBundleISFiles%

	document.fForm.filter[0].click();

	%ifvar filter equals('includeall')%
		document.fForm.filter[1].click();
	%endif%

	%ifvar filter equals('include')%
		var fnp = '%value fileNamePattern%';
		%ifvar fileNamePattern -isnull%
			document.fForm.filter[2].click();
			%loop files%
				var o = document.getElementById("id_%value fullName -urlencode%");
				if (o != null)
					o.selected = true;
			%endloop%
		%else%
			document.fForm.filter[4].click();
			document.fForm.fileNamePattern[0].value = "%value fileNamePattern%";
		%endif%
	%endif%

	%ifvar filter equals('exclude')%
		%ifvar fileNamePattern -isnull%
			document.fForm.filter[3].click();
			%loop files%
				var o = document.getElementById("id_%value fullName -urlencode%");
				if (o != null) 
					o.selected = true;
			%endloop%
		%else%
			document.fForm.filter[5].click();
			document.fForm.fileNamePattern[1].value = "%value fileNamePattern%";
		%endif%
	%endif%

	var s = new String();
	%loop deleteFiles%
		s += "%value fullName%;\r";
	%endloop%
	document.fForm.deleteFile.value = s;

%endinvoke%

%ifvar containsComponents equals('true')%
	componentConfig();
%endif%

stopProgressBar();
</script>
</FORM>
</BODY></HTML>
