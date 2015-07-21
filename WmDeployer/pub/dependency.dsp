<HTML><HEAD><TITLE>Bundle Dependencies</TITLE>
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META http-equiv=Pragma content=no-cache>
<META http-equiv=Expires content=-1>
<LINK href="webMethods.css" type="text/css" rel="stylesheet">
<LINK href="xtree.css" type="text/css" rel="stylesheet">
<SCRIPT src="webMethods.js"></SCRIPT>
<SCRIPT src="treetable.js"></SCRIPT>
<SCRIPT src="xtree.js"></SCRIPT>
</HEAD>

<BODY>
<TABLE width="100%">
  <TBODY>
  <TR>
    <TD class=menusection-Deployer>%value bundleName% > Unresolved Dependencies</TD>
  </TR>
  </TBODY>
</TABLE>

<!- Results from Submit ->
<TABLE>
%ifvar action equals('save')%
	<!- projectName, bundleName and tag-value pairs from treetable ->
	%invoke wm.deployer.gui.UIDependency:resolveBundleDependencies%
		%include error-handler.dsp%

		<!- refresh project tree in left frame ->
		%ifvar status equals('Success')%
		<script>
			startProgressBar("Displaying new Project definition");
			if(is_csrf_guard_enabled && needToInsertToken) {
   			   parent.treeFrame.document.location.href = "bundle-list.dsp?projectName=%value -htmlcode projectName%&" + _csrfTokenNm_ + "=" + _csrfTokenVal_;
			} else {
			   parent.treeFrame.document.location.href = "bundle-list.dsp?projectName=%value -htmlcode projectName%";
			}			
			var saveOK = true;
		</script>
		%else%
			<script>var saveOK = false;</script>
		%endif%

	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%endinvoke%
%endif%
</TABLE>

<TABLE cellSpacing=0 cellPadding=0 width="100%" >
  <TBODY>
  <TR>
    <TD colspan="2"> <ul> 
			<li> <A onclick="return startProgressBar('Refreshing Dependencies');" href="dependency.dsp?projectName=%value projectName%&bundleName=%value bundleName%&bundleType=%value bundleType%">Refresh this Page</A></li> 
			<li> <A href="resolved-dependency.dsp?projectName=%value -htmlcode projectName%&bundleName=%value -htmlcode bundleName%&bundleType=%value -htmlcode bundleType%">Resolved Dependencies</A></li> 
		</UL> </TD> 
  </TR>
  
  </TBODY>
</TABLE>

%invoke wm.deployer.gui.UIProject:getProjectInfo%

<! ------------------ Definition of the Main Table.  3 Columns ->

<TABLE class="tableForm" align="center" width="98%">
	<TBODY>

	<!- ../projectName, bundleName* ->
%rename ../projectName projectName -copy%
%invoke wm.deployer.gui.UIDependency:getUnresolvedBundleDependencies%

	%include error-handler.dsp%
	%ifvar dependencies -notempty%
  <TR>
    <TD class="heading" colspan="3" valign="top"> Unresolved Dependencies</TD>
  </TR>

%comment%
	<form id="form" name="form" method="POST" action="under-construction.dsp">
%endcomment%
	<form id="form" name="form" method="POST" action="dependency.dsp">
	<!- Submit Button, placed at top for convenience ->
		<INPUT type="hidden" name="projectName" value="%value projectName%">
		<INPUT type="hidden" name="bundleName" value="%value bundleName%">
		<INPUT type="hidden" name="bundleType" value="%value bundleType%">
		<INPUT type="hidden" name="action" value="save">

	%ifvar /defineAuthorized equals('true')%
	<TR>
		<TD class="action" colspan="3">
			<INPUT onclick="return startProgressBar('Updating Dependencies');" align="center" 
			type="submit" VALUE="Save" name="submit"> </TD>
	</TR>
	%endif%


  <TR>
    <TD class="oddcol-l" nowrap>Referenced Assets</TD>
    <TD class="oddcol" nowrap>Unset/Add/Exists/Ignore</TD>
    <TD class="oddcol" nowrap>Assets</TD>
  </TR>

	<!- ................ Begin Dependency (Package) Loop ................ ->
	<script> resetRows();</script>
	%loop dependencies%
		<script>swapRows();</script>

		<script>
		var sName = "%value serverAliasName -urlencode%%value referencedPackageName -urlencode%";

		// Initialize this current instance of package
		var packageName = sName;
		packages[packageName] = ["placeholder"];
		packages[packageName].length = 0;
		</script>

		<tr>

			<script>writeTD("row-l", "nowrap valign=\"top\"");</script>
			<img align=absmiddle border="0" src="images/blank.gif" width="0" height="15">
			<img align=absmiddle hspace=0 border="0" src="images/tree_minus.gif" 
				style="cursor: hand;" id="tree_%value serverAliasName -urlencode%%value referencedPackageName -urlencode%" 
				onclick="togglePackage('%value serverAliasName -urlencode%%value referencedPackageName -urlencode%');" width="9" height="9">


			<!- Type Handling for Referenced Assets ->
			%switch type%
			%case 'ACL'%
				<img align=absmiddle border="0" src="images/tree/xp/openfolder.png" 
					align="absmiddle"> %value serverAliasName%:ACLs </td>
			%case 'Group'%
				<img align=absmiddle border="0" src="images/tree/xp/openfolder.png" 
					align="absmiddle"> %value serverAliasName%:Groups </td>
			%case 'Port'%
				<img align=absmiddle border="0" src="images/tree/xp/openfolder.png" 
					align="absmiddle"> %value serverAliasName%:Ports </td>
			%case 'User'%
				<img align=absmiddle border="0" src="images/tree/xp/openfolder.png" 
					align="absmiddle"> %value serverAliasName%:Users </td>
			%case 'ScheduledService'%
				<img align=absmiddle border="0" src="images/tree/xp/openfolder.png" 
					align="absmiddle"> %value serverAliasName%:Scheduled Tasks </td>
			%case 'Package'%
				<img align=absmiddle border="0" src="images/ns_package.gif" 
					align="absmiddle"> %value serverAliasName%:%value referencedPackageName% </td>
			%case 'TNDocumentAttribute'%
				<img align=absmiddle border="0" src="images/tree/xp/openfolder.png" 
					align="absmiddle"> %value serverAliasName%:Document Attributes </td>
			%case 'TNDocumentType'%
				<img align=absmiddle border="0" src="images/tree/xp/openfolder.png" 
					align="absmiddle"> %value serverAliasName%:Document Types </td>
			%case 'TNProcessingRule'%
				<img align=absmiddle border="0" src="images/tree/xp/openfolder.png" 
					align="absmiddle"> %value serverAliasName%:Processing Rules </td>
			%case 'TNFieldDefinition'%
				<img align=absmiddle border="0" src="images/tree/xp/openfolder.png" 
					align="absmiddle"> %value serverAliasName%:Field Definitions</td>
			%case 'TNFieldGroup'%
				<img align=absmiddle border="0" src="images/tree/xp/openfolder.png" 
					align="absmiddle"> %value serverAliasName%:Field Groups</td>
			%case 'TNProfile'%
				<img align=absmiddle border="0" src="images/tree/xp/openfolder.png" 
					align="absmiddle"> %value serverAliasName%:Profiles</td>
			%case 'TNProfileGroup'%
				<img align=absmiddle border="0" src="images/tree/xp/openfolder.png" 
					align="absmiddle"> %value serverAliasName%:Profile Groups</td>
			%case 'TNIdType'%
				<img align=absmiddle border="0" src="images/tree/xp/openfolder.png" 
					align="absmiddle"> %value serverAliasName%:External ID Types</td>
			%case 'TNContactType'%
				<img align=absmiddle border="0" src="images/tree/xp/openfolder.png" 
					align="absmiddle"> %value serverAliasName%:Contact Types</td>
			%case 'TNBinaryType'%
				<img align=absmiddle border="0" src="images/tree/xp/openfolder.png" 
					align="absmiddle"> %value serverAliasName%:Binary Types</td>
			%case 'TNExtendedField'%
				<img align=absmiddle border="0" src="images/tree/xp/openfolder.png" 
					align="absmiddle"> %value serverAliasName%:Extended Fields</td>
			%case 'TNSecurityData'%
				<img align=absmiddle border="0" src="images/tree/xp/openfolder.png" 
					align="absmiddle"> %value serverAliasName%:Certificates</td>
			%case 'TNTPA'%
				<img align=absmiddle border="0" src="images/tree/xp/openfolder.png" 
					align="absmiddle"> %value serverAliasName%:Agreements</td>
			%case%
				<img align=absmiddle border="0" src="images/tree/xp/openfolder.png" 
					align="absmiddle"> %value serverAliasName%:%value typeLabel% </td>
			%end%


				<!- Package level Checkbox -- used only to set/unset child buttons ->
				<script>writeTD("rowdata", "nowrap valign=\"top\"")</script> 
					<INPUT type=radio 
						ID="%value serverAliasName -urlencode%%value referencedPackageName -urlencode%" 
						NAME="%value parentPluginName%$%value parentServerAliasName%$%value pluginType%$%value serverAliasName%$%value referencedPackageName%$$$" 
					%ifvar type equals('Package')% 
						onclick="setPkgChildren('UNSET', this);"
					%else% 
						onclick="setFolderChildren('UNSET', this);"
					%endif% 
						CHECKED
					%ifvar /defineAuthorized equals('false')% DISABLED %endif%>&nbsp;


					<INPUT type=radio 
						ID="%value serverAliasName -urlencode%%value referencedPackageName -urlencode%" 
						NAME="%value parentPluginName%$%value parentServerAliasName%$%value pluginType%$%value serverAliasName%$%value referencedPackageName%$$$" 
					%ifvar type equals('Package')% 
						VALUE="DEPENDENCY_PKG_ADD"
						onclick="setPkgChildren('ADD', this);"
					%else% 
						onclick="setFolderChildren('ADD', this);"
					%endif% 
					%ifvar /defineAuthorized equals('false')% DISABLED %endif%>&nbsp;

					<INPUT type=radio 
						ID="%value serverAliasName -urlencode%%value referencedPackageName -urlencode%" 
						NAME="%value parentPluginName%$%value parentServerAliasName%$%value pluginType%$%value serverAliasName%$%value referencedPackageName%$$$" 
					%ifvar type equals('Package')% 
						onclick="setPkgChildren('EXISTS', this);"
					%else% 
						onclick="setFolderChildren('EXISTS', this);"
					%endif% 
					%ifvar /defineAuthorized equals('false')% DISABLED %endif%>&nbsp;

					<INPUT type=radio 
						ID="%value serverAliasName -urlencode%%value referencedPackageName -urlencode%" 
						NAME="%value parentPluginName%$%value parentServerAliasName%$%value pluginType%$%value serverAliasName%$%value referencedPackageName%$$$" 
					%ifvar type equals('Package')% 
						onclick="setPkgChildren('IGNORE', this);"
					%else% 
						onclick="setFolderChildren('IGNORE', this);"
					%endif% 
					%ifvar /defineAuthorized equals('false')% DISABLED %endif%>&nbsp;
					</TD>

			<script>writeTD("rowdata", "nowrap valign=\"top\"");</script></td>
		</tr>

		<script>
		var numPackages = 0;
		</script>

		<!- ................ Begin Dependent Component Loop ................ ->

		%loop referencedComponents%

			<script>
			// Append the Component Name to the current Package array  - increments length implicitly
			var rName = "%value referencedComponentId -urlencode%";
			packages[packageName][packages[packageName].length] = rName;
			</script>

			<tr id="resource_%value ../serverAliasName -urlencode%%value ../referencedPackageName -urlencode%%value referencedComponentId -urlencode%">
				
				<!- Column 1 ->
				<script>writeTD("row-l", "nowrap valign=\"top\"");</script>
					<img align=absmiddle src="images/blank.gif" width="30" height="1">
					<script>
					%ifvar referencedComponentIcon%
						var icon = "%value referencedComponentIcon%";
					%else%
						var icon = getNSIcon("%value referencedComponentType%");
					%endif%
					w("<img align=absmiddle src='" + icon + "'>");
					</script>
					%value referencedComponentName%</td>

				<!- Column 2, Checkbox  The NAME:VALUE for this box must agree with Service pipeline ->
				<script>writeTD("rowdata", "nowrap valign=\"top\"")</script> 
					<INPUT type=radio 
						id="UNSET%value ../serverAliasName -urlencode%%value ../referencedPackageName -urlencode%%value referencedComponentId -urlencode%"
						name="%value ../parentPluginName%$%value ../parentServerAliasName%$%value ../pluginType%$%value ../serverAliasName%$%value ../referencedPackageName%$%value referencedComponentName -urlencode%$%value referencedComponentType%$%value referencedComponentId%$%value referencedComponentFolder%$%value referencedComponentParentId%$%value referencedComponentFullName -urlencode%" value="DEPENDENCY_UNSET" CHECKED
					%ifvar /defineAuthorized equals('false')% DISABLED %endif%>&nbsp;
					<INPUT type=radio 
						id="ADD%value ../serverAliasName -urlencode%%value ../referencedPackageName -urlencode%%value referencedComponentId -urlencode%"
						name="%value ../parentPluginName%$%value ../parentServerAliasName%$%value ../pluginType%$%value ../serverAliasName%$%value ../referencedPackageName%$%value referencedComponentName -urlencode%$%value referencedComponentType%$%value referencedComponentId%$%value referencedComponentFolder%$%value referencedComponentParentId%$%value referencedComponentFullName -urlencode%" value="DEPENDENCY_ADD"
					%ifvar /defineAuthorized equals('false')% DISABLED %else% %ifvar referencedComponentManualType equals('true')% DISABLED %else% %ifvar referencedComponentName matches('system/*')% DISABLED %endif% %else% %ifvar referencedComponentName matches('LDAP/*')% DISABLED %endif% %endif%>&nbsp;
					<INPUT type=radio 
						id="EXISTS%value ../serverAliasName -urlencode%%value ../referencedPackageName -urlencode%%value referencedComponentId -urlencode%"
						name="%value ../parentPluginName%$%value ../parentServerAliasName%$%value ../pluginType%$%value ../serverAliasName%$%value ../referencedPackageName%$%value referencedComponentName -urlencode%$%value referencedComponentType%$%value referencedComponentId%$%value referencedComponentFolder%$%value referencedComponentParentId%$%value referencedComponentFullName -urlencode%" value="DEPENDENCY_EXISTS"
					%ifvar /defineAuthorized equals('false')% DISABLED %endif%>&nbsp;
					<INPUT type=radio 
						id="IGNORE%value ../serverAliasName -urlencode%%value ../referencedPackageName -urlencode%%value referencedComponentId -urlencode%"
						name="%value ../parentPluginName%$%value ../parentServerAliasName%$%value ../pluginType%$%value ../serverAliasName%$%value ../referencedPackageName%$%value referencedComponentName -urlencode%$%value referencedComponentType%$%value referencedComponentId%$%value referencedComponentFolder%$%value referencedComponentParentId%$%value referencedComponentFullName -urlencode%" value="DEPENDENCY_IGNORE"
					%ifvar /defineAuthorized equals('false')% DISABLED %endif%>&nbsp;
					</TD>

				<!- Column 3: The Dependency Tree ->
				<script> writeTD("rowdata-l");</script>
				<SCRIPT>
					var tree = new WebFXTree("%value ../../bundleName%", null, null, 
						webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon);

					// bundled Packages
					%loop bundledPackages%
						%switch type%
						%case 'ACL'%
							var pkg = new WebFXTreeItem("%value serverAliasName%:ACLs");
						%case 'Group'%
							var pkg = new WebFXTreeItem("%value serverAliasName%:Groups");
						%case 'Port'%
							var pkg = new WebFXTreeItem("%value serverAliasName%:Ports");
						%case 'User'%
							var pkg = new WebFXTreeItem("%value serverAliasName%:Users");
						%case 'ScheduledService'%
							var pkg = new WebFXTreeItem("%value serverAliasName%:Scheduled Tasks");
						%case 'TNDocumentType'%
							var pkg = new WebFXTreeItem("%value serverAliasName%:Document Types");
						%case 'TNDocumentAttribute'%
							var pkg = new WebFXTreeItem("%value serverAliasName%:Document Attributes");
						%case 'TNProcessingRule'%
							var pkg = new WebFXTreeItem("%value serverAliasName%:Processing Rules");
						%case 'TNFieldDefinition'%
							var pkg = new WebFXTreeItem("%value serverAliasName%:Field Definitions");
						%case 'TNFieldGroup'%
							var pkg = new WebFXTreeItem("%value serverAliasName%:Field Groups");
						%case 'TNProfile'%
							var pkg = new WebFXTreeItem("%value serverAliasName%:Profiles");
						%case 'TNProfileGroup'%
							var pkg = new WebFXTreeItem("%value serverAliasName%:Profile Groups");
						%case 'TNIdType'%
							var pkg = new WebFXTreeItem("%value serverAliasName%:External ID Types");
						%case 'TNContactType'%
							var pkg = new WebFXTreeItem("%value serverAliasName%:Contact Types");
						%case 'TNBinaryType'%
							var pkg = new WebFXTreeItem("%value serverAliasName%:Binary Types");
						%case 'TNExtendedField'%
							var pkg = new WebFXTreeItem("%value serverAliasName%:Extended Fields");
						%case 'TNSecurityData'%
							var pkg = new WebFXTreeItem("%value serverAliasName%:Certificates");
						%case 'TNTPA'%
							var pkg = new WebFXTreeItem("%value serverAliasName%:Agreements");
						%case 'Package'%
							var pkg = new WebFXTreeItem("%value serverAliasName%:%value bundledPackageName%", 
								null, null, "images/ns_package.gif", "images/ns_package.gif");
						%case%
							var pkg = new WebFXTreeItem("%value serverAliasName%:%value typeLabel%");
						%end%

						tree.add(pkg);
						// Project (Bundled) Components
						%loop bundledComponents%
							var icon;
							%ifvar bundledComponentIcon%
								icon = "%value bundledComponentIcon%"; 
							%else%
								icon = getNSIcon("%value bundledComponentType%");
							%endif%
							var c = new WebFXTreeItem("%value bundledComponentName%", null, null, icon, icon);
							pkg.add(c);
						%endloop bundledComponents%
					%endloop bundledPackages%
					w(tree); 
				</SCRIPT></TD>

			</tr>

			<script>
			numPackages++;
			</script>

		%endloop referencedComponents%
		<!- **************** End Package Loop **************** ->

		<script>
		// Set the initial visual state of the Package tree
		if (numPackages==0) {
			// document.all["resource_"+packageName].style.display  = "none";
			document.all["tree_"+packageName].src = "images/blank.gif";
			document.all["tree_"+packageName].onclick = null;
			document.all["tree_"+packageName].style.cursor = "auto";
		}
		else if (getCookie(packageName) == UNKNOWN || getCookie(packageName) == COLLAPSE) {
			setCookie(packageName, COLLAPSE);
			for (package in packages[packageName]) {
				resourceName = packageName+packages[packageName][package];
				document.all["resource_"+resourceName].style.display  = "none";
			}
			document.all["tree_"+packageName].src = "images/tree_plus.gif";
		}
		</script>


	%endloop dependencies%
%endinvoke%
	<!- Submit Button, placed on bottom for convenience ->
	%ifvar /defineAuthorized equals('true')%
	<TR>
		<TD class="action" colspan="3">
			<INPUT onclick="return startProgressBar('Updating Dependencies');" align="center" 
			type="submit" VALUE="Save" name="submit2"> </TD>
	</TR>

	<script>
		// update Dependency Icon on left-frame to avoid expensive page refreshing
		parent.treeFrame.document.all["img_%value bundleName -urlencode%"].src = "images/dependency.gif";
	</script>

	%else%
	<TR><TD></TD><TD colspan="3"><FONT color="green"> Deployment Set has no unresolved dependencies.</FONT></TD></TR>
		<script>
			// update Dependency Icon on left-frame to avoid expensive page refreshing
			parent.treeFrame.document.all["img_%value bundleName -urlencode%"].src = "images/green_check.gif";
		</script>
	%endif%

	</FORM>
	</TBODY>
</TABLE>

%endinvoke%

<script> 
// Stop Progress bar after refresh unless a left-frame refresh is underway
%ifvar action equals('save')%
	if (saveOK == false) 
		stopProgressBar();
%else%
	stopProgressBar();
%end if%
</script> 

</BODY></HTML>
