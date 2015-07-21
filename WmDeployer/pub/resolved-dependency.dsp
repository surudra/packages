<HTML><HEAD><TITLE>Resolved Bundle Dependencies</TITLE>
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

<SCRIPT language=JavaScript>
function onAdd() {

	var pkg = trim(document.addDepForm.referencedPackageName.value);
	var cmp = trim(document.addDepForm.referencedComponentName.value);

	if (pkg == null || pkg == "") {
		alert("Please specify the Referenced Package Name.");
		return false;
	}

	if (cmp == null || cmp == "") {
		alert("Please specify the Referenced Component Name.");
		return false;
	}

	return true;
}
</SCRIPT>

<TABLE width="100%">
  <TR>
    <TD class=menusection-Deployer>%value bundleName% > Resolved Dependencies</TD>
  </TR>
</TABLE>

<!- Results from Submit ->
<TABLE width="100%">
%ifvar action equals('delete')%
	<!- projectName, bundleName, key:value pairs ->
	%invoke wm.deployer.gui.UIDependency:removeDependenciesFromBundle%
		%include error-handler.dsp%

		%ifvar status equals('Success')%
		<script>
			// update Dependency Icon on left-frame to avoid expensive page refreshing
			parent.treeFrame.document.all["img_%value bundleName -urlencode%"].src = "images/dependency.gif";
			// parent.treeFrame.document.location.href = "bundle-list.dsp?projectName=%value projectName%";
		</script>
		%end if%
	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%end if%

%ifvar action equals('add')%
	<!- projectName, bundleName, referencedPackageName, referencedComponentName ->
	%invoke wm.deployer.gui.UIDependency:addManualDependencyToBundle%
			%include error-handler.dsp%
	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%end if%
</TABLE>

%invoke wm.deployer.gui.UIProject:getProjectInfo%

<TABLE width="100%">
  <TR>
    <TD colspan="2"> 
			<UL> 
				<LI> <A href="resolved-dependency.dsp?projectName=%value -htmlcode projectName%&bundleName=%value -htmlcode bundleName%&bundleType=%value -htmlcode bundleType%">Refresh this Page</A></li> 
				<LI> <A onclick="return startProgressBar('Checking Dependencies'); "href="dependency.dsp?projectName=%value projectName%&bundleName=%value bundleName%&bundleType=%value bundleType%">Unresolved Dependencies</A></LI> 
			</UL> 
		</TD> 
  </TR>
  
<!- Definition of the Main Table.  3 Columns ->

	<TR>
		<TD><IMG height="0" src="images/blank.gif" width="5" border="0"></TD>
		<TD>
			<TABLE class="tableForm" width="100%">

<!- ../projectName, bundleName* ->
%rename ../projectName projectName -copy%
%invoke wm.deployer.gui.UIDependency:getResolvedBundleDependencies%

	%ifvar dependencies -notempty%
  			<TR>
    			<TD class="heading" colspan="3" valign="top"> Resolved Dependencies</TD>
  			</TR>

%comment%
				<FORM name="delDepForm" action=under-construction.dsp method=post>
%endcomment%
				<FORM name="delDepForm" action=resolved-dependency.dsp method=post>
					<INPUT type="hidden" VALUE="delete" name="action">
					<INPUT type="hidden" VALUE="%value projectName%" name="projectName">
					<INPUT type="hidden" VALUE="%value bundleName%" name="bundleName">
					<INPUT type="hidden" VALUE="%value bundleType%" name="bundleType">

	%ifvar /defineAuthorized equals('true')%
				<TR>
					<TD class="action" colspan="3">
						<INPUT align="center" type="submit" VALUE="Delete" name="submit"> </TD>
				</TR>
	%endif%

  			<TR>
    			<TD class="oddcol-l" nowrap>Referenced Assets</TD>
    			<TD class="oddcol" nowrap>Delete</TD>
    			<TD class="oddcol" nowrap>Resolution</TD>
  			</TR>

	<script>
	var bundleName = "%value bundleName -urlencode%";
	</script>

	<script> resetRows();</script>
	%loop dependencies%

		<script>
		// Add the Package Name to the current Bundle array  - increments length implicitly
		var sName = "%value serverAliasName -urlencode%%value referencedPackageName -urlencode%";

		// Initialize this current instance of package
		var packageName = sName;
		packages[packageName] = ["placeholder"];
		packages[packageName].length = 0;
		</script>

				<TR>

					<script>writeTD("row-l", "nowrap valign=\"top\"");</script>
					<img align=absmiddle border="0" src="images/blank.gif" width="0" height="15">
					<img align=absmiddle hspace=0 border="0" src="images/tree_minus.gif" 
						style="cursor: hand;" id="tree_%value serverAliasName -urlencode%%value referencedPackageName -urlencode%" 
						onclick="togglePackage('%value serverAliasName -urlencode%%value referencedPackageName -urlencode%');" width="9" height="9">

		<!- Special types here for non-Packages ->
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

					<script>writeTD("rowdata", "nowrap valign=\"top\"");</script></td>
					<!- Checkbox for Package, hide this for now ->
					<script>writeTD("rowdata", "nowrap valign=\"top\"")</script> <center> 
						<INPUT type="hidden" id="check_%value serverAliasName -urlencode%%value referencedPackageName -urlencode%"> 
						</center></TD>
				</TR>

		<script>
		var numPackages = 0;
		</script>

		<!- ................ Begin Dependent Component Loop ................ ->

		%loop referencedComponents%
		<script>swapRows();</script>

			<script>
			// Append the Component Name to the current Package array  - increments length implicitly
			var rName = "%value referencedComponentName -urlencode%";
			packages[packageName][packages[packageName].length] = rName;
			</script>

				<TR id="resource_%value ../serverAliasName -urlencode%%value ../referencedPackageName -urlencode%%value referencedComponentName -urlencode%">

				<!- Column 1 ->
				<script>writeTD("row-l", "nowrap valign=\"top\"");</script>
					<img align=absmiddle src="images/blank.gif" width="30" height="1">
					<script>
					%ifvar referencedComponentIcon%
						var icon = "%value referencedComponentIcon%";
					%else%
						var icon = getNSIcon("%value referencedComponentType%");
					%endif%
					w("<img height='16' width='16' align=absmiddle src='" + icon + "'>");
					</script>
					%value referencedComponentName%</td>

				<!- Column 2, Delete Checkbox  ->
				<script>writeTD("rowdata", "nowrap valign=\"top\"")</script> 
						<input type="checkbox" 
							%ifvar /defineAuthorized equals('true')%
							%else%
							disabled
							%endif%
							name="%value ../serverAliasName%$%value ../referencedPackageName%$%value referencedComponentName%$%value referencedComponentType%$%value referencedComponentId%" 
							value="DEPENDENCY_REMOVE"></TD>

				<!- Column 3: The Dependency Tree ->
				<script> writeTD("row-l");</script>
				<script> 	
					if ("%value status%" == "DEPENDENCY_EXISTS")
						w("Warn if does not exist on target");
					else if ("%value status%" == "DEPENDENCY_IGNORE")
						w("Ignored during deployment");
				</script> 	
				</TD>
				</TR>

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

		<script>swapRows();</script>

	<!- **************** End Package Loop **************** ->
	%endloop dependencies%

	%ifvar /defineAuthorized equals('true')%
				<TR>
					<TD class="action" colspan="3">
					<INPUT align="center" type="submit" VALUE="Delete" name="submit2"> </TD>
				</TR>
	%endif%

				</FORM>
	%else%
				<TR><TD colspan="3"><FONT color="green"> Deployment Set has no resolved dependencies.</FONT></TD></TR>
	%endif%
			</TABLE>
		</TD>
	</TR>
%endinvoke getResolvedBundleDependencies%


	<TR>
		<TD><IMG height="8" src="images/blank.gif" width="0" border="0"></TD>
	</TR>

	%ifvar /defineAuthorized equals('true')%
  	%ifvar bundleType equals('IS')%

	<FORM name="addDepForm" action=resolved-dependency.dsp method=post>
	<INPUT type="hidden" VALUE="add" name="action">
	<INPUT type="hidden" VALUE="%value projectName%" name="projectName">
	<INPUT type="hidden" VALUE="%value bundleName%" name="bundleName">

	<TR>
		<TD><IMG height="0" src="images/blank.gif" width="5" border="0"></TD>
		<TD>
			<SCRIPT>resetRows();</SCRIPT>
			<TABLE class="tableView" id="warnings" width="100%">
				<TR>
					<TD class="heading" colspan="2">Manually Add Dependency</TD>
				</TR>

				<TR>
					<TD nowrap class="oddrow">Referenced Package</TD>
					<TD class="oddrow-l"><INPUT name="referencedPackageName" size="32"></TD>
				</TR>

				<TR>
					<TD nowrap class="oddrow">Referenced Component</TD>
					<TD class="oddrow-l"><INPUT name="referencedComponentName" size="32"></TD>
				</TR>

				<TR>
					<TD class="action" colspan="2">
					<INPUT onclick="return onAdd();" align="center" type="submit" VALUE="Add" name="submit"> </TD>
				</TR>

			</TABLE>
		</TD>
	</TR>
	</FORM>
  	%endif%
	%endif%
</TABLE>
%endinvoke getProjectInfo%

</BODY></HTML>
