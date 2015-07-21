<HTML><HEAD>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META http-equiv="Expires" content="-1">
<SCRIPT src="webMethods.js"></SCRIPT>
<LINK href="webMethods.css" type="text/css" rel="stylesheet">
<BODY>

<SCRIPT language=JavaScript>
function onSimulate(dc)
{
	if (confirm("This will run a Simuation for Deployment Candidate '" + dc + "'.  Continue?")) {
		startProgressBar("Simulating Deployment for " + dc);
		return true;
	}
	return false;
}

function onCheckpoint(dc)
{
	if (confirm("This will create a Checkpoint for Deployment Candidate '" + dc + "'.  Continue?")) {
		startProgressBar("Creating Checkpoint for " + dc);
		return true;
	}
	return false;
}

function onDeploy(canBeRolledBack, dc)
{
    var isProjectOfTypeRepo = document.getElementById("isProjectOfTypeRepo").value;
    if(isProjectOfTypeRepo == 'true') {
        var isTransactionalDeploymentEnabledForRepo = document.getElementById("isTransactionalDeploymentEnabledForRepo").value;
        if(isTransactionalDeploymentEnabledForRepo == 'false') {
            var msg = "This will deploy Deployment Candidate '" + dc + "'.";
            if(canBeRolledBack == "false")
            {
              msg = msg + "No checkpoint available, so the changes will not be reversible.";
            }
            msg = msg + "  Continue?";

            if (confirm(msg)) {
              startProgressBar("Deploying " + dc);
              return true;
            }
            return false;
        }
    } else {
        var msg = "This will deploy Deployment Candidate '" + dc + "'.";
        if(canBeRolledBack == "false")
        {
            msg = msg + "No checkpoint available, so the changes will not be reversible.";
        }
        msg = msg + "  Continue?";

        if (confirm(msg)) {
            startProgressBar("Deploying " + dc);
            return true;
        }
        return false;
	}
}


function onRollback(dc)
{
	if (confirm("This will rollback Deployment '" + dc + "' on target servers.  Continue?")) {
		startProgressBar("Rollback to last Checkpoint for " + dc);
		return true;
	}
	return false;
}

function confirmDelete (proj) {

	if (confirm("Delete Deployment Candidate " + proj + "?\nThis action cannot be reversed.")) {
		startProgressBar("Deleting Deployment Candidate " + proj);
		return true;
	}
	return false;
}

</SCRIPT>

<TABLE width="100%">
	<TR>
		<TD class="menusection-Deployer" colspan="4"> %value projectName% &gt; Deploy
		</TD>
	</TR>

  %ifvar projectType equals('Repository')%
  	   %include navigation-bar-repository.dsp%
  %else%
	%include navigation-bar.dsp%
	%endif%
	
</TABLE>

<TABLE width="100%">
%ifvar action equals('add')%
	<!- projectName, deploymentName, deploymentDescription, mapSetName, buildName  ->
	%invoke wm.deployer.gui.UIDeployment:addDeploymentToProject%

		%ifvar status equals('Success')%
			<script>writeMessage('Successfully created Deployment Candidate %value deploymentName%.');</script>
			<!- Auto bring up properties panel for newly added Deployment ->
			<script>
				startProgressBar("Opening Deployment Candidate %value deploymentName%");
				if(is_csrf_guard_enabled && needToInsertToken) {
	   			   parent.propertyFrame.document.location.href = "edit-deployment.dsp?projectName=%value -htmlcode projectName%&deploymentName=%value -htmlcode deploymentName%&projectType=%value -htmlcode projectType%&" + _csrfTokenNm_ + "=" + _csrfTokenVal_;
				} else {
				   parent.propertyFrame.document.location.href = "edit-deployment.dsp?projectName=%value -htmlcode projectName%&deploymentName=%value -htmlcode deploymentName%&projectType=%value -htmlcode projectType%";
				}
			</script>
		%else%
			%include error-handler.dsp%
		%end if%

	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%end if%

%ifvar action equals('simulate')%
	<!- project, deploymentName*, preDeployString  ->
	%rename projectName project -copy%
	%invoke wm.deployer.UIDeployer:deployToTargets%
		%include error-handler.dsp%

		<!- Refresh properties following simulation ->
		<script>
			if(is_csrf_guard_enabled && needToInsertToken) {
	   		   parent.propertyFrame.document.location.href = "edit-deployment.dsp?projectName=%value -htmlcode projectName%&deploymentName=%value -htmlcode deploymentName%&" + _csrfTokenNm_ + "=" + _csrfTokenVal_;
			} else {
			   parent.propertyFrame.document.location.href = "edit-deployment.dsp?projectName=%value -htmlcode projectName%&deploymentName=%value -htmlcode deploymentName%";
			}
		</script>

	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%end if%

%ifvar action equals('checkpoint')%
	<!- projectName, deploymentName ->
	%invoke wm.deployer.gui.UICheckpoint:createCheckpoint%
		%include error-handler.dsp%

		<!- Refresh properties following simulation ->
		<script>
			if(is_csrf_guard_enabled && needToInsertToken) {
	   		   parent.propertyFrame.document.location.href = "edit-deployment.dsp?projectName=%value -htmlcode projectName%&deploymentName=%value -htmlcode deploymentName%&" + _csrfTokenNm_ + "=" + _csrfTokenVal_;
			} else {
			   parent.propertyFrame.document.location.href = "edit-deployment.dsp?projectName=%value -htmlcode projectName%&deploymentName=%value -htmlcode deploymentName%";
			}
		</script>

	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%end if%

%ifvar action equals('deploy')%
	<!- project, deploymentName*, preDeployString  ->
	%rename projectName project -copy%
	%invoke wm.deployer.UIDeployer:deployToTargets%
		%include error-handler.dsp%

		<!- Refresh properties following deployment ->
		<script>
			if(is_csrf_guard_enabled && needToInsertToken) {
	   		   parent.propertyFrame.document.location.href = "edit-deployment.dsp?projectName=%value -htmlcode projectName%&deploymentName=%value -htmlcode deploymentName%&" + _csrfTokenNm_ + "=" + _csrfTokenVal_;
			} else {
			   parent.propertyFrame.document.location.href = "edit-deployment.dsp?projectName=%value projectName -urlencode%&deploymentName=%value -htmlcode deploymentName%";
			}
		</script>

	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%end if%

%ifvar action equals('rollback')%
	<!- projectName, deploymentName ->
	%invoke wm.deployer.gui.UICheckpoint:rollbackToCheckpoint%
		%include error-handler.dsp%

		<!- Refresh properties following rollback ->
		<script>
			if(is_csrf_guard_enabled && needToInsertToken) {
	   		   parent.propertyFrame.document.location.href = "edit-deployment.dsp?projectName=%value -htmlcode projectName%&deploymentName=%value -htmlcode deploymentName%&" + _csrfTokenNm_ + "=" + _csrfTokenVal_;
			} else {
			   parent.propertyFrame.document.location.href = "edit-deployment.dsp?projectName=%value -htmlcode projectName%&deploymentName=%value -htmlcode deploymentName%";
			}
		</script>

	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%end if%

%ifvar action equals('delete')%
	<!- projectName*, deploymentName*  ->
	%invoke wm.deployer.gui.UIDeployment:removeDeploymentFromProject%
		%ifvar status equals('Success')%
			<script>writeMessage('Successfully deleted Deployment Candidate %value deploymentName%.');</script>
			<script>parent.propertyFrame.document.location.href = "blank.html";</script>
		%else%
			%include error-handler.dsp%
		%end if%

	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%end if%

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

	%invoke wm.deployer.gui.UIDeployment:listProjectDeployments%
		%ifvar status equals('Error')%
			<script>writeMessage('%value -htmlcode message%');</script>
		%endif%
		<input type="hidden" name="isTransactionalDeploymentEnabledForRepo" id="isTransactionalDeploymentEnabledForRepo" value="%value isTransactionalDeploymentEnabledForRepo%"/>
        <input type="hidden" name="isProjectOfTypeRepo" id="isProjectOfTypeRepo" value="%value isProjectOfTypeRepo%"/>
	<!-- %endinvoke% -->

</TABLE>

	%include navigation-links.dsp%
	%invoke wm.deployer.UIAuthorization:checkLock%
%endinvoke%
%ifvar canUserLock equals('true')%	
  %ifvar isLockingEnabled equals('true')%
  	  %ifvar isLocked equals('true')%	
  	    	%ifvar sameUser equals('true')%	
    		    Click <A onclick="return startProgressBar('Refreshing Project Definition');" href="deploy-list.dsp?action=unlock&projectName=%value projectName%&projectType=%value projectType%">here</A> to unlock the project
          %endif%
  	  %else%
  		    Click <A onclick="return startProgressBar('Refreshing Project Definition');" href="deploy-list.dsp?action=lock&projectName=%value projectName%&projectType=%value projectType%">here</A> to lock the project
  
  	  %endif%
  %endif%
%endif%
	%scope param(featureID='SPI_2')%
	%invoke wm.deployer.gui.UISettings:isFeatureEnabled%
	%endinvoke%	
<TABLE width="100%">
	<TR>
		<TD colspan="2">
			<UL>
			%ifvar /deployAuthorized equals('true')%
				%ifvar projectType equals('Repository')%
				<LI><A onclick="startProgressBar();" target="propertyFrame" href="add-deployment.dsp?projectName=%value projectName%&projectType=%value projectType%">Create Deployment Candidate</A>
				%else%
					%ifvar /canBeDeployed equals('true')%				
					<LI><A onclick="startProgressBar();" target="propertyFrame" href="add-deployment.dsp?projectName=%value projectName%">Create Deployment Candidate</A>
					%else%
					<LI><A href="javascript:void();" onclick="alert('This Project has no Builds or has no Deployment Maps.  Cannot create Deployment Candidate.'); return false;">Create Deployment Candidate</A></LI>
					%endif%
				%endif%
			%endif%
        <LI><A onclick="startProgressBar();" href="deploy-list.dsp?projectName=%value projectName%&projectType=%value projectType%">Refresh this Page</A>
        <LI><a target="propertyFrame" href="edit-project.dsp?projectName=%value -htmlcode projectName%&mode=project">Project Properties</a>

			</UL>
		</TD>
	</TR>
	<TR>
		<TD><IMG height="10" src="images/blank.gif" width="10"></TD>
		<TD>
			<TABLE class="tableView" width="100%">
				<TR>
					<TD class="heading" colspan="8">Deployment Candidates</TD>
				</TR>
				<TR>
					<TD class="oddcol">Name</TD>
					<TD class="oddcol">Status</TD>
					%ifvar isActive equals('true')%
						<TD class="oddcol">Simulate</TD>
						%else%
							%ifvar projectType equals('Runtime')%
								<TD class="oddcol">Simulate</TD>
							%endif%
					%endif%
					%ifvar isActive equals('true')%
						%ifvar enableCheckpoint equals('true')%
					  		<TD class="oddcol">Checkpoint</TD>
						%endif%
					%else%
						%ifvar projectType equals('Runtime')%
					  		<TD class="oddcol">Checkpoint</TD>
						%endif%
					%endif%	
					<TD class="oddcol">Deploy</TD>
 					%ifvar isActive equals('true')%
 						<TD class="oddcol">Rollback</TD>
 						%else%
 							%ifvar projectType equals('Runtime')%
 					  			<TD class="oddcol">Rollback</TD>
							%endif%
 					%endif%
					<TD class="oddcol">Delete</TD>
					<TD class="oddcol">Progress Report</TD>
				</TR>

	<!- projectName* ->
	<!-- %invoke wm.deployer.gui.UIDeployment:listProjectDeployments% -->

	%ifvar deployments -notempty%
	%loop deployments%

				<TR>
					<!- Deployment Candidate Name ->
					<SCRIPT>writeTD('rowdata-l');</SCRIPT>
						<A target="propertyFrame" href="edit-deployment.dsp?projectName=%value -htmlcode ../projectName%&deploymentName=%value -htmlcode deploymentName%">
							%value deploymentName%</A> </TD>

					<!- Status ->
					<SCRIPT>writeTD('rowdata');</SCRIPT>						
						%ifvar errorStatus equals('NA')%
						%ifvar isProjectNewer equals('true')%
							<IMG title="Project definition has changed since Build %value buildName%" src="images/warning.gif" border="0" width="16" height="16"></TD>
						%else%
              				%ifvar isDependencyResolved equals('true')%		
  								%ifvar isMapValid equals('false')%
  									<IMG title="The Deployment Map associated with this Deployment Candidate is invalid" src="images/warning.gif" border="0" width="16" height="16"></TD>																			
  								%else%
  									%ifvar isMapEmpty equals('true')%
  										<IMG title="The deployment map associated with this deployment candidate does not contain any mapped target servers or target groups." src="images/warning.gif" border="0" width="18" height="16"></TD>
  									%else%
  										%ifvar isMapPartial equals('true')%
  											<IMG title="The Deployment Map associated with this Deployment Candidate contains partially mapped Target Server(s)/Group(s)" src="images/warning.gif" border="0" width="18" height="16"></TD>		
  										%else%
  											<IMG title="Ready for Deployment" src="images/green_check.gif" border="0" width="13" height="13"></TD>
  										%endif%	
  									%endif%
  								%endif%              																
							%else%
								<IMG title="Dependencies Unresolved" src="images/dependency.gif" border="0" width="13" height="13"></TD>
							%endif%							
						%endif%
						%else%
							<IMG title="%value errorStatus%" src="images/warning.gif" border="0" width="16" height="16"></TD>
						%endif%

					<!- Simulation ->
					%ifvar ../isActive equals('true')%
					<SCRIPT>writeTD('rowdata');</SCRIPT> 
					%ifvar /deployAuthorized equals('true')%
						<A class="imagelink"
							onclick="return onSimulate('%value deploymentName%');"
							href="deploy-list.dsp?action=simulate&projectName=%value -htmlcode ../projectName%&projectType=%value -htmlcode ../projectType%&deploymentName=%value -htmlcode deploymentName%&preDeployString=true">
							<IMG title="Generate Deployment Simulation Report.  Does not deploy Build to target servers." src="images/simulate.gif" border="no" width="18" height="18"></A></TD>
					%else%
						<IMG src="images/simulate_disabled.gif" border="no" width="18" height="18"></TD>
					%endif%
					%else%
						%ifvar ../projectType equals('Runtime')%
						<SCRIPT>writeTD('rowdata');</SCRIPT> 
						%ifvar /deployAuthorized equals('true')%
						<A class="imagelink"
							onclick="return onSimulate('%value deploymentName%');"
							href="deploy-list.dsp?action=simulate&projectName=%value -htmlcode ../projectName%&projectType=%value -htmlcode ../projectType%&deploymentName=%value -htmlcode deploymentName%&preDeployString=true">
							<IMG title="Generate Deployment Simulation Report.  Does not deploy Build to target servers." src="images/simulate.gif" border="no" width="18" height="18"></A></TD>
						%else%
						<IMG src="images/simulate_disabled.gif" border="no" width="18" height="18"></TD>
						%endif%
						%endif%
					%endif%
					<!- Checkpoint ->
					%ifvar ../isActive equals('true')%
						%ifvar ../enableCheckpoint equals('true')%
						<SCRIPT>writeTD('rowdata');</SCRIPT> 
						%ifvar /deployAuthorized equals('true')%
						%ifvar canBeCheckpointed equals('true')%
							<A class="imagelink" 
							onclick="return onCheckpoint('%value deploymentName%');"
							href="deploy-list.dsp?action=checkpoint&projectName=%value -htmlcode ../projectName%&projectType=%value -htmlcode ../projectType%&deploymentName=%value -htmlcode deploymentName%">
							<IMG alt="Create checkpoint of Target Servers." src="images/configure.gif" border="no" width="18" height="18"></A></TD>
						%else%
							<IMG src="images/configure_disabled.gif" border="no" width="18" height="18"></TD>
						%endif%
						%else%
							<IMG src="images/configure_disabled.gif" border="no" width="18" height="18"></TD>
						%endif%
						%endif%
					%else%
						%ifvar ../projectType equals('Runtime')%
							%ifvar ../enableCheckpoint equals('true')%
							<SCRIPT>writeTD('rowdata');</SCRIPT> 
							%ifvar /deployAuthorized equals('true')%
							%ifvar canBeCheckpointed equals('true')%
								<A class="imagelink" 
							onclick="return onCheckpoint('%value deploymentName%');"
							href="deploy-list.dsp?action=checkpoint&projectName=%value  -htmlcode ../projectName%&projectType=%value -htmlcode ../projectType%&deploymentName=%value -htmlcode deploymentName%">
							<IMG alt="Create checkpoint of Target Servers." src="images/configure.gif" border="no" width="18" height="18"></A></TD>
							%else%
								<IMG src="images/configure_disabled.gif" border="no" width="18" height="18"></TD>
							%endif%
							%else%
							<IMG src="images/configure_disabled.gif" border="no" width="18" height="18"></TD>
							%endif%
							%endif%
						%endif%
                    %endif%
					<!- Deploy ->
					<SCRIPT>writeTD('rowdata');</SCRIPT> 
					%ifvar /deployAuthorized equals('true')%
					%ifvar canBeDeployed equals('true')%
						<A class="imagelink" 
							onclick="return onDeploy('%value canBeRolledBackForWarning%', '%value deploymentName%');"
							href="deploy-list.dsp?action=deploy&projectName=%value -htmlcode ../projectName%&projectType=%value -htmlcode ../projectType%&deploymentName=%value -htmlcode deploymentName%&preDeployString=false&force=true">
							<IMG alt="Deploy to Target Servers." src="images/deploy_go.gif" border="no" width="18" height="18"></A></TD>
					%else%
							<IMG src="images/deploy_disabled.gif" border="no" width="18" height="18"></TD>
					%endif%
					%else%
							<IMG src="images/deploy_disabled.gif" border="no" width="18" height="18"></TD>
					%endif%

					<!- Rollback ->
					%ifvar ../isActive equals('true')%
						<SCRIPT>writeTD('rowdata');</SCRIPT> 
						%ifvar /deployAuthorized equals('true')%
						%ifvar canBeRolledBack equals('true')%
							<A class="imagelink" 
							onclick="return onRollback('%value deploymentName%');"
							href="deploy-list.dsp?action=rollback&projectName=%value -htmlcode ../projectName%&projectType=%value -htmlcode ../projectType%&deploymentName=%value -htmlcode deploymentName%&preDeployString=false">
							<IMG alt="Rollback deployment on Target Servers." src="images/undo.gif" border="no" width="16" height="16"></A></TD>
						%else%
							<IMG src="images/undo_disabled.gif" border="no" width="16" height="16"></TD>
						%endif%
						%else%
							<IMG src="images/undo_disabled.gif" border="no" width="16" height="16"></TD>
						%endif%
					%else%
						%ifvar ../projectType equals('Runtime')%
							<SCRIPT>writeTD('rowdata');</SCRIPT> 
							%ifvar /deployAuthorized equals('true')%
							%ifvar canBeRolledBack equals('true')%
								<A class="imagelink" 
							onclick="return onRollback('%value deploymentName%');"
							href="deploy-list.dsp?action=rollback&projectName=%value -htmlcode ../projectName%&projectType=%value -htmlcode ../projectType%&deploymentName=%value -htmlcode deploymentName%&preDeployString=false">
							<IMG alt="Rollback deployment on Target Servers." src="images/undo.gif" border="no" width="16" height="16"></A></TD>
							%else%
							<IMG src="images/undo_disabled.gif" border="no" width="16" height="16"></TD>
							%endif%
							%else%
							<IMG src="images/undo_disabled.gif" border="no" width="16" height="16"></TD>
							%endif%
						%endif%
					%endif%
					<!- Delete ->
					<SCRIPT>writeTD("rowdata");</SCRIPT> 
					%ifvar /deployAuthorized equals('true')%
						<A onclick="return confirmDelete('%value deploymentName%');"
							href="deploy-list.dsp?action=delete&projectName=%value -htmlcode ../projectName%&projectType=%value -htmlcode ../projectType%&projectType=%value -htmlcode ../projectType%&deploymentName=%value -htmlcode deploymentName%">
							<IMG alt="Delete this Deployment Candidate." src="images/delete.gif" border="no" width="16" height="16"></A></TD>
					%else%
							<IMG src="images/delete_disabled.gif" border="no" width="16" height="16"></TD>
					%endif%
					<SCRIPT>writeTD("rowdata");</SCRIPT> 
						<A target="_blank" href="progress-report.dsp?type=deployment&projectName=%value -htmlcode ../projectName%&deploymentName=%value -htmlcode deploymentName%">
							<IMG alt="View this Report in a separate browser." src="images/edit.gif" border="no"></A></TD>
					<SCRIPT>swapRows();</SCRIPT>
				</TR>
	%endloop deployments%
	
	%else%
				<TR>
					<TD colspan=7><FONT color="red"> * No Deployment Candidates</FONT> </TD>
				</TR>
	%endif%
	%endscope% 
	%endinvoke%
			</TABLE>
		</TD>
	</TR>
</TABLE>

<script> 
%ifvar action equals('add')%
%else%
	stopProgressBar(); 
%endif%
</script> 

</BODY>
</HTML>
