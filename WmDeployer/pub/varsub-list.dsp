<HTML><HEAD>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META http-equiv="Expires" content="-1">
<LINK href="webMethods.css" type="text/css" rel="stylesheet">
<LINK href="xtree.css" type="text/css" rel="stylesheet">
<SCRIPT src="webMethods.js"></SCRIPT>
<SCRIPT src="xtree.js"></SCRIPT>
<BODY>

<SCRIPT language=JavaScript>	
</SCRIPT>

<TABLE width="100%">
    <TR>
      <TD class="menusection-Deployer" colspan="2">%value serverAlias% > Configurable Assets</TD>
    </TR>
</TABLE>

<TABLE width="100%">
	<TR>
		<TD colspan="2">
			<UL>
         <LI><A href="javascript:parent.document.location.reload()">Refresh this Page</A>
			</UL>
		</TD>
	</TR>

	<TR>
		<TD><IMG height="0" src="images/blank.gif" width="5" border="0"></TD>
		<TD>
			<TABLE class="tableView" width="100%">
				<TR>
					<TD class="heading" colspan=2>Configurable Assets</TD>
				</TR>

				<SCRIPT> resetRows(); </SCRIPT>
			
	
		<!- projectName* deploymentSetName ->
		%rename bundleName deploymentSetName -copy%
		%invoke wm.deployer.gui.UIVarsub:listVarSubItems%
			%ifvar items -notempty% 
				<TR>
					<SCRIPT> writeTD("col-l"); </SCRIPT> 
						Click on a tree object to view its source configuration and optionally substitute values on the target server.  </TD>
				</TR>
				<SCRIPT> swapRows(); </SCRIPT>
				<TR>
					<SCRIPT> writeTD("rowdata-l"); </SCRIPT> 

					<SCRIPT>
						var items = new WebFXTree("Deployment Set '%value bundleName%'");
						var serverList = new Array;
						var serverTreeList = new Array;
						var taskTreeList = new Array;
						var portTreeList = new Array;
						var extTreeList = new Array;

						var webServicesList = new Array;
						var packageList = new Array;
						var packageTreeList = new Array;

						// Array to hold the serverAlias:objectType Tree nodes
						var objectList = new Array;
						var objectTreeList = new Array;
						
						// Populate the complete list of source servers for later usage
						%loop items%
							var serverTree = getServerTree("%value sourceServerAlias%", serverList, serverTreeList);
							if (serverTree == null) {

								// Add this Server Node to the main search list 
								serverList[serverList.length] = "%value sourceServerAlias%";

								// Create tree node for server, add to List, and attach it to main tree
								var serverTree = new WebFXTreeItem("%value sourceServerAlias%", null, null, 
									webFXTreeConfig.serverIcon, webFXTreeConfig.serverIcon);
								serverTreeList[serverTreeList.length] = serverTree;
								items.add(serverTree);

								// Create Scheduled Task tree node but don't add it yet
								var taskTree = new WebFXTreeItem("Scheduled Tasks");
								taskTreeList[taskTreeList.length] = taskTree;

								// Create Port tree node but don't add it yet
								var portTree = new WebFXTreeItem("Ports");
								portTreeList[portTreeList.length] = portTree;

								// Create Extended Settings tree node but don't add it yet
								var extTree = new WebFXTreeItem("Extended Settings");
								extTreeList[extTreeList.length] = extTree;

								// Create Web Services tree node but don't add it yet
 								var webServiceTree = new WebFXTreeItem("Web Service Descriptor");
 								webServicesList[webServicesList.length] = webServiceTree;

								// Object Type folder node
								var objectTree = getServerTree("%value sourceServerAlias%:%value type%", objectList, objectTreeList);
								if (objectTree == null) {
									// Add this Object Node to the list
									objectList[objectList.length] = "%value sourceServerAlias%:%value type%";

									// Create tree node for this object type, add to List, but don't add it yet
									objectTree = new WebFXTreeItem("%value label%");
									objectTreeList[objectTreeList.length] = objectTree;
								}
							}

							// For stuff in Packages, build a unique Package List
							%ifvar packageName -notempty%
								var packageTree = getServerTree("%value sourceServerAlias%:%value packageName%", 
									packageList, packageTreeList);
								if (packageTree == null) {

									// Add this Server Node to the main search list 
									packageList[packageList.length] = "%value sourceServerAlias%:%value packageName%";

									// Create node for Package and add to treeList
									var packageTree = new WebFXTreeItem("%value packageName%", null, null, 
										webFXTreeConfig.ISPackage, webFXTreeConfig.ISPackage);
									packageTreeList[packageTreeList.length] = packageTree;

									// Find server node and attach here
									var serverTree = getServerTree("%value sourceServerAlias%", serverList, serverTreeList);
									serverTree.add(packageTree);
								}
							%endif%
						%endloop%

						// Now iterate through and attach as necessary
						%loop items%
							var serverTree = getServerTree("%value sourceServerAlias%", serverList, serverTreeList);
						%ifvar pluginType equals('IS')% 
							%switch type% 
							%case 'ScheduledService'%
								var taskTree = getServerTree("%value sourceServerAlias%", serverList, taskTreeList);
								if (taskTree.parentNode == null)
									serverTree.add(taskTree);
									
								var node = new WebFXTreeItem("%value service%", "varsub-task-page.dsp?projectName=%value ../projectName%&deploymentMapName=%value ../mapSetName%&deploymentSetName=%value ../deploymentSetName%&sourceServerAlias=%value sourceServerAlias%&targetServerAlias=%value ../serverAlias%&service=%value service%&key=%value taskId%&varSubItemType=%value type%&mode=edit", 
									null, webFXTreeConfig.ISTask, webFXTreeConfig.ISTask, webFXTreeConfig.propertyClass, "varSubBottom");
								taskTree.add(node);

							%case 'Port'%
								var portTree = getServerTree("%value sourceServerAlias%", serverList, portTreeList);
								if (portTree.parentNode == null)
									serverTree.add(portTree);
									
								var node = new WebFXTreeItem("%value -code name%", 
				"varsub-port-page.dsp?projectName=%value ../projectName%&deploymentMapName=%value ../mapSetName%&deploymentSetName=%value ../deploymentSetName%&sourceServerAlias=%value sourceServerAlias%&targetServerAlias=%value ../serverAlias%&key=%value -code name%&varSubItemType=%value type%&mode=edit", 
									null, webFXTreeConfig.ISPort, webFXTreeConfig.ISPort, webFXTreeConfig.propertyClass, "varSubBottom");
								portTree.add(node);

							%case 'ExtendedSettings'%
								var extTree = getServerTree("%value sourceServerAlias%", serverList, extTreeList);
								if (extTree.parentNode == null)
									serverTree.add(extTree);
									
								var node = new WebFXTreeItem("%value name%", "varsub-setting-page.dsp?projectName=%value ../projectName%&deploymentMapName=%value ../mapSetName%&deploymentSetName=%value ../deploymentSetName%&sourceServerAlias=%value sourceServerAlias%&targetServerAlias=%value ../serverAlias%&key=%value name%&varSubItemType=%value type%&mode=edit", 
									null, webFXTreeConfig.ISExtended, webFXTreeConfig.ISExtended, webFXTreeConfig.propertyClass,"varSubBottom");
								extTree.add(node);

							%case 'webServiceDescriptor'%
 								var webServiceTree = getServerTree("%value sourceServerAlias%", serverList, webServicesList);								
 								if (webServiceTree.parentNode == null)
 									serverTree.add(webServiceTree);    							
 								var node = new WebFXTreeItem("%value Name%", "varsub-wsd-page.dsp?projectName=%value ../projectName%&deploymentMapName=%value ../mapSetName%&deploymentSetName=%value ../bundleName%&sourceServerAlias=%value sourceServerAlias%&targetServerAlias=%value ../serverAlias%&key=%value Name%&pluginType=%value pluginType%&varSubItemType=%value type%&packageName=%value packageName%&mode=edit", 
 									null, webFXTreeConfig.ISWSD, webFXTreeConfig.ISWSD, webFXTreeConfig.propertyClass, "varSubBottom");
 								webServiceTree.add(node);


							%case 'AdapterConnection'%
								var packageTree = getServerTree("%value sourceServerAlias%:%value packageName%", 
									packageList, packageTreeList);

								var node = new WebFXTreeItem("%value name%", 
				"varsub-connection-page.dsp?projectName=%value ../projectName%&deploymentMapName=%value ../mapSetName%&deploymentSetName=%value ../deploymentSetName%&sourceServerAlias=%value sourceServerAlias%&targetServerAlias=%value ../serverAlias%&key=%value name%&varSubItemType=%value type%&packageName=%value packageName%&mode=edit", 
								null, getNSIcon("%value type%"), getNSIcon("%value type%"), webFXTreeConfig.propertyClass,"varSubBottom");
								packageTree.add(node);

							%case 'AdapterNotification'%
								var packageTree = getServerTree("%value sourceServerAlias%:%value packageName%", 
									packageList, packageTreeList);

								var node = new WebFXTreeItem("%value name%", 
				"varsub-notification-page.dsp?projectName=%value ../projectName%&deploymentMapName=%value ../mapSetName%&deploymentSetName=%value ../deploymentSetName%&sourceServerAlias=%value sourceServerAlias%&targetServerAlias=%value ../serverAlias%&key=%value name%&varSubItemType=%value type%&mode=edit", 
								null, getNSIcon("%value type%"), getNSIcon("%value type%"), webFXTreeConfig.propertyClass,"varSubBottom");
								packageTree.add(node);
								
							%case 'AdapterListener'%
								var packageTree = getServerTree("%value sourceServerAlias%:%value packageName%", 
									packageList, packageTreeList);

								var node = new WebFXTreeItem("%value name%", 
				"varsub-listener-page.dsp?projectName=%value ../projectName%&deploymentMapName=%value ../mapSetName%&deploymentSetName=%value ../deploymentSetName%&sourceServerAlias=%value sourceServerAlias%&targetServerAlias=%value ../serverAlias%&key=%value name%&varSubItemType=%value type%&mode=edit", 
								null, getNSIcon("%value type%"), getNSIcon("%value type%"), webFXTreeConfig.propertyClass,"varSubBottom");
								packageTree.add(node);	 								
							%endswitch% 

						%else% 
							// Generic plugin types now
							var objectTree = getServerTree("%value sourceServerAlias%:%value type%", objectList, objectTreeList);
							if (objectTree.parentNode == null)
									serverTree.add(objectTree);
									
							var node = new WebFXTreeItem("%value name%", "varsub-plugin-page.dsp?projectName=%value ../projectName%&deploymentMapName=%value ../mapSetName%&deploymentSetName=%value ../deploymentSetName%&sourceServerAlias=%value sourceServerAlias%&targetServerAlias=%value ../serverAlias%&key=%value name%&pluginType=%value pluginType%&varSubItemType=%value type%&mode=edit", 
									null, "%value typeIcon%", "%value typeIcon%", webFXTreeConfig.propertyClass,"varSubBottom");
								objectTree.add(node);
						%endif% 
						%endloop%

						w(items);
					</SCRIPT>
					</TD>
				</TR>
			%else% 
				<TR>
					<SCRIPT> writeTD("row-l"); </SCRIPT> <FONT color="red"> * No configurable assets </FONT> </TD>
				</TR>
			%endif% 
		%endinvoke%
				
			</TABLE>
		</TD>
	</TR>

</TABLE>
</BODY>
</HTML>
