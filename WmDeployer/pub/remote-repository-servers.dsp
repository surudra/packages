<HTML><HEAD>
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META http-equiv=Pragma content=no-cache>
<META http-equiv=Expires content=-1>
<LINK href="webMethods.css" type=text/css rel=stylesheet>
<SCRIPT src="webMethods.js"></SCRIPT>
</HEAD>
<BODY>

<SCRIPT language=JavaScript>
function confirmDelete(server) {
  if (confirm("Delete " + server + "?  This operation cannot be reversed.")) {
		startProgressBar();
		return true;
	}
	return false;
}

function confirmCreateIndex(server) {
  if (confirm("OK to create index on repository " + server + "?")) {
		startProgressBar();
		return true;
	}
	return false;
}

</SCRIPT>

<TABLE width="100%">
  <TR>
    <TD class=menusection-DeployerServers>Repositories</TD>
  </TR>
</TABLE>

<TABLE width="100%">
	<!-- Add Plugin Servers --> 
%ifvar action equals('add')%
	<!-- key-value pairs from table -->
	%invoke wm.deployer.gui.UIRepository:addRepositoryServer%
		%include error-handler.dsp%

		%ifvar status equals('Success')%
			<!- Post newly created Plugin Server in Property frame ->
			<script>
			if(is_csrf_guard_enabled && needToInsertToken) {
   			   parent.propertyFrame.document.location.href = "edit-plugin-server.dsp?aliasName=%value -htmlcode aliasName%&" + _csrfTokenNm_ + "=" + _csrfTokenVal_;
			} else {
			   parent.propertyFrame.document.location.href = "edit-plugin-server.dsp?aliasName=%value -htmlcode aliasName%";
			}
			</script>
		%end if%

	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%endif%

<!- Test -> 
%ifvar action equals('test')%	
	 <tr>
            <td colspan="2">&nbsp;</td>
        </tr>

        %invoke wm.deployer.gui.UICSServer:pingCentrasiteServer%
            <tr>
                <td class="message" colspan=2>
                    %ifvar message%
                        %value -htmlcode message%
		     %endif%
                </td>
            </tr>
        %onerror%
            <tr><td colspan="2" class="message">Error: Not Connected</td></tr>
        %endinvoke%
%endif%

<!- Create Index -> 
%ifvar action equals('createIndex')%	
	 <tr>
            <td colspan="2">&nbsp;</td>
        </tr>

        %invoke wm.deployer.gui.UICSServer:createIndex%
            <tr>
                <td class="message" colspan=2>
                    %ifvar message%
                        %value -htmlcode message%
		     %endif%
                </td>
            </tr>
        %onerror%
            <tr><td colspan="2" class="message">Error:There is no repository directory</td></tr>
        %endinvoke%
%endif%

<!- Delete -> 
%ifvar action equals('delete')%	
	%invoke wm.deployer.gui.UICSServer:deleteCentrasiteServer%
		%include error-handler.dsp%

		<!- property may be obsolete if bundle is deleted ->
		%ifvar status equals('Success')%
			<script>parent.propertyFrame.document.location.href = "blank.html";</script>
		%end if%
	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%endif%

</TABLE>

<!- Determine if this user is empowered to modify server stuff ->
%invoke wm.deployer.UIAuthorization:isAuthorized%
%endinvoke%

<TABLE width="100%">
	<TR>
		<TD colspan="2">
			<UL>
				%ifvar /isAuth equals('true')%
                <LI><A href="add-repository-server.dsp" target="propertyFrame" > Add Repository</A></LI>
				%endif%
				<LI><A onclick="startProgressBar();" HREF="remote-repository-servers.dsp"> Refresh this Page</A></LI>
			</UL>
		</TD>
	</TR>

	<FORM method="post" action="remote-repository-servers.dsp">
		
	<TR>
    <TD><IMG height="10" src="images/blank.gif" width="5"></TD>
    <TD>
      <TABLE class="tableView">
        <TR>
          <TD class="heading" colspan=5>Repositories</TD>
        </TR>
		<TR>					
			<td style="width:140" class="oddcol-l">Name</td>
			<td style="width:140" class="oddcol">Repository Type</td>
			<td style="width:140" class="oddcol">Test</td>	
			<td style="width:140" class="oddcol">Create Index</td>
			<td style="width:140" class="oddcol">Delete</td>
		</TR>
		<script>resetRows();</script>
 

		%invoke wm.deployer.gui.UICSServer:listCentrasiteServers%
			%ifvar repositoryServers -notempty%
			%loop repositoryServers%
				<TR>

					<!- Name ->
					<script> writeTD("rowdata-l", "nowrap");</script> 
						<A onclick="return startProgressBar();" target="propertyFrame" title="Show Repository Server Properties" href="repository-server-properties.dsp?aliasName=%value aliasName%">%value aliasName%</TD>

					<!- Host ->
					<script> writeTD("row-l", "nowrap");</script>%value repositoryType%</TD>

					<!- Test  ->
					<script> writeTD("rowdata", "nowrap");</script>
						<A class="imagelink" onclick="startProgressBar('Testing connectivity to Repository Server %value aliasName%')"
							href="remote-repository-servers.dsp?aliasName=%value aliasName%&action=test">
							<IMG alt="Test connectivity to this Server" src="images/checkdot.gif" border="0" width="14" height="14"></A>
					
					<!- Create Index  ->
					<script> writeTD("rowdata", "nowrap");</script>
						<A class="imagelink" onclick="return confirmCreateIndex('%value aliasName%');"
							href="remote-repository-servers.dsp?aliasName=%value -htmlcode aliasName%&action=createIndex">
							<IMG alt="Creating Index for Repository" src="images/checkdot.gif" border="0" width="14" height="14"></A>

					<!- Delete  ->
					<script> writeTD("rowdata", "nowrap");</script>
					%ifvar /isAuth equals('true')% 
						<A class="imagelink" onclick="return confirmDelete('%value aliasName%');"
							href="remote-repository-servers.dsp?aliasName=%value -htmlcode aliasName%&action=delete">
							<IMG alt="Delete this Server" src="images/delete.gif" border="0" width="16" height="16"></A>
					%else%
							<IMG src="images/delete_disabled.gif" border="0" width="16" height="16">
					%endif%
				</TR>
				<script>swapRows();</script>
			%endloop%

			%else%
				<TR>
					<TD colspan="5"><FONT color="red">* No Repository servers.</FONT></TD>
				</TR>
			%endif%
		%endinvoke%

			</TABLE>
		</TD>
	</TR>
	</FORM>
</TABLE>

<SCRIPT> stopProgressBar(); </SCRIPT>
</BODY></HTML>
