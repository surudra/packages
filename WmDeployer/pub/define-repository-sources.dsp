<HTML><HEAD>
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META http-equiv=Pragma content=no-cache>
<META http-equiv=Expires content=-1>
<LINK href="webMethods.css" type=text/css rel=stylesheet>
<SCRIPT src="webMethods.js"></SCRIPT>
</HEAD>
<BODY>

<SCRIPT>
function updateDS() {
	if (confirm("[DEP.0002.0173] When modifying the deployment set, Deployer will remove any checkpoints created for the associated deployment candidates. You must recreate any checkpoints you want to use. \nDo you want to continue?")) {
		return true;
	}
	
	return false;
}

function enableSaveProperties() {
	document.getElementById("saveProperties").disabled = false;
}

function enableSaveSource(element) {
  var selectedId = element.id; 
  document.getElementById(selectedId).checked = true;
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
    <TD class=menusection-Deployer>%value bundleName% > Properties</TD>
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
			   	   parent.treeFrame.document.location.href = "bundle-list.dsp?projectName=%value -htmlcode projectName%&projectType=Repository&" + _csrfTokenNm_ + "=" + _csrfTokenVal_;
				} else {
				   parent.treeFrame.document.location.href = "bundle-list.dsp?projectName=%value -htmlcode projectName%&projectType=Repository";
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
		%ifvar status equals('Success')%
		<script>
		    var checkpointExists = %value doesCheckpointExistForThisProject%;
        		    if(checkpointExists) {
        		        updateDS();
        		    }
			// refresh Project left-frame 
			startProgressBar("Displaying new Project definition");
			if(is_csrf_guard_enabled && needToInsertToken) {
			   parent.treeFrame.document.location.href = "bundle-list.dsp?projectName=%value -htmlcode projectName%&projectType=Repository&" + _csrfTokenNm_ + "=" + _csrfTokenVal_;
			} else {
			   parent.treeFrame.document.location.href = "bundle-list.dsp?projectName=%value -htmlcode projectName%&projectType=Repository";
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
%endif%
</TABLE>

%invoke wm.deployer.gui.UIProject:getProjectInfo%

<TABLE width="100%">
	<TR>
		<TD colspan="2">
			<UL>
				<LI><A onclick="return startProgressBar();" HREF="define-repository-sources.dsp?projectName=%value projectName%&bundleName=%value bundleName%"> Refresh this Page</A></LI>
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
				<FORM name="deploymentSetForm" method="POST" action="define-repository-sources.dsp">

				<TR>
					<TD class="heading" colspan="2">Set Properties</TD>
				</TR>

				<TR>
					<script> writeTD("row"); </script>Name</TD>
					<script> writeTD("rowdata-l"); </script> %value bundleName%</TD>
				</TR>
				<SCRIPT>swapRows();</SCRIPT>

			%invoke wm.deployer.gui.UIBundle:getBundleProperties%
				<TR>
					<script> writeTD("row"); </script>Source Of Truth</TD>
					<script> writeTD("rowdata-l"); </script>%value ../projectType%</TD>
				</TR>
				<SCRIPT>swapRows();</SCRIPT>
				%ifvar ../projectType equals ('Repository')%
				
				%else
				<TR>
					<script> writeTD("row"); </script>Type</TD>
					%ifvar pluginType%
				  	<script> writeTD("rowdata-l"); </script>%value pluginType%</TD>
				  %else%
				  	<script> writeTD("rowdata-l"); </script>IS & TN</TD>
					%endif%
				</TR>
				<SCRIPT>swapRows();</SCRIPT>
        %endif%

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
                  %comment%
				<TR>
					<script>writeTDspan("col-l","2");</script>You can use the Packages and All other assets fields to narrow the display of assets.&nbsp;&nbsp;Specify a regular expression 
					that specifies the text that the asset names must contain in order to be displayed. <BR>For example, to narrow the display to assets whose name contains a certain string, 
					specify the regular expression <B><i>.*string.*</B></i>&nbsp;&nbsp;For more information, see the webMethods Deployer User's Guide.
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
					<script> writeTD("row"); </script>All other assets</TD>
					<script> writeTD("rowdata-l"); </script> 
					%ifvar /defineAuthorized equals('true')% 
						<INPUT onchange="enableSaveProperties();" name="otherRegExp" value="%value otherRegExp%" size="32">
					%else%
						%value otherRegExp%
					%endif%
					</TD>
				</TR>
				<SCRIPT>swapRows();</SCRIPT>
			%endcomment%
			%endinvoke%

			%ifvar /defineAuthorized equals('true')%
				<TR>
					<INPUT type="hidden" name="projectName" value="%value projectName%">
					<INPUT type="hidden" name="deploymentSetName" value="%value bundleName%">
					<INPUT type="hidden" name="bundleName" value="%value bundleName%">
					<INPUT type="hidden" name="action" value="updateDeploymentSet">
					<TD class="action" colspan="2">
						<INPUT id="saveProperties" onclick="return onSaveProperties();" align="center" type="submit" VALUE="Save" name="submit"> </TD>
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
    <TD><IMG src="images/blank.gif" height="0" width="5"></TD>
    <TD>
      <TABLE class="tableView" width="100%">
        <TR>
					%ifvar /defineAuthorized equals('true')%
						%ifvar bundleMode equals('Deploy')%
						    <TD class="heading" colspan=5>Select Repository </TD>
						%else%
							  <TD class="redheading" colspan=5>Select Servers</TD>
						%endif%
					%else%
						%ifvar bundleMode equals('Deploy')%
					          <TD class="heading" colspan=5>Repository</TD>
						%else%
							  <TD class="heading" colspan=5>Servers</TD>
						%endif%
					%endif%
        </TR>

				<FORM METHOD="post" ACTION="define-repository-sources.dsp">
					<input type="hidden" name="action" value="updateSources">
					<input type="hidden" name="projectName" value="%value projectName%">
					<input type="hidden" name="bundleName" value="%value bundleName%">
					<input type="hidden" name="pluginType" value="%value pluginType%">
				<TR>
					<td class="oddcol" width="20%">Select</td>				
					<td class="oddcol-l">Repository Alias</td>
				<!--	<td class="oddcol" width="20">Repository Type</td> -->			
				</TR>

				<script>resetRows();</script>
				
  		%invoke  wm.deployer.gui.UIRepository:listRepositoryServers%
			%loop repositoryServers%
				<TR>
					<script> writeTD("rowdata", "nowrap");</script>
					<input id="alias_%value aliasName -urlencode%" type="radio" onclick="enableSaveSource(this);" value="%value aliasName%" name="SERVER_INCL"></TD>  				
					<script> writeTD("rowdata-l", "nowrap");</script> %value aliasName% </TD>
				</TR>
				<script>swapRows();</script>
			%endloop%
  		%endinvoke listRepositoryServers%

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
%ifvar /mapAuthorized equals('true')%
	document.deploymentSetForm.deploymentSetDescription.focus();
%endif%
</script>

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

%endinvoke%
</BODY>
</HTML>
