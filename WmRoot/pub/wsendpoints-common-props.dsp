<TR>
	<TD colspan="2" class="heading">Web Service Endpoint Alias Properties</TD>
</TR>

<TR>
	<TD class="oddrow" width="30%"><B>Alias</B></TD>
	<TD class="oddrow-l" width="70%">
		%ifvar ../../action equals('view')%
			<B>%value alias%</B>
		%else%
			<INPUT TYPE="hidden" NAME="dummyEmptyValue" VALUE="" />
			%ifvar ../../action equals('edit')%
				<INPUT name="alias" type="hidden" VALUE="%value alias%" style="width:40%">
				<B>%value alias%</B>
			%else%
				<INPUT name="alias" VALUE="%value alias%" style="width:40%">
			%endif%
		%endif%
	</TD>
</TR>

<TR>
	<TD class="evenrow">Description</TD>
	<TD class="evenrow-l">
		%ifvar ../../action equals('view')%
			%value description%
		%else%
			<INPUT name="description" VALUE="%value description%" style="width:100%">
		%endif%
	</TD>
</TR>

<TR>
	<TD class="oddrow">Type</TD>
	<TD class="oddrow-l">
		%ifvar ../../action equals('view')%
			%ifvar ../type equals('provider')% Provider %else% %ifvar ../type equals('addressing')% Message Addressing %else% Consumer %endif% %endif%
		%else%
			%ifvar ../../action equals('edit')%
				<INPUT name="type" type="hidden" VALUE="%value ../type%">
				%ifvar ../type equals('provider')% Provider %else% %ifvar ../type equals('addressing')% Message Addressing %else% Consumer %endif% %endif%
			%else%
				<INPUT TYPE="radio" NAME="wsetype" ID="wsetype" VALUE="provider" checked onclick="toggleProperties('wsetype')">Provider</INPUT>
				<INPUT TYPE="radio" NAME="wsetype" ID="wsetype"VALUE="consumer" onclick="toggleProperties('wsetype')">Consumer</INPUT>
				<INPUT TYPE="radio" NAME="wsetype" ID="wsetype"VALUE="addressing" onclick="toggleProperties('wsetype')">Message Addressing</INPUT>
			%endif%
		%endif%
	</TD>
</TR>


<TR>
	<TD class="evenrow">Transport Type</TD>
	<TD class="evenrow-l">
		%ifvar ../../action equals('view')%
			%value  transportInfo/transportType%
		%else%
			%ifvar ../../action equals('edit')%
				<INPUT name="transportType" type="hidden" VALUE="%value transportInfo/transportType%">
				%value transportInfo/transportType%
			%else%
				<INPUT TYPE="radio" NAME="transType" VALUE="HTTP" checked onclick="toggleProperties('transType')">HTTP</INPUT>
				<INPUT TYPE="radio" NAME="transType" VALUE="HTTPS" onclick="toggleProperties('transType')">HTTPS</INPUT>
				<INPUT TYPE="radio" NAME="transType" VALUE="JMS" onclick="toggleProperties('transType')">JMS</INPUT>
			%endif%
		%endif%
	</TD>
</TR>

