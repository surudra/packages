<HTML><HEAD>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META http-equiv="Expires" content="-1">
<SCRIPT src="webMethods.js"></SCRIPT>
<LINK href="webMethods.css" type="text/css" rel="stylesheet">
<BODY>
<SCRIPT language=JavaScript>
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

%invoke wm.deployer.gui.UIVarsub:getVarSubAdapterNotification%

<TABLE width=100%>
%comment%
	<FORM name="properties" action="under-construction.dsp" method="POST">
%endcomment%
	<FORM NAME="properties" action="varsub-notification.dsp" method="POST">
		<INPUT type="hidden" name="projectName" value="%value projectName%">
		<INPUT type="hidden" name="deploymentMapName" value="%value deploymentMapName%">
		<INPUT type="hidden" name="deploymentSetName" value="%value deploymentSetName%">
		<INPUT type="hidden" name="sourceServerAlias" value="%value sourceServerAlias%">
		<INPUT type="hidden" name="targetServerAlias" value="%value targetServerAlias%">
		<INPUT type="hidden" name="key" value="%value key%">
		<INPUT type="hidden" name="varSubItemType" value="%value varSubItemType%">
		<INPUT type="hidden" name="packageName" value="%value packageName%">
		<INPUT type="hidden" name="mode" value="%value /mode%">

	<TR>
		<TD><IMG SRC="images/blank.gif" height=10 width=10></TD>
		<TD>
		<TABLE class="tableForm">

			<tr>
				<td class="heading" colspan="2">Details for %value key%</td>
			</tr>

			<!- Interval ->
			<tr><td class="evenrow">Interval (seconds) </td>
				<td class="%ifvar /mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
			%ifvar /mode equals('view')%
				%value /currentItem/notificationInterval%
			%else%
					<input name="notificationInterval" value="%value /varSubItem/notificationInterval%" size=20>
			%endif%
				</td>
			</tr>

			<!- Overlap (boolean) ->
			<tr><td class="oddrow">Overlap </td>
				<td class="%ifvar /mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
			%ifvar /mode equals('view')%
				%value /currentItem/notificationOverlap%
			%else%
					<SELECT size="1" name="notificationOverlap">
						<OPTION VALUE=""></OPTION>
						<OPTION %ifvar /varSubItem/notificationOverlap equals('true')% selected %endif% value="true">true</OPTION>
						<OPTION %ifvar /varSubItem/notificationOverlap equals('false')% selected %endif% value="false">false</OPTION>
					</SELECT>
			%endif%
				</td>
			</tr>

			<!- Immediate (boolean) ->
			<tr><td class="evenrow">Immediate </td>
				<td class="%ifvar /mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
			%ifvar /mode equals('view')%
				%value /currentItem/notificationImmediate%
			%else%
					<SELECT size="1" name="notificationImmediate">
						<OPTION VALUE=""></OPTION>
						<OPTION %ifvar /varSubItem/notificationImmediate equals('true')% selected %endif% value="true">true</OPTION>
						<OPTION %ifvar /varSubItem/notificationImmediate equals('false')% selected %endif% value="false">false</OPTION>
					</SELECT>
			%endif%
				</td>
			</tr>

			%ifvar /mode equals('edit')%
			<tr>
				<td colspan="1" class="action">
				<input type="submit" name="actionButton" value="Save Substitutions"> </td>
				<td colspan="1" class="action">
				<input type="submit" name="actionButton" value="Clear Substitutions"> </td>
			</tr>
			%endif%
		</table>
		</td>
	</TR>
	</FORM>
</TABLE>
%endinvoke%
</BODY>
</HTML>
