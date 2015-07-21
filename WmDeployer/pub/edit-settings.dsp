<HTML><HEAD>
<HTML><HEAD>
<TITLE>Edit Settings</TITLE>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META http-equiv="Expires" content="-1">
<SCRIPT src="webMethods.js"></SCRIPT>
<LINK href="webMethods.css" type="text/css" rel="stylesheet">
<BODY>

<SCRIPT language=JavaScript>
function enableSaveProperties() {
	document.getElementById("save").disabled = false;
}

function onSave() {
	startProgressBar();
	return true;
}

</SCRIPT>

</HEAD>
<BODY>

<TABLE width="100%">
	<TR>
		<TD class="menusection-Deployer" colspan="4"> Settings 
		</TD>
	</TR>
</TABLE>

<TABLE>
%ifvar action equals('updateSettings')%
	<!- projectName, projectDescription ->
	%invoke wm.deployer.gui.UISettings:updateSettings%
		%include error-handler.dsp%

	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%end if%

%ifvar action equals('startServer')%
	%invoke wm.deployer.Util:startGlueServer%
		%include error-handler.dsp%

	<script>writeMessage("Start up command sent to Deployer.");</script>
	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%endinvoke%
%end if%

%ifvar action equals('stopServer')%
	%invoke wm.deployer.Util:shutdownGlueServer%
		%include error-handler.dsp%

	<script>writeMessage("Shut down command sent to Deployer.");</script>
	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%end if%
</TABLE>

<TABLE>
	<TR>
		<TD colspan="2">
     	<UL>	
        <LI><a onclick="startProgressBar();" href="edit-settings.dsp">Refresh this Page</a>
     	</UL>	
		</TD>
	</TR>

<!- Determine if this user is empowered to modify server stuff ->
%invoke wm.deployer.UIAuthorization:isAuthorized%
%endinvoke%

%invoke wm.deployer.gui.UISettings:getSettings%

	<TR>
		<TD><IMG height="0" src="images/blank.gif" width="10"></TD>
			<SCRIPT>resetRows();</SCRIPT>
		<TD>
			<TABLE class="tableView">
%comment%
				<FORM name="projectForm" method="POST" action="under-construction.dsp">
%endcomment%
				<FORM name="projectForm" method="POST" action="edit-settings.dsp" onSubmit="return onSave();">

 				<SCRIPT>swapRows();</SCRIPT>
				<TR>
					<TD class="subHeading" colspan=2><b>Options having * are applicable only for 'Runtime' type projects</b></TD>
				</TR>
				
				<TR>
					<TD class="heading" colspan=2>Audit Logging Setting</TD>
				</TR>

				<TR>
					<script> writeTD("row", "nowrap"); </script>Enable Audit Logging</TD>
					<script> writeTD("rowdata-l", "nowrap"); </script> 
				%ifvar isAuth equals('true')%
					%ifvar auditLog equals('true')%
						<INPUT onchange="enableSaveProperties();" type="radio" name="auditLog" value="true" checked>Yes
						<INPUT onchange="enableSaveProperties();" type="radio" name="auditLog" value="false">No
					%else%
						<INPUT onchange="enableSaveProperties();" type="radio" name="auditLog" value="true" >Yes
						<INPUT onchange="enableSaveProperties();" type="radio" name="auditLog" value="false" checked>No
					%endif%
				%else%
						%ifvar auditLog equals('false')% Yes
            			%else% 
            				No
            			%endif%
				%endif%
				</TR>
				<SCRIPT>swapRows();</SCRIPT>

				<TR>
					<TD class="heading" colspan=2>Dependency Checking Defaults<b>*</b></TD>
				</TR>

				<TR>
					<script> writeTD("row", "nowrap"); </script>Mode</TD>
					<script> writeTD("rowdata-l", "nowrap"); </script> 
				%ifvar isAuth equals('true')%
					%ifvar reduceDependencyChecks equals('false')%
						<INPUT onchange="enableSaveProperties();" type="radio" name="reduceDependencyChecks" value="false" checked>Always
						<INPUT onchange="enableSaveProperties();" type="radio" name="reduceDependencyChecks" value="true">Reduced
						<INPUT onchange="enableSaveProperties();" type="radio" name="reduceDependencyChecks" value="none">Manual
					%else%
					  %ifvar reduceDependencyChecks equals('true')%
						<INPUT onchange="enableSaveProperties();" type="radio" name="reduceDependencyChecks" value="false">Always
						<INPUT onchange="enableSaveProperties();" type="radio" name="reduceDependencyChecks" value="true" checked>Reduced
						<INPUT onchange="enableSaveProperties();" type="radio" name="reduceDependencyChecks" value="none">Manual
					  %else%
						<INPUT onchange="enableSaveProperties();" type="radio" name="reduceDependencyChecks" value="false">Always
						<INPUT onchange="enableSaveProperties();" type="radio" name="reduceDependencyChecks" value="true">Reduced
						<INPUT onchange="enableSaveProperties();" type="radio" name="reduceDependencyChecks" value="none" checked>Manual
					  %endif%
					%endif%
				%else%
						%ifvar reduceDependencyChecks equals('false')% Automatic
            %else% 
            	Manual
            %endif%
				%endif%
				</TR>
				<SCRIPT>swapRows();</SCRIPT>

       			 <TR>
					<TD class="heading" colspan=2>Project Locking Default</TD>
				 </TR>			
       			 <TR>
					<script> writeTD("row", "nowrap"); </script>Enable Project Locking</TD>
					<script> writeTD("rowdata-l", "nowrap"); </script> 
					%ifvar isAuth equals('true')%
            		 <INPUT onchange="enableSaveProperties();" type="radio" name="projectLocking" value="true" 
							%ifvar projectLocking equals('true')% checked %endif%>Yes
					 <INPUT onchange="enableSaveProperties();" type="radio" name="projectLocking" value="false"
							%ifvar projectLocking equals('false')% checked %endif%>No
			 		%endif%
				</TR>
				<SCRIPT>swapRows();</SCRIPT>     

				<TR>
					<TD class="heading" colspan=2>General Deployment Defaults</TD>
				</TR>

        <TR>
					<script> writeTD("row", "nowrap"); </script>Optimize UI Response<b>*</b></TD>
					<script> writeTD("rowdata-l", "nowrap"); </script> 
					%ifvar isAuth equals('true')%
						%ifvar optimisticNetwork equals('true')%
							<INPUT onchange="enableSaveProperties();" type="radio" name="optimisticNetwork" value="true" checked>Yes
							<INPUT onchange="enableSaveProperties();" type="radio" name="optimisticNetwork" value="false">No
						%else%
							<INPUT onchange="enableSaveProperties();" type="radio" name="optimisticNetwork" value="true" >Yes
							<INPUT onchange="enableSaveProperties();" type="radio" name="optimisticNetwork" value="false" checked>No
						%endif%
					%else%
						%ifvar optimisticNetwork equals('true')% 
							Yes
            			%else% 
            				No
            			%endif%
					%endif%
				</TR>
				
				<TR>
					<script> writeTD("row", "nowrap"); </script>Large File Support<b>*</b></TD>
					<script> writeTD("rowdata-l", "nowrap"); </script> 
				%ifvar isAuth equals('true')%
					%ifvar largeFileSupport equals('true')%
						<INPUT onchange="enableSaveProperties();" type="radio" name="largeFileSupport" value="true" checked>Yes
						<INPUT onchange="enableSaveProperties();" type="radio" name="largeFileSupport" value="false">No
					%else%
						<INPUT onchange="enableSaveProperties();" type="radio" name="largeFileSupport" value="true" >Yes
						<INPUT onchange="enableSaveProperties();" type="radio" name="largeFileSupport" value="false" checked>No
					%endif%
				%else%
						%ifvar largeFileSupport equals('false')% Yes
            %else% 
            	No
            %endif%
				%endif%
				</TR>
				<SCRIPT>swapRows();</SCRIPT>
				
				<TR>
					<script> writeTD("row", "nowrap"); </script>Checkpoint Creation<b>*</b></TD>
					<script> writeTD("rowdata-l", "nowrap"); </script> 
				%ifvar isAuth equals('true')%
					%ifvar checkpointAutomatic equals('true')%
						<INPUT onchange="enableSaveProperties();" type="radio" name="checkpointAutomatic" value="true" checked>Automatic
						<INPUT onchange="enableSaveProperties();" type="radio" name="checkpointAutomatic" value="false">Manual
					%else%
						<INPUT onchange="enableSaveProperties();" type="radio" name="checkpointAutomatic" value="true" >Automatic
						<INPUT onchange="enableSaveProperties();" type="radio" name="checkpointAutomatic" value="false" checked>Manual
					%endif%
				%else%
						%ifvar checkpointAutomatic equals('false')% Automatic
            %else% 
            	Manual
            %endif%
				%endif%
				</TR>
				<SCRIPT>swapRows();</SCRIPT>

				<TR>
					<script> writeTD("row", "nowrap"); </script>Rollback on Error<b>*</b></TD>
					<script> writeTD("rowdata-l", "nowrap"); </script> 
				%ifvar isAuth equals('true')%
					%ifvar rollbackAutomatic equals('true')%
						<INPUT onchange="enableSaveProperties();" type="radio" name="rollbackAutomatic" value="true" checked>Automatic
						<INPUT onchange="enableSaveProperties();" type="radio" name="rollbackAutomatic" value="false">Manual
					%else%
						<INPUT onchange="enableSaveProperties();" type="radio" name="rollbackAutomatic" value="true">Automatic
						<INPUT onchange="enableSaveProperties();" type="radio" name="rollbackAutomatic" value="false" checked>Manual
					%endif%
				%else%
						%ifvar rollbackAutomatic equals('false')% Automatic
            %else% 
            	Manual
            %endif%
				%endif%
				</TR>
				<SCRIPT>swapRows();</SCRIPT>
				
				<TR>
					<script> writeTD("row", "nowrap"); </script>Enable Concurrent Deployment</TD>
					<script> writeTD("rowdata-l", "nowrap"); </script> 
				%ifvar isAuth equals('true')%
					%ifvar concurrentDeployment equals('true')%
						<INPUT onchange="enableSaveProperties();" type="radio" name="concurrentDeployment" value="true" checked>Yes
						<INPUT onchange="enableSaveProperties();" type="radio" name="concurrentDeployment" value="false">No
					%else%
						<INPUT onchange="enableSaveProperties();" type="radio" name="concurrentDeployment" value="true">Yes
						<INPUT onchange="enableSaveProperties();" type="radio" name="concurrentDeployment" value="false" checked>No
					%endif%
				%else%
						%ifvar concurrentDeployment equals('false')% No
            %else% 
            	No
            %endif%
				%endif%
				</TR>
				<SCRIPT>swapRows();</SCRIPT>
				
				<TR>
					<script> writeTD("row", "nowrap"); </script>Deployer Service Timeout</TD>
					<script> writeTD("rowdata-l", "nowrap"); </script> 
					%ifvar isAuth equals('true')%
						%ifvar serviceTimeout -isnull%
	          				<INPUT onchange="enableSaveProperties();" name="serviceTimeout" value="0" size="20"> ms
	          			%else%
	          				<INPUT onchange="enableSaveProperties();" name="serviceTimeout" value="%value serviceTimeout%" size="20"> ms
	          			%endif%
					%else%
						%value serviceTimeout% ms
					%endif%
				</TR>
				<SCRIPT>swapRows();</SCRIPT>
				
				<TR>
					<script> writeTD("row", "nowrap"); </script>Batch Size for Runtime Deployment<b>*</b></TD>
					<script> writeTD("rowdata-l", "nowrap"); </script> 
				%ifvar isAuth equals('true')%
					%ifvar runtimeBatchSize -isnull%
						<INPUT onchange="enableSaveProperties();" name="runtimeBatchSize" value="10" size="20"> no of objects
					%else%
						<INPUT onchange="enableSaveProperties();" name="runtimeBatchSize" value="%value runtimeBatchSize%" size="20"> no of objects
					%endif%
				%else%
					%value runtimeBatchSize% no of objects
				%endif%
				</TR>
				
				<SCRIPT>swapRows();</SCRIPT>
				
				<TR>
					<script> writeTD("row", "nowrap"); </script>Batch Size for Repository Deployment</TD>
					<script> writeTD("rowdata-l", "nowrap"); </script> 
					%ifvar isAuth equals('true')%
						%ifvar repoBatchSize -isnull%
					<INPUT onchange="enableSaveProperties();" name="repoBatchSize" value="1" size="20"> no of objects
					%else%
					<INPUT onchange="enableSaveProperties();" name="repoBatchSize" value="%value repoBatchSize%" size="20"> no of objects
					%endif%
					%else%
					%value repoBatchSize% no of objects
					%endif%
				</TR>
				
				<SCRIPT>swapRows();</SCRIPT>
				
				<TR>
					<script> writeTD("row", "nowrap"); </script>Maximum Plugin Objects Displayed</TD>
					<script> writeTD("rowdata-l", "nowrap"); </script> 
					%ifvar isAuth equals('true')%
						%ifvar maxPluginObjects -isnull%
					<INPUT onchange="enableSaveProperties();" name="maxPluginObjects" value="2500" size="20">
					%else%
					<INPUT onchange="enableSaveProperties();" name="maxPluginObjects" value="%value maxPluginObjects%" size="20">
					%endif%
					%else%
					%value maxPluginObjects%
					%endif%
				</TR>

				
				
				
				<SCRIPT>swapRows();</SCRIPT>
				
				<TR>
					<TD class="heading" colspan=2>IS & TN Deployment Defaults<b>*</b></TD>
				</TR>

				<TR>
					<TD class="subHeading" colspan=2>Suspend During Deployment</TD>
				</TR>

				<TR>
					<script> writeTD("row", "nowrap"); </script>Triggers</TD>
					<script> writeTD("rowdata-l", "nowrap"); </script> 
				%ifvar isAuth equals('true')%
						<INPUT onchange="enableSaveProperties();" type="radio" name="stopTriggers" value="true"
							%ifvar stopTriggers equals('true')% checked %endif%>All
						<INPUT onchange="enableSaveProperties();" type="radio" name="stopTriggers" value="false"
							%ifvar stopTriggers equals('false')% checked %endif%>None
						<INPUT onchange="enableSaveProperties();" type="radio" name="stopTriggers" value="selected"
							%ifvar stopTriggers equals('selected')% checked %endif%>Selected
				%else%
						%ifvar stopTriggers equals('true')% Yes 
            %else% 
						  %ifvar stopTriggers equals('false')% No 
              %else% 
                 Selected
              %endif%
            %endif%
				%endif%
				</TR>
				<SCRIPT>swapRows();</SCRIPT>

				<TR>
					<script> writeTD("row", "nowrap"); </script>Ports</TD>
					<script> writeTD("rowdata-l", "nowrap"); </script> 
				%ifvar isAuth equals('true')%
						<INPUT onchange="enableSaveProperties();" type="radio" name="stopListeners" value="true" 
							%ifvar stopListeners equals('true')% checked %endif%>Yes
						<INPUT onchange="enableSaveProperties();" type="radio" name="stopListeners" value="false"
							%ifvar stopListeners equals('false')% checked %endif%>No
				%else%
						%ifvar stopListeners equals('true')% Yes %else% No %endif%
				%endif%
				</TR>
				<SCRIPT>swapRows();</SCRIPT>

				<TR>
					<script> writeTD("row", "nowrap"); </script>Scheduled Tasks</TD>
					<script> writeTD("rowdata-l", "nowrap"); </script> 
				%ifvar isAuth equals('true')%
						<INPUT onchange="enableSaveProperties();" type="radio" name="stopServices" value="true"
							%ifvar stopServices equals('true')% checked %endif%>Yes
						<INPUT onchange="enableSaveProperties();" type="radio" name="stopServices" value="false"
							%ifvar stopServices equals('false')% checked %endif%>No
				%else%
						%ifvar stopServices equals('true')% Yes %else% No %endif%
				%endif%
				</TR>
				<SCRIPT>swapRows();</SCRIPT>

				<TR>
					<script> writeTD("row", "nowrap"); </script>Adapters</TD>
					<script> writeTD("rowdata-l", "nowrap"); </script> 
				%ifvar isAuth equals('true')%
						<INPUT onchange="enableSaveProperties();" type="radio" name="stopAdapters" value="false"
							%ifvar stopAdapters equals('false')% checked %endif%>None
						<INPUT onchange="enableSaveProperties();" type="radio" name="stopAdapters" value="true"
							%ifvar stopAdapters equals('true')% checked %endif%>Selected
				%else%
					%ifvar stopAdapters equals('true')% 
						Selected
          %else% 
						No
          %endif%
				%endif%
				</TR>
				<SCRIPT>swapRows();</SCRIPT>

				<TR>
					<TD class="subHeading" colspan=2>Overwrite Existing</TD>
				</TR>

				<TR>
					<script> writeTD("row"); </script>TN Rules</TD>
					<script> writeTD("rowdata-l", "nowrap"); </script> 
				%ifvar isAuth equals('true')%
						<INPUT onchange="enableSaveProperties();" type="radio" name="deployTNRules" value="REPLACE"
							%ifvar deployTNRules equals('REPLACE')% checked %endif%>Replace All
						<INPUT onchange="enableSaveProperties();" type="radio" name="deployTNRules" value="MERGE"
							%ifvar deployTNRules equals('MERGE')% checked %endif%>Merge
				%else%
						%ifvar deployTNRules equals('REPLACE')% Replace All %else% Merge %endif%
				%endif%
				</TR>
				<SCRIPT>swapRows();</SCRIPT>

				<TR>
					<script> writeTD("row"); </script>ACL Maps</TD>
					<script> writeTD("rowdata-l", "nowrap"); </script> 
				%ifvar isAuth equals('true')%
						<INPUT onchange="enableSaveProperties();" type="radio" name="deployACLMap" value="true"
							%ifvar deployACLMap equals('true')% checked %endif%>Yes
						<INPUT onchange="enableSaveProperties();" type="radio" name="deployACLMap" value="false"
							%ifvar deployACLMap equals('false')% checked %endif%>No
				%else%
						%ifvar deployACLMap equals('true')% Yes %else% No %endif%
				%endif%
				</TR>
				<SCRIPT>swapRows();</SCRIPT>

				<TR>
					<script> writeTD("row"); </script>Other Non-Package Assets</TD>
					<script> writeTD("rowdata-l", "nowrap"); </script> 
				%ifvar isAuth equals('true')%
						<INPUT onchange="enableSaveProperties();" type="radio" name="overwrite" value="ALWAYS"
							%ifvar overwrite equals('ALWAYS')% checked %endif%>Yes
						<INPUT onchange="enableSaveProperties();" type="radio" name="overwrite" value="NEVER"
							%ifvar overwrite equals('NEVER')% checked %endif%>No
				%else%
						%ifvar overwrite equals('ALWAYS')% Yes %else% No %endif%
				%endif%
				</TR>
				<SCRIPT>swapRows();</SCRIPT>

				<SCRIPT>swapRows();</SCRIPT>

				<TR>
					<TD class="subHeading" colspan=2>Activate After Deployment</TD>
				</TR>

				<TR>
					<script> writeTD("row"); </script>Ports</TD>
					<script> writeTD("rowdata-l", "nowrap"); </script> 
				%ifvar isAuth equals('true')%
						<INPUT onchange="enableSaveProperties();" type="radio" name="disablePorts" value="false"
							%ifvar disablePorts equals('false')% checked %endif%>Yes
						<INPUT onchange="enableSaveProperties();" type="radio" name="disablePorts" value="true"
							%ifvar disablePorts equals('true')% checked %endif%>No
				%else%
						%ifvar disablePorts equals('true')% Yes %else% No %endif%
				%endif%
				</TR>
				<SCRIPT>swapRows();</SCRIPT>

				<TR>
					<script> writeTD("row"); </script>Scheduled Tasks</TD>
					<script> writeTD("rowdata-l", "nowrap"); </script> 
				%ifvar isAuth equals('true')%
						<INPUT onchange="enableSaveProperties();" type="radio" name="disableServices" value="false"
							%ifvar disableServices equals('false')% checked %endif%>Yes
						<INPUT onchange="enableSaveProperties();" type="radio" name="disableServices" value="true"
							%ifvar disableServices equals('true')% checked %endif%>No
				%else%
						%ifvar disableServices equals('true')% Yes %else% No %endif%
				%endif%
				</TR>
				<SCRIPT>swapRows();</SCRIPT>
				
 				<TR>
 					<script> writeTD("row"); </script>Adapters</TD>
 					<script> writeTD("rowdata-l", "nowrap"); </script> 
 				%ifvar isAuth equals('true')%
 						<INPUT onchange="enableSaveProperties();" type="radio" name="enableAdapters" value="true"
 							%ifvar enableAdapters equals('true')% checked %endif%>Yes
 						<INPUT onchange="enableSaveProperties();" type="radio" name="enableAdapters" value="false"
 							%ifvar enableAdapters equals('false')% checked %endif%>No
 				%else%
 						%ifvar enableAdapters equals('true')% Yes %else% No %endif%
 				%endif%
 				</TR>
												
				%ifvar isAuth equals('true')%
				<TR>
					<INPUT type="hidden" name="action" value="updateSettings">
					<TD class="action" colspan="2">
						<INPUT align="center" type="submit" VALUE="Save" name="submit" id="save"> </TD>
				</TR>
				%endif%
				</FORM>
			</TABLE>
		</TD>
	</TR>
</TABLE>
%endinvoke%

<script>

stopProgressBar();
%ifvar isAuth equals('true')%
	// document.projectForm.projectDescription.focus();
%endif%
</script>

</BODY>
</HTML>
