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
function confirmClearSubstitution() {
		return confirm("[DEP.0002.0169] Do you want to clear all substitutions? You cannot undo this action.");
	}
</SCRIPT>

<TABLE width=100%>
	<TR>
		<TD class="menusection-Deployer">%value key% > Target Substitutions and Source Values</TD>
	</TR>
</TABLE>

<TABLE width="100%">


<!- SaveMultiple -> 
%ifvar action equals('saveMultiple')%
	<!- All fields on form ->
	%invoke wm.deployer.gui.UIVarsub:saveVarSubItemForMultipleServers%
		%include error-handler.dsp%

	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%end if%



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

%ifvar mode equals('edit')%
%invoke wm.deployer.gui.UIVarsub:getVarSubAdapterListener%
	%include error-handler.dsp%
	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%end if%

%ifvar /mode equals('assetListing')%
%invoke wm.deployer.gui.UIVarsub:getVarSubAdapterListenerByAsset%
	%include error-handler.dsp%
	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%end if%

<TABLE width=100%>
	<FORM NAME="properties" action="varsub-listener-page.dsp" method="POST">
	
		<INPUT type="hidden" name="projectName" value="%value projectName%">
		<INPUT type="hidden" name="deploymentMapName" value="%value deploymentMapName%">
		<INPUT type="hidden" name="deploymentSetName" value="%value deploymentSetName%">
		<INPUT type="hidden" name="sourceServerAlias" value="%value sourceServerAlias%">
		<INPUT type="hidden" name="targetServerAlias" value="%value targetServerAlias%">
		<INPUT type="hidden" name="key" value="%value key%">
		<INPUT type="hidden" name="varSubItemType" value="%value varSubItemType%">
		<INPUT type="hidden" name="type" value="%value currentItem/type%">
		<INPUT type="hidden" name="packageName" value="%value packageName%">
		<INPUT type="hidden" name="mode" value="edit">
		<INPUT type="hidden" name="action">
		<INPUT type="hidden" name="pluginType" value="%value pluginType%">
		<INPUT type="hidden" name="service" value="%value service%">
		<INPUT type="hidden" name="listOfTargetServerAlias" value="%value listOfTargetServerAlias%">
		
	<TR>
		<TD><IMG SRC="images/blank.gif" height=10 width=10></TD>
		<TD>
		<TABLE class="tableForm">
			<tr>
				<td class="heading" colspan="2">Details for %value key%</td>
			</tr>

			<tr><td class="evenrow">Listener Type</td>
				<td class="evenrowdata-l"> %value /currentItem/type% </td>
			</tr>

			<tr><td class="oddrow">Package Name</td>
				<td class="oddrowdata-l"> %value /currentItem/packageName% </td>
			</tr>
			
			<tr><td class="oddrow">Connection name</td>
				<td class="oddrowdata-l"> %value /currentItem/connDataNodeName% </td>
			</tr>
			
			 <tr><td class="oddrow">Retry Limit</td>
				<td class="%ifvar /mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
					<input name="retryLimit" value="%value /varSubItem/parameters/retryLimit%"><b>%value /currentItem/retryLimit%</b>
				</td>
			</tr>	
			
			<!--
			<tr><td class="oddrow">Retry Backoff Timeout</td>
			<td class="oddrowdata-l"> <input id="parameters.%value systemName%" name="parameters.%value systemName%" size=30> <td class="oddrowdata">  %value /currentItem/retryBackoffTimeout% </td> </td> 
			<!--	<td class="oddrowdata-1"> %value /currentItem/retryBackoffTimeout% </td> -->
			</tr>
	
			<tr><td class="oddrow">Retry Backoff Timeout</td>
				<td class="%ifvar /mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
					<input name="retryBackoffTimeout" value="%value /varSubItem/parameters/retryBackoffTimeout%"><b>%value /currentItem/retryBackoffTimeout%</b>
				</td>
			</tr>		

			<!- This begins the actual Adatper Listener fields ->
			<tr>
				<td class="heading" colspan="2">Listener Properties </td>
			</tr>

	<SCRIPT> resetRows(); </SCRIPT>
			<!- Iterate over parameters document and paint fields ->
	%loop /currentItem/parameters%
			<tr>
				<SCRIPT> writeTD("row"); </SCRIPT> %value displayName% </TD>
				<SCRIPT> writeTD("row-l"); </SCRIPT>
		%ifvar /mode equals('view')%
			%ifvar isPassword equals('true')% ******
			%else%
					<script> xl("%value defaultValue%"); </script>
			%endif%
		%else%
					<input id="parameters.%value systemName%" name="parameters.%value systemName%" 
			%ifvar isPassword equals('true')% 
						type="password"
			%endif%
						size=30>
						%ifvar isPassword equals('true')% ******
			%else%
					<script> xl("%value defaultValue%"); </script>
		%endif%
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


	<SCRIPT> resetRows(); </SCRIPT>

			%ifvar /mode equals('edit')%
			<tr>
				<td colspan="1" class="action">
				<input name="actionButton" type="submit" value="Save Substitutions"> </td>
				<td colspan="1" class="action">
				<input onclick="return confirmClearSubstitution();" name="actionButton" type="submit" value="Clear Substitutions"> </td>
			</tr>
		</TABLE>
		</td>
	</TR>
	</FORM>
</TABLE>

</BODY>
</HTML>
