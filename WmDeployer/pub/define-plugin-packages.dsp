<HTML><HEAD><TITLE>Plugin Packages</TITLE>
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META http-equiv=Pragma content=no-cache>
<META http-equiv=Expires content=-1>
<LINK href="webMethods.css" type=text/css rel=stylesheet>
<LINK href="xtree.css" type=text/css rel=stylesheet>
<SCRIPT src="webMethods.js"></SCRIPT>
<script src="xtree.js"></script>
<script src="xtreecheckbox.js"></script>
</HEAD>
<BODY>

<TABLE width="100%">
  <TBODY>
  <TR>
    <TD class=menusection-Deployer>%value bundleName% > %value parentServerAliasName%:Packages</TD>
  </TR>
  </TBODY>
</TABLE>

<TABLE width="100%">
  <TR>
    <TD colspan="2">
      <UL>
				<LI> <A onclick="return startProgressBar();" href="define-plugin-packages.dsp?projectName=%value projectName%&bundleName=%value bundleName%&parentServerAliasName=%value parentServerAliasName%&regExp=%value regExp%&regExp2=%value regExp2%">Refresh this Page</A></LI> 
       </UL>
    </TD>
  </TR>
</TABLE>

<TABLE class="tableView" width="100%">
	<TBODY>
	<SCRIPT>resetRows();</SCRIPT>		
  <TR>
		<TD><img border="0" src="images/blank.gif" width="20" height="1"></TD>
    <TD class="heading" valign="top"> Select Packages or Package Components </TD>
		<TD valign="top"> <img border="0" src="images/blank.gif" width="20" height="1"></td>
  </TR>

%comment%
	<FORM id="form" name="form" method="POST" target="treeFrame" action="under-construction.dsp">
%endcomment%
	<FORM id="form" name="form" method="POST" target="treeFrame" action="bundle-list.dsp">

	<!- Submit Button, placed at top for convenience ->
	<TR>
 		<TD valign="top"></td>
		<TD class="action">
			<INPUT onclick="return startProgressBar();" align="center" type="submit" 
				VALUE="Save" name="submit"> </TD>
 		<TD valign="top"></td>
		<INPUT type="hidden" name="projectName" value='%value projectName%'>
		<INPUT type="hidden" name="bundleName" value='%value bundleName%'>
		<INPUT type="hidden" name="parentServerAliasName" value='%value parentServerAliasName%'>
		<INPUT type="hidden" name="regExp" value='%value regExp%'>
		<INPUT type="hidden" name="regExp2" value='%value regExp2%'>
    <INPUT type="hidden" name="action" value="updateDeveloper">
	</TR>

	<SCRIPT>swapRows();</SCRIPT>		
	<TR>
 		<TD valign="top"></td>
		<script>writeTDspan("col-l","1");</script>Click on a Package Name to select individual Package components or files to add to the Deployment Set.
 		<TD valign="top"></td>
	</TR>

	<SCRIPT>swapRows();</SCRIPT>		
	<TR>
 		<TD valign="top"></td>
		<script> writeTD("rowdata-l", "width='100%'");</script>

<script>

	// Enumerate over entire list of configured sources
	%invoke wm.deployer.gui.UIBundle:getBundleServers%
		var devTree = new WebFXTree("%value parentServerAliasName%:Packages");

		var filterCnt = 0;
		var matchCnt = 0;
		%loop servers%

		%ifvar parentServerAliasName vequals(../parentServerAliasName)%
		%ifvar pluginType equals('IS')%
			var serverTree = new WebFXCheckBoxTreeItem("%value serverAliasName%", null, false, null, 
				webFXTreeConfig.logicalServerIcon, webFXTreeConfig.logicalServerIcon);
			devTree.add(serverTree);

			// Retrieve Packages from Server
			%rename serverAliasName serverAlias -copy%
			%rename ../projectName projectName -copy%
			%rename ../bundleName bundleName -copy%
			// serverAlias, projectName, bundleName
			%invoke wm.deployer.gui.server.IS:listPackages%
				%loop packages%

				if (matchRegularExpression("%value /regExp%", "%value packageName%")) {
					var pkgNode = new WebFXCheckBoxTreeItem("%value packageName%", 
						"define-component.dsp?projectName=%value ../../../projectName%&bundleName=%value ../../../bundleName%&serverAliasName=%value ../serverAlias%&packageName=%value packageName%&mode=plugin&parentServer=%value ../../parentServerAliasName%&regExp=%value /regExp%&regExp2=%value /regExp2%", 
						false, null, webFXTreeConfig.ISPackage, webFXTreeConfig.ISPackage,
						"%value ../serverAlias -urlencode%$%value packageName%$PACKAGE_INCL", "PACKAGE_INCL", webFXTreeConfig.linkClass);
					serverTree.add(pkgNode);
					matchCnt++;
				}
				else
					filterCnt++;

				%endloop packages%
			%endinvoke listPackages%
		%endloop servers%
		%endif%
		%endif%
	%endinvoke servers%

// Render the tree 
w(devTree);
</script>
		</TD>
 		<TD valign="top"></td>
	</TR>

<!- If the regular expression is in force, let the user know>
%ifvar regExp -notempty%
	<TR>
		<TD valign="top"></td>
		<script>
		writeTDspan("col-l","1");
		w("Regular expression '%value regExp%' matched " + matchCnt + 
				" and filtered " + filterCnt + " Packages.");
		</script>
		<TD valign="top"></td>
	</TR>
%endif%

	<!- Submit Button, placed at bottom for convenience ->
	<TR>
 		<TD valign="top"></td>
		<TD class="action">
			<INPUT onclick="return startProgressBar();" align="center" type="submit" 
				VALUE="Save" name="submit2"> </TD>
 		<TD valign="top"></td>
	</TR>

	</FORM>
	<TBODY>
</TABLE>

<script>
// This bit selects checkboxes from the current definition of the project ->

// getBundlePackages: projectName*, bundleName*
%invoke wm.deployer.gui.UIBundle:getBundlePackages%
	%loop servers%
		%loop packages%
			// Find the uniquely named Element and check it
			var p = (document.getElementsByName("%value ../serverAliasName -urlencode%$%value packageName%$PACKAGE_INCL")).item(0);
			if (p != null) {
				webFXTreeHandler.all[p.parentNode.id].setChecked(true);

				// For partial packages
				%ifvar componentsOrFiles equals('true')%
					// Disable the checkbox for partial packages 
					p.disabled = true;
					// change icon to partial package
					document.getElementById(p.parentNode.id + '-icon').src = "images/ns_partial_package.gif";
					// change href based on components or types
					%ifvar containsFiles equals('true')%
						document.getElementById(p.parentNode.id + '-anchor').href = "define-files.dsp?projectName=%value -htmlcode /projectName%&bundleName=%value -htmlcode /bundleName%&serverAliasName=%value ../serverAliasName -urlencode%&packageName=%value -htmlcode packageName%&mode=plugin";
					%else%
						document.getElementById(p.parentNode.id + '-anchor').href = "define-component.dsp?projectName=%value -htmlcode /projectName%&bundleName=%value -htmlcode /bundleName%&serverAliasName=%value ../serverAliasName -urlencode%&packageName=%value -htmlcode packageName%&mode=plugin";
					%endif%
				%endif%
			}
		%endloop%
	%endloop servers%
%endinvoke%

stopProgressBar();

</script>

</BODY></HTML>
