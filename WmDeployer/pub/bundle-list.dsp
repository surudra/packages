<HTML><HEAD>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META http-equiv="Expires" content="-1">
<LINK href="webMethods.css" type="text/css" rel="stylesheet">
<LINK href="xtree.css" type="text/css" rel="stylesheet">
<SCRIPT src="webMethods.js"></SCRIPT>
<SCRIPT src="xtree.js"></SCRIPT>
</HEAD>

<BODY>

<SCRIPT language=JavaScript>
function confirmDelete(bundle) {
  if (confirm("OK to delete Deployment Set " + bundle + "?\n\nThis action is not reversible.")) {
		startProgressBar("Deleting Deployment Set " + bundle);
		return true;
	}
	return false;
}

function confirmDeleteDeletionSet(bundle) {
  if (confirm("OK to delete Deployment Set " + bundle + "?\n\nThis action is not reversible.")) {
		startProgressBar("Deleting Deployment Set " + bundle);
		return true;
	}
	return false;
}

// Click the parent Frame's hidden field to start the Progress Bar
function updateDS() {
	if (confirm("[DEP.0002.0173] When modifying the deployment set, Deployer will remove any checkpoints created for the associated deployment candidates. You must recreate any checkpoints you want to use. \nDo you want to continue?")) {
		return true;
	}
	
	return false;
}

function exportDeleteBundles(deleteBundleFileExists)
{
	if(deleteBundleFileExists == "true")
	{
		if(confirm("Deletion set definitions file already exists for this project. Do you want to overwrite it?"))
		{
			return true;
		}
		else
		{
			return false;
		}
	}
	return true;
}

function showImportDeleteBundles()
{
	var importdeletebundlecontainer = document.getElementById("deleteBundleContainer");
	var deletebundleall = document.getElementById("deleteBundleAll");
	var deletebundlefew = document.getElementById("deleteBundleFew");
	deletebundleall.style.display="";
	deletebundlefew.style.display="none";
	importdeletebundlecontainer.style.display="";
}

function hideImportDeleteBundles()
{
	var importdeletebundlecontainer = document.getElementById("deleteBundleContainer");
	var deletebundleall = document.getElementById("deleteBundleAll");
	var deletebundlefew = document.getElementById("deleteBundleFew");
	deletebundleall.style.display="none";
	deletebundlefew.style.display="";
	importdeletebundlecontainer.style.display="none";
}

</SCRIPT>


<TABLE border="0" cellspacing="1" width="100%">
	<TR>
		<TD colspan="4" class="menusection-Deployer">%value projectName% &gt; Define 
		</TD>
	</TR>

  %ifvar projectType equals('Repository')%
  	   %include navigation-bar-repository.dsp%
  %else%
  	%include navigation-bar.dsp% 
	%endif%
</TABLE>

<TABLE width="100%">

<!- Add Bundle -> 
%ifvar action equals('add')%
	<!- bundleName, bundleDescription, projectName, bundleType ->
	%invoke wm.deployer.gui.UIProject:addBundleToProject%
		%include error-handler.dsp%

		%ifvar status equals('Success')%	
			<!- Auto bring up source servers panel for newly added Bundle ->
			%ifvar bundleType equals('IS')%
				%ifvar sourceOfTruth equals('Runtime')%
					<script>
						if(is_csrf_guard_enabled && needToInsertToken) {
			   			   parent.propertyFrame.document.location.href = "define-is-sources.dsp?projectName=%value -htmlcode projectName%&bundleName=%value -htmlcode bundleName%&" + _csrfTokenNm_ + "=" + _csrfTokenVal_;
						} else {
						   parent.propertyFrame.document.location.href = "define-is-sources.dsp?projectName=%value -htmlcode projectName%&bundleName=%value -htmlcode bundleName%";
						}					
					</script>
				%else%
					<script>
						if(is_csrf_guard_enabled && needToInsertToken) {
			   			   parent.propertyFrame.document.location.href = "define-repository-sources.dsp?projectName=%value -htmlcode projectName%&bundleName=%value -htmlcode bundleName%&" + _csrfTokenNm_ + "=" + _csrfTokenVal_;
						} else {
						   parent.propertyFrame.document.location.href = "define-repository-sources.dsp?projectName=%value -htmlcode projectName%&bundleName=%value -htmlcode bundleName%";
						}					
					</script>
				%end if%
			%else%
		  	%ifvar sourceOfTruth equals('Runtime')%
					<script>
						if(is_csrf_guard_enabled && needToInsertToken) {
			   			   parent.propertyFrame.document.location.href = "define-plugin-sources.dsp?projectName=%value -htmlcode projectName%&pluginType=%value -htmlcode bundleType%&bundleName=%value -htmlcode bundleName%&" + _csrfTokenNm_ + "=" + _csrfTokenVal_;
						} else {
						   parent.propertyFrame.document.location.href = "define-plugin-sources.dsp?projectName=%value -htmlcode projectName%&pluginType=%value -htmlcode bundleType%&bundleName=%value -htmlcode bundleName%";
						}					
					</script>
				%else%
				     %ifvar bundleMode equals('Deploy')%
				      <script>
						if(is_csrf_guard_enabled && needToInsertToken) {
			   			   parent.propertyFrame.document.location.href = "define-repository-sources.dsp?projectName=%value -htmlcode projectName%&pluginType=%value -htmlcode bundleType%&bundleName=%value -htmlcode bundleName%&" + _csrfTokenNm_ + "=" + _csrfTokenVal_;
						} else {
						   parent.propertyFrame.document.location.href = "define-repository-sources.dsp?projectName=%value -htmlcode projectName%&pluginType=%value -htmlcode bundleType%&bundleName=%value -htmlcode bundleName%";
						}					        
 			          </script>
				     %else%
				        <script>
						if(is_csrf_guard_enabled && needToInsertToken) {
			   			   parent.propertyFrame.document.location.href = "define-deletionset-plugin-sources.dsp?isRepositoryDeletionSet=true&projectName=%value -htmlcode projectName%&pluginType=%value -htmlcode bundleType%&bundleName=%value -htmlcode bundleName%&" + _csrfTokenNm_ + "=" + _csrfTokenVal_;
						} else {
						   parent.propertyFrame.document.location.href = "define-deletionset-plugin-sources.dsp?isRepositoryDeletionSet=true&projectName=%value -htmlcode projectName%&pluginType=%value -htmlcode bundleType%&bundleName=%value -htmlcode bundleName%";
						}					        
				       </script>
				     %endif%
				%end if%
			%endif%			
		%end if%

	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%end if%

<!- Delete Bundle -> 
%ifvar action equals('delete')%
	<!- projectName, bundleName -> 
	%invoke wm.deployer.gui.UIProject:removeBundleFromProject%
		%include error-handler.dsp%

		<!- property may be obsolete if bundle is deleted ->
		%ifvar status equals('Success')%
			<script>parent.propertyFrame.document.location.href = "blank.html";</script>
		%end if%
	%onerror%
		%loop -struct%
			<TR><TD>%value $key%=%value%</TD></TR>
		%endloop%
	%end invoke%
%end if%

<!- Update Security stuff -> 
%ifvar action equals('updateSecurity')%
	<!- Scheduled Tasks: projectName, bundleName and key-value pairs from tree ->
	%invoke wm.deployer.gui.UIBundle:updateBundleScheduledServiceList%
	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%

	<!- Ports: projectName, bundleName and key-value pairs from tree ->
	%invoke wm.deployer.gui.UIBundle:updateBundlePortList%
	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%

	<!- Users: projectName, bundleName and key-value pairs from tree ->
	%invoke wm.deployer.gui.UIBundle:updateBundleUserList%
	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%

	<!- Groups: projectName, bundleName and key-value pairs from tree ->
	%invoke wm.deployer.gui.UIBundle:updateBundleGroupList%
	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%

	<!- Extended Settings: projectName, bundleName and key-value pairs from tree ->
	%invoke wm.deployer.gui.UIBundle:updateBundleExtendedSettings%
	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%

	<!- ACLs: projectName, bundleName and key-value pairs from tree ->
	%invoke wm.deployer.gui.UIBundle:updateBundleAclList%

		%ifvar status equals('Success')%
			<script>writeMessage('Successfully updated Administration assets in Deployment Set %value bundleName%.');</script>
		%else%
			%include error-handler.dsp%
		%endif%
	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%end if%

<!- Update Packages Components -> 
%ifvar action equals('updateComponent')%
	<!- update: projectName*, bundleName*, serverAliasName*, packageName*, key:value pairs from tree ->
	%invoke wm.deployer.gui.UIBundle:updateBundleISComponentList%
		%include error-handler.dsp%
	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%end if%

<!- Update Packages Files -> 
%ifvar action equals('updateFile')%
	<!- update: projectName*, bundleName*, serverAliasName*, 
				packageName*, filter*, fileNamePattern*, fileList*, deleteFileList* ->
	%invoke wm.deployer.gui.UIBundle:updateBundleISFileList%
		%include error-handler.dsp%
	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%end if%

%ifvar action equals('updateTN')%
	<!- Packages: projectName, bundleName and tag-value pairs from tree ->
	%invoke wm.deployer.gui.TN:updateBundleTNTypesList%
		%include error-handler.dsp%
	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%end if%

<!- Update Plugin  -> 
%ifvar action equals('updatePlugin')%
	<!- Plugin: projectName, bundleName, pluginType, and tag-value pairs from tree ->
	%invoke wm.deployer.gui.UIPlugin:updateBundlePluginObjectList%
		%include error-handler.dsp%
	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%end if%

%ifvar action equals('exportDeleteBundles')%
	%invoke wm.deployer.gui.UIProject:exportDeleteBundles%
		%ifvar status equals('Success')%
			<script>writeMessage("Deletion set definitions file written to replicate\\outbound folder of WmDeployer Package on %sysvar host%.");</script>
			<script>window.open("projects/%value ../encodedProjName%/%value ../encodedProjName%_deleteSets.xml");</script>
		%else%
			%ifvar errorCode equals('100')%				
				<script>window.open("projects/%value ../encodedProjName%/%value ../encodedProjName%_deleteSets.xml");</script>
				%include error-handler.dsp%
			%else%
				%include error-handler.dsp%
			%endif%			
		%endif%
		%onerror%
			%loop -struct%
				<tr><td>%value $key%=%value%</td></tr>
			%endloop%
	%endinvoke%
%endif%

%ifvar action equals('importDeleteBundles')%
	%invoke wm.deployer.gui.UIProject:importDeleteBundles%
		%include error-handler.dsp%

		%onerror%
			%loop -struct%
				<tr><td>%value $key%=%value%</td></tr>
			%endloop%
	%endinvoke%
%endif%

<!-- UnLock -->
%ifvar action equals('unlock')%
	%invoke wm.deployer.UIAuthorization:unlockProject%
			%ifvar status equals('Success')%
	      <script>parent.propertyFrame.document.location.href = "blank.html";</script>
	    %end if%
	%end invoke%
%end if%

<!-- Lock -->
%ifvar action equals('lock')%
	%invoke wm.deployer.UIAuthorization:lockProject%
			%ifvar status equals('Success')%
	      <script>parent.propertyFrame.location.href = "blank.html"</script>
	    %end if%
	%end invoke%
%end if%

<!-- Add Asset to repository deletion set-->
%ifvar action equals('updateBundleDeletionSet')%		
		%invoke wm.deployer.gui.UIBundle:updateBundleDeletionSet%
		  %include error-handler.dsp%
		  %ifvar status equals('Success')%
		<script>
		    var checkpointExists = %value doesCheckpointExistForThisProject%;
		    if(checkpointExists) {
		        updateDS();
		    }
		</script>
		%endif%
  	     %onerror%
  		      %loop -struct%
  			     <tr><td>%value $key%=%value%</td></tr>
  		      %endloop%
		%end invoke%
%endif%

</TABLE>

%include navigation-links.dsp%

%invoke wm.deployer.UIAuthorization:checkLock%
%endinvoke%
%ifvar canUserLock equals('true')%		
  %ifvar isLockingEnabled equals('true')%
  	  %ifvar isLocked equals('true')%	
  	     %ifvar sameUser equals('true')%	  	  
    		    Click <A onclick="return startProgressBar('Refreshing Project Definition');" href="bundle-list.dsp?action=unlock&projectName=%value projectName%&projectType=%value projectType%">here</A> to unlock the project
    		%endif%
  	  %else%
  		    Click <A onclick="return startProgressBar('Refreshing Project Definition');" href="bundle-list.dsp?action=lock&projectName=%value projectName%&projectType=%value projectType%">here</A> to lock the project
  	  %endif%
  %endif%
%endif%


</script>

<TABLE width="100%">
	<TBODY>
    <TR>
      <TD colspan="2">
        <UL>
					%ifvar /defineAuthorized equals('true')%
          <LI><A target="propertyFrame" href="add-bundle.dsp?projectName=%value -htmlcode projectName%&projectType=%value -htmlcode projectType%">Create Set</A>
					%endif%
          <LI><A onclick="return startProgressBar('Refreshing Project Definition');" href="bundle-list.dsp?projectName=%value projectName%&projectType=%value projectType%">Refresh this Page</A>
          <LI><a target="propertyFrame" href="edit-project.dsp?projectName=%value -htmlcode projectName%&mode=project">Project Properties</a>
		
		%scope param(featureID='SPI_2')%
		%invoke wm.deployer.gui.UISettings:isFeatureEnabled%
		%endinvoke%
	  	%invoke wm.deployer.gui.UIProject:getProjectBundles%
	  	
	  	%ifvar projectType equals('Repository')%
      %else%
        %ifvar /defineAuthorized equals('true')%
  		  <LI><a onclick="return exportDeleteBundles('%value deletionBundleFileExists%');" href="bundle-list.dsp?projectName=%value -htmlcode projectName%&action=exportDeleteBundles&deletionBundleFileExists=%value -htmlcode deletionBundleFileExists%">Export Deletion Set Definitions</a>
            <form name="importDeleteBundles" method="POST" action="bundle-list.dsp">
  			<input type="hidden" name="action" value="importDeleteBundles">
  			<input type="hidden" name="projectName" value="%value projectName%">
  
  			<LI id="deleteBundleFew"><A onclick="startProgressBar();" href="javascript:showImportDeleteBundles(true)">Import Deletion Set Definitions</A></LI>
  			<LI style="display:none" id="deleteBundleAll"><A onclick="startProgressBar();" href="javascript:hideImportDeleteBundles(true)">Import Deletion Set Definitions</A></LI>
  	
  			<DIV id="deleteBundleContainer" name="deleteBundleContainer" style="display:none;padding-top=2mm;"><br>
  				%invoke wm.deployer.gui.UIProject:listImportDeleteBundles%
  					%ifvar importDeleteBundles -notempty%
  						<select name="fileName">
  						%loop importDeleteBundles%
  							<option value="%value fileName%">%value fileName%</option>
  						%endloop%
  						</select>
  					<input type="submit" value="Import">
  					%else%
  						<font color="red">* No Deletion Sets to import</font>
  					%endif%
  				%end invoke%
  		</DIV>
  	   </form>
        %endif%
		  %endif%
        </UL>
      </TD>
    </TR>

		<!- Begin Project Definition Table ->
		<TR>
    	<TD><img src="images/blank.gif" width="10" height="1"></TD>
      <TD>

	<!- projectName -> 

        <TABLE class="tableView" width="100%">
					<TBODY>
						<SCRIPT>resetRows();</SCRIPT>
            <TR>
              <TD class="heading" colspan="5">Deployment Sets</TD>
            </TR>

%comment%
		%ifvar bundles -notempty%
						<TR>
							<TD class="evencol-l" colspan="4"> 
								Click on a tree object to view or change its properties.
							</TD>
						</TR>
		%endif%
%endcomment%

            <TR>
              <TD class="oddcol">Name</TD>
              <TD class="oddcol">Description</TD>
              <TD class="oddcol">Unresolved<BR>Dependencies</TD>
              <TD class="oddcol">Delete</TD>
            </TR>

		%ifvar bundles -notempty%
						<SCRIPT>resetRows();</SCRIPT>
						<SCRIPT>swapRows();</SCRIPT>		
			%loop bundles%
						<SCRIPT>swapRows();</SCRIPT>		
            <TR>
						<!- The Project Tree, yeah baby! ->
							<script> writeTD("rowdata-l");</script>
							<SCRIPT>
							   %ifvar sourceOfTruth equals('FlatFile')%
							      %include bundle-repository-tree.dsp%
							   %else%
								%ifvar bundleType equals('IS')%
									%include bundle-is-tree.dsp%
								%else%									
									%include bundle-plugin-tree.dsp%																		
								%endif%
  							%endif%
							</SCRIPT>
							</TD>

              <SCRIPT>writeTD('row-l');</SCRIPT> 
									%value bundleDescription%</TD>

							<!- Unresolved Dependencies? ->
							<SCRIPT>writeTD("rowdata");</SCRIPT>                 
							%ifvar /reduceDependencyChecks equals('none')% 
								%ifvar hasUnresolvedDependencies equals('true')%
                					<IMG ID="img_%value bundleName -urlencode%" src="images/ns_unknown_node.gif" border="no" width="14" height="14">
                				%else%
                					<IMG ID="img_%value bundleName -urlencode%" src="images/green_check.gif" border="no" width="14" height="14">
								%endif%
							%else%
							  %ifvar /reduceDependencyChecks equals('true')% 
                <IMG ID="img_%value bundleName -urlencode%" src="images/ns_unknown_node.gif" border="no" width="14" height="14">
							  %else%
								  %ifvar hasUnresolvedDependencies equals('true')%
                <IMG ID="img_%value bundleName -urlencode%" src="images/dependency.gif" border="no" width="14" height="14">
								  %else%
                <IMG ID="img_%value bundleName -urlencode%" src="images/green_check.gif" border="no" width="14" height="14">
								  %endif%
							  %endif%
							%endif%
							%ifvar ../projectType equals('Repository')%
								<A onclick="return startProgressBar('Checking dependencies');" target="propertyFrame" href="dependency-composite.dsp?projectName=%value ../projectName%&bundleName=%value bundleName%&bundleType=%value bundleType%&projectType=%value ../projectType%">
              %else%
                <A onclick="return startProgressBar('Checking dependencies');" target="propertyFrame" href="dependency.dsp?projectName=%value ../projectName%&bundleName=%value bundleName%&bundleType=%value bundleType%&projectType=%value ../projectType%">              
              %endif%								
							%ifvar /defineAuthorized equals('true')%
								Check
							%else%
								View
							%endif%

							<SCRIPT>writeTD("rowdata");</SCRIPT> 
							%ifvar /defineAuthorized equals('true')%
								<A onclick="return confirmDelete('%value bundleName%');"
                	href="bundle-list.dsp?action=delete&projectName=%value ../projectName%&bundleName=%value bundleName%&projectType=%value ../projectType%">
                	<IMG alt="Delete this Deployment Set" src="images/delete.gif" border="no" width="16" height="16"></A></TD>
							%else%
                	<IMG src="images/delete_disabled.gif" border="no" width="16" height="16"></TD>
							%endif%
            </TR>

			%endloop bundles%
		%else%
						<TR>
							<TD colspan=4><FONT color="red"> * No Deployment Sets </FONT> </TD>
						</TR>
		%endif%
		
			<TR>
				<TD colspan="5">
					<BR><BR><BR>
				</TD>
			</TR>
			%ifvar isActive equals('true')%
				%include inc-deletion-set.dsp%
				%else%
					%ifvar ../projectType equals('Runtime')%
						%include inc-deletion-set.dsp%
					%endif%
    	    %endif%	    		
		</form>
	%endinvoke getProjectBundles%
	%endscope%
					</TBODY>
				</TABLE>
			</TD>
		</TR>
  </TBODY>
</TABLE>
<script> stopProgressBar(); </script> 
</BODY>
</HTML>
