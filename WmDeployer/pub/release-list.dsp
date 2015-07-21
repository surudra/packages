<HTML><HEAD>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META http-equiv="Expires" content="-1">
<LINK href="webMethods.css" type="text/css" rel="stylesheet">
<SCRIPT src="webMethods.js"></SCRIPT>

<BODY>

<SCRIPT language=JavaScript>
function confirmDelete(release)
{
	if (confirm("OK to delete Build " + release + "?\n\nThis action is not reversible.")) {
		startProgressBar("Deleting Build " + release);
		return true;
	}
	return false;
}

function confirmReload(release)
{
	if (confirm("This will overwrite the current contents of Build '" + release + "'.  Continue?")) {
		startProgressBar("Re-build in progress");
		return true;
	}
	return false;
}

function confirmExport(release)
{
	if (confirm("This will export Build '" + release + "' for import to another webMethods Deployer.  Continue?")) {
		startProgressBar("Build Export in progress");
		return true;
	}
	return false;
}

function confirmOverwrite(release)
{
	if (confirm("Build '" + release + "' already exists in the replicate/outbound directory. Do you want to overwrite the existing build?")) {
		startProgressBar("Build Overwrite in progress");
		return true;
	}
	return false;
}

</SCRIPT>

<TABLE width="100%">
	 <TR>
		 <TD class="menusection-Deployer" colspan="4"> %value projectName% &gt; Build 
		</TD>
	 </TR>

	%include navigation-bar.dsp%

</TABLE>

<TABLE width="100%">
<!- Add Build -> 
%ifvar action equals('add')%
	<!- buildName, projectName ->
	%invoke wm.deployer.UIExtractor:extractSource%
		%include error-handler.dsp%

		<!- Post newly created Build in Property frame ->
		<script>
			if(is_csrf_guard_enabled && needToInsertToken) {
   			   parent.propertyFrame.document.location.href = "build-status.dsp?projectName=%value -htmlcode projectName%&releaseName=%value -htmlcode buildName%&" + _csrfTokenNm_ + "=" + _csrfTokenVal_;
			} else {
			   parent.propertyFrame.document.location.href = "build-status.dsp?projectName=%value -htmlcode projectName%&releaseName=%value -htmlcode buildName%";
			}		
		</script>

	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%end if%

<!- Delete Build -> 
%ifvar action equals('delete')%
	<!- projectName, releaseName -> 
	%invoke wm.deployer.gui.UIRelease:deleteRelease%
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

<!- Reload Build -> 
%ifvar action equals('reload')%
	<!- buildName, projectName ->
	%invoke wm.deployer.UIExtractor:extractSource%
		%include error-handler.dsp%

		<!- Post newly created Build in Property frame ->
		<script>
			if(is_csrf_guard_enabled && needToInsertToken) {
   			   parent.propertyFrame.document.location.href = "build-status.dsp?projectName=%value -htmlcode projectName%&releaseName=%value -htmlcode buildName%&" + _csrfTokenNm_ + "=" + _csrfTokenVal_;
			} else {
			   parent.propertyFrame.document.location.href = "build-status.dsp?projectName=%value -htmlcode projectName%&releaseName=%value -htmlcode buildName%";
			}		
		</script>

	%onerror%
		<!- Post newly created Build in Property frame ->
		<script>
			if(is_csrf_guard_enabled && needToInsertToken) {
   			   parent.propertyFrame.document.location.href = "build-status.dsp?projectName=%value -htmlcode projectName%&releaseName=%value -htmlcode buildName%&" + _csrfTokenNm_ + "=" + _csrfTokenVal_;
			} else {
			   parent.propertyFrame.document.location.href = "build-status.dsp?projectName=%value -htmlcode projectName%&releaseName=%value -htmlcode buildName%";
			}		
		</script>
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%end if%

<!- Export Build -> 
%ifvar action equals('export')%
	<!- projectName, buildName ->
	%invoke wm.deployer.gui.UIReplicate:exportBuild%
		%ifvar status equals('Success')%
			<script>writeMessage("Build File written to replicate\\outbound folder of WmDeployer Package on %sysvar host%.");</script>
			<script>window.open("projects/%value ../encodedProjName%/builds/%value ../encodedProjName%_ExportedBuild_%value buildName%.zip");</script>
		%else%
			%ifvar errorCode equals('100')%				
				<script>window.open("projects/%value ../encodedProjName%/builds/%value ../encodedProjName%_ExportedBuild_%value buildName%.zip");</script>
				%include error-handler.dsp%
			%else%
				%include error-handler.dsp%
			%endif%
		%endif%

	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%end if%


<!-- Lock -->
%ifvar action equals('lock')%
	%invoke wm.deployer.UIAuthorization:lockProject%
		%ifvar status equals('Success')%	
      <script>parent.propertyFrame.document.location.href = "blank.html";</script>	
		%endif%
	%end invoke%
%end if%

<!-- UnLock -->
%ifvar action equals('unlock')%
	%invoke wm.deployer.UIAuthorization:unlockProject%
		%ifvar status equals('Success')%	
      <script>parent.propertyFrame.document.location.href = "blank.html";</script>	
		%endif%	
	%end invoke%
%end if%

<!-- ExportedBuildExists?? -->
%ifvar action equals('exportedBuildExists')%    
	%invoke wm.deployer.gui.UIReplicate:exportedBuildExists%
		%ifvar outboundFileExists equals('true')%	
 			<script>
 			   if (confirmOverwrite('%value exportedBuildName%')){
		 			if(is_csrf_guard_enabled && needToInsertToken) {
		   			   document.location.href="release-list.dsp?action=export&projectName=%value -htmlcode ../projectName%&buildName=%value -htmlcode buildName%&overwrite=true&" + _csrfTokenNm_ + "=" + _csrfTokenVal_;
					} else {
					   document.location.href="release-list.dsp?action=export&projectName=%value -htmlcode ../projectName%&buildName=%value -htmlcode buildName%&overwrite=true";
					}			   
				}else{
		 			if(is_csrf_guard_enabled && needToInsertToken) {
		   			   document.location.href="release-list.dsp?action=export&projectName=%value -htmlcode ../projectName%&buildName=%value -htmlcode buildName%&overwrite=false&" + _csrfTokenNm_ + "=" + _csrfTokenVal_;
					} else {
					   document.location.href="release-list.dsp?action=export&projectName=%value -htmlcode ../projectName%&buildName=%value -htmlcode buildName%&overwrite=false";
					}				
         		}
      		</script>
      	%else%
			<script>
		 		if(is_csrf_guard_enabled && needToInsertToken) {
		   		   document.location.href="release-list.dsp?action=export&projectName=%value -htmlcode ../projectName%&buildName=%value -htmlcode buildName%&overwrite=false&" + _csrfTokenNm_ + "=" + _csrfTokenVal_;
				} else {
				   document.location.href="release-list.dsp?action=export&projectName=%value -htmlcode ../projectName%&buildName=%value -htmlcode buildName%&overwrite=false";
				}			
			</script>	
    	%endif%	
	%endinvoke%     
%endif%

</TABLE>

	%include navigation-links.dsp%
	%invoke wm.deployer.UIAuthorization:checkLock%
  %endinvoke%
%ifvar canUserLock equals('true')%		
  %ifvar isLockingEnabled equals('true')%
  	  %ifvar isLocked equals('true')%	
  	     %ifvar sameUser equals('true')%	  	  
    		    Click <A onclick="return startProgressBar('Refreshing Project Definition');" href="release-list.dsp?action=unlock&projectName=%value projectName%">here</A> to unlock the project
        %endif%
  	  %else%
  		    Click <A onclick="return startProgressBar('Refreshing Project Definition');" href="release-list.dsp?action=lock&projectName=%value projectName%">here</A> to lock the project
  
  	  %endif%
  %endif%	
%endif%

<TABLE width="100%">
	<TBODY>
		<TR>
			<TD colspan="2">
				<UL>
			%ifvar /buildAuthorized equals('true')%
				%ifvar /canBeExtracted equals('true')%
					<LI><U><A target="propertyFrame" href="add-release.dsp?projectName=%value -htmlcode projectName%">Create Build</A></U>
				%else%
					<LI><U><A href="javascript:void();" 
						onclick="alert('This Project has no Deployment Sets.  Cannot create a Build.'); return false;">Create Build</A></U>
				%endif%
			%endif%
          <LI><A onclick="return startProgressBar();" href="release-list.dsp?projectName=%value projectName%">Refresh this Page</A>
          <LI><a target="propertyFrame" href="edit-project.dsp?projectName=%value -htmlcode projectName%&mode=project">Project Properties</a>
				</UL>
			</TD>
		</TR>
		<TR>
			<TD><IMG height="10" src="images/blank.gif" width="10"></TD>
			<TD>
				<TABLE class="tableView" width="100%">
					<TBODY>
						<TR>
							<TD class="heading" colspan="7">Builds</TD>
						</TR>
						<TR>
							<TD class="oddcol">Name</TD>
							<TD class="oddcol">Description</TD>
							<TD class="oddcol">Status</TD>
							<TD class="oddcol">Re-build</TD>
							<TD class="oddcol">Export</TD>
							<TD class="oddcol">Delete</TD>
							<TD class="oddcol">Progress Report</TD>
						</TR>

	%invoke wm.deployer.gui.UIRelease:listReleases%
	%ifvar releases -notempty%
	%loop releases%

						<TR>
							<!- Build Name ->
							<SCRIPT>writeTD('rowdata-l');</SCRIPT>
								<A target="propertyFrame" href="build-status.dsp?projectName=%value -htmlcode ../projectName%&releaseName=%value -htmlcode releaseName%">
									%value releaseName%</A></TD>

							<!- Build Created ->
							<SCRIPT>writeTD('rowdata');</SCRIPT> %value releaseDescription% </TD>

							<!- Build Status ->
							<SCRIPT>writeTD('rowdata');</SCRIPT>
								%ifvar releaseStatus equals('Error')%
									<IMG alt="Error creating this Build." title="Error creating this Build." src="images/dependency.gif" border="0" width="14" height="14"></TD>
								%else%
									%ifvar isProjectNewer equals('true')%
									<IMG alt="Project definition has changed since this Build" title="Project definition has changed since this Build" src="images/warning.gif" border="0" width="16" height="16"></TD>
									%else%
									<IMG alt="Ready for Deployment Candidate" title="Ready for Deployment Candidate" src="images/green_check.gif" border="0" width="13" height="13"></TD>
									%endif%
								%endif%

							<!- Re-Build ->
							<SCRIPT>writeTD('rowdata');</SCRIPT> 
							%ifvar /buildAuthorized equals('true')%
								<A class="imagelink" onclick="return confirmReload('%value releaseName%');"
									href="release-list.dsp?action=reload&projectName=%value -htmlcode ../projectName%&buildName=%value -htmlcode releaseName%&buildDescription=%value -htmlcode releaseDescription%">
									<IMG alt="Re-build (overwrite) this Build" title="Re-build (overwrite) this Build" src="images/rebuild.gif" border="no" width="16" height="16"></A></TD>
								%else%
									<IMG src="images/rebuild_disabled.gif" border="no" width="16" height="16"></TD>
								%endif%

							<!- Export ->
							<SCRIPT>writeTD('rowdata');</SCRIPT> 
							%ifvar /buildAuthorized equals('true')%
								<A class="imagelink" onclick="return confirmExport('%value releaseName%');"
									href="release-list.dsp?action=exportedBuildExists&projectName=%value -htmlcode ../projectName%&buildName=%value -htmlcode releaseName%">
									<IMG alt="Export this Build" src="images/btn_export.gif" border="no" width="20" height="20"></A></TD>
							%else%
									<IMG src="images/btn_export_disabled.gif" border="no" width="20" height="20"></TD>
							%endif%
							
							<!- Delete ->
							<SCRIPT>writeTD("rowdata");</SCRIPT> 
							%ifvar /buildAuthorized equals('true')%
								<A onclick="return confirmDelete('%value releaseName%');"
									href="release-list.dsp?action=delete&projectName=%value -htmlcode ../projectName%&releaseName=%value releaseName -urlencode%">
									<IMG alt="Delete this Build" src="images/delete.gif" border="no" width="16" height="16"></A></TD>
							%else%
									<IMG src="images/delete_disabled.gif" border="no" width="16" height="16"></TD>
							%endif%
							<SCRIPT>writeTD("rowdata");</SCRIPT> 
								<A target="_blank" class="imagelink" href="progress-report.dsp?type=build&projectName=%value -htmlcode ../projectName%&releaseName=%value releaseName -urlencode%">
								<IMG alt="View this Report in a separate browser." src="images/edit.gif" border="no"></A></TD>
							<SCRIPT>swapRows();</SCRIPT>
						</TR>
	%endloop releases%
	%else%
						<TR>
							<TD colspan=3><FONT color="red"> * No Builds </FONT> </TD>
						</TR>
	%endif%
	%endinvoke listReleases%


					</TBODY>
				</TABLE>
			</TD>
		</TR>
	</TBODY>
</TABLE>

<script> stopProgressBar(); </script> 

</BODY>
</HTML>
