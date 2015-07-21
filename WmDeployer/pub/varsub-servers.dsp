<HTML><HEAD>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META http-equiv="Expires" content="-1">
<LINK href="webMethods.css" type="text/css" rel="stylesheet">
<LINK href="xtree.css" type="text/css" rel="stylesheet">
<SCRIPT src="webMethods.js"></SCRIPT>
<SCRIPT src="xtree.js"></SCRIPT>
<SCRIPT src="xtreeradiobutton.js"></SCRIPT>
<BODY>

<SCRIPT language=JavaScript>
function confirmClearSubstitution()
{
	return confirm("OK to clear all Substitution(s)?\n\nThis action is not reversible.");
}
</SCRIPT>

<TABLE width="100%">
    <TR>
      <TD class="menusection-Deployer" colspan="2">%value mapSetName% > List Of Target Servers</TD>
    </TR>
</TABLE>

<TABLE width="100%">
	<TR>
		<TD colspan="2">
			<UL>
         <LI><A href="javascript:parent.document.location.reload()">Refresh this Page</A>
		 <LI><A onclick="return confirmClearSubstitution();" 
		 href="javascript:parent.document.location.reload()">Clear All Substitution</A>
			</UL>
		</TD>
	</TR>

	<TR>
		<TD><IMG height="0" src="images/blank.gif" width="5" border="0"></TD>
		<TD>
			<TABLE class="tableView" width="100%">
				<TR>
					<TD class="heading" colspan=2>List Of Target Servers</TD>
				</TR>

				<SCRIPT> resetRows(); </SCRIPT>
			
	
		<!-- projectName* deploymentSetName -->
		
				<TR>
					<SCRIPT> writeTD("col-l"); </SCRIPT> 
						Click on a tree object(target server) to view its Deployment Sets.  </TD>
				</TR>
				<SCRIPT> swapRows(); </SCRIPT>
				<TR>
					<SCRIPT> writeTD("rowdata-l"); </SCRIPT> 
           <SCRIPT>
           
           </SCRIPT>
					<SCRIPT>
%invoke wm.deployer.gui.UIProject:getProjectBundleNames%
			%ifvar bundles -notempty% 
var devTree = new WebFXTree("Deployment Sets");
			var matchCnt = 0;
					%loop bundles%
					%rename ../projectName projectName -copy%
					%rename ../mapSetName mapSetName -copy%
					%rename bundleType pluginType -copy%
						var serverTree = new WebFXTreeItem("%value bundleName%");
							%invoke wm.deployer.gui.UITarget:listMapsInSet%
								%ifvar maps -notempty%
									%loop maps%
                  
                  if(is_csrf_guard_enabled && needToInsertToken) {
                var pkgNode = new WebFXRadioButtonTreeItem("%value serverAlias%","varsub-list-manager.dsp?projectName=%value ../projectName%&bundleName=%value ../bundleName%&mapSetName=%value ../mapSetName%&serverAlias=%value serverAlias%" +'&' + _csrfTokenNm_ + '=' + _csrfTokenVal_ , false, null, webFXTreeConfig.serverIcon, webFXTreeConfig.serverIcon,
									"anurag$$PACKAGE_INCL", "PACKAGE_INCL", webFXTreeConfig.linkClass);
               } else {
              var pkgNode = new WebFXRadioButtonTreeItem("%value serverAlias%","varsub-list-manager.dsp?projectName=%value ../projectName%&bundleName=%value ../bundleName%&mapSetName=%value ../mapSetName%&serverAlias=%value serverAlias%", false, null, webFXTreeConfig.serverIcon, webFXTreeConfig.serverIcon,
									"anurag$$PACKAGE_INCL", "PACKAGE_INCL", webFXTreeConfig.linkClass);
                   }  
										
										serverTree.add(pkgNode);
										matchCnt++;
									%endloop maps%
								%endif maps%
							%endinvoke listMapsInSet%
							%invoke wm.deployer.gui.UITargetGroup:listTargetGroupsInSet%
								%ifvar targetGroups -notempty%
									%loop targetGroups%
										var targetGroupNode = new WebFXTreeItem("%value targetGroupAlias%",null, null, 
										webFXTreeConfig.targetGroupIcon, webFXTreeConfig.targetGroupIcon);
											%rename targetGroupAlias rtgName -copy%
											%rename ../pluginType pluginType -copy%
											%rename ../projectName projectName -copy%
											%rename ../mapSetName mapSetName -copy%
											%rename ../bundleName bundleName -copy%
											%invoke wm.deployer.gui.UITargetGroup:listTargetGroupServers%
												%loop targetGroupServers%
                          if(is_csrf_guard_enabled && needToInsertToken) {
                          
                              var targetServers = new WebFXRadioButtonTreeItem("%value name%", 
														"varsub-list-manager.dsp?projectName=%value ../projectName%&bundleName=%value ../bundleName%&mapSetName=%value ../mapSetName%&serverAlias=%value name%" +'&' + _csrfTokenNm_ + '=' + _csrfTokenVal_, 
														false, null, webFXTreeConfig.serverIcon, webFXTreeConfig.serverIcon,
														"anurag$$PACKAGE_INCL", "PACKAGE_INCL", webFXTreeConfig.linkClass);
                          }
                          else {
													var targetServers = new WebFXRadioButtonTreeItem("%value name%", 
														"varsub-list-manager.dsp?projectName=%value ../projectName%&bundleName=%value ../bundleName%&mapSetName=%value ../mapSetName%&serverAlias=%value name%", 
														false, null, webFXTreeConfig.serverIcon, webFXTreeConfig.serverIcon,
														"anurag$$PACKAGE_INCL", "PACKAGE_INCL", webFXTreeConfig.linkClass);
                            }
													targetGroupNode.add(targetServers);
												%endloop targetGroupServers%
	                  						    %loop targetGroupClusters%
													var targetClusters = new WebFXTreeItem("%value clusterName%", 
														null, false, null, webFXTreeConfig.clusterServer, webFXTreeConfig.clusterServer);
													targetGroupNode.add(targetClusters);
    													%loop targetClusterServers%
                              
                              if(is_csrf_guard_enabled && needToInsertToken){
                              
                              var targetClusterServer = new WebFXRadioButtonTreeItem("%value clusterServer%", 
    														"varsub-list-manager.dsp?projectName=%value ../../projectName%&bundleName=%value ../../bundleName%&mapSetName=%value ../../mapSetName%&serverAlias=%value clusterServer%"+'&' + _csrfTokenNm_ + '=' + _csrfTokenVal_ , 
    														false, null, webFXTreeConfig.serverIcon, webFXTreeConfig.serverIcon,
    														"anurag$$PACKAGE_INCL", "PACKAGE_INCL", webFXTreeConfig.linkClass);
                              
                              }
                              
                              else {
    												   	var targetClusterServer = new WebFXRadioButtonTreeItem("%value clusterServer%", 
    														"varsub-list-manager.dsp?projectName=%value ../../projectName%&bundleName=%value ../../bundleName%&mapSetName=%value ../../mapSetName%&serverAlias=%value clusterServer%", 
    														false, null, webFXTreeConfig.serverIcon, webFXTreeConfig.serverIcon,
    														"anurag$$PACKAGE_INCL", "PACKAGE_INCL", webFXTreeConfig.linkClass);
                                
                                }
    													   targetClusters.add(targetClusterServer);
    												%endloop targetClusterServers%
												%endloop targetGroupClusters%														
											%endinvoke listTargetGroupServers%
										serverTree.add(targetGroupNode);
										matchCnt++;
									%endloop targetGroups%
								%endif targetGroups%
							%endinvoke listTargetGroupsInSet%
							devTree.add(serverTree);
					%endloop bundles%		
			%endif%
%endinvoke getProjectBundleNames%
	w(devTree);
					</SCRIPT>
					</TD>
				</TR>
				
			</TABLE>
		</TD>
	</TR>

</TABLE>
</BODY>
</HTML>
