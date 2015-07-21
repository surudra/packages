<HTML><HEAD>
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META http-equiv=Pragma content=no-cache>
<META http-equiv=Expires content=-1>
<LINK href="webMethods.css" type=text/css rel=stylesheet>
<SCRIPT src="webMethods.js"></SCRIPT>
</HEAD>
<BODY>

<SCRIPT>
function doAdd() {
	startProgressBar('Adding Target Servers');
	return true;
}

// Manage the Add button behavior
var checkBoxCount = 0;
function manageAddButtons(obj, clusterName) {
 // alert(obj.name+ " // "+ clusterName+ " // " + obj.id);

	if (obj.checked)  {
      if(clusterName != "") {
      // var response = confirm('Selecting a server which is a node of a Cluster: '+clusterName+". ); 
       alert('Selecting this server which is a node of the Cluster - '+clusterName+' would break the Cluster. For cluster support, proceed by creating a Target Group' ); 
       }
       		checkBoxCount++;
    }
	else
		checkBoxCount--;

	if (checkBoxCount > 0) {
		document.getElementById("addButton").disabled = false;
		document.getElementById("addButton2").disabled = false;
	}
	else {
		document.getElementById("addButton").disabled = true;
		document.getElementById("addButton2").disabled = true;
	}
}
</SCRIPT>

<TABLE width="100%">
  <TR>
    <TD class=menusection-Deployer>%value mapSetName% &gt; %value bundleName% &gt; Add Targets</TD>
  </TR>
</TABLE>

<TABLE width="100%">
	<TR>
		<TD colspan="2">
			<UL>
				<LI><A onclick="return startProgressBar();" href="add-plugin-target.dsp?projectName=%value projectName%&pluginType=%value pluginType%&bundleName=%value bundleName%&mapSetName=%value mapSetName%&mapSetDescription=%value mapSetDescription%">
						Refresh this Page</A></LI>
				<LI><A onclick="return startProgressBar();" href="edit-map.dsp?projectName=%value projectName%&mapSetName=%value mapSetName%&mapSetDescription=%value mapSetDescription%">
						Return to %value mapSetName% > Properties</A></LI>
			</UL>
			<DIV id="messageDiv" name="messageDiv">
			</DIV>
		</TD>
	</TR>

	<FORM METHOD="post" ACTION="edit-map.dsp">
		<input type="hidden" name="action" value="add">
		<input type="hidden" name="projectName" value="%value projectName%">
		<input type="hidden" name="bundleName" value="%value bundleName%">
		<input type="hidden" name="pluginType" value="%value pluginType%">
		<input type="hidden" name="mapSetName" value="%value mapSetName%">
		<input type="hidden" name="mapSetDescription" value="%value mapSetDescription%">

	<TR>
    <TD><IMG height="10" src="images/blank.gif" width="5"></TD>
    <TD>
      <TABLE class="tableView" width="100%">
        <TR>
          <TD class="heading" colspan=5>Add Target %value pluginType% Servers</TD>
        </TR>

				<TR>
			  	<TD colspan=6 class="action">
						<input id="addButton" disabled onclick="return doAdd();" type="submit" name="submit" value="Add">
					</TD>
				</TR>		

				<TR>
					<td class="oddcol">Add</td>
					<td class="oddcol-l">Name</td>
					<td class="oddcol-l">Server</td>
					<td class="oddcol-l">User</td>
					<td class="oddcol-l">Version</td>
				</TR>


		<script>resetRows();</script>
		<!- pluginType ->
		%invoke wm.deployer.gui.UIPlugin:listTargetPluginServers%
			%loop pluginServers%
				<TR>
					<script> writeTD("rowdata", "nowrap");</script>
					<input id="alias_%value name -urlencode%" type="checkbox" onclick="manageAddButtons(this,'%value clusterName%');" name="%value name%" value="SERVER_ALIAS"></TD>
					<script> writeTD("rowdata-l", "nowrap");</script> %value name% </TD>
					<script> writeTD("row-l", "nowrap");</script>%value host%:%value port%</TD>
					<script> writeTD("row-l", "nowrap");</script>%value user%</TD>
					<script> writeTD("row-l", "nowrap");</script>%value runtimeVersion%</TD>						
				</TR>
				<script>swapRows();</script>
			%endloop%
			%ifvar filterVersion -notempty%
			<script>
				var messageDiv = document.getElementById("messageDiv");
				messageDiv.innerHTML = "<TABLE><TR><TD class=\"message\">[DEP.0002.0171] Deployer has applied a filter for targets of version %value filterVersion% on project %value projectName% for map %value mapSetName%.</TD></TR></TABLE>";
			</script>
			%endif%
		%endinvoke%

				<TR>
	  			<TD colspan=6 class="action">
						<input id="addButton2" disabled onclick="return doAdd();" type="submit" name="submitB" value="Add">
					</TD>
				</TR>		
			</TABLE>
		</TD>
	</FORM>
</TABLE>

<script>
// Hide any rows that are already mapped to this mapSet
%invoke wm.deployer.gui.UITarget:listMapsInSet%
%loop maps%
	// document.all.item("alias_%value serverAliasName -urlencode%").disabled  = true;
	document.getElementById("alias_%value serverAlias -urlencode%").checked = true;
	document.getElementById("alias_%value serverAlias -urlencode%").disabled = true;
%endloop%

stopProgressBar();
</script>

</BODY></HTML>
