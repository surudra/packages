<HTML><HEAD>
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META http-equiv=Pragma content=no-cache>
<META http-equiv=Expires content=-1>
<LINK href="webMethods.css" type=text/css rel=stylesheet>
<SCRIPT src="webMethods.js"></SCRIPT>

<SCRIPT language=JavaScript>
function confirmDelete(server) {
  if (confirm("Delete " + server + "?  This operation cannot be reversed.")) {
		startProgressBar();
		return true;
	}
	return false;
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

function onUpdate(hostLabel,versionLabel) {
	// Name is always required
	var value = document.serverForm.name.value;
	if ( trim(value) == "" ) {
		alert("%value pluginType% Server Name is required.");
		document.serverForm.name.focus();
		return false;
	} 

	if (!isIllegalName(value)) {
		alert("Invalid Name.\nRefer to Integration Server Administrator's Guide for listed illegal characters.");
		document.serverForm.name.focus();
		return false;
	}


	// Host
	if (hostLabel.length > 0) {
		value = document.serverForm.host.value;
		if ( trim(value) == "" ) {
			alert(hostLabel + " is required.");
			document.serverForm.host.focus();
			return false;
		} 
	}

	// Version
	if (versionLabel.length > 0) {
		value = document.serverForm.host.value;
		if ( trim(value) == "" ) {
			alert(hostLabel + " is required.");
			document.serverForm.host.focus();
			return false;
		} 
	}
	
	return true;
}

	
function enableSaveButton() {
	document.getElementById("save").disabled = false;
	document.getElementById("save1").disabled = false;
}

</SCRIPT>
</HEAD>
<BODY onLoad="javascript:onLoad();">

<TABLE width="100%">
  <TR>
    <TD class=menusection-DeployerServers>%value pluginLabel% Servers</TD>
  </TR>
</TABLE>



<TABLE width="100%">
	<!-- Add Plugin Servers --> 
%ifvar action equals('add')%
	<!-- key-value pairs from table -->
	%invoke wm.deployer.gui.UIPlugin:addPluginServer%
		%include error-handler.dsp%

		%ifvar status equals('Success')%
			<!- Post newly created Plugin Server in Property frame ->
			<script>
			if(is_csrf_guard_enabled && needToInsertToken) {
   			   parent.propertyFrame.document.location.href = "edit-plugin-server.dsp?pluginType=%value -htmlcode pluginType%&pluginLabel=%value -htmlcode pluginLabel%&name=%value -htmlcode name%&" + _csrfTokenNm_ + "=" + _csrfTokenVal_;
			} else {
			   parent.propertyFrame.document.location.href = "edit-plugin-server.dsp?pluginType=%value -htmlcode pluginType%&pluginLabel=%value -htmlcode pluginLabel%&name=%value -htmlcode name%";
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
	<!- pluginType(i), name(i) ->
	%invoke wm.deployer.gui.UIPlugin:pingPluginServer%
		%switch status%
		%case 'Success'%
			<script>writeMessage("Successfully connected to %value pluginLabel% Server %value name%.  Plugin reports version %value -htmlcode version%");</script>
		%case 'Error'%
			<script>
				writeError("Error connecting to server: %value -htmlcode message%");
			</script>
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

<!- Delete -> 
%ifvar action equals('delete')%
	<!- pluginType (i), name (i) ->
	%invoke wm.deployer.gui.UIPlugin:deletePluginServer%
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

<!- Update Server Version ->
%ifvar action equals('updateServer')%
	%invoke wm.deployer.gui.UIPlugin:updatePluginServerVersion%
		%include error-handler.dsp%

	<!--	%ifvar status equals('Success')%
			<script>
			if(is_csrf_guard_enabled && needToInsertToken) {
   			   parent.treeFrame.document.location.href = "plugin-servers.dsp?pluginType=%value -htmlcode pluginType%&pluginLabel=%value -htmlcode pluginLabel%&" + _csrfTokenNm_ + "=" + _csrfTokenVal_;
			} else {
			   parent.treeFrame.document.location.href = "plugin-servers.dsp?pluginType=%value -htmlcode pluginType%&pluginLabel=%value -htmlcode pluginLabel%";
			}
			</script>
		%end if% -->
		
	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%end if%

</TABLE>

<!- Determine if this user is empowered to modify server stuff ->
%invoke wm.deployer.UIAuthorization:isAuthorized%
%end invoke%	

<TABLE width="100%">
	<TR>
		<TD colspan="2">
			<UL>
			%ifvar /isAuth equals('true')% 
				<LI><A target="propertyFrame" href="add-plugin-server.dsp?pluginType=%value -htmlcode pluginType%&pluginLabel=%value -htmlcode pluginLabel%"> Configure %value pluginLabel% Server</A></LI>
				%endif%
				<LI><A onclick="startProgressBar();" HREF="plugin-servers.dsp?pluginType=%value -htmlcode pluginType%&pluginLabel=%value -htmlcode pluginLabel%"> Refresh this Page</A></LI>
			</UL>
		</TD>
	</TR>

	<FORM method="post" action="plugin-servers.dsp">
		<input type="hidden" name="pluginType" value="%value pluginType%">
		<input type="hidden" name="pluginLabel" value="%value pluginLabel%">
		<input type="hidden" name="name" value="%value name%">	
	<TR>
    <TD><IMG height="10" src="images/blank.gif" width="5"></TD>
    <TD>
      <TABLE class="tableView">
        <TR>
          <TD class="heading" colspan=6>%value pluginLabel% Servers</TD>
        </TR>

		
		
		%ifvar /isAuth equals('true')% 
                <TR>
                	<INPUT type="hidden" name="pluginType" value='%value pluginType%'>
					<INPUT type="hidden" name="name" value='%value name%'>
					<INPUT type="hidden" name="action" value="updateServer">
                    <TD colspan=6 class="action">						
						<INPUT disabled onclick="return onUpdate('%value hostLabel%','%value versionLabel%');"type="submit" VALUE="Save" name="submit" id="save">
					</TD>
				</TR>		
			%endif%
		
		%invoke wm.deployer.gui.UIPlugin:getPluginServerLabels%
				
				%ifvar /pluginType equals('UniversalMessaging')% 
					<TR>
						<td style="width:140" class="oddcol-l">Name</td>
						<td style="width:140" class="oddcol-l">Realm URL</td>
						<td style="width:140" class="oddcol-l">%value versionLabel%</td>
						<td style="width:140" class="oddcol-l">Test</td>
						<td style="width:140" class="oddcol">Delete</td>
					</TR>
				%else%
					<TR>
						<td style="width:140" class="oddcol-l">Name</td>
						<td style="width:140" class="oddcol-l">%value hostLabel%</td>
						<td style="width:140" class="oddcol-l">%value portLabel%</td>
						<td style="width:140" class="oddcol-l">%value versionLabel%</td>
						<td style="width:140" class="oddcol-l">Test</td>
						<td style="width:140" class="oddcol">Delete</td>
					</TR>
				%endif%
		%end invoke%

				<script>resetRows();</script>
		%invoke wm.deployer.gui.UIPlugin:listPluginServersOptimized%
		<INPUT name="validVersions" id="validVersions" type="hidden" value="%value validVersions%">	
			%ifvar pluginServers -notempty%
			%loop pluginServers%
				<TR>

					<!- Name ->
					<script> writeTD("rowdata-l", "nowrap");</script> 
						<A onclick="return startProgressBar();" target="propertyFrame" href="edit-plugin-server.dsp?pluginType=%value /pluginType%&pluginLabel=%value /pluginLabel%&name=%value name%">%value name%</TD>

					 %ifvar /pluginType equals('UniversalMessaging')% 
						<!- Realm Name ->
						<script> writeTD("row-l", "nowrap");</script>%value realmURL%</TD>
					%else%
						<!- Host ->
						<script> writeTD("row-l", "nowrap");</script>%value host%</TD>

						<!- Port ->
						<script> writeTD("row-l", "nowrap");</script>%value port%</TD>
					%endif%
					
					<!- Version ->
						<script> writeTD("rowdata-l"); </script>
						%ifvar /isAuth equals('true')%		
						<INPUT name="selectedVersion" id="selectedVersion" type="hidden" value="%value runtimeVersion%">
						<select onchange="enableSaveButton();" name="runtimeVersion" id="runtimeVersion">								
						</select>
						%else%
							%value version%
						%endif%
					<!- Test  ->
					<script> writeTD("rowdata", "nowrap");</script>
						<A class="imagelink" onclick="startProgressBar('Testing connectivity to %value /pluginType% Server %value name%')"
							href="plugin-servers.dsp?pluginType=%value /pluginType%&pluginLabel=%value /pluginLabel%&name=%value name%&action=test">
							<IMG alt="Test connectivity to this Server" src="images/checkdot.gif" border="0" width="14" height="14"></A>

					<!- Delete  ->
					<script> writeTD("rowdata", "nowrap");</script>
					%ifvar /isAuth equals('true')% 
						<A class="imagelink" onclick="return confirmDelete('%value name%');"
							href="plugin-servers.dsp?pluginType=%value -htmlcode /pluginType%&pluginLabel=%value -htmlcode /pluginLabel%&name=%value -htmlcode name%&action=delete">
							<IMG alt="Delete this Server" src="images/delete.gif" border="0" width="16" height="16"></A>
					%else%
							<IMG src="images/delete_disabled.gif" border="0" width="16" height="16">
					%endif%
				</TR>
				<script>swapRows();</script>
			%endloop%

			%else%
				<TR>
					<TD colspan="6"><FONT color="red">* No %value pluginLabel% servers.</FONT></TD>
				</TR>
			%endif%
		
		

	%ifvar /isAuth equals('true')% 
                <TR>
                	<INPUT type="hidden" name="pluginType" value='%value pluginType%'>
					<INPUT type="hidden" name="name" value='%value name%'>
					<INPUT type="hidden" name="action" value="updateServer">
                    <TD colspan=6 class="action">						
						<INPUT disabled onclick="return onUpdate('%value hostLabel%','%value versionLabel%');"type="submit" VALUE="Save" name="submit" id="save1">
					</TD>
				</TR>		
			%endif%
		%end invoke%	
			</TABLE>
		</TD>
	</TR>

	</FORM>
</TABLE>

<SCRIPT> stopProgressBar(); </SCRIPT>
</BODY></HTML>
