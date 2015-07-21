var serverTree = new WebFXCheckBoxTreeItem("%value serverAliasName%", null, false, null, 
						webFXTreeConfig.serverIcon, webFXTreeConfig.serverIcon);

						// Get Object Types for this plugin (i: pluginType)
						%rename ../pluginType pluginType -copy%
						%invoke wm.deployer.gui.UIPlugin:listPluginTypes%
						%loop types%

							// list Objects for this type (i:pluginType, i:objectType, i:serverAliasName)
							%rename ../pluginType pluginType -copy%
							%rename ../serverAliasName serverAliasName -copy%
							%invoke wm.deployer.gui.UIPlugin:listPluginObjects%
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
								%ifvar name equals('')%
								   
								%else%
									// Create folder and stash for later use
									var fItem = new WebFXCheckBoxTreeItem("%value name%", null, false, 
										null, webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon);
									folderList[folderList.length] = "%value id%";
									folderTreeList[folderTreeList.length] = fItem;
								%endif%
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
												"%value ../serverAliasName -urlencode%$PLUGINDEPLOYERDATA$%value ../objectType -urlencode%$PLUGINDEPLOYERDATA$%value name -urlencode%$PLUGINDEPLOYERDATA$%value id -urlencode%$PLUGINDEPLOYERDATA$%value parentId -urlencode%$PLUGINDEPLOYERDATA$%value path -urlencode%$PLUGINDEPLOYERDATA$%value fullName -urlencode%",
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
								%ifvar name equals('')%
								    
								%else%
								%ifvar type equals('folder')%
									var fItem = getFolderParent("%value id%", folderList, folderTreeList); 
									var pItem = getFolderParent("%value parentId%", folderList, folderTreeList); 
									pItem.add(fItem);
								%endif%
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