<HTML><HEAD>
 <TITLE>Edit Project </TITLE>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META http-equiv="Expires" content="-1">
<LINK href="webMethods.css" type="text/css" rel="stylesheet">
<SCRIPT src="webMethods.js"></SCRIPT>

</HEAD>
<BODY>

<SCRIPT language=JavaScript>
function enableSaveProperties() {
  if(document.getElementById("save1") != null) {
  	document.getElementById("save1").disabled = false;
  }
	document.getElementById("save2").disabled = false;
}

function showOrHideDiv(divElement)
{

	divValue = document.getElementById(divElement).style.display;
	//alert('adf' + divValue);
	if (divValue == 'none')
	{
		document.getElementById(divElement).style.display = 'block';
	}
	else
	{
		document.getElementById(divElement).style.display = 'none';	
	}
}
</SCRIPT>

<TABLE width="100%">
	<TR>
%ifvar mode equals('list')%
		<TD class="menusection-Deployer" colspan="4"> %value projectName% &gt; Properties 
%else%
		<TD class="menusection-Deployer" colspan="4"> Project Properties 
%endif%
		</TD>
	</TR>

%ifvar mode equals('list')%
  %ifvar projectType equals('Repository')%
  	   %include navigation-bar-repository.dsp%
  %else%
	%include navigation-bar.dsp% 
%endif%
%endif%
</TABLE>

<TABLE>
%ifvar action equals('updateProject')%
	<!- projectName, projectDescription ->
	%invoke wm.deployer.gui.UIProject:updateProject%
		%include error-handler.dsp%

		%ifvar status equals('Success')%
		<script> 
			if(is_csrf_guard_enabled && needToInsertToken) {
   			   parent.treeFrame.document.location.href = "bundle-list.dsp?projectName=%value -htmlcode projectName%&projectType=%value -htmlcode projectType%&" + _csrfTokenNm_ + "=" + _csrfTokenVal_;
			} else {
			   parent.treeFrame.document.location.href = "bundle-list.dsp?projectName=%value -htmlcode projectName%&projectType=%value -htmlcode projectType%";
			}
		</script>
			%ifvar mode equals('list')%
			<script>
				startProgressBar("Refreshing Project List");
				parent.treeFrame.document.location.href = "project-list.dsp";
			</script>
			%endif%
		%else%
			<script> stopProgressBar(); </script>
		%endif%
	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%end if%

%ifvar action equals('export')%
	<!- projectName, doExport ->
	%invoke wm.deployer.gui.UIProject:getProjectInfo%
		%ifvar status equals('Success')%
			<script>writeMessage("Exported project properties File written to replicate\\outbound folder of WmDeployer Package on %sysvar host%.");</script>
			<script>window.open("projects/%value ../encodedProjName%/%value ../encodedProjName%.properties");</script>
		%endif%
		%ifvar status equals('Exists')%
			<script>writeError("%value -htmlcode message%");</script>
			<script>window.open("projects/%value ../encodedProjName%/%value ../encodedProjName%.properties");</script>
		%endif%		
		%ifvar status equals('Error')%
			%include error-handler.dsp%
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
		%include error-handler.dsp%	
	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%end if%

<!-- Import Project-->
%ifvar action equals('import')%
	%invoke wm.deployer.gui.UIProject:importProject%
		%include error-handler.dsp%	
	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%end if%

</TABLE>

%include navigation-links.dsp%

<TABLE>
	<TR>
		<TD colspan="2">
     	<UL>	
        <LI><a onclick="startProgressBar();" href="edit-project.dsp?projectName=%value projectName%&mode=%value mode%&projectType=%value projectType%">Refresh this Page</a>
       	
        	%ifvar defineAuthorized equals('true')%
      	    <LI><a onclick="startProgressBar();" href="edit-project.dsp?projectName=%value projectName%&mode=%value mode%&action=export&doExport=true&projectType=%value projectType%">Export Project properties</a>
            <LI><a href="javascript:showOrHideDiv('projectContainer')">Import Project Properties</a>
                 
            		<p>
            		<form name="projectForm1" action="edit-project.dsp">
            		   <INPUT type="hidden" value="%value projectName%" name="projectName">
            		   <INPUT type="hidden" value="%value projectType%" name="projectType">      		   
                       <INPUT type="hidden" VALUE="import" name="action">
            
            		<div id="projectContainer" style="display:none">
            		
            	   %invoke wm.deployer.gui.UIProject:listProjectsToImport%	
            	
            		  %ifvar importProjects -notempty%		
            		  <select name="importFileName">
            				%loop importProjects%
            					<option value="%value%">%value%</option>
            				%end loop%		
            	   	</select>
            	 	   <input type="submit" value="Import Project">
            	       %else%
            				  <font color="red">* No Projects to import (*.properties)</font>
            	   	   %endif%
                	%end invoke%
            		</div>
            		</form>
            		</p> 
           %endif%    
     	</UL>	
		</TD>
	</TR>

	<TR>
		<TD><IMG height="0" src="images/blank.gif" width="10"></TD>
			<SCRIPT>resetRows();</SCRIPT>
		<TD>
			<TABLE class="tableView">
				<TR>
					<TD class="heading" colspan="2">Project Properties</TD>
				</TR>

%comment%
				<FORM name="projectForm" method="POST" action="under-construction.dsp">
%endcomment%
				<FORM name="projectForm" method="POST" action="edit-project.dsp">

				%ifvar defineAuthorized equals('true')%
				<INPUT type="hidden" value="%value projectType%" name="projectType">
				<INPUT type="hidden" name="mode" value='%value mode%'>
				%ifvar projectType equals('Repository')%	
        
        %else%			
    				<TR>
    					<INPUT type="hidden" name="projectName" value='%value projectName%'>
    					<INPUT type="hidden" name="action" value="updateProject">
    					<TD class="action" colspan="2">
    						<INPUT onclick="return startProgressBar('Saving Project Properties');" align="center" 
    							type="submit" VALUE="Save" name="submit" id="save1"> </TD>
    				</TR>
    		%endif%
				%endif%

				<TR>
					<script> writeTD("row"); </script>Project Name</TD>
					<script> writeTD("rowdata-l"); </script> %value projectName%</TD>
				</TR>
				<SCRIPT>swapRows();</SCRIPT>

				<TR>
					<script> writeTD("row"); </script>Description</TD>
					<script> writeTD("rowdata-l"); </script> 
				%ifvar defineAuthorized equals('true')%
						<INPUT onchange="enableSaveProperties();" name="projectDescription" value="%value description%" size="32">
				%else%
						%value description% 
				%endif%
					</TD>
				</TR>
				<SCRIPT>swapRows();</SCRIPT>

				<TR>
					<script> writeTD("row"); </script>Project Type</TD>
					<script> writeTD("rowdata-l"); </script> %value projectType%</TD>
				</TR>
				<SCRIPT>swapRows();</SCRIPT>	
				
				 %ifvar projectType equals('Runtime')%

				<TR>
					<TD class="heading" colspan=2>Dependency Checking Options</TD>
				</TR>

				<TR>
					<script> writeTD("row", "nowrap"); </script>Mode</TD>
					<script> writeTD("rowdata-l", "nowrap"); </script> 
				%ifvar defineAuthorized equals('true')%
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
						%ifvar reduceDependencyChecks equals('false')% Always
            			%else% 
            				%ifvar reduceDependencyChecks equals('true')% Reduced
            				 %else% 		
            					Manual
           					 %endif%
            			 %endif%
				%endif%
				%endif%
				
				</TR>
					
					<SCRIPT>swapRows();</SCRIPT>
					
	      			<TR>
						<TD class="heading" colspan=2>General Project Settings</TD>
					</TR>			
	       			<TR>
						<script> writeTD("row", "nowrap"); </script>Enable Project Locking</TD>
						<script> writeTD("rowdata-l", "nowrap"); </script> 
					%ifvar defineAuthorized equals('true')%					
	          			   <INPUT onchange="enableSaveProperties();" type="radio" name="projectLocking" value="true" 
								%ifvar projectLocking equals('true')% checked %endif%>Yes
							<INPUT onchange="enableSaveProperties();" type="radio" name="projectLocking" value="false"
								%ifvar projectLocking equals('false')% checked %endif%>No
					%else%
					%ifvar projectLocking equals('true')% Yes
	           		 %else% 
	              		No
	           		 %endif%							
					%endif%
					</TR>
					%scope param(featureID='SPI_2')%
						%invoke wm.deployer.gui.UISettings:isFeatureEnabled%
						%endinvoke%
					<TR>
						<script> writeTD("row", "nowrap"); </script>Enable Concurrent Deployment</TD>
						<script> writeTD("rowdata-l", "nowrap"); </script> 
					%ifvar defineAuthorized equals('true')%					
	          			   <INPUT onchange="enableSaveProperties();" type="radio" name="concurrentDeployment" value="true" 
								%ifvar concurrentDeployment equals('true')% checked %endif%>Yes
							<INPUT onchange="enableSaveProperties();" type="radio" name="concurrentDeployment" value="false"
								%ifvar concurrentDeployment equals('false')% checked %endif%>No
					%else%
					%ifvar concurrentDeployment equals('true')% Yes
	           		 %else% 
	              		No
	           		 %endif%							
					%endif%
					</TR>
					<SCRIPT>swapRows();</SCRIPT>
					%ifvar projectType equals('Repository')%
					<TR>
						<script> writeTD("row", "nowrap"); </script>Ignore Missing Dependencies</TD>
						<script> writeTD("rowdata-l", "nowrap"); </script> 
					%ifvar defineAuthorized equals('true')%					
	          			   <INPUT onchange="enableSaveProperties();" type="radio" name="ignoreMissingDependencies" value="true" 
								%ifvar ignoreMissingDependencies equals('true')% checked %endif%>Yes
							<INPUT onchange="enableSaveProperties();" type="radio" name="ignoreMissingDependencies" value="false"
								%ifvar ignoreMissingDependencies equals('false')% checked %endif%>No
					%else%
					%ifvar ignoreMissingDependencies equals('true')% Yes
	           		 %else% 
	              		No
	           		 %endif%							
					%endif%
					</TR>
					%endif%
					<SCRIPT>swapRows();</SCRIPT>
					%ifvar projectType equals('Repository')%
						
						%ifvar isActive equals('true')%
						<TR>
							<script> writeTD("row", "nowrap"); </script>Enable Transactional Deployment</TD>
							<script> writeTD("rowdata-l", "nowrap"); </script> 
							%ifvar defineAuthorized equals('true')%					
	          			   		<INPUT onchange="enableSaveProperties();" type="radio" name="isTransactionalDeployment" value="true" 
									%ifvar isTransactionalDeployment equals('true')% checked %endif%>Yes
								<INPUT onchange="enableSaveProperties();" type="radio" name="isTransactionalDeployment" value="false"
									%ifvar isTransactionalDeployment equals('false')% checked %endif%>No
							%else%
							%ifvar isTransactionalDeployment equals('true')% Yes
	           		 		%else% 
	              			No
	           		 		%endif%							
						%endif%
					%endif%
					</TR>
					%endif%
					%endscope%			
					<SCRIPT>swapRows();</SCRIPT>					

				 %ifvar projectType equals('Runtime')%

				<TR>
					<TD class="heading" colspan=2>General Deployment Options</TD>
				</TR>

				<TR>
					<script> writeTD("row", "nowrap"); </script>Checkpoint Creation</TD>
					<script> writeTD("rowdata-l", "nowrap"); </script> 
				%ifvar defineAuthorized equals('true')%
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
					<script> writeTD("row", "nowrap"); </script>Rollback on Error</TD>
					<script> writeTD("rowdata-l", "nowrap"); </script> 
				%ifvar defineAuthorized equals('true')%
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
					<TD class="heading" colspan=2>IS & TN Deployment Options</TD>
				</TR>

				<TR>
					<TD class="subHeading" colspan=2>Suspend During Deployment</TD>
				</TR>

				<TR>
					<script> writeTD("row", "nowrap"); </script>Triggers</TD>
					<script> writeTD("rowdata-l", "nowrap"); </script> 
				%ifvar defineAuthorized equals('true')%
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
				%ifvar defineAuthorized equals('true')%
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
				%ifvar defineAuthorized equals('true')%
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
				%ifvar defineAuthorized equals('true')%
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
				%ifvar defineAuthorized equals('true')%
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
				%ifvar defineAuthorized equals('true')%
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
				%ifvar defineAuthorized equals('true')%
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
				%ifvar defineAuthorized equals('true')%
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
				%ifvar defineAuthorized equals('true')%
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
 				%ifvar defineAuthorized equals('true')%
 						<INPUT onchange="enableSaveProperties();" type="radio" name="enableAdapters" value="true"
 							%ifvar enableAdapters equals('true')% checked %endif%>Yes
 						<INPUT onchange="enableSaveProperties();" type="radio" name="enableAdapters" value="false"
 							%ifvar enableAdapters equals('false')% checked %endif%>No
 				%else%
 						%ifvar enableAdapters equals('true')% Yes %else% No %endif%
 				%endif%
 				</TR>
 				<SCRIPT>swapRows();</SCRIPT>
				

	<!- Process the Plugin Project Options here ->
	%loop pluginProperties%
				<TR>
					<TD class="heading" colspan=2>%value pluginName% Deployment Options</TD>
				</TR>
					%ifvar pluginName equals('Optimize')%
						<TR>
							<TD class="subHeading" colspan=2>The Optimize Project properties are valid only for releases older than 8.2.2</TD>
						</TR>
					%endif%
				</TR>
			%loop properties%
				<TR>
					<script> writeTD("row"); </script>%value label%</TD>
					<script> writeTD("rowdata-l", "nowrap"); </script> 
				%switch type%
				%case 'BOOLEAN'%
				%ifvar /defineAuthorized equals('true')%
					<INPUT onchange="enableSaveProperties();" type="radio" name="%value ../pluginName%$%value name%" value="TRUE"
					%ifvar value equals('TRUE')% checked %endif%>Yes
					<INPUT onchange="enableSaveProperties();" type="radio" name="%value ../pluginName%$%value name%" value="FALSE"
					%ifvar value equals('FALSE')% checked %endif%>No
				%else%
					%ifvar value equals('TRUE')%Yes%else%No%endif%
				%endif%
				%case 'STRING'%
				%ifvar /defineAuthorized equals('true')%
					<INPUT onchange="enableSaveProperties();" name="%value ../pluginName%$%value name%" value="%value value%" size="32">
				%else%
					%value value%
				%endif%
				%endswitch%
				</TR>
				<SCRIPT>swapRows();</SCRIPT>
			%endloop%
	%endloop%
	%endif%

	%ifvar defineAuthorized equals('true')%
				<TR>
					<INPUT type="hidden" name="projectName" value='%value projectName%'>
					<INPUT type="hidden" name="action" value="updateProject">
					<TD class="action" colspan="2">
						<INPUT onclick="return startProgressBar('Saving Project Properties');" align="center" 
							type="submit" VALUE="Save" name="submit2" id="save2"> </TD>
				</TR>
	%endif%
				</FORM>
			</TABLE>
		</TD>
	</TR>
</TABLE>

<script>
%ifvar defineAuthorized equals('true')%
	document.projectForm.projectDescription.focus();
%endif%

%ifvar mode equals('list')%
	%ifvar action equals('updateProject')%
	%else%
		stopProgressBar();
	%endif%
%else%
	stopProgressBar();
%endif%
</script>

</BODY>
</HTML>
