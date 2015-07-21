<HTML><HEAD>
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META http-equiv=Pragma content=no-cache>
<META http-equiv=Expires content=-1>
<LINK href="webMethods.css" type=text/css rel=stylesheet>
<SCRIPT src="webMethods.js"></SCRIPT>
</HEAD>
<BODY>

<SCRIPT>
function enableSaveProperties() {
	document.getElementById("saveProperties").disabled = false;
}

function enableSaveSource() {
	document.getElementById("saveSource").disabled = false;
}

function onSaveProperties() {

	var regExp = document.getElementById("packageRegExp").value;
	if (!testRegularExpression(regExp)) {
		alert("The Regular Expression " + regExp + " is not valid.");
		document.getElementById("packageRegExp").focus();
		return false;
	}

	var regExp = document.getElementById("otherRegExp").value;
	if (!testRegularExpression(regExp)) {
		alert("The Regular Expression " + regExp + " is not valid.");
		document.getElementById("otherRegExp").focus();
		return false;
	}

	startProgressBar("Saving Set Properties.");
	return true;
}

</SCRIPT>

<TABLE width="100%">
  <TR>
    <TD class=menusection-Deployer>%value bundleName% > Source Servers</TD>
  </TR>
</TABLE>

<TABLE width="100%">
%ifvar action equals('updateDeploymentSet')%
	<!- projectName, deploymentSetName, deploymentSetDescription ->
	%invoke wm.deployer.gui.UIBundle:updateDeploymentSet%
		%include error-handler.dsp%

		%ifvar status equals('Success')%
			<script> 
				startProgressBar("Displaying new Project definition");
				if(is_csrf_guard_enabled && needToInsertToken) {
			   	   parent.treeFrame.document.location.href = "bundle-list.dsp?projectName=%value -htmlcode projectName%&" + _csrfTokenNm_ + "=" + _csrfTokenVal_;
				} else {
				   parent.treeFrame.document.location.href = "bundle-list.dsp?projectName=%value -htmlcode projectName%";
				}					
			</script>
		%else%
		<script>
			// stop the progress bar that was started during the submit
			stopProgressBar(); 
		</script>
		%endif%

	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%end if%

<!- Update Source Servers -> 
%ifvar action equals('updateSources')%
	<!- projectName, key-value pairs from table ->
	%invoke wm.deployer.gui.UIBundle:updateBundleSourceServerList%
		%include error-handler.dsp%
	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%endif%
</TABLE>

<!- Get some essential Project and Plugin properties for later use ->
%invoke wm.deployer.gui.UIProject:getProjectInfo%
%endinvoke%

%invoke wm.deployer.gui.UIPlugin:getPluginInfo%
%endinvoke%

<TABLE width="100%">

     
	%invoke wm.deployer.gui.UIBundle:getBundleProperties%
	%include error-handler.dsp%
	<TR>
		<TD colspan="2">
			<UL>
				<LI><A HREF="define-plugin-sources.dsp?projectName=%value -htmlcode projectName%&pluginType=%value -htmlcode pluginType%&bundleName=%value -htmlcode bundleName%"> Refresh this Page</A></LI>
			</UL>
		</TD>
	</TR>

	<TR>
    <TD><IMG height="10" src="images/blank.gif" width="5"></TD>
    <TD>
			<SCRIPT>resetRows();</SCRIPT>
			<TABLE class="tableView" width="100%">
%comment%
				<FORM name="deploymentSetForm" method="POST" action="under-construction.dsp">
%endcomment%
				<FORM name="deploymentSetForm" method="POST" action="define-plugin-sources.dsp">

				<TR>
					<TD class="heading" colspan="2">Set Properties</TD>
				</TR>

				<TR>
					<script> writeTD("row"); </script>Name</TD>
					<script> writeTD("rowdata-l"); </script> %value bundleName%</TD>
				</TR>
				<SCRIPT>swapRows();</SCRIPT>


			        <TR>
					<script> writeTD("row"); </script>Source Of Truth</TD>
					<script> writeTD("rowdata-l"); </script>%value sourceOfTruth%</TD>
				</TR>

				<SCRIPT>swapRows();</SCRIPT>
				<TR>
					<script> writeTD("row"); </script>Type</TD>
					<script> writeTD("rowdata-l"); </script> %value bundleType%</TD>
				</TR>
				<SCRIPT>swapRows();</SCRIPT>

				<TR>
					<script> writeTD("row"); </script>Description</TD>
					<script> writeTD("rowdata-l"); </script> 
					%ifvar /defineAuthorized equals('true')%
						<INPUT onchange="enableSaveProperties();" name="deploymentSetDescription" value="%value bundleDescription%" size="40">
					%else%
						%value bundleDescription%
					%endif%
					</TD>
				</TR>
				<SCRIPT>swapRows();</SCRIPT>

				<TR>
					<script>writeTDspan("col-l","2");</script>You may specify Regular Expressions to limit the assets displayed for the following types.&nbsp;&nbsp;(Leave blank to display ALL assets).
				</TR>

				<TR>
					<script> writeTD("row"); </script>Packages</TD>
					<script> writeTD("rowdata-l"); </script> 
					%ifvar /defineAuthorized equals('true')% 
						<INPUT onchange="enableSaveProperties();" name="packageRegExp" value="%value packageRegExp%" size="32">
					%else%
						%value packageRegExp%
					%endif%
					</TD>
				</TR>
				<SCRIPT>swapRows();</SCRIPT>
				<TR>
					<script> writeTD("row"); </script>All other types</TD>
					<script> writeTD("rowdata-l"); </script> 
					%ifvar /defineAuthorized equals('true')% 
						<INPUT onchange="enableSaveProperties();" name="otherRegExp" value="%value otherRegExp%" size="32">
					%else%
						%value otherRegExp%
					%endif%
					</TD>
				</TR>
				<SCRIPT>swapRows();</SCRIPT>

			%endinvoke%

			%ifvar /defineAuthorized equals('true')%
				<TR>
					<INPUT type="hidden" name="projectName" value="%value projectName%">
					<INPUT type="hidden" name="deploymentSetName" value="%value bundleName%">
					<INPUT type="hidden" name="bundleName" value="%value bundleName%">
					<INPUT type="hidden" name="pluginType" value="%value pluginType%">
					<INPUT type="hidden" name="action" value="updateDeploymentSet">
					<TD class="action" colspan="2">
						<INPUT id="saveProperties" disabled onclick="return onSaveProperties();" align="center" type="submit" VALUE="Save" name="submit"> </TD>
				</TR>
			%endif%

				</FORM>
			</TABLE>
		</TD>
	</TR>

	<TR>
    <TD><IMG src="images/blank.gif" height="5" width="0"></TD>
	</TR>

	<TR>
    <TD><IMG height="10" src="images/blank.gif" width="5"></TD>
    <TD>
      <TABLE class="tableView" width="100%">
        <TR>
			%ifvar /defineAuthorized equals('true')%
				%ifvar /isReferencesOtherServers equals('false')%
					%ifvar bundleMode equals('Deploy')%
						<TD class="heading" colspan=5>Select Source %value pluginType% Servers</TD>
					%else%
						<TD class="redheading" colspan=5>Select %value pluginType% Servers</TD>
					%endif%
				%else%
					%ifvar bundleMode equals('Deploy')%
						<TD class="heading" colspan=5>Select Source %value pluginType% Server</TD>
					%else%
						<TD class="redheading" colspan=5>Select %value pluginType% Server</TD>
					%endif%
				%endif%
			%else%
				%ifvar /isReferencesOtherServers equals('false')%
					%ifvar bundleMode equals('Deploy')%
						<TD class="heading" colspan=5>Source %value pluginType% Servers</TD>
					%else%
						<TD class="redheading" colspan=5>%value pluginType% Servers</TD>
					%endif%
				%else%
					%ifvar bundleMode equals('Deploy')%
						<TD class="heading" colspan=5>Source %value pluginType% Server</TD>
					%else%
						<TD class="redheading" colspan=5>%value pluginType% Server</TD>
					%endif%
				%endif%
			%endif%
        </TR>

%comment%
				<FORM name="deploymentSetForm" method="POST" action="under-construction.dsp">
%endcomment%
				<FORM METHOD="post" ACTION="define-plugin-sources.dsp">
					<input type="hidden" name="action" value="updateSources">
					<input type="hidden" name="projectName" value="%value projectName%">
					<input type="hidden" name="pluginType" value="%value pluginType%">
					<input type="hidden" name="bundleName" value="%value bundleName%">

				<TR>
					<td class="oddcol">Select</td>
					<td class="oddcol-l">Name</td>
					<td class="oddcol-l">Server</td>
					<td class="oddcol-l">Version</td>
				</TR>

				<script>resetRows(); </script>
		%invoke wm.deployer.gui.UIPlugin:listPluginServers%
			%loop pluginServers%
				<TR>
					<script>writeTD("rowdata", "nowrap");</script>
					%ifvar /isReferencesOtherServers equals('false')%
					<input id="alias_%value name -urlencode%" 
						%ifvar /defineAuthorized equals('false')% disabled %endif%
						onclick="enableSaveSource();" type="checkbox" name="%value name%" value="SERVER_INCL">
					%else%
					<input id="alias_%value name -urlencode%" 
						%ifvar /defineAuthorized equals('false')% disabled %endif%
						onclick="enableSaveSource();" type="radio" value="%value name%" name="SERVER_INCL">
					%endif%
					</TD>
					<script> writeTD("rowdata-l", "nowrap");</script> %value name% </TD>
					<script> writeTD("row-l", "nowrap");</script><script>document.write(concatHostAndPortString('%value host%','%value port%'));</script></TD>
					<script> writeTD("row-l", "nowrap");</script>%value runtimeVersion%</TD>
				</TR>
				<script>swapRows();</script>
			%endloop%
		%endinvoke%

		%ifvar /defineAuthorized equals('true')%
				<TR>
	  			<TD colspan=5 class="action">
						<input id="saveSource" disabled type="submit" name="submitB" value="Save">
					</TD>
				</TR>		
		%endif%
				</FORM>
			</TABLE>
		</TD>
	</TR>
</TABLE>

<script>
// Hide any rows that are already mapped to this mapSet
%invoke wm.deployer.gui.UIBundle:getBundleSourceServers%
%loop servers%
	document.getElementById("alias_%value serverAliasName -urlencode%").checked = true;
%endloop%

%ifvar action equals('updateDeploymentSet')%
	// Don't stop the progress bar
%else%
	stopProgressBar();
%endif%

</script>

</BODY>
</HTML>
