<HTML><HEAD><TITLE>Define TN</TITLE>
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
  <TR>
    <TD class=menusection-Deployer>%value bundleName% > Trading Networks</TD>
  </TR>
</TABLE>

<TABLE width="100%">
  <TR>
    <TD colspan="2">
      <UL>
				<LI> <A onclick="return startProgressBar();" href="define-tn.dsp?projectName=%value projectName%&bundleName=%value bundleName%&regExp=%value regExp%">Refresh this Page</A></LI> 
       </UL>
    </TD>
  </TR>
</TABLE>

<TABLE class="tableView" width="100%">
  <TR>
		<TD><img border="0" src="images/blank.gif" width="20" height="1"></TD>
    <TD class="heading" valign="top"> Select Trading Networks Assets</TD>
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
			<INPUT onclick="return startProgressBar('Saving Trading Networks assets');" align="center" type="submit" 
				VALUE="Save" name="submit"> </TD>
 		<TD valign="top"></td>
		<INPUT type="hidden" name="projectName" value='%value projectName%'>
		<INPUT type="hidden" name="bundleName" value='%value bundleName%'>
		<INPUT type="hidden" name="regExp" value='%value regExp%'>
		<INPUT type="hidden" name="action" value="updateTN">
	</TR>

	<SCRIPT>resetRows();</SCRIPT>
	<TR>
 		<TD valign="top"></td>
		<script> writeTD("rowdata-l", "width='100%'");</script>

<script>
	
	%invoke wm.deployer.gui.UISettings:getSettings%
    %endinvoke%
    
	// Enumerate over entire list of configured sources
	%invoke wm.deployer.gui.UIBundle:getBundleSourceServers%
		%ifvar servers -notempty%
			var TNTree = new WebFXTree("Trading Networks");

		var matchCnt = 0;
		var filterCnt = 0;
		var treeNodeCountExceeded = 'false';
		%loop servers%
		       	%rename serverAliasName serverAlias -copy%
			%rename ../../treeNodeCount treeNodeCount -copy%

			// Ping this Integration server before investing too much in it
			%ifvar ../optimisticNetwork equals('false')%
				%invoke wm.deployer.gui.server.IS:ping%
				%endinvoke%
			%endif%
			
			%ifvar ../optimisticNetwork equals('true')%
					%include inc-tn-tree.dsp%
			%else%	
				%ifvar status equals('Success')%
					%include inc-tn-tree.dsp%
				%else%
					var serverTree = new WebFXTreeItem("%value serverAlias% (Unavailable: %value message%)",
							null, null, webFXTreeConfig.serverIcon, webFXTreeConfig.serverIcon);
				%endif%
			%endif%
				
		TNTree.add(serverTree);
		%endloop serverAliases%
		%else%
			var TNTree = new WebFXTree("Trading Networks (no Source Server configured)", null, null,
				webFXTreeConfig.TNicon, webFXTreeConfig.TNicon);
		%endif%
	%endinvoke servers%

// Write out the tree for the next section
w(TNTree);
</script>
		</TD>
 		<TD valign="top"></td>
	</TR>

<!- If the regular expression is in force, let the user know>
	<TR>
		<TD valign="top"></td>
		<script>
		writeTDspan("col-l","1");
%ifvar regExp -notempty%
		w("Regular Expression '%value regExp%' matched " + matchCnt + 
				" and filtered " + filterCnt + " assets.");
%else%
	if(treeNodeCountExceeded == 'true')
	{
		w(matchCnt + " assets displayed. (Please note that actual number of assets exceeded the 'Maximum TN Tree Objects Count'. Hence remaining assets are not displayed.)");
	}
	else
	{
		w(matchCnt + " assets displayed.");
	}
%endif%
		</script>
		<TD valign="top"></td>
	</TR>

	<SCRIPT>swapRows();</SCRIPT>
	<!- Submit Button, placed at bottom for convenience ->
	<TR>
 		<TD valign="top"></td>
		<TD class="action">
			<INPUT onclick="return startProgressBar('Saving Trading Networks assets');" align="center" type="submit" 
				VALUE="Save" name="submit2"> </TD>
 		<TD valign="top"></td>
	</TR>

	</FORM>
</TABLE>

<script>
// This bit selects checkboxes from the current definition of the project ->

// getBundleTNTypes: projectName*, bundleName*
%invoke wm.deployer.gui.TN:getBundleTNTypes%
	%loop servers%

		// Processing Rules
		%loop rules%
			// Find the uniquely named Element and check it
			var p = document.getElementsByName("%value ../serverAliasName -urlencode%$TNDEPLOYERDATA$%value ruleKey -urlencode%$TNDEPLOYERDATA$%value ruleName -urlencode%");
			if (p.length == 1) {
				webFXTreeHandler.all[p.item(0).parentNode.id].setChecked(true);
			}
		%endloop%

		// Doc Attribs
		%loop attribs%
			// Find the uniquely named Element and check it
			var p = document.getElementsByName("%value ../serverAliasName -urlencode%$TNDEPLOYERDATA$%value attribKey -urlencode%$TNDEPLOYERDATA$%value attribName -urlencode%");
			if (p.length == 1) {
				webFXTreeHandler.all[p.item(0).parentNode.id].setChecked(true);
			}
		%endloop%

		// Doc Types
		%loop types%
			// Find the uniquely named Element and check it
			var p = document.getElementsByName("%value ../serverAliasName -urlencode%$TNDEPLOYERDATA$%value typeKey -urlencode%$TNDEPLOYERDATA$%value typeName -urlencode%");
			if (p.length == 1) {
				webFXTreeHandler.all[p.item(0).parentNode.id].setChecked(true);
			}
		%endloop%

		// TPAs
		%loop tpas%
			// Find the uniquely named Element and check it
			var p = document.getElementsByName("%value ../serverAliasName -urlencode%$TNDEPLOYERDATA$%value tpaKey -urlencode%$TNDEPLOYERDATA$%value tpaName -urlencode%");
			if (p.length == 1) {
				webFXTreeHandler.all[p.item(0).parentNode.id].setChecked(true);
			}
		%endloop%

		// Field Groups
		%loop fldgrps%
			// Find the uniquely named Element and check it
			var p = document.getElementsByName("%value ../serverAliasName -urlencode%$TNDEPLOYERDATA$%value fldgrpKey -urlencode%$TNDEPLOYERDATA$%value fldgrpName -urlencode%");
			if (p.length == 1) {
				webFXTreeHandler.all[p.item(0).parentNode.id].setChecked(true);
			}
		%endloop%

		// Field Definitions
		%loop flddefs%
			// Find the uniquely named Element and check it
			var p = document.getElementsByName("%value ../serverAliasName -urlencode%$TNDEPLOYERDATA$%value flddefKey -urlencode%$TNDEPLOYERDATA$%value flddefName -urlencode%");
			if (p.length == 1) {
				webFXTreeHandler.all[p.item(0).parentNode.id].setChecked(true);
			}
		%endloop%

		// External ID Types
		%loop idTypes%
			// Find the uniquely named Element and check it
			var p = document.getElementsByName("%value ../serverAliasName -urlencode%$TNDEPLOYERDATA$%value idTypeKey -urlencode%$TNDEPLOYERDATA$%value idTypeName -urlencode%");
			if (p.length == 1) {
				webFXTreeHandler.all[p.item(0).parentNode.id].setChecked(true);
			}
		%endloop%

		// Contact Types
		%loop contactTypes%
			// Find the uniquely named Element and check it
			var p = document.getElementsByName("%value ../serverAliasName -urlencode%$TNDEPLOYERDATA$%value contactTypeKey -urlencode%$TNDEPLOYERDATA$%value contactTypeName -urlencode%");
			if (p.length == 1) {
				webFXTreeHandler.all[p.item(0).parentNode.id].setChecked(true);
			}
		%endloop%

		// Binary Types
		%loop binaryTypes%
			// Find the uniquely named Element and check it
			var p = document.getElementsByName("%value ../serverAliasName -urlencode%$TNDEPLOYERDATA$%value binaryTypeKey -urlencode%$TNDEPLOYERDATA$%value binaryTypeName -urlencode%");
			if (p.length == 1) {
				webFXTreeHandler.all[p.item(0).parentNode.id].setChecked(true);
			}
		%endloop%

		// Profile Groups
		%loop profileGroups%
			var p = document.getElementsByName("%value ../serverAliasName -urlencode%$TNDEPLOYERDATA$%value profileGroupKey -urlencode%$TNDEPLOYERDATA$%value profileGroupName -urlencode%");
			if (p.length == 1) {
				webFXTreeHandler.all[p.item(0).parentNode.id].setChecked(true);
			}
		%endloop%

		// Queues
		%loop queues%
			// Find the uniquely named Element and check it
			var p = document.getElementsByName("%value ../serverAliasName -urlencode%$TNDEPLOYERDATA$%value queueKey -urlencode%$TNDEPLOYERDATA$%value queueName -urlencode%");
			if (p.length == 1) {
				webFXTreeHandler.all[p.item(0).parentNode.id].setChecked(true);
			}
		%endloop%

		// DLS
		%loop dls%
			// Find the uniquely named Element and check it
			var p = document.getElementsByName("%value ../serverAliasName -urlencode%$TNDEPLOYERDATA$%value dlsKey -urlencode%$TNDEPLOYERDATA$%value dlsName -urlencode%");
			if (p.length == 1) {
				webFXTreeHandler.all[p.item(0).parentNode.id].setChecked(true);
			}
		%endloop%

		// Fp
		%loop fp%
			// Find the uniquely named Element and check it
			var p = document.getElementsByName("%value ../serverAliasName -urlencode%$TNDEPLOYERDATA$%value fpKey -urlencode%$TNDEPLOYERDATA$%value fpName -urlencode%");
			if (p.length == 1) {
				webFXTreeHandler.all[p.item(0).parentNode.id].setChecked(true);
			}
		%endloop%

		// Archival Services
		%loop archSvcs%
			// Find the uniquely named Element and check it
			var p = document.getElementsByName("%value ../serverAliasName -urlencode%$TNDEPLOYERDATA$%value archSvcsName -urlencode%$TNDEPLOYERDATA$%value archSvcsName -urlencode%");
			if (p.length == 1) {
				webFXTreeHandler.all[p.item(0).parentNode.id].setChecked(true);
			}
		%endloop%


		// Partner Data: Profiles
		%loop profiles%
			// Find the uniquely named Element and check it
			var p = document.getElementsByName("%value ../serverAliasName -urlencode%$TNDEPLOYERDATA$%value profileKey -urlencode%$TNDEPLOYERDATA$%value profileName -urlencode%");
			if (p.length == 1) {
				webFXTreeHandler.all[p.item(0).parentNode.id].setChecked(true);
			}
		%endloop%

		// Partner Data: Extended Fields
		%loop extflds%
			// Find the uniquely named Element and check it
			var p = document.getElementsByName("%value ../serverAliasName -urlencode%$TNDEPLOYERDATA$%value extfldKey -urlencode%$TNDEPLOYERDATA$%value extfldName -urlencode%$TNDEPLOYERDATA$%value extfldParentKey -urlencode%$TNDEPLOYERDATA$%value extfldParentName -urlencode%");
			if (p.length == 1) {
				webFXTreeHandler.all[p.item(0).parentNode.id].setChecked(true);
			}
		%endloop%

		// Partner Data: Security Data
		%loop securityData%
			var p = document.getElementsByName("%value ../serverAliasName -urlencode%$TNDEPLOYERDATA$%value securityDataKey -urlencode%$TNDEPLOYERDATA$SecurityData$TNDEPLOYERDATA$%value securityDataParentKey -urlencode%$TNDEPLOYERDATA$%value securityDataParentName -urlencode%");
			if (p.length == 1) {
				webFXTreeHandler.all[p.item(0).parentNode.id].setChecked(true);
			}
		%endloop%

	%endloop servers%
%endinvoke%

stopProgressBar();

</script>

</BODY></HTML>
