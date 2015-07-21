<HTML><HEAD>
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META http-equiv=Pragma content=no-cache>
<META http-equiv=Expires content=-1>
<LINK href="webMethods.css" type=text/css rel=stylesheet>
<SCRIPT src="webMethods.js"></SCRIPT>
<SCRIPT language="JavaScript" type="text/javascript">
// open separate IS Admin window and load dsp into the main frame, 
// default is root IS Admin with no frame load
var newWindow;
function openWindow( mainUrl, frameUrl ) {
    if(!mainUrl || mainUrl==null || mainUrl=='') mainUrl = '/';
    //if(!frameUrl || frameUrl==null) frameUrl = '/WmRoot/settings-remote-addedit.dsp';
    // make sure it isn't already opened
    if (!newWindow || newWindow.closed) {
        newWindow = window.open(mainUrl);
        // delay writing until window exists in IE/Windows
        if(frameUrl) setTimeout('pushFrame(\''+frameUrl+'\')', 500);
    } else if (newWindow.focus) {
        // window is already open and focusable, so bring it to the front
        newWindow.focus( );
        // delay writing until window exists in IE/Windows
        if(frameUrl) setTimeout('pushFrame(\''+frameUrl+'\')', 500);
    }
}

function onLoad() {
	var validVersions = document.getElementById("validVersions").value;
	var validVersionsArray = validVersions.split(",");
	var selectedVersionArray = document.getElementsByName("selectedVersion");
	var versionSelectObjectArray = document.getElementsByName("runtimeVersion");	
	for (j=0;j<versionSelectObjectArray.length;j++) {				
		var versionSelectObject = versionSelectObjectArray[j];
		var selectedVersionObject = selectedVersionArray[j];
		versionSelectObject.options.length = validVersionsArray.length;
		for (i=0;i<validVersionsArray.length;i++) {		
			versionSelectObject.options[i].text = validVersionsArray[i];
			versionSelectObject.options[i].value = validVersionsArray[i];
			if(selectedVersionObject.value != null && selectedVersionObject.value == validVersionsArray[i]) {
				versionSelectObject.options[i].selected = true;
			}	
		}	
	}
}

function pushFrame(frameUrl) {
    //f points to the "body" frame
	try
	{
		var f = newWindow.frames[0].frames[2];	
		if(f == null || f == undefined)
		{
			throw "Error";
		}
		if(frameUrl && f) {
		  if(is_csrf_guard_enabled && needToInsertToken) {
			f.location.href = frameUrl+ "?" + _csrfTokenNm_ + "=" + _csrfTokenVal_;
		   } else {
			f.location.href = frameUrl;
		   }		
		}
	}
	catch (e)
	{
		setTimeout('pushFrame(\''+frameUrl+'\')', 1000);		
	}
}

</SCRIPT>
<SCRIPT language="JavaScript" type="text/javascript">
function confirmInstall() {
	document.getElementById("action").value = "updateServers";
    if (confirm("Install WmDeployerResource Package on selected Servers?")) {
		startProgressBar();
		return true;
    }
	return false;
}

function save() {
    document.getElementById("action").value = "saveVersion";
}

// Manage the Install button behavior
var checkBoxCount = 0;
function manageInstallButtons(obj) {

	if (obj.checked)
		checkBoxCount++;
	else
		checkBoxCount--;

	if (checkBoxCount > 0) {
		document.getElementById("installButton").disabled = false;
		document.getElementById("installButton2").disabled = false;
	}
	else {
		document.getElementById("installButton").disabled = true;
		document.getElementById("installButton2").disabled = true;
	}
}
</SCRIPT>
</HEAD>

<BODY onLoad="javascript:onLoad();">

<TABLE width="100%">
  <TR>
    <TD class=menusection-DeployerServers>Remote Servers</TD>
  </TR>
</TABLE>

<TABLE width="100%">
	<!- Update Source Servers -> 
%ifvar action equals('updateServers')%	
	<!- key-value pairs from table ->
	%invoke wm.deployer.UIDeployer:deployResourceToTargets%
		%include error-handler.dsp%

	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
	<script>parent.propertyFrame.document.location.reload();</script>
%endif%

%ifvar action equals('saveVersion')%	
	<!- key-value pairs from table ->
	%invoke wm.deployer.Util:persistVersionAliasMapping%
		%include error-handler.dsp%

	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
	<script>parent.propertyFrame.document.location.reload();</script>
%endif%

<!- Test -> 
%ifvar action equals('test')%
	<!- pluginType(i), name(i) ->
	%invoke wm.deployer.gui.server.IS:ping%
		%switch status%
		%case 'Success'%
				<script>writeMessage("Successfully connected to Integration Server %value serverAlias%.  Deployer Resource Package reports version %value -htmlcode version%. Integration Server reports version %value -htmlcode is_version%.");</script>
		%case 'Error'%
				<script>writeError("Error connecting to Integration Server: %value serverAlias%: %value -htmlcode message%");</script>
		%case 'Warning'%
				<script>writeWarning("%value -htmlcode message%");</script>
		%case%
				<script>writeMessage("%value -htmlcode message%");</script>
		%end%

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
                <LI><A HREF="javascript: openWindow('/', '/WmRoot/settings-remote-addedit.dsp');"> Add Remote Server Alias</A></LI>
				%endif%
				<LI><A onclick="startProgressBar();" HREF="remote-servers.dsp"> Refresh this Page</A></LI>
			</UL>
		</TD>
	</TR>

	<FORM method="post" action="remote-servers.dsp">
	<input type="hidden" name="action" id="action">
	<TR>
    <TD><IMG height="10" src="images/blank.gif" width="5"></TD>
    <TD>
      <TABLE class="tableView">
        <TR>
				%ifvar /isAuth equals('true')% 
          <TD class="heading" colspan=6>Install Resource Package to IS & TN Remote Servers</TD>
				%else%
          <TD class="heading" colspan=6>IS & TN Remote Servers</TD>
				%endif%
        </TR>

			%ifvar /isAuth equals('true')% 
                <TR>
                    <TD colspan=6 class="action">						
						<input id="installButton" name="submit"disabled onclick="return confirmInstall();" type="submit" value="Install">
						<input id="saveButton1" name="save1" onclick="return save();" type="submit" value="Save">
					</TD>
				</TR>		
			%endif%

				<TR>
				%ifvar /isAuth equals('true')% 
					<td style="width:140" class="oddcol">Install</td>
				%endif%
					<td style="width:140" class="oddcol-l">Alias</td>
					<td style="width:140" class="oddcol-l">Server</td>
					<td style="width:140" class="oddcol">Port</td>
					<td style="width:140" class="oddcol">Version</td>
					<td style="width:140" class="oddcol">Test</td>
				</TR>

				<script>resetRows();</script>
				%invoke wm.deployer.Util:cleanUpISAliases%
				%endinvoke%
				%invoke wm.deployer.Util:listAliases%
				<INPUT name="validVersions" id="validVersions" type="hidden" value="%value validVersions%">
					%loop serverAliases%
				<TR>
						%ifvar /isAuth equals('true')% 
					<script> writeTD("rowdata", "nowrap");</script>
						<input id="alias_%value serverAliasName -urlencode%" type="checkbox" onclick="manageInstallButtons(this);"
						name="%value serverAliasName%" value="TARGET_INCL"></TD>
						%endif%

					<script> writeTD("rowdata-l", "nowrap");</script>
						<A onclick="startProgressBar();"
							href="remote-server-properties.dsp?serverAlias=%value serverAliasName%"
							target="propertyFrame" 
							title="Show Remote Server Properties">
							%value serverAliasName%</A>
						</TD>
					
					<script> writeTD("row-l", "nowrap");</script>%value serverAliasHost%</TD>

					<script> writeTD("row-l", "nowrap");</script>%value serverAliasPort%</TD>
					
					<script> writeTD("row-l", "nowrap");</script><INPUT name="serverAliasName" type="hidden" value="%value serverAliasName%"><INPUT name="selectedVersion" type="hidden" value="%value runtimeVersion%">
					<select name="runtimeVersion" id="runtimeVersion">								
					</select></TD>

					<!- Test  ->
					<script> writeTD("rowdata", "nowrap");</script>
						<A class="imagelink" onclick="startProgressBar();"
							href="remote-servers.dsp?serverAlias=%value serverAliasName%&action=test">
							<IMG alt="Test connectivity to Resource Package on this Integration Server" src="images/checkdot.gif" border="0" width="14" height="14"></A>
						</TD>	

				</TR>
				<script>swapRows();</script>
					%endloop%
				%endinvoke%

			%ifvar /isAuth equals('true')% 
				<TR>
                    <TD colspan=6 class="action">						
						<input id="installButton2" disabled name="submit2" onclick="return confirmInstall();" type="submit" value="Install">
						<input id="saveButton2" name="save2" onclick="return save();" type="submit" value="Save">
					</TD>
				</TR>		
			%endif%
			</TABLE>
		</TD>
	</TR>
	</FORM>
</TABLE>

<SCRIPT> stopProgressBar(); </SCRIPT>
</BODY></HTML>
