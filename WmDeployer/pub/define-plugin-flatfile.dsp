<HTML><HEAD><TITLE>Define %value pluginType%</TITLE>
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META http-equiv=Pragma content=no-cache>
<META http-equiv=Expires content=-1>
<LINK href="webMethods.css" type=text/css rel=stylesheet>
<LINK href="xtree.css" type=text/css rel=stylesheet>
<SCRIPT src="webMethods.js"></SCRIPT>
<script src="xtree.js"></script>
<script src="xtreecheckbox.js"></script>
</HEAD>
<BODY>

<TABLE width="100%">
	<TBODY>
	<TR>
		<TD class=menusection-Deployer>%value bundleName% > %value pluginType%</TD>
	</TR>
	</TBODY>
</TABLE>

<TABLE width="100%">
	<TR>
		<TD colspan="2">
			<UL>
				<LI> <A onclick="return startProgressBar('Refreshing %value pluginType% assets');" href="define-plugin.dsp?pluginType=%value pluginType%&projectName=%value projectName%&bundleName=%value bundleName%&regExp=%value regExp%">Refresh this Page</A></LI> 
			 </UL>
		</TD>
	</TR>
</TABLE>

<TABLE class="tableView" width="100%">
	<TBODY>
	<SCRIPT>resetRows();</SCRIPT>		
	<TR>
		<TD><img border="0" src="images/blank.gif" width="20" height="1"></TD>
		<TD class="heading" valign="top"> Select %value pluginType% Assets </TD>
		<TD valign="top"> <img border="0" src="images/blank.gif" width="20" height="1"></td>
	</TR>

%comment%
	<FORM id="form" name="form" method="POST" target="treeFrame" action="under-construction.dsp">
%endcomment%
	<FORM id="form" name="form" method="POST" target="treeFrame" action="bundle-list.dsp">

	<!- Submit Button, placed at top for convenience ->
	<TR>
 		<TD valign="top"></td>
		<TD class="action">
			<INPUT onclick="return startProgressBar('Saving %value pluginType% assets');" align="center" type="submit" 
				VALUE="Save" name="submit"> </TD>
 		<TD valign="top"></td>
		<INPUT type="hidden" name="pluginType" value='%value pluginType%'>
		<INPUT type="hidden" name="projectName" value='%value projectName%'>
		<INPUT type="hidden" name="bundleName" value='%value bundleName%'>
		<INPUT type="hidden" name="regExp" value='%value regExp%'>
		<INPUT type="hidden" name="action" value="updatePlugin">
	</TR>

	<!- TODO: implement getPluginInfo service to get miscellaneous crap ->
	<SCRIPT>swapRows();</SCRIPT>		
	<TR>
 		<TD valign="top"></td>
		<script>writeTDspan("col-l","1");</script>%value pluginNote%
 		<TD valign="top"></td>
	</TR>

	<SCRIPT>swapRows();</SCRIPT>		
	<TR>
 		<TD valign="top"></td>
		<script> writeTD("rowdata-l", "width='100%'");</script>

<script>

	// Enumerate over entire list of configured sources
	%invoke wm.deployer.gui.UIBundle:getBundleSourceServers%
		%ifvar servers -notempty%
			var devTree = new WebFXTree("%value pluginType%");

			var matchCnt = 0;
			var filterCnt = 0;
			var exceedCnt = 0;
			%loop servers%
				// Ping this server before investing too much in it
				%rename ../pluginType pluginType -copy%
				%rename serverAliasName name -copy%

					// Process this plugin server if the ping succeeds
						var serverTree = new WebFXCheckBoxTreeItem("%value serverAliasName%", null, false, null, 
						webFXTreeConfig.serverIcon, webFXTreeConfig.serverIcon);

						// Get Object Types for this plugin (i: pluginType)
						%rename ../pluginType pluginType -copy%
						%invoke wm.deployer.gui.UIPlugin:listPluginTypes%
						%loop types%

							// list Objects for this type (i:pluginType, i:objectType, i:serverAliasName)
							%rename ../pluginType pluginType -copy%
							%rename ../serverAliasName aliasName  -copy%

							%invoke wm.deployer.gui.UIFlatFile:getAssetsFromFlatFile%
							%ifvar status equals('Success')%

								// Create folder node
								%ifvar folderName -notempty%
									var typeNode = new WebFXCheckBoxTreeItem("%value folderName%", null, false, 
										null, webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon);
								%else%
									var typeNode = new WebFXCheckBoxTreeItem("%value objectType%", null, false, 
										null, webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon);
								%endif%

								// Make the folder node the parent node for the rest
								var folderList = new Array;
								var folderTreeList = new Array;
								folderList[0] = null;
								folderTreeList[0] = typeNode;
								
								// multi-pass algorithm over object list to create folder hierarchy
								// 1st loop: build up the folders and stick in an array for later finding
								%loop objects% 
								%ifvar type equals('folder')%
									// Create folder and stash for later use
									var fItem = new WebFXCheckBoxTreeItem("%value name%", null, false, 
										null, webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon);
									folderList[folderList.length] = "%value id%";
									folderTreeList[folderTreeList.length] = fItem;
								%endif%
								%endloop objects%

								// 2nd pass: iterate over the actual objects and attach to their parent folder
								var maxPluginObjects = "%value ../maxPluginObjects%";
								
								%loop objects%
								%ifvar type equals('folder')%
								%else%
									if (matchCnt < maxPluginObjects)
									{
										if (matchRegularExpression("%value /regExp%", "%value name%")) {
										
											var objNode = new WebFXCheckBoxTreeItem("%value name%", null,
												false, null, "%value ../typeIcon%", "%value ../typeIcon%",
												"%value ../aliasName -urlencode%$PLUGINDEPLOYERDATA$%value ../objectType -urlencode%$PLUGINDEPLOYERDATA$%value name -urlencode%$PLUGINDEPLOYERDATA$%value id -urlencode%$PLUGINDEPLOYERDATA$%value parentId -urlencode%$PLUGINDEPLOYERDATA$%value path -urlencode%$PLUGINDEPLOYERDATA$%value fullName -urlencode%",
												"INCL_%value /pluginType -urlencode%");
	
											var pItem = getFolderParent("%value parentId%", folderList, folderTreeList); 
											pItem.add(objNode);
											matchCnt++;
										}
										else
											filterCnt++;
									}
									else
										exceedCnt++;
								%endif%
								%endloop%

								// 3rd pass: create folder hierarchy
								%loop objects% 
								%ifvar type equals('folder')%
									var fItem = getFolderParent("%value id%", folderList, folderTreeList); 
									var pItem = getFolderParent("%value parentId%", folderList, folderTreeList); 
									pItem.add(fItem);
								%endif%
								%endloop objects%


							%else%
								// Create folder node with error
								%ifvar folderName -notempty%
									var typeNode = new WebFXTreeItem("%value folderName% (%value message -code%)", null,
										null, webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon);
								%else%
									var typeNode = new WebFXTreeItem("%value objectType% (%value message -code%)", null,
										null, webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon);
								%endif%
							%endif%

							// Add folder node to main tree
							serverTree.add(typeNode);
							%endinvoke%
						%endloop%
						%endinvoke%


				devTree.add(serverTree);

			%endloop serverAliases%
		%else%
			var devTree = new WebFXTree("%value pluginType% (no Source Servers configured)");
		%endif%
	%endinvoke servers%

// Remove dead leaves
trimTree(devTree);

// Render the tree 
w(devTree);
</script>
		</TD>
 		<TD valign="top"></td>
	</TR>

<!- If the regular expression is in force, let the user know>
	<TR>
		<TD valign="top"></td>
		<script>
		writeTDspan("col-l","1");
%ifvar regExp -notempty%
		if (exceedCnt == 0) {
			w(matchCnt + " assets displayed. &nbsp;Regular expression '%value regExp%' filtered " + filterCnt + " assets."); 
		}
		else {
			w(exceedCnt + " assets exceeded the " + maxPluginObjects + 
				" asset display limit. &nbsp;Regular expression '%value regExp%' filtered " + filterCnt + 
				" assets. &nbsp;Consider refining your Regular Expression."); 
		}
%else%
		if (matchCnt < maxPluginObjects) {
			w(matchCnt + " assets displayed.");
		}
		else {
			w(exceedCnt + " assets exceeded the " + maxPluginObjects + 
				" asset display limit. &nbsp;Consider a Regular Expression to reduce the list."); 
		}
%endif%
		</script>
		<TD valign="top"></td>
	</TR>

	<!- Submit Button, placed at bottom for convenience ->
	<TR>
 		<TD valign="top"></td>
		<TD class="action">
			<INPUT onclick="return startProgressBar('Saving %value pluginType% assets');" align="center" type="submit" 
				VALUE="Save" name="submit2"> </TD>
 		<TD valign="top"></td>
	</TR>

	</FORM>
	<TBODY>
</TABLE>

<script>
// This bit selects checkboxes from the current definition of the bundle ->

// getBundlePackages: projectName*, bundleName*
%invoke wm.deployer.gui.UIPlugin:getBundlePluginObjects%
	%loop plugins%
	// Only interested in junk of this bundleType (aka pluginType)
	%ifvar pluginType vequals(../pluginType)%
		%loop servers%
			%loop objectTypes%
				%loop objects%
					// Find the uniquely named Element and check it
					var p = (document.getElementsByName("%value ../../serverAliasName -urlencode%$PLUGINDEPLOYERDATA$%value ../objectTypeName -urlencode%$PLUGINDEPLOYERDATA$%value name -urlencode%$PLUGINDEPLOYERDATA$%value id -urlencode%$PLUGINDEPLOYERDATA$%value parentId -urlencode%$PLUGINDEPLOYERDATA$%value path -urlencode%$PLUGINDEPLOYERDATA$%value fullName -urlencode%")).item(0);
					if (p != null) 
						webFXTreeHandler.all[p.parentNode.id].setChecked(true);
				%endloop objects%
			%endloop objectTypes%
		%endloop servers%
	%endif%
	%endloop plugins%
%endinvoke%

stopProgressBar();

</script>

</BODY></HTML>
