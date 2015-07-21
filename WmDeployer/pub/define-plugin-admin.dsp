<HTML><HEAD><TITLE>Define IS Admin</TITLE>
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
    <TD class=menusection-Deployer>%value bundleName% > %value parentServerAliasName%:Administration</TD>
  </TR>
  </TBODY>
</TABLE>

<SCRIPT>resetRows();</SCRIPT>
<TABLE width="100%">
  <TR>
    <TD colspan="2">
      <UL>
				<LI> <A onclick="return startProgressBar();" href="define-plugin-admin.dsp?projectName=%value projectName%&bundleName=%value bundleName%&parentServerAliasName=%value parentServerAliasName%&regExp=%value regExp%">Refresh this Page</A></LI> 
       </UL>
    </TD>
  </TR>
</TABLE>

<TABLE class="tableView" width="100%">
	<TBODY>
  <TR>
		<TD><img border="0" src="images/blank.gif" width="20" height="1"></TD>
    <TD class="heading" valign="top"> Select Administration Assets</TD>
		<TD valign="top"> <img border="0" src="images/blank.gif" width="20" height="1"></td>
  </TR>

%comment%
	<FORM id="form" name="form" method="POST" action="under-construction.dsp">
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
		<INPUT type="hidden" name="action" value="updateSecurity">
	</TR>

	<TR>
 		<TD valign="top"></td>
		<script> writeTD("rowdata-l", "width='100%'");</script>

<script>


	// Enumerate over entire list of configured sources
	%invoke wm.deployer.gui.UIBundle:getBundleServers%
		var secTree = new WebFXTree("%value parentServerAliasName%:Administration");
		var filterCnt = 0;
		var matchCnt = 0;
		%loop servers%
		%ifvar parentServerAliasName vequals(../parentServerAliasName)%

		%ifvar pluginType equals('IS')%

			%rename serverAliasName serverAlias -copy%
			%rename ../projectName projectName -copy%
			%rename ../bundleName bundleName -copy%

			var serverTree = new WebFXCheckBoxTreeItem("%value serverAliasName%", null, false, null, 
				webFXTreeConfig.logicalServerIcon, webFXTreeConfig.logicalServerIcon);
			secTree.add(serverTree);

    	%include shared-security-tree.dsp%

		%endif%
		%endif%
		%endloop servers%

	%endinvoke%

// Write out the tree for the next section
w(secTree);
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
		w("Regular Expression '%value regExp%' matched " + matchCnt + 
				" and filtered " + filterCnt + " assets.");
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

// getBundleScheduledServices: projectName*, bundleName*
%invoke wm.deployer.gui.UIBundle:getBundleScheduledServices%
	%loop servers%
		%loop services%
			// Find the uniquely named Element and check it
			var p = document.getElementById("%value taskId%");
			if (p != null) webFXTreeHandler.all[p.parentNode.id].setChecked(true);
		%endloop%
	%endloop servers%
%endinvoke%

// getBundlePorts: projectName*, bundleName*
%invoke wm.deployer.gui.UIBundle:getBundlePorts%
	%loop servers%
		%loop ports%
			// Find the uniquely named Element and check it
			var p = document.getElementsByName("%value ../serverAliasName -urlencode%$%value portKey -urlencode%$%value portType%$PORT_INCL");
			if (p.length == 1) {
				webFXTreeHandler.all[p.item(0).parentNode.id].setChecked(true);
			}
		%endloop%
	%endloop servers%
%endinvoke%

// getBundleUsers: projectName*, bundleName*
%invoke wm.deployer.gui.UIBundle:getBundleUsers%
	%loop servers%
		%loop users%
			// Find the uniquely named Element and check it
			var p = document.getElementsByName("%value ../serverAliasName -urlencode%$%value userName%$USER_INCL");
			if (p.length == 1) {
				webFXTreeHandler.all[p.item(0).parentNode.id].setChecked(true);
			}
		%endloop%
	%endloop servers%
%endinvoke%

// getBundleGroups: projectName*, bundleName*
%invoke wm.deployer.gui.UIBundle:getBundleGroups%
	%loop servers%
		%loop groups%
			// Find the uniquely named Element and check it
			var p = document.getElementsByName("%value ../serverAliasName -urlencode%$%value groupName%$GROUP_INCL");
			if (p.length == 1) {
				webFXTreeHandler.all[p.item(0).parentNode.id].setChecked(true);
			}
		%endloop%
	%endloop servers%
%endinvoke%

// getBundleAcls: projectName*, bundleName*
%invoke wm.deployer.gui.UIBundle:getBundleAcls%
	%loop servers%
		%loop acls%
			// Find the uniquely named Element and check it
			var p = document.getElementsByName("%value ../serverAliasName -urlencode%$%value aclName%$ACL_INCL");
			if (p.length == 1) {
				webFXTreeHandler.all[p.item(0).parentNode.id].setChecked(true);
			}
		%endloop%
	%endloop servers%
%endinvoke%

stopProgressBar();

</script>

</BODY></HTML>
