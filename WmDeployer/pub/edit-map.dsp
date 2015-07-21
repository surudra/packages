<HTML><HEAD>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META http-equiv="Expires" content="-1">
<LINK href="webMethods.css" type="text/css" rel="stylesheet">
<SCRIPT src="webMethods.js"></SCRIPT>
<SCRIPT src="xtree.js"></SCRIPT>
<SCRIPT src="xtreecheckbox.js"></SCRIPT>

</HEAD>
<BODY>

<SCRIPT language=JavaScript>
var problemOnTarget = false;

function confirmDelete(map, target)
{
	if (confirm("OK to delete Target Server " + target + " from Deployment Map " + map + "?\n\nThis action is not reversible.")) {
		startProgressBar();
		return true;
	}

	return false;
}

function enableSaveDescription() {
	document.getElementById("saveDescription").disabled = false;
}

function showImportVarsub(){
	var importvarsubcontainer = document.getElementById("varsubContainer");
	var varsuball = document.getElementById("varsubAll");
	var varsubfew = document.getElementById("varsubFew");
	varsuball.style.display="";
	varsubfew.style.display="none";
	importvarsubcontainer.style.display="";
	//document.getElementById("pfilter").focus();
}
var serverTree = new Array();

function hideImportVarsub(){
	var importvarsubcontainer = document.getElementById("varsubContainer");
	var varsuball = document.getElementById("varsubAll");
	var varsubfew = document.getElementById("varsubFew");
	varsuball.style.display="none";
	varsubfew.style.display="";
	importvarsubcontainer.style.display="none";
	//document.getElementById("pfilter").focus();
}
</SCRIPT>

<TABLE width="100%">
    <TR>
      <TD class="menusection-Deployer" colspan="2">%value mapSetName% > Properties</TD>
    </TR>
</TABLE>

<TABLE>
%ifvar action equals('addTargetGroup')%
	<!- projectName, pluginType (may be null), bundleName, mapSetName, series of TARGET_GROUP_ALIAS:name pairs ->
	%invoke wm.deployer.gui.UITargetGroup:addTargetGroupsInSet%	
		%include error-handler.dsp%
	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%end if%

%ifvar action equals('add')%
	<!- projectName, pluginType (may be null), bundleName, mapSetName, series of SERVER_ALIAS:name pairs ->
	%invoke wm.deployer.gui.UITarget:addMapsToSet%
		%include error-handler.dsp%

	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%end if%


%ifvar action equals('deleteGroup')%
	<!- projectName, pluginType (may be null), bundleName, mapSetName, targetGroupAlias ->
	%invoke wm.deployer.gui.UITargetGroup:removeTargetGroupsFromSet%
		%include error-handler.dsp%

	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%end if%

%ifvar action equals('delete')%
	<!- projectName, pluginType (may be null), bundleName, mapSetName, serverAlias ->
	%invoke wm.deployer.gui.UITarget:removeMapFromSet%
		%include error-handler.dsp%

	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%end if%

%ifvar action equals('updateMapSet')%
	<!- projectName, bundleName, mapSetName, serverAlias ->
	%invoke wm.deployer.gui.UITarget:updateMapSet%
		%include error-handler.dsp%

		%ifvar status equals('Success')%
			<script>
				parent.treeFrame.document.getElementById("desc_%value mapSetName -urlencode%").innerHTML = "%value mapSetDescription%";
			</script>
		%end if%
	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%end if%

%ifvar action equals('exportVarsub')%
	<!- projectName, pluginType (may be null), bundleName, mapSetName, serverAlias ->
	%invoke wm.deployer.gui.UIVarsub:exportVarsub1%
		%ifvar status equals('Success')%
			<script>writeMessage("Varsub File written to replicate\\outbound folder of WmDeployer Package on %sysvar host%.");</script>
			<script>window.open("projects/%value ../encodedProjName%/mapExports/%value ../encodedProjName%_%value mapSetName%_VarSub.xml");</script>
		%else%
			%ifvar errorCode equals('100')%				
				<script>window.open("projects/%value ../encodedProjName%/mapExports/%value ../encodedProjName%_%value mapSetName%_VarSub.xml");</script>
				%include error-handler.dsp%
			%else%
				%include error-handler.dsp%
			%endif%
		%endif%
	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%end if%

%ifvar action equals('importVarsub')%
	<!- projectName, pluginType (may be null), bundleName, mapSetName, serverAlias ->
	%invoke wm.deployer.gui.UIVarsub:importVarsub1%
		%include error-handler.dsp%

	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%end if%

%ifvar action equals('addDependents')%
	%invoke wm.deployer.gui.UITarget:addDependentsToBundle%
		%include error-handler.dsp%
	%onerror%
		%loop -struct%
			<TR><TD>%value $key%=%value%</TD></TR>
		%endloop%
	%end invoke%
%end if%

%ifvar action equals('removeComponents')%
	%invoke wm.deployer.gui.UITarget:removeComponentsFromBundle%
		%include error-handler.dsp%
	%onerror%
		%loop -struct%
			<TR><TD>%value $key%=%value%</TD></TR>
		%endloop%
	%end invoke%
%end if%
</TABLE>

%invoke wm.deployer.gui.UIProject:getProjectInfo%

<TABLE width="100%">
	<TR>
		<TD colspan="2">
			<UL>
				<LI><A onclick="startProgressBar();" href="edit-map.dsp?projectName=%value projectName%&mapSetName=%value mapSetName%&mapSetDescription=%value mapSetDescription%">Refresh this Page</A></LI>
				%ifvar /mapAuthorized equals('true')%
				<LI><A href="varsub-by-assets-manager.dsp?projectName=%value -htmlcode projectName%&mapSetName=%value -htmlcode mapSetName%&mapSetDescription=%value -htmlcode mapSetDescription%" target="_blank">Configure Build By Assets</A></LI>
				<LI><A href="varsub-server-manager.dsp?projectName=%value -htmlcode projectName%&mapSetName=%value -htmlcode mapSetName%&mapSetDescription=%value -htmlcode mapSetDescription%" target="_blank">Configure Build By Servers</A></LI>
				<LI><A onclick="startProgressBar();" href="edit-map.dsp?projectName=%value projectName%&mapSetName=%value mapSetName%&action=exportVarsub">Export Variable Substitution</A></LI>
				<form name="importVarsub" method="POST" action="edit-map.dsp">
				<input type="hidden" name="action" value="importVarsub">
				<input type="hidden" name="projectName" value="%value projectName%">
				<input type="hidden" name="mapSetName" value="%value mapSetName%">
				<LI id="varsubFew"><A onclick="startProgressBar();" href="javascript:showImportVarsub(true)">Import Variable Substitution</A></LI>
				<LI style="display:none" id="varsubAll"><A onclick="startProgressBar();" href="javascript:hideImportVarsub(true)">Import Variable Substitution</A></LI>
				
				<DIV id="varsubContainer" name="varsubContainer" style="display:none;padding-top=2mm;"><br>
				
				%invoke wm.deployer.gui.UITarget:listImportVarsubs%
					%ifvar importVS -notempty%
						<select name="importFileName">
				%loop importVS%
				<option value="%value mapName%.vs">%value mapName%</option>
				%endloop%
						</select>
						<input type="submit" value="Import">
					%else%
						<font color="red">* No Varsubs to import (*.vs)</font>
					%endif%
				%end invoke%
				</DIV>
				</form>
				%endif%
			</UL>
		</TD>
	</TR>

	<TR>
		<TD><IMG height="0" src="images/blank.gif" width="5" border="0"></TD>
		<TD>
			<TABLE class="tableView" width="100%">
				<TR>
					<TD class="heading" colspan=2>Deployment Map Properties</TD>
				</TR>

				<FORM name="mapSetForm" method="POST" action="edit-map.dsp">

				<TR>
					<TD nowrap class="oddrow">Name</TD>
					<TD class="oddrowdata-l">%value mapSetName%</TD>
				</TR>

				<TR>
					<TD nowrap class="evenrow">Description</TD>
					%ifvar /mapAuthorized equals('true')%
					<TD class="evenrow-l"><INPUT onchange="enableSaveDescription();" name="mapSetDescription" value="%value mapSetDescription%" size="32">
					%else%
					<TD class="evenrow-l">%value mapSetDescription%
					%endif%
					</TD>
				</TR>
				
				<TR>
					<TD nowrap class="oddrow">Status</TD>
					<TD class="oddrowdata-l">
					<IMG ID="status_%value mapSetName -urlencode%" src="images/warning.gif" border="0" width="14" height="14"> </TD>					
				</TR>

			%ifvar /mapAuthorized equals('true')%
				<TR>
					<INPUT type="hidden" name="projectName" value='%value projectName%'>
					<INPUT type="hidden" name="mapSetName" value='%value mapSetName%'>
					<INPUT type="hidden" name="action" value="updateMapSet">

					<TD class="action" colspan="2">
						<INPUT id="saveDescription" onclick="return startProgressBar();" align="center" type="submit" VALUE="Save" name="submit"> </TD>
				</TR>
			%endif%

				</FORM>

			</TABLE>
		</TD>
	</TR>

	<TR>
		<TD><IMG height="4" src="images/blank.gif" width="0" border="0"></TD>
	</TR>

	<TR>
		<TD><IMG height="0" src="images/blank.gif" width="5" border="0"></TD>
		<TD>
			<TABLE class="tableView" width="100%">
				<TR>
					<TD class="heading" colspan=2>Deployment Map Topology</TD>
				</TR>

				<TR>
					<TD width="25%" class="oddcol-l">Set</TD>
					<TD width="75%" class="oddcol">Set Mapping</TD>
				</TR>


				<SCRIPT>resetRows();</SCRIPT>
				<!- projectName ->
				%invoke wm.deployer.gui.UIProject:getProjectBundleNames%
				%loop bundles%


				<TR>
					<SCRIPT>writeTDrowspan('rowdata-l',4);</SCRIPT> %value bundleName% 
					%ifvar bundleType equals('IS')% 
					(IS & TN)
					%else%
						%ifvar bundleType equals('ProcessModel')% 
						(BPM (ProcessModel))					
						%else%						
						(%value bundleType%)
					%endif%						
					%endif%</TD>

					<SCRIPT>writeTD('row-l');</SCRIPT> 
					%ifvar /mapAuthorized equals('true')%
						%ifvar bundleType equals('IS')%
					<A onclick="return startProgressBar();" 
						href="add-is-target.dsp?projectName=%value ../projectName%&bundleName=%value bundleName%&mapSetName=%value ../mapSetName%&mapSetDescription=%value ../mapSetDescription%">Add Target Server</A></TD>
						%else%
					<A onclick="return startProgressBar();" 
						href="add-plugin-target.dsp?projectName=%value ../projectName%&pluginType=%value bundleType%&bundleName=%value bundleName%&mapSetName=%value ../mapSetName%&mapSetDescription=%value ../mapSetDescription%">Add Target Server</A></TD>
						%endif%
					%endif%

					<TR>
						<TD style="padding: 0px;">
							<TABLE class="tableInline" width=100% cellspacing=1>
								<COLGROUP><COL width="85%"><COL width="15%"></COLGROUP>

								<!- projectName, mapSetName, bundleName ->
								%rename ../projectName projectName -copy%	
								%rename ../mapSetName mapSetName -copy%	
								%scope param(refreshTargetServerAliasCache='true')%
								%invoke wm.deployer.gui.UITarget:listMapsInSet%
								%ifvar maps -notempty%
								<script>swapRows();</script>
								<TR>
									<script>writeTD("col-l");</script>Target Server</TD>
									<script>writeTD("col");</script>References</TD>
									<script>writeTD("col");</script>Delete</TD>
								</TR>
								<script>swapRows();</script>
								%loop maps%
								<TR>

									<!- Target Server Name ->
								<script>writeTD("rowdata-l");</script> %value serverAlias% </TD>

									<!- Target Depedencies ->
								<SCRIPT>writeTD("rowdata", "nowrap");</SCRIPT> 
								%ifvar /reduceDependencyChecks equals('true')%
                <IMG src="images/ns_unknown_node.gif" border="no" width="14" height="14">
								%else%
								  %ifvar /reduceDependencyChecks equals('none')%
								  	%ifvar missingReferencedComponents equals('false')%
                						<IMG src="images/green_check.gif" border="no" width="14" height="14">
                					%else%
                						<IMG src="images/ns_unknown_node.gif" border="no" width="14" height="14">
                						<SCRIPT> problemOnTarget = true; </SCRIPT>
                					%endif%
								  %else%
									  %ifvar missingReferencedComponents equals('true')%
                <IMG src="images/dependency.gif" border="no" width="14" height="14">
								<SCRIPT> problemOnTarget = true; </SCRIPT>
									  %else%
											%ifvar versionMismatch equals('true')%
											<IMG src="images/dependency.gif" border="no" width="14" height="14" alt="Version Mismatch">
											<SCRIPT> problemOnTarget = true; </SCRIPT>
											%else%
												%ifvar missingReferencedComponents equals('false')%
												<IMG src="images/green_check.gif" border="no" width="14" height="14">
												%else%
												<IMG src="images/dependency.gif" border="no" width="14" height="14" alt="Unable to verify references on this Target." title="Unable to verify references on this Target.">
												<SCRIPT> problemOnTarget = true; </SCRIPT>
												%endif%
											%endif%
									  %endif%
									%endif%
								%endif%
								<A onclick="return startProgressBar('Checking Target Dependencies');" target="propertyFrame" href="target-dependency.dsp?projectName=%value ../projectName%&bundleName=%value ../bundleName%&pluginType=%value ../bundleType%&mapSetName=%value ../mapSetName%&targetServerAliasName=%value serverAlias%&mapSetDescription=%value ../../../mapSetDescription%&missingReferences=%value missingReferencedComponents%"> Check

									<!- Launch varsub page ->
									<!- Delete Icon ->
									<script>writeTD("rowdata");</script>
									%ifvar /mapAuthorized equals('true')%
									<A class ="imagelink" onclick="return confirmDelete('%value ../mapSetName%', '%value serverAlias%');"
										href="edit-map.dsp?action=delete&projectName=%value -htmlcode ../projectName%&bundleName=%value -htmlcode ../bundleName%&mapSetName=%value -htmlcode ../mapSetName%&serverAlias=%value -htmlcode serverAlias%">
										<IMG SRC="images/delete.gif" border=0 alt="Delete this target server."></A></TD>
									%else%
										<IMG SRC="images/delete_disabled.gif" border=0></TD>
									%endif%
								</TR>
								%endloop maps%
								%else%
								<TR> <SCRIPT>writeTD("row-l");</script><B><FONT color="red">* The deployment set is not mapped.</B></FONT></TD> </TR>
								%endif maps%
								%endinvoke listMapsInSet%
                               %end%
							</TABLE>
						</TD>

				</TR>
				<tr>
					<SCRIPT>writeTD('row-l');</SCRIPT> 
					%ifvar /mapAuthorized equals('true')%						
					<A onclick="return startProgressBar();" 
						href="add-plugin-targetgroup.dsp?projectName=%value ../projectName%&pluginType=%value bundleType%&bundleName=%value bundleName%&mapSetName=%value ../mapSetName%&mapSetDescription=%value ../mapSetDescription%">Add Target Group</A></TD>
					%endif%	
				</tr>
				<tr><td style="padding: 0px;">
							<TABLE class="tableInline" width=100% cellspacing=1>
								<COLGROUP><COL width="85%"><COL width="15%"></COLGROUP>

								
								
								<!- projectName, mapSetName, bundleName ->
								%rename ../projectName projectName -copy%	
								%rename ../mapSetName mapSetName -copy%	
								
								%invoke wm.deployer.gui.UITargetGroup:listTargetGroupsInSet%
								%ifvar targetGroups -notempty%
								<script>swapRows();</script>
								<TR>
									<script>writeTD("col-l");</script>Target Group</TD>
									<script>writeTD("col");</script>References</TD>
									<script>writeTD("col");</script>Delete</TD>
								</TR>
								<script>swapRows();</script>
								
								%loop targetGroups%
								<script>	
										serverTree = new Array();

										// make the nodes of the server tree for the given target group 
										%rename targetGroupAlias rtgName -copy%	
										%rename ../bundleType pluginType -copy%	
										%invoke wm.deployer.gui.UITargetGroup:listTargetGroupServers%
										var cnt = 0;
										%loop targetGroupServers%

									    serverTree[%value $index%] = new WebFXTreeItem("%value name%", null, null, 
										webFXTreeConfig.serverIcon, webFXTreeConfig.serverIcon);
										
												var cnt = %value $index% + 1;
										%endloop targetGroupServers%
										
                   %loop targetGroupClusters%
                          
                          serverTree[%value $index% + cnt] = new WebFXTreeItem("%value clusterName%", null, null, 
    										webFXTreeConfig.clusterServer, webFXTreeConfig.clusterServer);        								        
        						%endloop targetGroupClusters%	
        						
										%endinvoke%	
								</script>

								<tr>

								<SCRIPT>writeTD('row-l');</SCRIPT> 
								<script>
									var matchCnt = 0;
									var devTree_%value $index% = new WebFXTree("%value targetGroupAlias%",null,null,webFXTreeConfig.targetGroupIcon,webFXTreeConfig.targetGroupIcon);
									
									for (var i=0; i < serverTree.length; i++)
									{
										devTree_%value $index%.add(serverTree[i]);
									}

									w(devTree_%value $index%);
								</script>
								</td>

								<SCRIPT>writeTD("rowdata", "nowrap");</SCRIPT> 
								%ifvar /reduceDependencyChecks equals('true')%
									<IMG src="images/ns_unknown_node.gif" border="no" width="14" height="14">
								%else%
								  %ifvar /reduceDependencyChecks equals('none')%
									<IMG src="images/ns_unknown_node.gif" border="no" width="14" height="14">
								  %else%
									  %ifvar missingReferencedComponents equals('true')%
									 <IMG src="images/dependency.gif" border="no" width="14" height="14">
										<SCRIPT> problemOnTarget = true; </SCRIPT>
									  %else%
											%ifvar versionMismatch equals('true')%
											<IMG src="images/dependency.gif" border="no" width="14" height="14">
											<SCRIPT> problemOnTarget = true; </SCRIPT>
											%else%
												  %ifvar missingReferencedComponents equals('false')%
												 <IMG src="images/green_check.gif" border="no" width="14" height="14">
												  %else%
													<IMG src="images/dependency.gif" border="no" width="14" height="14" alt="Unable to verify references on this Target." title="Unable to verify references on this Target.">
													<SCRIPT> problemOnTarget = true; </SCRIPT>
												  %endif%
											%endif%
									  %endif%
									%endif%
								%endif%

<A onclick="return startProgressBar('Checking Target Dependencies');" target="propertyFrame" href="target-dependency-group.dsp?projectName=%value ../projectName%&bundleName=%value ../bundleName%&pluginType=%value ../bundleType%&mapSetName=%value ../mapSetName%&rtgName=%value targetGroupAlias%&mapSetDescription=%value ../../../mapSetDescription%&pluginType=%value pluginType%&missingReferences=%value missingReferencedComponents%"> Check								
								</td>
								
									<!-- Target Group Tree -->
								
								<!- Target Depedencies ->
								
									<script>writeTD("rowdata");</script>
									%ifvar /mapAuthorized equals('true')%
									<A class ="imagelink" onclick="return confirmDelete('%value ../mapSetName%', '%value serverAlias%');"
										href="edit-map.dsp?action=deleteGroup&projectName=%value -htmlcode ../projectName%&bundleName=%value -htmlcode ../bundleName%&mapSetName=%value -htmlcode ../mapSetName%&targetGroupAlias=%value -htmlcode targetGroupAlias%">
										<IMG SRC="images/delete.gif" border=0 alt="Delete this target Group."></A></TD>
									%else%
										<IMG SRC="images/delete_disabled.gif" border=0></TD>
									%endif%
								</TR>

								%endloop targetGroups% 
								

					
								%else%
								<TR> <SCRIPT>writeTD("row-l");</script><B><FONT color="red">* The deployment set is not mapped.</B></FONT></TD> </TR>
								%endif targetGroups%
								%endinvoke listTargetGroupsInSet%

							</TABLE>
				</td></tr>


				<SCRIPT>swapRows();</SCRIPT>
				%endloop bundles%
				<TR>
					<TD colspan="2">
					<BR>
					</TD>
				</TR>
				%loop deleteBundles%
				<TR>
					<SCRIPT>writeTDrowspan('rowdata-l',4);</SCRIPT>
					<FONT color="#CD3700">
					%value bundleName% 
					%ifvar bundleType equals('IS')% 
					(IS & TN)
					%else%
					(%value bundleType%)
					%endif%
					</FONT></TD>

					<SCRIPT>writeTD('row-l');</SCRIPT> 
					%ifvar /mapAuthorized equals('true')%
						%ifvar bundleType equals('IS')%
					<A onclick="return startProgressBar();" 
						href="add-is-target.dsp?projectName=%value ../projectName%&bundleName=%value bundleName%&mapSetName=%value ../mapSetName%&mapSetDescription=%value ../mapSetDescription%">Add Target Server</A></TD>
						%else%
					<A onclick="return startProgressBar();" 
						href="add-plugin-target.dsp?projectName=%value ../projectName%&pluginType=%value bundleType%&bundleName=%value bundleName%&mapSetName=%value ../mapSetName%&mapSetDescription=%value ../mapSetDescription%">Add Target Server</A></TD>
						%endif%
					%endif%

					<TR>
						<TD style="padding: 0px;">
							<TABLE class="tableInline" width=100% cellspacing=1>
								<COLGROUP><COL width="85%"><COL width="15%"></COLGROUP>

								<!- projectName, mapSetName, bundleName ->
								%rename ../projectName projectName -copy%	
								%rename ../mapSetName mapSetName -copy%	
								%scope param(refreshTargetServerAliasCache='true')%
								%invoke wm.deployer.gui.UITarget:listMapsInSet%
								%ifvar maps -notempty%
								<script>swapRows();</script>
								<TR>
									<script>writeTD("col-l");</script>Target Server</TD>
									<script>writeTD("col");</script>Dependents</TD>
									<script>writeTD("col");</script>Delete</TD>
								</TR>
								<script>swapRows();</script>
								%loop maps%
								<TR>

									<!- Target Server Name ->
								<script>writeTD("rowdata-l");</script> %value serverAlias% </TD>

									<!- Target Depedencies ->
								<SCRIPT>writeTD("rowdata", "nowrap");</SCRIPT> 
									%ifvar missingReferencedComponents equals('true')%
										 <IMG src="images/dependency.gif" border="no" width="14" height="14">
										  <SCRIPT> problemOnTarget = true; </SCRIPT>
								    %else%
									  %ifvar missingReferencedComponents equals('false')%
										    <IMG src="images/green_check.gif" border="no" width="14" height="14">
									  %else%
										    <IMG src="images/dependency.gif" border="no" width="14" height="14" alt="Unable to verify dependents on this Target." title="Unable to verify dependents on this Target.">
											<SCRIPT> problemOnTarget = true; </SCRIPT>
									  %endif%
								   %endif%
								<A onclick="return startProgressBar('Checking Target Dependencies');" target="propertyFrame" href="target-dependency.dsp?projectName=%value ../projectName%&pluginType=%value pluginName%&bundleName=%value ../bundleName%&mapSetName=%value ../mapSetName%&targetServerAliasName=%value serverAlias%&mapSetDescription=%value ../../../mapSetDescription%&missingReferences=%value missingReferencedComponents%"> Check

									<!- Launch varsub page ->
									<!- Delete Icon ->
									<script>writeTD("rowdata");</script>
									%ifvar /mapAuthorized equals('true')%
									<A class ="imagelink" onclick="return confirmDelete('%value ../mapSetName%', '%value serverAlias%');"
										href="edit-map.dsp?action=delete&projectName=%value -htmlcode ../projectName%&bundleName=%value -htmlcode ../bundleName%&mapSetName=%value -htmlcode ../mapSetName%&serverAlias=%value -htmlcode serverAlias%">
										<IMG SRC="images/delete.gif" border=0 alt="Delete this target server."></A></TD>
									%else%
										<IMG SRC="images/delete_disabled.gif" border=0></TD>
									%endif%
								</TR>
								%endloop maps%
								%else%
								<TR> <SCRIPT>writeTD("row-l");</script><B><FONT color="red">* Deletion set not mapped</B></FONT></TD> </TR>
								%endif maps%
								%endinvoke listMapsInSet%
                              %end%
							</TABLE>
						</TD>

				</TR>
				<tr>
					<SCRIPT>writeTD('row-l');</SCRIPT> 
					%ifvar /mapAuthorized equals('true')%						
					<A onclick="return startProgressBar();" 
						href="add-plugin-targetgroup.dsp?projectName=%value ../projectName%&pluginType=%value bundleType%&bundleName=%value bundleName%&mapSetName=%value ../mapSetName%&mapSetDescription=%value ../mapSetDescription%">Add Target Group</A></TD>
					%endif%	
				</tr>
				<tr><td style="padding: 0px;">
							<TABLE class="tableInline" width=100% cellspacing=1>
								<COLGROUP><COL width="85%"><COL width="15%"></COLGROUP>

								
								
								<!- projectName, mapSetName, bundleName ->
								%rename ../projectName projectName -copy%	
								%rename ../mapSetName mapSetName -copy%	
								
								%invoke wm.deployer.gui.UITargetGroup:listTargetGroupsInSet%
								%ifvar targetGroups -notempty%
								<script>swapRows();</script>
								<TR>
									<script>writeTD("col-l");</script>Target Group</TD>
									<script>writeTD("col");</script>Dependents</TD>
									<script>writeTD("col");</script>Delete</TD>
								</TR>
								<script>swapRows();</script>
								
								%loop targetGroups%
								<script>	
										serverTree = new Array();

										// make the nodes of the server tree for the given target group 
										%rename targetGroupAlias rtgName -copy%	
										%rename ../bundleType pluginType -copy%	
										%invoke wm.deployer.gui.UITargetGroup:listTargetGroupServers%
										var cnt = 0;
										%loop targetGroupServers%

									    serverTree[%value $index%] = new WebFXTreeItem("%value name%", null, null, 
										webFXTreeConfig.serverIcon, webFXTreeConfig.serverIcon);
										
												var cnt = %value $index% + 1;
										%endloop targetGroupServers%
                        
                    
                   %loop targetGroupClusters%
                      
                      serverTree[%value $index% + cnt] = new WebFXTreeItem("%value clusterName%", null, null, 
										webFXTreeConfig.clusterServer, webFXTreeConfig.clusterServer);
        								
        
        						%endloop targetGroupClusters%	
										
										%endinvoke%	
								</script>


								<tr>

								<SCRIPT>writeTD('row-l');</SCRIPT> 
								<script>
									var matchCnt = 0;
									var devTree_%value $index% = new WebFXTree("%value targetGroupAlias%",null,null,webFXTreeConfig.targetGroupIcon,webFXTreeConfig.targetGroupIcon);
									
									for (var i=0; i < serverTree.length; i++)
									{
										devTree_%value $index%.add(serverTree[i]);
									}

									w(devTree_%value $index%);
								</script>
								</td>

								<SCRIPT>writeTD("rowdata", "nowrap");</SCRIPT> 
									  %ifvar missingReferencedComponents equals('true')%
											<IMG src="images/dependency.gif" border="no" width="14" height="14">
											<SCRIPT> problemOnTarget = true; </SCRIPT>
									  %else%
										  %ifvar missingReferencedComponents equals('false')%
												<IMG src="images/green_check.gif" border="no" width="14" height="14">
										  %else%
												<IMG src="images/dependency.gif" border="no" width="14" height="14" alt="Unable to verify dependents on this Target." title="Unable to verify dependents on this Target.">
												<SCRIPT> problemOnTarget = true; </SCRIPT>
										  %endif%
									  %endif%

<A onclick="return startProgressBar('Checking Target Dependencies');" target="propertyFrame" href="target-dependency-group.dsp?projectName=%value ../projectName%&pluginType=%value ../bundleType%&bundleName=%value ../bundleName%&mapSetName=%value ../mapSetName%&rtgName=%value targetGroupAlias%&mapSetDescription=%value ../../../mapSetDescription%&pluginType=%value pluginType%&missingReferences=%value missingReferencedComponents%"> Check								
								</td>
								
									<!-- Target Group Tree -->
								
								<!- Target Depedencies ->
								
									<script>writeTD("rowdata");</script>
									%ifvar /mapAuthorized equals('true')%
									<A class ="imagelink" onclick="return confirmDelete('%value ../mapSetName%', '%value serverAlias%');"
										href="edit-map.dsp?action=deleteGroup&projectName=%value -htmlcode ../projectName%&bundleName=%value -htmlcode ../bundleName%&mapSetName=%value -htmlcode ../mapSetName%&targetGroupAlias=%value -htmlcode targetGroupAlias%">
										<IMG SRC="images/delete.gif" border=0 alt="Delete this target Group."></A></TD>
									%else%
										<IMG SRC="images/delete_disabled.gif" border=0></TD>
									%endif%
								</TR>

								%endloop targetGroups% 
								

					
								%else%
								<TR> <SCRIPT>writeTD("row-l");</script><B><FONT color="red">* Deletion set not mapped</B></FONT></TD> </TR>
								%endif targetGroups%
								%endinvoke listTargetGroupsInSet%

							</TABLE>
				</td></tr>


				<SCRIPT>swapRows();</SCRIPT>
				%endloop deleteBundles%
				%endinvoke getProjectBundles%

			</TABLE>
		</TD>
	</TR>
</TABLE>
%endinvoke%

<script>
	stopProgressBar();
	%ifvar /mapAuthorized equals('true')%
		document.mapSetForm.mapSetDescription.focus();		
		if (problemOnTarget == true) 
			%ifvar /reduceDependencyChecks equals('none')%
				//parent.treeFrame.document.all["img_%value mapSetName -urlencode%"].src = "images/ns_unknown_node.gif";
        this.document.all["status_%value mapSetName -urlencode%"].src = "images/ns_unknown_node.gif";				
			%else%
				//parent.treeFrame.document.all["img_%value mapSetName -urlencode%"].src = "images/dependency.gif";
				this.document.all["status_%value mapSetName -urlencode%"].src = "images/dependency.gif";
			%endif%
			//parent.treeFrame.document.all["img_%value mapSetName -urlencode%"].alt = "References missing on one or more Targets";							
	%endif%
	if (problemOnTarget == false) 
		   this.document.all["status_%value mapSetName -urlencode%"].src = "images/green_check.gif";

</script>

</BODY>
</HTML>
