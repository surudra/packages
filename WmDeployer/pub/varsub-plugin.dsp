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
		<TD class="menusection-Deployer">%value key% > %ifvar mode equals('view')%Source Values%else%Target Values%endif%</TD>
	</TR>
</TABLE>

<TABLE width="100%">
<!- Save -> 
%ifvar actionButton equals('Save Values')%
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
%ifvar actionButton equals('Clear Values')%
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

%invoke wm.deployer.gui.UIVarsub:getVarSubPluginObject%

<TABLE width=100%>
%comment%
	<FORM name="properties" action="under-construction.dsp" method="POST">
%endcomment%
	<FORM NAME="properties" action="varsub-plugin.dsp" method="POST">
		<INPUT type="hidden" name="projectName" value="%value projectName%">
		<INPUT type="hidden" name="deploymentMapName" value="%value deploymentMapName%">
		<INPUT type="hidden" name="deploymentSetName" value="%value deploymentSetName%">
		<INPUT type="hidden" name="sourceServerAlias" value="%value sourceServerAlias%">
		<INPUT type="hidden" name="targetServerAlias" value="%value targetServerAlias%">
		<INPUT type="hidden" name="pluginType" value="%value pluginType%">
		<INPUT type="hidden" name="varSubItemType" value="%value varSubItemType%">
		<INPUT type="hidden" name="key" value="%value key%">
		<INPUT type="hidden" name="mode" value="%value /mode%">

	<TR>
		<TD><IMG SRC="images/blank.gif" height=10 width=10></TD>
		<TD>
		<TABLE class="tableForm">
			<tr>
		%ifvar /mode equals('view')%
				<td class="heading" colspan="2">Source Values</td>
		%else%
				<td class="heading" colspan="2">Target Values</td>
		%endif%
			</tr>

			<SCRIPT> resetRows(); </SCRIPT>

	%loop /currentItems%
			<tr>
				<SCRIPT> writeTD("row"); </SCRIPT> %value label% </TD>
				<SCRIPT> writeTD("%ifvar /mode equals('view')%rowdata-l%else%row-l%endif%"); </SCRIPT>
		%ifvar /mode equals('view')%
			<script> xl("%value value%"); </script>
		%else%
			%switch type%
			%case 'BOOLEAN'%
				<input id="%value item%" name="varSubItems.%value item%" type="radio" value="TRUE">TRUE
				<input id="%value item%" name="varSubItems.%value item%" type="radio" value="FALSE">FALSE
			%case 'STRING'%
				<input id="%value item%" name="varSubItems.%value item%" size=30>
			%endswitch%
		%endif%
				</td>
			</tr>
		<SCRIPT>swapRows();</SCRIPT>
	%endloop%

	%ifvar /mode equals('edit')%
		%loop /varSubItems%
		<SCRIPT>
			var p = document.properties.%value item%;
			if (p != null) {
				// This is a cheesy way to determin boolean type
				%ifvar type equals('BOOLEAN')%
					%ifvar value equals('TRUE')%
						p[0].checked = true;
					%else%
						p[1].checked = true;
					%endif%
				%else%
					p.value = "%value value%";
				%endif%
			}
		</SCRIPT>
		%endloop%

	<tr>
		<td colspan="1" class="action">
		<input name="actionButton" type="submit" value="Save Values"> </td>
		<td colspan="1" class="action">
		<input name="actionButton" type="submit" value="Clear Values"> </td>
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
