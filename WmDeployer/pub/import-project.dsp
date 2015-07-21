<HTML><HEAD>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META http-equiv="Expires" content="-1">
<SCRIPT src="webMethods.js"></SCRIPT>
<LINK href="webMethods.css" type="text/css" rel="stylesheet">
<BODY>

<SCRIPT language=JavaScript>

function onImport(buildName) {

	var rel = buildName.options[buildName.selectedIndex].value;

	if (confirm("About to Import Project Build '" + rel + "'.  Continue?")) {
			return true;
	}

	return false;
}

</SCRIPT>

<TABLE width="100%">
	<TR>
		<TD class="menusection-DeployerTools" colspan="4"> Import Build
		</TD>
	</TR>

</TABLE>

<TABLE width="100%">
%ifvar action equals('import')%
	<!- buildName*  ->
	%invoke wm.deployer.gui.UIReplicate:importBuild%
		%include error-handler.dsp%
	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%end if%

</TABLE>

<!- Determine if this user is empowered to project creation/copy stuff ->
%invoke wm.deployer.UIAuthorization:isAuthorized%
%endinvoke%

<TABLE>
	<TR>
		<TD colspan="2">
			<UL>
				<LI><A href="import-project.dsp">Refresh this Page</A>
			</UL>
		</TD>
	</TR>

	<TR>
		<TD><IMG height="10" src="images/blank.gif" width="20"></TD>
		<TD valign="top">
			<TABLE width="100%" class="tableForm">
				<TR>
					<TD class="heading" colspan="2">Select a Project Build to Import</TD>
				</TR>

				<FORM name=myForm method="POST" action="import-project.dsp">
					<INPUT type="hidden" value="%value projectName%" name="projectName">
           <INPUT type="hidden" VALUE="import" name="action">

				%invoke wm.deployer.gui.UIReplicate:listImportBuilds%
					%ifvar importBuilds -notempty%
				<TR>
					%ifvar /isAuth equals('true')% 
					<TD nowrap width="25%" class="oddrow">Project Build</TD>

					<TD class="oddrow-l">
						<P><SELECT size="1" name="buildName">
						%loop importBuilds%
							<OPTION VALUE="%value%">%value%</OPTION>
						%endloop%
						</SELECT></P>
					</TD>
					%else%
        	<TR>
        		<TD colspan="5"><FONT color="red">* No Builds authorized for current User.</FONT></TD>
        	</TR>		
					%endif%
					
				</TR>

					%ifvar /isAuth equals('true')% 
				<TR>
					<TD class="action" colspan="2" nowrap>
						<INPUT onclick="return onImport(buildName);" type="submit" value="Import">
					</TD>
				</TR>
				  %endif%

					%else%
				<TR>
					<TD colspan=2 class="oddrow-l"><FONT color="red"> No Builds to Import </FONT>
					</TD>
				</TR>
					%endif%
				%endinvoke%

				</FORM>
			</TABLE>
		</TD>
	</TR>
</TABLE>

</BODY>
</HTML>
