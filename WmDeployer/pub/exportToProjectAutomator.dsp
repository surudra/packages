<HTML><HEAD>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META http-equiv="Expires" content="-1">
<LINK href="webMethods.css" type="text/css" rel="stylesheet">
<SCRIPT src="webMethods.js"></SCRIPT>
</HEAD>
<BODY>

<SCRIPT language=JavaScript>
</SCRIPT>

<TABLE width="100%">
	<TR>
		<TD class="menusection-DeployerTools" colspan="4"> Export Project to Project Automator Specification
		</TD>
	</TR>
</TABLE>
<!- Determine if this user is empowered to project creation/copy stuff ->
  %invoke wm.deployer.UIAuthorization:isAuthorized%
  %endinvoke%
<TABLE width="100%">  
  %ifvar action equals('exportToProjectAutomator')%
  	%invoke wm.deployer.Util:exportProjectToProjectAutomatorSpecification%
  		%include error-handler.dsp%
  			<script>window.open("projects/%value encodedProjectName%/%value encodedProjectName%_ProjectAutomator.xml");</script>
  	%onerror%
  		%loop -struct%
  			<tr><td>%value $key%=%value%</td></tr>
  		%endloop%
  	%endinvoke%
  %endif%
</TABLE>

<FORM name="exportProjectToProjectAutomator" method="POST" action="exportToProjectAutomator.dsp">
<TABLE width="100%">
	<BR>

	<TR>		
		<TD valign="top">
		
			<TABLE width="100%" class="tableForm">
				%ifvar /isAuth equals('true')% 
				<TR>
					<TD class="heading" colspan="2">Export Project to Project Automator Specification</TD>
				</TR>

				<INPUT type="hidden" VALUE="exportToProjectAutomator" name="action">	 
				<INPUT type="hidden" VALUE="true" name="exportedFromUI">	 
				 
				<SCRIPT>resetRows();</SCRIPT>				
				<TR>
					<SCRIPT>writeTD('row-l', 'width="25%" style="text-align:right;"');</SCRIPT>Project</TD>
					
					<SCRIPT>writeTD('row-l');swapRows();</SCRIPT> 
					<select name="projectName">
					%invoke wm.deployer.gui.UIProject:listProjects%
						%ifvar projects -notempty%
							%loop projects%
								<option value="%value projectName%">%value projectName%</option>
							%endloop projects%
						%endif%
					%endinvoke%
					</select>
					</TD>
				</TR>

				<TR>
					<SCRIPT>writeTD('row-l', 'width="25%" style="text-align:right;"');</SCRIPT>Export Alias Definition</TD>
					
					<SCRIPT>writeTD('row-l');swapRows();</SCRIPT> <input type="checkbox" name="exportAliasDefinition" id="exportAliasDefinition" checked="checked"/>
					</TD>
				</TR>
				<TR>
					<SCRIPT>writeTD('row-l', 'width="25%" style="text-align:right;"');</SCRIPT>Export Deployment and Deletion Set Definition</TD>
					
					<SCRIPT>writeTD('row-l');swapRows();</SCRIPT> <input type="checkbox" name="exportDeploymentSetDefinition" id="exportDeploymentSetDefinition" checked="checked"/>
					</TD>
				</TR>
				<TR>
					<SCRIPT>writeTD('row-l', 'width="25%" style="text-align:right;"');</SCRIPT>Export Build Definition</TD>
					
					<SCRIPT>writeTD('row-l');swapRows();</SCRIPT> <input type="checkbox" name="exportBuildDefinition" id="exportBuildDefinition" checked="checked"/>
					</TD>
				</TR>
				<TR>
					<SCRIPT>writeTD('row-l', 'width="25%" style="text-align:right;"');</SCRIPT>Export Map Definition</TD>
					
					<SCRIPT>writeTD('row-l');swapRows();</SCRIPT> <input type="checkbox" name="exportMapDefinition" id="exportMapDefinition" checked="checked"/>
					</TD>
				</TR>
				<TR>
					<SCRIPT>writeTD('row-l', 'width="25%" style="text-align:right;"');</SCRIPT>Export Deployment Candidate Definition</TD>
					
					<SCRIPT>writeTD('row-l');swapRows();</SCRIPT> <input type="checkbox" name="exportDeploymentCandidateDefinition" id="exportDeploymentCandidateDefinition" checked="checked"/>
					</TD>
				</TR>
				%endif%

		</TD>
	</TR>
</TABLE>

<TABLE width="100%" class="action">
    <TR>
		<TD >					
			<INPUT type="submit" style="width:150" align="center" value="Export To Project Automator" >
		</TD>
	</TR>
</TABLE>
</FORM>
</BODY>
</HTML>
