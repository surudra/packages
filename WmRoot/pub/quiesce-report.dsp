<HTML>
    <HEAD>
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
        <META HTTP-EQUIV="Expires" CONTENT="-1">
        <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
		<SCRIPT SRC="webMethods.js.txt"></SCRIPT>
		<script>
			function setVal()
			{
				quiesceForm.timeout.value=parent.topmenu.document.forms[0].timeout.value;
				quiesceForm.isQuiesceMode.value=parent.topmenu.document.forms[0].isQuiesceMode.value;
				quiesceForm.submitted.value ='true';
				quiesceForm.submit();
			}
		</script>
    </HEAD>
    
    <body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" onLoad="setNavigation('quiesce-report.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Server_EnterExitQuiesceModeScrn');">
		<form name="quiesceForm" action="quiesce-report.dsp" method="POST">
			<input type="hidden" name="isQuiesceMode" >
			<input type="hidden" name="timeout" >
			<input type="hidden" name="submitted" value="false">
		</form>	
		%ifvar submitted equals('true')%
			%ifvar isQuiesceMode equals('true')%
				%invoke wm.server.quiesce:setQuiesceMode%
				%endinvoke%
			%else%
				
				%invoke wm.server.quiesce:setActiveMode%
				%endinvoke%
			%endif%
			<TABLE width="100%">
				<TR>
					<TD class="menusection-Security" colspan="2"> Server &gt; Quiesce  </TD>
				</TR>
				%ifvar message%
					%ifvar message equals('INVALID')%
						<tr><td colspan="2">&nbsp;</td></tr>
						<TR><TD class="message" colspan="2">Unable to quiesce Integration Server. All of the following conditions must be satisfied to switch Integration Server in quiesce mode
							<ul>
								<li>Quiesce port should be set.</li> 
								<li>Quiesce port should be enabled.</li>
								<li>Quiesce port should not be suspended.</li> 
								<li>Quiesce port should have allow access mode.</li>
							</ul>
						 </TD></TR>
					%else%
						<tr><td colspan="2">&nbsp;</td></tr>
						<TR><TD class="message" colspan="2">%value message%</TD></TR>

					%endif%
				%endif%
				<TR>
					<TD>
						<TABLE class="tableView" width="75%%">
							<TR>
								<TD class="heading" colspan="11">Quiesce Report</TD>
							</TR>

							<TR>
							  <TD class="oddcol-l">Type</TD>
							  <TD class="oddcol-l">Status</TD>
							  <TD class="oddcol-l">Message</TD>
							</TR>
							%loop report%
							<TR>
								<script>writeTD("rowdata");</script><p align="left">%value type% </p> </TD>
								<script>writeTD("rowdata");</script><p align="left">%value status% </p></TD>
								<script>writeTD("rowdata");</script><p align="left">%value message%</p></TD>			
							</TR>
							%endloop%
						</TABLE>
					</TD>
				</TR>
			</TABLE>
		%else%
			<script>setVal();</script>
		%endif%
		<script>parent.topmenu.location.reload();</script>
</BODY>