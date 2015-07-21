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
    <TD class=menusection-Deployer>%value bundleName% > %value parentServerAliasName%:Trading Networks</TD>
  </TR>
</TABLE>

<TABLE width="100%">
  <TR>
    <TD colspan="2">
      <UL>
				<LI> <A onclick="return startProgressBar();" href="define-plugin-tn.dsp?projectName=%value projectName%&bundleName=%value bundleName%&parentServerAliasName=%value parentServerAliasName%">Refresh this Page</A></LI> 
       </UL>
    </TD>
  </TR>
</TABLE>

<TABLE class="tableView" width="100%">
  <TR>
		<TD><img border="0" src="images/blank.gif" width="20" height="1"></TD>
    <TD class="heading" valign="top"> Select Trading Network Assets</TD>
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
		<INPUT type="hidden" name="action" value="updateTN">
	</TR>

	<SCRIPT>resetRows();</SCRIPT>
	<TR>
 		<TD valign="top"></td>
		<script> writeTD("rowdata-l", "width='100%'");</script>

<script>

	// Enumerate over entire list of configured sources
	%invoke wm.deployer.gui.UIBundle:getBundleServers%
		var TNTree = new WebFXTree("Trading Networks");

		%loop servers%
		%ifvar parentServerAliasName vequals(../parentServerAliasName)%
		%ifvar pluginType equals('TN')%

			%rename serverAliasName serverAlias -copy%
			%rename ../projectName projectName -copy%
			%rename ../bundleName bundleName -copy%

			var serverTree = new WebFXCheckBoxTreeItem("%value serverAliasName%", null, false, null, 
				webFXTreeConfig.logicalServerIcon, webFXTreeConfig.logicalServerIcon);

			// Retrieve TN crapola from Server
			// listTnTypes: serverAlias, various booleans
				%scope param(attribs='false') param(types='false') param(rules='false') param(flddefs='false') param(profiles='false') param(lookups='false') param(tpas='false') param(extflds='false') param(securityData='false') param(all='true')%
				%invoke wm.deployer.gui.TN:listTNTypes%

					// Processing Rules
					%ifvar rules -notempty%
						var subTree = new WebFXCheckBoxTreeItem("Processing Rules");
						serverTree.add(subTree);
						%loop rules%
							var p = new WebFXCheckBoxTreeItem("%value ruleName%", null, false, null, 
								webFXTreeConfig.TNrule, webFXTreeConfig.TNrule, 
								"%value ../serverAliasName -urlencode%$TNDEPLOYERDATA$%value ruleKey -urlencode%$TNDEPLOYERDATA$%value ruleName -urlencode%", "TNProcessingRule_INCL");
							subTree.add(p);
						%endloop%
					%endif%

					// Document Attributes
					%ifvar attribs -notempty%
						var subTree = new WebFXCheckBoxTreeItem("Document Attributes");
						serverTree.add(subTree);
						%loop attribs%
							var p = new WebFXCheckBoxTreeItem("%value attribName%", null, false, null, 
								webFXTreeConfig.TNattribute, webFXTreeConfig.TNattribute, 
								"%value ../serverAliasName -urlencode%$TNDEPLOYERDATA$%value attribKey -urlencode%$TNDEPLOYERDATA$%value attribName -urlencode%", "TNDocumentAttribute_INCL");
							subTree.add(p);
						%endloop%
					%endif%

					// Document Types
					%ifvar types -notempty%
						var subTree = new WebFXCheckBoxTreeItem("Document Types");
						serverTree.add(subTree);
						%loop types%
							var p = new WebFXCheckBoxTreeItem("%value typeName%", null, false, null, 
								webFXTreeConfig.TNtype, webFXTreeConfig.TNtype, 
								"%value ../serverAliasName -urlencode%$TNDEPLOYERDATA$%value typeKey -urlencode%$TNDEPLOYERDATA$%value typeName -urlencode%", "TNDocumentType_INCL");
							subTree.add(p);
						%endloop%
					%endif%

					// Agreements
					%ifvar tpas -notempty%
						var subTree = new WebFXCheckBoxTreeItem("Agreements");
						serverTree.add(subTree);
						%loop tpas%
							var p = new WebFXCheckBoxTreeItem("%value tpaName%", null, false, null, 
								webFXTreeConfig.TNagreement, webFXTreeConfig.TNagreement, 
								"%value ../serverAliasName -urlencode%$TNDEPLOYERDATA$%value tpaKey -urlencode%$TNDEPLOYERDATA$%value tpaName -urlencode%", "TNTPA_INCL");
							subTree.add(p);
						%endloop%
					%endif%

					// Field Groups
					%ifvar fldgrps -notempty%
						var subTree = new WebFXCheckBoxTreeItem("Field Groups");
						serverTree.add(subTree);
						%loop fldgrps%
							var p = new WebFXCheckBoxTreeItem("%value fldgrpName%", null, false, null, 
								webFXTreeConfig.TNprofileFld, webFXTreeConfig.TNprofileFld, 
								"%value ../serverAliasName -urlencode%$TNDEPLOYERDATA$%value fldgrpKey -urlencode%$TNDEPLOYERDATA$%value fldgrpName -urlencode%", "TNFieldGroup_INCL");
							subTree.add(p);
						%endloop%
					%endif%

					// Field Definitions
					%ifvar flddefs -notempty%
						var subTree = new WebFXCheckBoxTreeItem("Field Definitions");
						serverTree.add(subTree);
						%loop flddefs%
							var p = new WebFXCheckBoxTreeItem("%value flddefName%", null, false, null, 
								webFXTreeConfig.TNprofileFld, webFXTreeConfig.TNprofileFld, 
								"%value ../serverAliasName -urlencode%$TNDEPLOYERDATA$%value flddefKey -urlencode%$TNDEPLOYERDATA$%value flddefName -urlencode%", "TNFieldDefinition_INCL");
							subTree.add(p);
						%endloop%
					%endif%

					// External ID Types
					%ifvar idTypes -notempty%
						var subTree = new WebFXCheckBoxTreeItem("External ID Types");
						serverTree.add(subTree);
						%loop idTypes%
							var p = new WebFXCheckBoxTreeItem("%value idTypeName%", null, false, null, 
								webFXTreeConfig.TNprofileFld, webFXTreeConfig.TNprofileFld, 
								"%value ../serverAliasName -urlencode%$TNDEPLOYERDATA$%value idTypeKey -urlencode%$TNDEPLOYERDATA$%value idTypeName -urlencode%", "TNIdType_INCL");
							subTree.add(p);
						%endloop%
					%endif%

					// Contact Types
					%ifvar contactTypes -notempty%
						var subTree = new WebFXCheckBoxTreeItem("Contact Types");
						serverTree.add(subTree);
						%loop contactTypes%
							var p = new WebFXCheckBoxTreeItem("%value contactTypeName%", null, false, null, 
								webFXTreeConfig.TNprofileFld, webFXTreeConfig.TNprofileFld, 
								"%value ../serverAliasName -urlencode%$TNDEPLOYERDATA$%value contactTypeKey -urlencode%$TNDEPLOYERDATA$%value contactTypeName -urlencode%", "TNContactType_INCL");
							subTree.add(p);
						%endloop%
					%endif%

					// Binary Types
					%ifvar binaryTypes -notempty%
						var subTree = new WebFXCheckBoxTreeItem("Binary Types");
						serverTree.add(subTree);
						%loop binaryTypes%
							var p = new WebFXCheckBoxTreeItem("%value binaryTypeName%", null, false, null, 
								webFXTreeConfig.TNprofileFld, webFXTreeConfig.TNprofileFld, 
								"%value ../serverAliasName -urlencode%$TNDEPLOYERDATA$%value binaryTypeKey -urlencode%$TNDEPLOYERDATA$%value binaryTypeName -urlencode%", "TNBinaryType_INCL");
							subTree.add(p);
						%endloop%
					%endif%

					// Profile Groups
					%ifvar profileGroups -notempty%
						var subTree = new WebFXCheckBoxTreeItem("Profile Groups");
						serverTree.add(subTree);
						%loop profileGroups%
							var p = new WebFXCheckBoxTreeItem("%value profileGroupName%", null, false, null, 
								webFXTreeConfig.TNprofile, webFXTreeConfig.TNprofile, 
								"%value ../serverAliasName -urlencode%$TNDEPLOYERDATA$%value profileGroupKey -urlencode%$TNDEPLOYERDATA$%value profileGroupName -urlencode%", "TNProfileGroup_INCL");
							subTree.add(p);
						%endloop%
					%endif%

					// To guarantee a unique Partner Data folder 
					var partnerList = new Array;
					var partnerTreeList = new Array;

					var subTree = new WebFXCheckBoxTreeItem("Partner Data");

					// Partner Data: Profiles
					%loop profiles%
						var partnerTree = new WebFXCheckBoxTreeItem("Partner: %value profileName%");
						var p = new WebFXCheckBoxTreeItem("Profile", null, false, null, 
							webFXTreeConfig.TNprofile, webFXTreeConfig.TNprofile, 
							"%value ../serverAliasName -urlencode%$TNDEPLOYERDATA$%value profileKey -urlencode%$TNDEPLOYERDATA$%value profileName -urlencode%", "TNProfile_INCL");
						partnerTree.add(p);
						subTree.add(partnerTree);

						// Stow away the Profile Key for later lookup
						partnerList[partnerList.length] = "%value profileKey%";
						partnerTreeList[partnerTreeList.length] = partnerTree;
					%endloop%

					// Partner Data: Extended Fields
					%loop extflds%
						var partnerTree = getServerTree("%value extfldParentKey%", partnerList, partnerTreeList);
						var p = new WebFXCheckBoxTreeItem("%value extfldName%", null, false, null, 
							webFXTreeConfig.TNprofileFld, webFXTreeConfig.TNprofileFld, 
							"%value ../serverAliasName -urlencode%$TNDEPLOYERDATA$%value extfldKey -urlencode%$TNDEPLOYERDATA$%value extfldName -urlencode%$TNDEPLOYERDATA$%value extfldParentKey -urlencode%$TNDEPLOYERDATA$%value extfldParentName -urlencode%", "TNExtendedField_INCL");
						partnerTree.add(p);
					%endloop%

					// Partner Data: Security Data
					%loop securityData%
						var partnerTree = getServerTree("%value securityDataParentKey%", partnerList, partnerTreeList);
						var p = new WebFXCheckBoxTreeItem("Security Data", null, false, null, 
							webFXTreeConfig.TNcertificate, webFXTreeConfig.TNcertificate, 
							"%value ../serverAliasName -urlencode%$TNDEPLOYERDATA$%value securityDataKey -urlencode%$TNDEPLOYERDATA$SecurityData$TNDEPLOYERDATA$%value securityDataParentKey -urlencode%$TNDEPLOYERDATA$%value securityDataParentName -urlencode%", "TNSecurityData_INCL");
						partnerTree.add(p);
					%endloop%

					if (subTree.childNodes.length > 0)
						serverTree.add(subTree);

				%endinvoke listTNTypes%
			%endscope%

			if (serverTree.childNodes.length> 0) 
				TNTree.add(serverTree);
			else {
				var serverTree = new WebFXTreeItem("%value serverAliasName% (Trading Networks not present)", null, null, 
				webFXTreeConfig.serverIcon, webFXTreeConfig.serverIcon);
				TNTree.add(serverTree);
			}

		%endif%
		%endif%
		%endloop servers%
	%endinvoke servers%

// Write out the tree for the next section
w(TNTree);
</script>
		</TD>
 		<TD valign="top"></td>
	</TR>

	<SCRIPT>swapRows();</SCRIPT>
	<!- Submit Button, placed at bottom for convenience ->
	<TR>
 		<TD valign="top"></td>
		<TD class="action">
			<INPUT onclick="return startProgressBar();" align="center" type="submit" 
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
			var partnerTree = getServerTree("%value securityDataParentKey%", partnerList, partnerTreeList);
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
