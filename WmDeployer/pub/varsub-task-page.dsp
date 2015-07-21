<HTML><HEAD>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META http-equiv="Expires" content="-1">
<SCRIPT src="webMethods.js"></SCRIPT>
<LINK href="webMethods.css" type="text/css" rel="stylesheet">
<BODY>
<SCRIPT language=JavaScript>

function onSave() {

	var value = document.schedule.persistJob.value;

	if ((value != 'true') && (value != 'false')) {
		alert("Valid values are 'true' and 'false'.");
		document.schedule.persistJob.focus();
		return false;
	}

	value = document.schedule.runInCluster.value;

	if ((value != 'true') && (value != 'false')) {
		alert("Valid values are 'true' and 'false'.");
		document.schedule.runInCluster.focus();
		return false;
	}

	return true;
}
function confirmClearSubstitution() {
		return confirm("[DEP.0002.0169] Do you want to clear all substitutions? You cannot undo this action.");
	}
</SCRIPT>

<TABLE width=100%>
	<TR>
		<TD class="menusection-Deployer">%value service% > Target Substitutions and Source Values</TD>
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


<!-- Save --> 
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

<!-- Clear --> 
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

%ifvar /mode equals('edit')%
	%invoke wm.deployer.gui.UIVarsub:getVarSubScheduledService%
	%include error-handler.dsp%
	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%end if%

%ifvar /mode equals('assetListing')%
	%invoke wm.deployer.gui.UIVarsub:getVarSubScheduledServiceByAsset%
	%include error-handler.dsp%
	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%end if%


<TABLE width=100%>
	%comment%
	<FORM name="schedule" action="under-construction.dsp" method="POST">
	%endcomment%
	<FORM NAME="properties" action="varsub-task-page.dsp" method="POST">
		<INPUT type="hidden" name="projectName" value="%value projectName%">
		<INPUT type="hidden" name="deploymentMapName" value="%value deploymentMapName%">
		<INPUT type="hidden" name="deploymentSetName" value="%value deploymentSetName%">
		<INPUT type="hidden" name="sourceServerAlias" value="%value sourceServerAlias%">
		<INPUT type="hidden" name="targetServerAlias" value="%value targetServerAlias%">
		<INPUT type="hidden" name="key" value="%value key%">
		<INPUT type="hidden" name="varSubItemType" value="%value varSubItemType%">
		<INPUT type="hidden" name="type" value="%value currentItem/type%">
		<INPUT type="hidden" name="mode" value="%value mode%">
		<INPUT type="hidden" name="service" value="%value service%">
		<INPUT type="hidden" name="pluginType" value="%value pluginType%">
		<INPUT type="hidden" name="action">
		<INPUT type="hidden" name="listOfTargetServerAlias" value="%value listOfTargetServerAlias%">

		<TR>
			<TD><IMG SRC="images/blank.gif" width=10></TD>
			<TD><TABLE class="tableForm">

				<TR><TD class="heading" colspan=6>Service Information</td></tr>

				<tr>
					<td class="oddrow" colspan="1">folder.subfolder:service</td>
					<td colspan=5 class="oddrowdata-l"> %value /currentItem/service%
					</td>
				</tr>

				<tr>
					<td class="evenrow" colspan="1">Run As User</td>
					<td colspan="5" class="%ifvar /mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
				
					<INPUT NAME="runAsUser" size=30 value="%value /varSubItem/runAsUser%"><b>%value /currentItem/runAsUser%</b></input> 
				
					</td>
				</tr>
				
				<tr>
					<td class="evenrow" colspan="1">Target Node</td>
					<td colspan="5" class="%ifvar /mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
				
					<INPUT NAME="target" size=30 value="%value /varSubItem/target%"><b>%value /currentItem/target%</b></input> 
				
					</td>
				</tr>

				<tr>
					<td class="oddrow" colspan="1">Persist After Restart</td>
					<td class="%ifvar /mode equals('view')%oddrowdata-l%else%oddrow-l%endif%" colspan="5">
				
					<input name="persistJob" size=10 value ="%value /varSubItem/persistJob%"> true/false <b>%value /currentItem/persistJob%</b></input>
				
					</td>
				</tr>

				<tr>
					<td class="evenrow" colspan="1">Scheduled for Cluster</td>
					<td class="%ifvar /mode equals('view')%evenrowdata-l%else%evenrow-l%endif%" colspan="5">
				
					<input name="runInCluster" size=10 value="%value /varSubItem/runInCluster%"> true/false <b>%value /currentItem/runInCluster%</b>
				
					</td>
				</tr>

			%switch /currentItem/type%
			%case 'once'%
				<tr><td class="subHeading" colspan=6>One-Time Tasks</td></tr>

				<tr>
					<td class="oddrow" colspan="1">Date</td>
					<td class="%ifvar /mode equals('view')%oddrowdata-l%else%oddrow-l%endif%" colspan="5">
				
						<input name="date" size=12 value="%value /varSubItem/oneTimeTaskInfo/date%">&nbsp;YYYY/MM/DD <b>%value /currentItem/oneTimeTaskInfo/date%</b></input>
				
					</td>
				</tr>

				<tr>
					<td class="evenrow" colspan="1">Time</td>
					<td class="%ifvar /mode equals('view')%evenrowdata-l%else%evenrow-l%endif%" colspan="5">
				
						<input name="time" size=12 value="%value /varSubItem/oneTimeTaskInfo/time%">&nbsp;HH:MM:SS <b> %value /currentItem/oneTimeTaskInfo/time% </b></input>
				
					</td>
				</tr>

			%case 'repeat'%
				<tr><td class="subHeading" colspan=6>Repeating Tasks With a Simple Interval</td></tr>

				<tr>
					<td colspan="1" class="oddrow">Interval</td>
					<td colspan="5" class="%ifvar /mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
				
					<input name="interval" size=12 value="%value /varSubItem/repeatingTaskInfo/interval%"> <b>%value /currentItem/repeatingTaskInfo/interval% seconds</b></input>
				
					</td>
				</tr>

				<tr>
					<td colspan="1" class="evenrow">Repeating</td>
					<td colspan="5" class="%ifvar /mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
				
					<input name="doNotOverlap" size=12 value="%value /varSubItem/repeatingTaskInfo/doNotOverlap%"> true/false <b>%value /currentItem/repeatingTaskInfo/doNotOverlap%</b></input>
			
					</td>
				</tr>

			%case 'complex'%
				<tr><td class="subHeading" colspan=6>Repeating Tasks with Complex Schedules</td></tr>

				<tr>
					<td colspan="1" class="oddrow" >Start Date</td>
					<td colspan="5" class="%ifvar /mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
				
					<input name="startDate" value="%value /varSubItem/complexTaskInfo/startDate%" size=12 > YYYY/MM/DD <b>%value /currentItem/complexTaskInfo/startDate%</b></input>
				
					</td>
				</tr>

				<tr>
					<td colspan="1" class="evenrow" >Start Time</td>
					<td colspan="5" class="%ifvar /mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
				
					<input name="startTime" value="%value /varSubItem/complexTaskInfo/startTime%" size=12 > HH:MM:SS <b> %value /currentItem/complexTaskInfo/startTime% </b></input>
				
					</td>
				</tr>

				<tr>
					<td colspan="1" class="oddrow" >End Date</td>
					<td colspan="5" class="%ifvar /mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
				
					<input name="endDate" value="%value /varSubItem/complexTaskInfo/endDate%" size=12 > YYYY/MM/DD <b> %value /currentItem/complexTaskInfo/endDate% </b></input>
				
					</td>
				</tr>

				<tr>
					<td colspan="1" class="evenrow" >End Time</td>
					<td colspan="5" class="%ifvar /mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
				
					<input name="endTime" value="%value /varSubItem/complexTaskInfo/endTime%" size=12 > HH:MM:SS <b> %value /currentItem/complexTaskInfo/endTime% </b></input>
				
					</td>
				</tr>

				%ifvar /mode equals('view')%
				<tr>
					<td class="oddrow" >Months</td>
					<td class="oddrowdata-l" >
						<SCRIPT>
						var first = 1;
						%loop /currentItem/complexTaskInfo/moMask% 
							%ifvar selected -notempty% 
								if (first) { first=0; w("%value name%"); }
								else  w(",&nbsp;%value name%"); 
							%endif%
						%endloop%
						</SCRIPT>
					</td>
				</tr>
				<tr>
					<td class="evenrow" >Days</td>
					<td class="evenrowdata-l" >
						<SCRIPT>
						var first = 1;
						%loop /currentItem/complexTaskInfo/dayMoMask% 
							%ifvar selected -notempty% 
								if (first) { first=0; w("%value name%"); }
								else  w(",&nbsp;%value name%"); 
							%endif%
						%endloop%
						</SCRIPT>
					</td>
				</tr>
				<tr>
					<td class="oddrow" >Weekly Days</td>
					<td class="oddrowdata-l" >
						<SCRIPT>
						var first = 1;
						%loop /currentItem/complexTaskInfo/dayWkMask% 
							%ifvar selected -notempty% 
								if (first) { first=0; w("%value name%"); }
								else  w(",&nbsp;%value name%"); 
							%endif%
						%endloop%
						</SCRIPT>
					</td>
				</tr>
				<tr>
					<td class="evenrow" >Hours</td>
					<td class="evenrowdata-l" >
						<SCRIPT>
						var first = 1;
						%loop /currentItem/complexTaskInfo/hourMask% 
							%ifvar selected -notempty% 
								if (first) { first=0; w("%value name%"); }
								else  w(",&nbsp;%value name%"); 
							%endif%
						%endloop%
						</SCRIPT>
					</td>
				</tr>
				<tr>
					<td class="oddrow" >Minutes</td>
					<td class="oddrowdata-l" >
						<SCRIPT>
						var first = 1;
						%loop /currentItem/complexTaskInfo/minMask% 
							%ifvar selected -notempty% 
								if (first) { first=0; w("%value name%"); }
								else  w(",&nbsp;%value name%"); 
							%endif%
						%endloop%
						</SCRIPT>
					</td>
				</tr>

				%else%
				<tr>
					<td class="oddrow" rowspan="3" >Run Mask</td><td class="oddrow-l" >Months</td><td class="oddrow-l" >Days</td><td class="oddrow-l" >Weekly Days</td><td class="oddrow-l" >Hours</td><td class="oddrow-l" >Minutes</td>
				</tr>

				<tr>
					<td class="oddrow-l" >
					<select name=months size=7 multiple>
					%loop /varSubItem/complexTaskInfo/moMask%<option value="%value idx%" %value selected%>%value name%</option>%endloop%
						</select>
					</td>

					<td class="oddrow-l">
					<select name="daysOfMonth" size=7 multiple>
					%loop /varSubItem/complexTaskInfo/dayMoMask%<option value="%value idx%" %value selected%>%value name%</option>%endloop%
					</select>
					</td>
					<td class="oddrow-l">
					<select name="daysOfWeek" size=7 multiple>
					%loop /varSubItem/complexTaskInfo/dayWkMask%<option value="%value idx%" %value selected%>%value name%</option>%endloop%
					</select>
					</td>
					<td class="oddrow-l">
					<select name="hours" size=7 multiple>
					%loop /varSubItem/complexTaskInfo/hourMask%<option value="%value idx%" %value selected%>%value name%</option>%endloop%
					</select>
					</td>
					<td class="oddrow-l">
					<select name="minutes" size=7 multiple>
					%loop /varSubItem/complexTaskInfo/minMask%<option value="%value idx%" %value selected%>%value name%</option>%endloop%
					</select>
					</td>
				</tr>
				<tr>
					<td class="oddrow" colspan=5>
					<i>Selecting no assets is equivalent to selecting all assets for a given list</i>
					</td>
				</tr>
				%endif%
			%endswitch%

			%ifvar /mode equals('edit')%
				<TR>
					<TD class="action" colspan="3">
						<INPUT onclick="return onSave();" class="data" name="actionButton" type="submit" value="Save Substitutions"> </TD>
					<TD class="action" colspan="3">
						<INPUT onclick="return confirmClearSubstitution();" class="data" name="actionButton" type="submit" value="Clear Substitutions"> </TD>
				</TR>
			%endif%
			</TD></TABLE>
		</TR>
	</FORM>
</TABLE>


</BODY>
</HTML>
