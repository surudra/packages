<HTML><HEAD>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META http-equiv="Expires" content="-1">
<SCRIPT src="webMethods.js"></SCRIPT>
<LINK href="webMethods.css" type="text/css" rel="stylesheet">
<BODY>
<SCRIPT language=JavaScript>
</SCRIPT>

<SCRIPT>
function getAsterisk(value) {
	var pwd = "";
	for (count=0; count<value.length; count++ ) {
		pwd = pwd + "*";
	}
	return w(pwd);
}

</SCRIPT>

<TABLE width=100%>
	<TR>
		<TD class="menusection-Deployer">%value key% > %ifvar mode equals('view')%Source Values%else%Target Substitutions%endif%</TD>
	</TR>
</TABLE>

<TABLE width="100%">
<!- Save -> 
%ifvar actionButton equals('Save Substitutions')%
	<!- All fields on form ->
	%invoke wm.deployer.gui.UIVarsub:saveVarSubItem%
		%include error-handler.dsp%

	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%end if%
</TABLE>

<!- Clear -> 
%ifvar actionButton equals('Clear Substitutions')%
	<!- All fields on form ->
	%invoke wm.deployer.gui.UIVarsub:removeVarSubItem%
		%include error-handler.dsp%

	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%end if%
</TABLE>

%invoke wm.deployer.gui.UIVarsub:getVarSubAdapterConnection%

<TABLE width=100%>
%comment%
	<FORM name="properties" action="under-construction.dsp" method="POST">
%endcomment%
	<FORM NAME="properties" action="varsub-connection.dsp" method="POST">
		<INPUT type="hidden" name="projectName" value="%value projectName%">
		<INPUT type="hidden" name="deploymentMapName" value="%value deploymentMapName%">
		<INPUT type="hidden" name="deploymentSetName" value="%value deploymentSetName%">
		<INPUT type="hidden" name="sourceServerAlias" value="%value sourceServerAlias%">
		<INPUT type="hidden" name="targetServerAlias" value="%value targetServerAlias%">
		<INPUT type="hidden" name="key" value="%value key%">
		<INPUT type="hidden" name="varSubItemType" value="%value varSubItemType%">
		<INPUT type="hidden" name="type" value="%value currentItem/type%">
		<INPUT type="hidden" name="packageName" value="%value packageName%">
		<INPUT type="hidden" name="mode" value="%value /mode%">

	<TR>
		<TD><IMG SRC="images/blank.gif" height=10 width=10></TD>
		<TD>
		<TABLE class="tableForm">
			<tr>
				<td class="heading" colspan="2">Details for %value key%</td>
			</tr>

		%ifvar /mode equals('view')%
			<tr><td class="evenrow">Connection Type</td>
				<td class="evenrowdata-l"> %value /currentItem/type% </td>
			</tr>

			<tr><td class="oddrow">Package Name</td>
				<td class="oddrowdata-l"> %value packageName% </td>
			</tr>
		%endif%

			<!- This begins the actual Adatper Connection fields ->
			<tr>
				<td class="heading" colspan="2">Connection Properties</td>
			</tr>

	<SCRIPT> resetRows(); </SCRIPT>
			<!- Iterate over parameters document and paint fields ->
	%loop /currentItem/parameters%
			<tr>
				<SCRIPT> writeTD("row"); </SCRIPT> %value displayName% </TD>
				<SCRIPT> writeTD("%ifvar /mode equals('view')%rowdata-l%else%row-l%endif%"); </SCRIPT>
		%ifvar /mode equals('view')%
			%ifvar isPassword equals('true')% ******
			%else%
					<script> xl("%value value%"); </script>
			%endif%
		%else%
					<input id="parameters.%value systemName%" name="parameters.%value systemName%" 
			%ifvar isPassword equals('true')% 
						type="password"
			%endif%
						size=30>
		%endif%
				</td>
			</tr>
		<SCRIPT>swapRows();</SCRIPT>
	%endloop%

	%ifvar /mode equals('edit')%
		%loop -struct /varSubItem/parameters%
		<SCRIPT>
			var p = document.getElementById("parameters.%value $key%");
			p.value = "%value%";
		</SCRIPT>
		%endloop%
	%endif%

			<tr>
				<td class="heading" colspan="2">Connection Management Properties</td>
			</tr>

	<SCRIPT> resetRows(); </SCRIPT>
	<!- Iterate over parameters document and paint fields ->
	%loop /currentItem/connectionManagerProperties%
			<tr>
				<SCRIPT> writeTD("row"); </SCRIPT> %value displayName% </TD>
				<SCRIPT> writeTD("%ifvar /mode equals('view')%rowdata-l%else%row-l%endif%"); </SCRIPT>
		%ifvar /mode equals('view')%
					<script> xl("%value value%"); </script>
		%else%
					<input id="connectionManagerProperties.%value systemName%" 
						name="connectionManagerProperties.%value systemName%" size=30>
		%endif%
				</td>
			</tr>
		<SCRIPT>swapRows();</SCRIPT>
	%endloop%

	%ifvar /mode equals('edit')%
		%loop -struct /varSubItem/connectionManagerProperties%
		<SCRIPT>
			var p = document.getElementById("connectionManagerProperties.%value $key%");
			p.value = "%value%";
		</SCRIPT>
		%endloop%
	%endif%

			%ifvar /mode equals('edit')%
			<tr>
				<td colspan="1" class="action">
				<input name="actionButton" type="submit" value="Save Substitutions"> </td>
				<td colspan="1" class="action">
				<input name="actionButton" type="submit" value="Clear Substitutions"> </td>
			</tr>
			%endif%
		</TABLE>
		</td>
	</TR>
	</FORM>
</TABLE>
%endinvoke%

</BODY>
</HTML>
