// This file must be included from within a <SCRIPT> tag 

// Return name in list
function findInList(name, nameList) {
	for (n in nameList) {
		if (nameList[s] == name)
			return (name);
	}
	return null;
}

function objectIsTypePackage(t) {
	if ((t == "ISComponent") || (t == "Package") || (t == "ISFile")) 
		return true;
	else
		return false;
}

function parseAndCreateTree(nodeArray, serverTree, addPosition, assetType){
	if(nodeArray != null && nodeArray.length > 0){	
		if(addPosition >= nodeArray.length){
			return;
		}
		var doAdd = true;
		var existingNodePos = -1;
		
		for (var i = 0; i < serverTree.childNodes.length; i++) {
			if(serverTree.childNodes[i].text == nodeArray[addPosition]){
				existingNodePos = i;
				doAdd = false;
				break;
			}
		}
		var subNode = null;
		if(doAdd){
			subNode = new WebFXTreeItem(nodeArray[addPosition],null,null,getACDLIcon(assetType), getACDLIcon(assetType));
			serverTree.add(subNode,true);
		}
		else {
			subNode = serverTree.childNodes[existingNodePos];
		}
		
		addPosition = addPosition+1;
		parseAndCreateTree(nodeArray,subNode,addPosition, assetType);
	}
}
	
%rename bundleType pluginType -copy%

// The Bundle node
%ifvar sourceOfTruth equals('Runtime')%
var bundle = new WebFXTree("%value bundleName% (%value pluginType%)", 
	"define-plugin-sources.dsp?projectName=%value ../projectName%&pluginType=%value pluginType%&bundleName=%value bundleName%",
	null, webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon, webFXTreeConfig.propertyClass);
	%else%
	%ifvar bundleMode equals('Delete')%
	       var bundle = new WebFXTree("%value bundleName%",
	"define-deletionset-plugin-sources.dsp?isRepositoryDeletionSet=true&projectName=%value ../projectName%&pluginType=%value pluginType%&bundleName=%value bundleName%",
	null, webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon, webFXTreeConfig.propertyClass);
	%else%
		var bundle = new WebFXTree("%value bundleName% (%value pluginType%)", 
	     "define-repository-sources.dsp?projectName=%value ../projectName%&pluginType=%value pluginType%&bundleName=%value bundleName%",
      	null, webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon, webFXTreeConfig.propertyClass);
	%endif%
	%endif%

// projectName (i), bundleName (i)
%rename ../projectName projectName -copy%

// The Plugin node for this bundle 
%ifvar /defineAuthorized equals('true')%
  %ifvar sourceOfTruth equals('FlatFile')%
  		%ifvar bundleMode equals('Delete')%  		
  		%else%
  		var pluginTree = new WebFXTreeItem("%value pluginType%", 
  		"define-plugin-flatfile.dsp?pluginType=%value pluginType%&projectName=%value ../projectName%&bundleName=%value bundleName%&regExp=%value otherRegExp%", 
  		null, webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon, webFXTreeConfig.linkClass);
  		%endif%       
   %else%
	var pluginTree = new WebFXTreeItem("%value pluginType%", 
		"define-plugin.dsp?pluginType=%value pluginType%&projectName=%value ../projectName%&bundleName=%value bundleName%&regExp=%value otherRegExp%", 
		null, webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon, webFXTreeConfig.linkClass);
  %endif%		
%else%
	var pluginTree = new WebFXTreeItem("%value pluginType%", 
		null, null, webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon, null);
%endif%

%ifvar sourceOfTruth equals('FlatFile')%
       %ifvar bundleMode equals('Delete')%
       		%invoke wm.deployer.gui.UIBundle:getBundleSourceServers%
       			%loop servers%
       				var serverStr = '%value serverAliasName%';
					var serverAliasParts = serverStr.split("$"); 	
					var pluginName = serverAliasParts[1];
					var serverAlias = serverAliasParts[0];
       				var serverTree = new WebFXTreeItem(serverAlias +" ( "+"%value pluginLabel%"+" )",
					"define-delete-bundle-repository-tree.dsp?projectName=%value ../projectName%&bundleName=%value ../bundleName%&serverAlias="+serverAlias+"&pluginType="+pluginName,
					null, webFXTreeConfig.serverIcon, webFXTreeConfig.serverIcon, null, null);					
					%rename ../projectName projectName -copy%
					%rename ../bundleName bundleName -copy%
					%scope param(replaceByName='true')%
						
						%invoke wm.deployer.gui.UIBundle:getSelectedAssetsFromDeletionSet%
							%loop assets%
								var pathToAssets=new Array();
								var pathToAssetsIndex = 0;
								%loop pathToAssets%
									pathToAssets[pathToAssetsIndex++] =  "%value treeNodeName%";
								%endloop%
								parseAndCreateTree(pathToAssets,serverTree,0,"%value assetType%");														
							%endloop%
						%endinvoke% 
					%endscope%					
					bundle.add(serverTree);
       			%endloop%			  
			%endinvoke%      	      
       %else%
		bundle.add(pluginTree);
       %endif%
%else%
	bundle.add(pluginTree);
%endif%

%ifvar sourceOfTruth equals('Runtime')%
%invoke wm.deployer.gui.UIPlugin:getBundlePluginObjects%

	// 1st pass: bundle type plugin
	%loop plugins%
		%ifvar pluginType vequals(../pluginType)%

			// gots to remember these plugin servers for attaching crap later
			var serverList = new Array;
			var serverTreeList = new Array;

			%loop servers%
				var serverTree = new WebFXTreeItem("%value serverAliasName%", null, null, 
					webFXTreeConfig.serverIcon, webFXTreeConfig.serverIcon);
				pluginTree.add(serverTree);				
				
				// Attach the plugin Server Node for future lookup?
				serverList[serverList.length] = "%value serverAliasName%";
				serverTreeList[serverTreeList.length] = serverTree;

				%loop objectTypes%
					var typeNode = new WebFXTreeItem("%value objectTypeFolderName%");
					serverTree.add(typeNode);

					// Make the typeNode the parent node
					var folderList = new Array;
					var folderTreeList = new Array;
					folderList[0] = null;
					folderTreeList[0] = typeNode;

					// This 2-pass algorithm works no matter what order the folders are placed
					%loop folders% 
						// Create this folder beneath the parent
						var fItem = new WebFXTreeItem("%value folderName%");

						folderList[folderList.length] = "%value fullFolderName%";
						folderTreeList[folderTreeList.length] = fItem;
					%endloop folders%

					// Loop #2 to place the folders correctly in the xtree
					%loop folders% 
						var pItem = getFolderParent("%value parentFolder%", folderList, folderTreeList); 
						var fItem = getFolderParent("%value fullFolderName%", folderList, folderTreeList); 
						pItem.add(fItem);
					%endloop folders%

					%loop objects%
						var p = new WebFXTreeItem("%value name%", null, null, 
							"%value objectIcon%", "%value objectIcon%");
						var pItem = getFolderParent("%value path%", folderList, folderTreeList); 
						pItem.add(p);
					%endloop%
				%endloop%
			%endloop servers%
		%endif%
	%endloop plugins%

	// 2nd pass: process embedded IS plugin stuff
	%loop plugins%
		%ifvar pluginType equals('IS')%

			var ISList = new Array;
			var adminTreeList = new Array;
			var packageTreeList = new Array;

			%loop servers%
				// Attach the IS hyperlinks below the plugin server icon
				if (findInList("%value parentServerAliasName%", ISList) == null) {

					// Find the parent server node
					var pItem = getServerTree("%value parentServerAliasName%", serverList, serverTreeList); 

					// Add this remembrance so we only do it once
					ISList[ISList.length] = "%value parentServerAliasName%";

					// Hard-coded Administration link
					var adminTree = new WebFXTreeItem("Administration",
						"define-plugin-admin.dsp?projectName=%value /projectName%&bundleName=%value ../../../bundleName%&parentServerAliasName=%value parentServerAliasName%&regExp=%value ../../otherRegExp%",
						null, webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon, webFXTreeConfig.linkClass);
					pItem.add(adminTree);
					adminTreeList[adminTreeList.length] = adminTree;

					// Hard-coded Package link
					var packageTree = new WebFXTreeItem("Packages", 
						"define-plugin-packages.dsp?projectName=%value /projectName%&bundleName=%value ../../../bundleName%&parentServerAliasName=%value parentServerAliasName%&regExp=%value ../../packageRegExp%&regExp2=%value ../../otherRegExp%",
						null, webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon, webFXTreeConfig.linkClass);
					pItem.add(packageTree);
					packageTreeList[packageTreeList.length] = packageTree;

				}
			%endloop servers%

			// Here we go again...build logical server nodes and stow away
			var logISList = new Array;
			var logAdminTreeList = new Array;
			var logPackageTreeList = new Array;

			%loop servers%

				logISList[logISList.length] = "%value serverAliasName%";

				var adminTree = new WebFXTreeItem("%value serverAliasName%", null, null, 
					webFXTreeConfig.logicalServerIcon, webFXTreeConfig.logicalServerIcon);
				logAdminTreeList[logAdminTreeList.length] = adminTree;

				var packageTree = new WebFXTreeItem("%value serverAliasName%", null, null, 
					webFXTreeConfig.logicalServerIcon, webFXTreeConfig.logicalServerIcon);
				logPackageTreeList[logPackageTreeList.length] = packageTree;

				// Attach the Package nodes
				%loop objectTypes%
					if (objectIsTypePackage("%value objectTypeName%")) {

						// Re-use Partial Package logic
						%loop objects%

							// Make these vars local to this context
							%rename /projectName projectName -copy%
							%rename ../../../../bundleName bundleName -copy%
							%rename ../../serverAliasName serverAliasName -copy%

							%ifvar ../objectTypeName equals('Package')%
								%rename name packageName -copy%
								var pkgTree = new WebFXTreeItem("%value objectName%", 
									"package-properties.dsp?projectName=%value projectName%&bundleName=%value bundleName%&serverAliasName=%value serverAliasName%&packageName=%value objectName%", 
									null, webFXTreeConfig.ISPackage, webFXTreeConfig.ISPackage, 
									webFXTreeConfig.propertyClass);
								packageTree.add(pkgTree);
							%else%
								%ifvar ../objectTypeName equals('ISComponent')%
									%rename complexObjectKey objectName -copy%

									var pkgTree = new WebFXTreeItem("%value complexObjectKey%", 
									"package-properties.dsp?projectName=%value projectName%&bundleName=%value bundleName%&serverAliasName=%value serverAliasName%&packageName=%value objectName%", 
										null, 
										webFXTreeConfig.ISPartialPackage, webFXTreeConfig.ISPartialPackage,
										webFXTreeConfig.propertyClass);

									packageTree.add(pkgTree);

									%include package-components-tree.dsp%
									%include package-files-tree.dsp%

								%else%
									%ifvar ../objectTypeName equals('ISFile')%
										%rename complexObjectKey objectName -copy%

										var pkgTree = new WebFXTreeItem("%value complexObjectKey%", 
										"package-properties.dsp?projectName=%value projectName%&bundleName=%value bundleName%&serverAliasName=%value serverAliasName%&packageName=%value objectName%", 
											null, 
											webFXTreeConfig.ISPartialPackage, webFXTreeConfig.ISPartialPackage,
											webFXTreeConfig.propertyClass);

										packageTree.add(pkgTree);

										%include package-files-tree.dsp%
									%endif%
								%endif%
							%endif%
						%endloop%
					}
				%endloop%

				// You're gonna do this many times to preserve IS order of object types in tree
				// Scheduled Tasks
				%loop objectTypes%
					%ifvar objectTypeName equals('ScheduledService')%
						var typeFolder = new WebFXTreeItem(getNSFolderName("%value objectTypeName%"));
						adminTree.add(typeFolder);
						%loop objects%
							var p = new WebFXTreeItem("%value objectName%", null, null, 
								getNSIcon("%value ../objectTypeName%"), getNSIcon("%value ../objectTypeName%"));
							typeFolder.add(p);
						%endloop%
					%endif%
				%endloop objecttypes%

				// Ports
				%loop objectTypes%
					%ifvar objectTypeName equals('Port')%
						var typeFolder = new WebFXTreeItem(getNSFolderName("%value objectTypeName%"));
						adminTree.add(typeFolder);
						%loop objects%
							var p = new WebFXTreeItem("%value objectName%", null, null, 
								getNSIcon("%value ../objectTypeName%"), getNSIcon("%value ../objectTypeName%"));
							typeFolder.add(p);
						%endloop%
					%endif%
				%endloop objecttypes%

				// Users
				%loop objectTypes%
					%ifvar objectTypeName equals('User')%
						var typeFolder = new WebFXTreeItem(getNSFolderName("%value objectTypeName%"));
						adminTree.add(typeFolder);
						%loop objects%
							var p = new WebFXTreeItem("%value objectName%", null, null, 
								getNSIcon("%value ../objectTypeName%"), getNSIcon("%value ../objectTypeName%"));
							typeFolder.add(p);
						%endloop%
					%endif%
				%endloop objecttypes%

				// Groups
				%loop objectTypes%
					%ifvar objectTypeName equals('Group')%
						var typeFolder = new WebFXTreeItem(getNSFolderName("%value objectTypeName%"));
						adminTree.add(typeFolder);
						%loop objects%
							var p = new WebFXTreeItem("%value objectName%", null, null, 
								getNSIcon("%value ../objectTypeName%"), getNSIcon("%value ../objectTypeName%"));
							typeFolder.add(p);
						%endloop%
					%endif%
				%endloop objecttypes%

				// ACLs
				%loop objectTypes%
					%ifvar objectTypeName equals('ACL')%
						var typeFolder = new WebFXTreeItem(getNSFolderName("%value objectTypeName%"));
						adminTree.add(typeFolder);
						%loop objects%
							var p = new WebFXTreeItem("%value objectName%", null, null, 
								getNSIcon("%value ../objectTypeName%"), getNSIcon("%value ../objectTypeName%"));
							typeFolder.add(p);
						%endloop%
					%endif%
				%endloop objecttypes%

			%endloop servers%

			// last pass: Attach logical nodes to IS hyperlinks if they have children
			%loop servers%

				// Anybody home from Administration?
				var lItem = getServerTree("%value serverAliasName%", logISList, logAdminTreeList); 
				if (lItem.childNodes.length > 0) {
					var hItem = getServerTree("%value parentServerAliasName%", ISList, adminTreeList); 
					hItem.add(lItem);
				}

				// Anybody home from Packages?
				var lItem = getServerTree("%value serverAliasName%", logISList, logPackageTreeList); 
				if (lItem.childNodes.length > 0) {
					var hItem = getServerTree("%value parentServerAliasName%", ISList, packageTreeList); 
					hItem.add(lItem);
				}

			%endloop servers%
		%endif%
	%endloop plugins%

	// 3rd pass: process embedded TN plugin stuff
	%loop plugins%
		%ifvar pluginType equals('TN')%

			var ISList = new Array;
			var TNTreeList = new Array;

			%loop servers%
				// Attach the IS hyperlinks below the plugin server icon
				if (findInList("%value parentServerAliasName%", ISList) == null) {

					// Find the parent server node
					var pItem = getServerTree("%value parentServerAliasName%", serverList, serverTreeList); 

					// Add this remembrance so we only do it once
					ISList[ISList.length] = "%value parentServerAliasName%";

					// Hard-coded Trading Networks link
					var TNTree = new WebFXTreeItem("Trading Networks",
						"define-plugin-tn.dsp?projectName=%value /projectName%&bundleName=%value ../../../bundleName%&parentServerAliasName=%value parentServerAliasName%",
						null, webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon, webFXTreeConfig.linkClass);
					pItem.add(TNTree);
					TNTreeList[TNTreeList.length] = TNTree;
			
					%rename /projectName projectName -copy%
					%rename ../../../bundleName bundleName -copy%
					var serverIcon = webFXTreeConfig.logicalServerIcon;
					%include tn-tree.dsp%

				}
			%endloop servers%
		%endif%
	%endloop plugins%

	// 4th pass: process embedded plugin within plugin stuff - except if that embedded plugin is of type IS
	%loop plugins%
		%ifvar ../pluginType vequals(pluginType)%
    %else%
		  %ifvar pluginType equals('IS')%
      %else%

			%loop servers%

				// Find the parent server node
				var pItem = getServerTree("%value parentServerAliasName%", serverList, serverTreeList); 

				// Read-only Link to embedded plugin
				var EmbeddedTree = new WebFXTreeItem("%value ../pluginType%");
				pItem.add(EmbeddedTree);

				// Add the logical server item to the parent
				var logServer = new WebFXTreeItem("%value serverAliasName%", null, null, 
					webFXTreeConfig.logicalServerIcon, webFXTreeConfig.logicalServerIcon);
				EmbeddedTree.add(logServer);

				// Loop through the objects as you would with a plugin, dumb-ass
				%loop objectTypes%
					var typeNode = new WebFXTreeItem("%value objectTypeFolderName%");
					logServer.add(typeNode);

					// Make the typeNode the parent node
					var folderList = new Array;
					var folderTreeList = new Array;
					folderList[0] = null;
					folderTreeList[0] = typeNode;

					// This 2-pass algorithm works no matter what order the folders are placed
					%loop folders% 
						// Create this folder beneath the parent
						var fItem = new WebFXTreeItem("%value folderName%");

						folderList[folderList.length] = "%value fullFolderName%";
						folderTreeList[folderTreeList.length] = fItem;
					%endloop folders%

					// Loop #2 to place the folders correctly in the xtree
					%loop folders% 
						var pItem = getFolderParent("%value parentFolder%", folderList, folderTreeList); 
						var fItem = getFolderParent("%value fullFolderName%", folderList, folderTreeList); 
						pItem.add(fItem);
					%endloop folders%

					%loop objects%
						var p = new WebFXTreeItem("%value name%", null, null, 
							"%value objectIcon%", "%value objectIcon%");
						var pItem = getFolderParent("%value folderName%", folderList, folderTreeList); 
						pItem.add(p);
					%endloop%
				%endloop%

			%endloop servers%
		%endif else%
	%endif else%
	%endloop plugins%
%endinvoke%
%endif%
w(bundle); 
