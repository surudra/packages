%ifvar independent%
	<BODY>
	<TABLE WIDTH="100%">
%endif%

	<TR><td class="title" %ifvar colspan% colspan="%value colspan%" %endif%>%value title%</td></TR>
	<FORM>
	<TR>
		<TD class="action" %ifvar colspan% colspan="%value colspan%" %endif%>
		%ifvar execjavascript%
			<INPUT class="data" type="button" onclick="%value encode(htmlattr) execjavascript%();" value="Submit">
		%else%
			<INPUT class="data" type="button" onclick="%value form empty='parent.main.document.forms[0]'%.submit();" value="Submit">
		%endif%
	%ifvar independent%
		<INPUT class="data" type="button" onclick="parent.history.go(-1);" value="Cancel">
	%else%
		<INPUT class="data" type="button" onclick="history.go(-1);" value="Cancel">
	%endif%
		</TD>
	</TR>
	</FORM>

%ifvar independent%
	</TABLE>
	</BODY>
%endif%
