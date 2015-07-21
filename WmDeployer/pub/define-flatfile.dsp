<HTML><HEAD><TITLE>Define Developer</TITLE>
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

<SCRIPT language=JavaScript>

// Click the parent Frame's hidden field to start the Progress Bar
function updateDS() {
	startProgressBar("Saving selected Packages");
	return true;
}

function test() {
  alert(" Test");
}

</script>
<TABLE width="100%">
  <TBODY>
  <TR>
    <TD class=menusection-Deployer>%value bundleName% > Packages</TD>
  </TR>
  </TBODY>
</TABLE>

<TABLE width="100%">
<!- Update Developer (packages) -> 
%ifvar action equals('updateDeveloper')%
	<!- Packages: projectName, bundleName and tag-value pairs from tree ->
	%invoke wm.deployer.gui.UIBundle:updateBundlePackageList%
		%include error-handler.dsp%

		%ifvar status equals('Success')%
		<script>
			// refresh Project left-frame 
			startProgressBar("Displaying new Project definition");
			if(is_csrf_guard_enabled && needToInsertToken) {
   			   parent.treeFrame.document.location.href = "bundle-list.dsp?projectName=%value -htmlcode projectName%&" + _csrfTokenNm_ + "=" + _csrfTokenVal_;
			} else {
			   parent.treeFrame.document.location.href = "bundle-list.dsp?projectName=%value -htmlcode projectName%";
			}
		</script>
		%else%
		<script>
			// stop the progress bar that was started during the submit
			stopProgressBar(); 
		</script>

		%endif%
	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%end if%
</TABLE>

<TABLE width="100%">
  <TR>
    <TD colspan="2">
      <UL>
				<LI> <A onclick="return startProgressBar('Refreshing Package list');" href="define-flatfile.dsp?projectName=%value projectName%&bundleName=%value bundleName%&regExp=%value regExp%&regExp2=%value regExp2%">Refresh this Page</A></LI> 
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
	<FORM id="form" name="form" method="POST" action="define-flatfile.dsp">

	<!- Submit Button, placed at top for convenience ->
	<TR>
 		<TD valign="top"></td>
		<TD class="action">
			<INPUT onclick="return updateDS();" align="center" type="submit" 
				VALUE="Save" name="submit"> </TD>
 		<TD valign="top"></td>
		<INPUT type="hidden" name="projectName" value='%value projectName%'>
		<INPUT type="hidden" name="bundleName" value='%value bundleName%'>
		<INPUT type="hidden" name="regExp" value='%value regExp%'>
		<INPUT type="hidden" name="regExp2" value='%value regExp2%'>
		<INPUT type="hidden" name="action" value="updateDeveloper">
	</TR>
	<SCRIPT>swapRows();</SCRIPT>		
	<TR>
 		<TD valign="top"></td>
		%ifvar bundleMode equals('Deploy')%
		<script>writeTDspan("col-l","1");</script>Click on a Package Name to select individual Package components or files to add to the Deployment Set.
		%else%
		<script>writeTDspan("col-l","1");</script>Click on a Package Name to select individual Package components to add to the Deletion Set.
		%endif%
 		<TD valign="top"></td>
	</TR>

	<SCRIPT>swapRows();</SCRIPT>		
	<TR>
 		<TD valign="top"></td>
		<script> writeTD("rowdata-l", "width='100%'");</script>

<script>

	// Enumerate over entire list of configured sources
	%invoke wm.deployer.gui.UIBundle:getBundleSourceServers%

		%ifvar servers -notempty%
			var devTree = new WebFXTree("Packages");

			var filterCnt = 0;
			var matchCnt = 0;
			%loop servers%
				%rename serverAliasName serverAlias -copy%
				// Ping this Integration server before investing too much in it
				%rename serverAlias aliasName -copy%	

					var serverTree = new WebFXTreeItem("%value serverAliasName%", null, false, null, 
						webFXTreeConfig.serverIcon, webFXTreeConfig.serverIcon);

					// Retrieve Packages from Server
					// serverAlias	
					%ifvar ../sourceOfTruth equals('FlatFile')%					
  					%invoke wm.deployer.gui.UIFlatFile:getAssetsFromFlatFile%
						%loop packagesList%							
						var pkgNode = new WebFXCheckBoxTreeItem("%value packageName%", "define-component-flatfile.dsp?projectName=%value ../../../../projectName%&bundleName=%value ../../../../bundleName%&serverAliasName=%value ../serverAlias%&packageName=%value packageName%&regExp=%value /regExp%&regExp2=%value /regExp2%&bundleMode=%value ../../../../bundleMode%", 
											false, null, webFXTreeConfig.ISPackage, webFXTreeConfig.ISPackage,
											"%value ../serverAlias -urlencode%$%value packageName%$PACKAGE_INCL", "PACKAGE_INCL", webFXTreeConfig.linkClass);	 
					    
						    %loop componentName%
							var fldNode = new WebFXCheckBoxTreeItem("%value folderName%", null, 
											false, null, webFXTreeConfig.ISFolder, webFXTreeConfig.ISFolder,
											"%value fullFolderName%$Folder", "Folder", null);	 
											 %loop servicesName%
												 var srvNode = new WebFXCheckBoxTreeItem("%value serviceName% - Ver1.2", null, 
												false, null, webFXTreeConfig.ISFolder, webFXTreeConfig.ISFolder,
												"%value folderName%:%value serviceName%$FlowService", "COMPONENT_INCL", null);
												fldNode.add(srvNode);
											 %endloop servicesName%
											pkgNode.add(fldNode);
						    %endloop componentName%
						    serverTree.add(pkgNode); 
						
						    matchCnt++;  
						%endloop packagesList%        
           %endinvoke%
				 %endif%

				devTree.add(serverTree);
			%endloop servers%
		%else%
			var devTree = new WebFXTree("Packages (no Source Servers configured)");
		%endif%
%endinvoke wm.deployer.gui.UIBundle:getBundleSourceServers%

// Render the tree 
w(devTree);
</script>

	
	<script> w(pkgTree1); </script>
	
		</TD>
 		<TD valign="top"></td>
	</TR>

<!- If the regular expression is in force, let the user know>
	<TR>
		<TD valign="top"></td>
		<script>
		writeTDspan("col-l","1");
%ifvar regExp -notempty%
		w("Regular expression '%value regExp%' matched " + matchCnt + 
				" and filtered " + filterCnt + " Packages.");
%else%
		w(matchCnt + " Packages displayed.");
%endif%
		</script>
		<TD valign="top"></td>
	</TR>

	<!- Submit Button, placed at bottom for convenience ->
	<TR>
 		<TD valign="top"></td>
		<TD class="action">
			<INPUT onclick="return updateDS();" align="center" type="submit" 
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
				var parentID = p.parentNode.id;
				var anchor = document.getElementById(parentID + '-anchor');
				var icon = document.getElementById(parentID + '-icon');

				// Check this item, and trigger cascade behavior
				webFXTreeHandler.all[parentID].setChecked(true);

				// For complete packages, set to default node behavior
				%ifvar componentsOrFiles equals('false')%
						anchor.href = webFXTreeConfig.defaultAction;
						anchor.onclick = 'return true;';
						p.parentNode.className = webFXTreeConfig.defaultClass;
				%else%
					// For partials, disable the checkbox and update the icon
					p.disabled = true;
					icon.src = "images/ns_partial_package.gif";

					// finally, change href based on components or types
					%ifvar containsFiles equals('true')%
						anchor.href = "define-files.dsp?projectName=%value -htmlcode /projectName%&bundleName=%value -htmlcode /bundleName%&serverAliasName=%value ../serverAliasName -urlencode%&packageName=%value -htmlcode packageName%&bundleMode=%value -htmlcode ../../bundleMode%";
					%else%
						anchor.href = "define-component.dsp?projectName=%value -htmlcode /projectName%&bundleName=%value -htmlcode /bundleName%&serverAliasName=%value ../serverAliasName -urlencode%&packageName=%value -htmlcode packageName%&bundleMode=%value -htmlcode ../../bundleMode%";
					%endif%
				%endif%
			}
		%endloop%
	%endloop servers%
%endinvoke%

%ifvar action equals('updateDeveloper')%
%else%
	stopProgressBar();
%endif%

</script>

</BODY></HTML>
