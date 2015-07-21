<HTML><HEAD>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META http-equiv="Expires" content="-1">
<LINK href="webMethods.css" type="text/css" rel="stylesheet">
<SCRIPT src="webMethods.js"></SCRIPT>
<BODY>

<SCRIPT language=JavaScript>
function enableSaveDescription() {
	document.getElementById("saveDescription").disabled = false;
}
</SCRIPT>

<TABLE width="100%">
    <TR>
      <TD class="menusection-Deployer" colspan="2">%value deploymentName% > Properties</TD>
    </TR>
</TABLE>

<TABLE width="100%">

%ifvar action equals('updateDeployment')%
	<!- projectName*, deploymentName*, deploymentDescription* ->
	%invoke wm.deployer.gui.UIDeployment:updateDeployment%
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
				<LI><A onclick="return startProgressBar();" href="edit-deployment.dsp?projectName=%value projectName%&deploymentName=%value deploymentName%">Refresh this Page</A></LI>
			</UL>
		</TD>
	</TR>

	<TR>
		<TD><IMG height="0" src="images/blank.gif" width="5" border="0"></TD>
		<TD>
			<TABLE class="tableView" width="100%">
				<TR>
					<TD class="heading" colspan=2>Deployment Properties</TD>
				</TR>

  %invoke wm.deployer.gui.UIDeployment:getDeployment%
				<FORM name="propertiesForm" method="POST" action="edit-deployment.dsp">
			  <SCRIPT>resetRows();</SCRIPT>
				<TR>
					<script> writeTD("row"); </script>Name</TD>
					<script> writeTD("rowdata-l"); </script> %value deploymentName%</TD>
				</TR>

				<SCRIPT>swapRows();</SCRIPT>
				<TR>
					<script> writeTD("row"); </script>Description</TD>
					<script> writeTD("rowdata-l"); </script> 
					%ifvar /deployAuthorized equals('true')%
						<INPUT onchange="enableSaveDescription();" name="deploymentDescription" value="%value deploymentDescription%" size="32">
					%else%
						%value deploymentDescription%
					%endif%
					</TD>
				</TR>
                %ifvar projectType equals('Runtime')%		
				<SCRIPT>swapRows();</SCRIPT>
				<TR>
					<script> writeTD("row"); </script>Project Build</TD>
					<script> writeTD("rowdata-l"); </script> %value buildName%</TD>
				</TR>
               %endif%
				<SCRIPT>swapRows();</SCRIPT>
				<TR>
					<script> writeTD("row"); </script>Deployment Map</TD>
					<script> writeTD("rowdata-l"); </script> %value mapSetName%</TD>
				</TR>

				<SCRIPT>swapRows();</SCRIPT>
				<TR>
					<script> writeTD("row"); </script>Checkpoint Exists</TD>
					<script> writeTD("rowdata-l"); </script>
					%ifvar checkpointed equals('true')%Yes%else%No%endif%</TD>
				</TR>

			%ifvar /deployAuthorized equals('true')%
				<TR>
					<INPUT type="hidden" name="projectName" value='%value projectName%'>
					<INPUT type="hidden" name="deploymentName" value='%value deploymentName%'>
					<INPUT type="hidden" name="action" value="updateDeployment">
					<TD class="action" colspan="2">
						<INPUT id="saveDescription" onclick="return startProgressBar();" align="center" type="submit" VALUE="Save" name="submit"> </TD>
				</TR>
			%endif%
				</FORM>

			</TABLE>
		</TD>
	</TR>

<!- projectName*, deploymentName* ->
%invoke wm.deployer.gui.UIDeployment:listDeploymentReportsChronologically%
	
<!-  Deployment History ->

	<TR>
		<TD><IMG height="10" src="images/blank.gif" width="0" border="0"></TD>
	</TR>

	<TR>
		<TD><IMG height="0" src="images/blank.gif" width="10" border="0"></TD>
		<TD>
			<SCRIPT>resetRows();</SCRIPT>
			<TABLE class="tableView" id="warnings" width="100%">
				<TR>
					<TD class="heading" colspan="4">Deployment History</TD>
				</TR>

	%ifvar reports -notempty%
				<SCRIPT>swapRows();</SCRIPT>
				<TR>
					<TD class="oddcol">Report</TD>
					<TD class="oddcol">Status</TD>
					<TD class="oddcol">Report Type</TD>
					<TD class="oddcol">Report Created</TD>
				</TR>

		%loop reports%
				<SCRIPT>swapRows();</SCRIPT>
				

				<TR>
					<SCRIPT>writeTD('rowdata');</SCRIPT> 
						<A target="_blank" class="imagelink" href="%value reportName%">
						<IMG alt="View this Report in a separate browser." src="images/edit.gif"  border="no"></A>
					</TD>
					
					<SCRIPT>writeTD('rowdata');</SCRIPT>
						%ifvar reportStatus equals('0')%		
							<IMG alt="Success report" src="images/green_check.gif" border="0" width="13" height="13">
						%endif%	
								
						%ifvar reportStatus equals('1')%
							<IMG alt="Warning report" src="images/warning.gif" border="0" width="13" height="16">
						%endif%              																
						
						%ifvar reportStatus equals('2')%
							<IMG alt="Error report" src="images/dependency.gif" border="0" width="13" height="13">
						%endif%              																
					</TD>
					
					<SCRIPT>writeTD('rowdata');</SCRIPT> %value reportType% </TD>

					<SCRIPT>writeTD('rowdata');</SCRIPT> %value reportTimestamp% </TD>
				</TR>
		%endloop%

	%else%
				<TR>
					<TD class="oddcol-l" colspan="4">No Deployment History</TD>
				</TR>
	%endif%

			</TABLE>
		</TD>
	</TR>

%endinvoke%


</TABLE>
%endinvoke getProjectInfo%


<script>
%ifvar /deployAuthorized equals('true')%
	document.propertiesForm.deploymentDescription.focus();
%endif%

stopProgressBar();
</script>

</BODY>
</HTML>
