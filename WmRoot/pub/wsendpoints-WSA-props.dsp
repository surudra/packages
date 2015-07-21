<TR>
	<TD colspan="2" class="heading">Message Addressing Properties (Optional)</TD>
</TR>
<tbody id="muRoleWSADiv">
<TR>
	<TD class="oddrow">Must Understand</TD>
	<TD class="oddrow-l">
		%ifvar ../../action equals('view')%
			%value mustUnderstand%
		%else%
			<select id="mustUnderstand" name="mustUnderstand">
				<option value="false" %ifvar mustUnderstand equals('false')%	selected = true;%endif%>False</option>
				<option value="true" %ifvar mustUnderstand equals('true')% selected = true;%endif%>True</option>
			</select>
		%endif%
	</TD>
</TR>
<tr>
	<TD class="evenrow">Role</TD>
	<TD class="evenrow-l">
		%ifvar ../../action equals('view')%
			%value soapRole%
		%else%
		<table width="100%">
			<tr>
				<td width="25%">
					<select id="soapRoleOptions" style="width:100%" onchange="toggleSoapRoleInput();">
						<option value="Ultimate Receiver"
						%ifvar soapRole equals('Ultimate Receiver')%selected%endif%>Ultimate Receiver</option>
						<option value="Next" %ifvar soapRole equals('Next')%selected%endif%>Next</option>
						<option value="None" %ifvar soapRole equals('None')%selected%endif%>None</option>
						<option value="other"
						%ifvar ../../action equals('edit')%
							%ifvar soapRole equals('Ultimate Receiver')%
							%else%
								%ifvar soapRole equals('Next')%
								%else%
									%ifvar soapRole equals('None')%
									%else%
										selected	
									%endif%
								%endif%
							%endif%
						%endif%
						>Other</option>
					</select>
				</td>
				<td class="evenrow-l" width="75%">
					<INPUT id="soapRoleInputField" name="soapRoleInputField" VALUE="%value soapRole%" style="width:100%" %ifvar action equals('create')%disabled%endif%>	
				</td>
			</tr>
		</table>
		%endif%
	</TD>
</TR>
</tbody>
<tbody id="toWSADiv">
	<TR>
		<TD class="oddrow">To</TD>
		<TD class="evenrow-l">
			%scope param(eprType='to')%
				%include wsendpoints-endpointReference.dsp%
			%endscope%
		</TD>
	</TR>
</tbody>
<tbody id="fromReplyToFaultToWSADiv">
	<TR>
		<TD class="evenrow">From</TD>
		<TD class="evenrow-l">
			%scope param(eprType='from')%
				%include wsendpoints-endpointReference.dsp%
			%endscope%
		</TD>
	</TR>
	<TR>
		<TD class="oddrow">ReplyTo</TD>
		<TD class="evenrow-l">
			%scope param(eprType='replyTo')%
				%include wsendpoints-endpointReference.dsp%
			%endscope%
		</TD>
	</TR>
	<TR>
		<TD class="evenrow">FaultTo</TD>
		<TD class="evenrow-l">
			%scope param(eprType='faultTo')%
				%include wsendpoints-endpointReference.dsp%
			%endscope%
		</TD>
	</TR>
</tbody>
<tbody id="responseMapWSADiv">
	<TR>
		<TD class="evenrow">Response Map</TD>
		<TD class="evenrow-l">
			<table id="responseMapTable" name="responseMapTable" class="tableView" width="100%">
				%ifvar action equals('create')%
					<tr>
						<td class="oddcol">Address</td>
						<td class="oddcol">Message Addressing Alias</td>
						<td class="oddcol">Add</td>
						<td class="oddcol">Delete</td>
					</tr>
					<script>addResponseMapRow();disableFirstResponseMapRowDeleteButton();</script>
				%else%
					<tr>
						<td class="oddcol">Address</td>
						<td class="oddcol">Message Addressing Alias</td>
						%ifvar ../../../action equals('edit')%
						<td class="oddcol">Add</td>
						<td class="oddcol">Delete</td>
						%endif%
					</tr>
					%ifvar responseToMap%
						%loop responseToMap%
							<script>editResponseMapRow('%value ../../../action%','%value address%','%value messageAddressingEndpointAlias%','%value -htmlcode transportType%');</script>
						%endloop%
					%else%
						<script>editResponseMapRow('%value ../../../action%','','','%value -htmlcode transportType%');</script>
					%endif%
					%ifvar action equals('edit')%
						<script>disableFirstResponseMapRowDeleteButton();</script>
					%endif%
				%endif%
			</table>
		</TD>
	</TR>
</tbody>
