<HTML><HEAD>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META http-equiv="Expires" content="-1">
<LINK href="webMethods.css" type="text/css" rel="stylesheet">
<SCRIPT src="webMethods.js"></SCRIPT>
<BODY>

<SCRIPT language=JavaScript>
</SCRIPT>

<TABLE width="100%">
    <TR>
      <TD class="menusection-Deployer" colspan="2">%value releaseName% > Properties</TD>
    </TR>
</TABLE>


<TABLE width="100%">
	<TR>
		<TD colspan="2">
			<UL>
				<LI><A href="build-status.dsp?projectName=%value -htmlcode projectName%&releaseName=%value -htmlcode releaseName%">Refresh this Page</A></LI>
			</UL>
		</TD>
	</TR>

%invoke wm.deployer.gui.UIRelease:getReleaseInfo%
	<TR>
		<TD><IMG height="0" src="images/blank.gif" width="5" border="0"></TD>
		<TD>
			<TABLE class="tableView" width="100%">
				<TR>
					<TD class="heading" colspan=2>Build Properties</TD>
				</TR>

			  <SCRIPT>resetRows();</SCRIPT>
				<TR>
					<script> writeTD("row"); </script>Name</TD>
					<script> writeTD("rowdata-l"); </script> %value releaseName%</TD>
				</TR>

			  <SCRIPT>swapRows();</SCRIPT>
				<TR>
					<script> writeTD("row"); </script>Description</TD>
					<script> writeTD("rowdata-l"); </script> %value releaseDescription%</TD>
				</TR>

			  <SCRIPT>swapRows();</SCRIPT>
				<TR>
					<script> writeTD("row"); </script>Created By</TD>
					<script> writeTD("rowdata-l"); </script> %value releaseExtractUser%</TD>
				</TR>

				<!- Build Status ->
			  <SCRIPT>swapRows();</SCRIPT>
				<TR>
					<script> writeTD("row"); </script>Status</TD>
					<script> writeTD("rowdata-l"); </script> 

					%ifvar releaseStatus equals('Error')%
						<IMG src="images/dependency.gif" border="0" width="14" height="14">
						Error creating this Build.</TD>
					%else%
						%ifvar isProjectNewer equals('true')%
							<IMG src="images/warning.gif" border="0" width="16" height="16">
							Project definition has changed since this Build.</TD>
						%else%
							<IMG src="images/green_check.gif" border="0" width="13" height="13">
							Ready for Deployment Candidate
						%endif%
					%endif%
			</TABLE>
		</TD>
	</TR>

<!-  Build History ->

	<TR>
		<TD><IMG height="8" src="images/blank.gif" width="0" border="0"></TD>
	</TR>

	<TR>
		<TD><IMG height="0" src="images/blank.gif" width="5" border="0"></TD>
		<TD>
			<SCRIPT>resetRows();</SCRIPT>
			<TABLE class="tableView" id="warnings" width="100%">
				<TR>
					<TD class="heading" colspan="3">Build History</TD>
				</TR>

	%ifvar reports -notempty%
				<SCRIPT>swapRows();</SCRIPT>
				<TR>
					<TD class="oddcol">Report</TD>
					<TD class="oddcol">Report Type</TD>
					<TD class="oddcol">Report Created</TD>
				</TR>
		%loop reports%
				<SCRIPT>swapRows();</SCRIPT>

				<TR>
					<SCRIPT>writeTD('rowdata');</SCRIPT> 
						<A target="_blank" class="imagelink" href="%value reportName%">
						<IMG alt="View this Report in a separate browser." src="images/edit.gif" border="no"></A></TD>

					<SCRIPT>writeTD('rowdata');</SCRIPT> Build </TD>

					<SCRIPT>writeTD('rowdata');</SCRIPT> %value reportTimestamp% </TD>
				</TR>
		%endloop%
	%else%
				<TR>
					<TD class="oddcol-l" colspan="2">No Build History</TD>
				</TR>
	%endif%
			</TABLE>
		</TD>
	</TR>
%endinvoke%

</TABLE>
</BODY>
</HTML>
