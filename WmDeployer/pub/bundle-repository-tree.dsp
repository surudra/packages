// This file must be included from within a <SCRIPT> tag 
%rename ../../projectName projectName -copy%
%invoke wm.deployer.gui.UIBundle:getBundleProperties%
%ifvar sourceOfTruth equals('Runtime')%
var bundle = new WebFXTree("%value bundleName%", 
"define-is-sources.dsp?projectName=%value projectName%&bundleName=%value bundleName%",
null, webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon, webFXTreeConfig.propertyClass);

%else%
var bundle = new WebFXTree("%value bundleName%", 
"define-repository-sources.dsp?projectName=%value projectName%&bundleName=%value bundleName%",
null, webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon, webFXTreeConfig.propertyClass);
%endif%
%endinvoke%


// Build the xtree nodes for each potential Server for later reference in the tree
var serverList = new Array;
var secTreeList = new Array;

// Get Bundle Servers: ../projectName, bundleName*
// Preload this list for the IS Administration crap since we have multiple services
%rename ../projectName projectName -copy%
%invoke wm.deployer.gui.UIBundle:getBundleServers%
	%loop servers%
		serverList[serverList.length] = "%value serverAliasName%";
		var serverTree = new WebFXTreeItem("%value serverAliasName%", null, null, 
		webFXTreeConfig.serverIcon, webFXTreeConfig.serverIcon);
		secTreeList[secTreeList.length] = serverTree;
	%endloop%
%endinvoke%

%rename ../projectName projectName -copy%

var repoTree = new WebFXTreeItem("Repository", 
									"define-repository.dsp?projectName=%value ../projectName%&bundleName=%value bundleName%&regExp=%value packageRegExp%&regExp2=%value otherRegExp%&bundleMode=%value bundleMode%",
									null, webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon, webFXTreeConfig.linkClass);

//bundle.add(repoTree);  

// Get Bundle Packages: projectName*, bundleName*
%invoke wm.deployer.gui.UIBundle:getBundleComposites%
	%loop servers%
		var serverTree = new WebFXTreeItem("%value serverAliasName%", 
			"define-repository.dsp?projectName=%value ../../projectName%&bundleName=%value ../bundleName%&regExp=%value ../packageRegExp%&regExp2=%value otherRegExp%&bundleMode=%value ../bundleMode%",
			null, webFXTreeConfig.serverIcon, webFXTreeConfig.serverIcon, webFXTreeConfig.linkClass);

		bundle.add(serverTree);

		var runtimeList = new Array;
		var runtimeTreeList = new Array;		

		%loop composites%

			var runtimeTree = getServerTree("%value runtimeType%", runtimeList, runtimeTreeList);
			if(runtimeTree == null) {      
				runtimeList[runtimeList.length] = "%value runtimeType%";

				runtimeTree = new WebFXTreeItem("%value runtimeType%", null, null, 
									webFXTreeConfig.runtimeIcon, webFXTreeConfig.runtimeIcon);

				runtimeTreeList[runtimeTreeList.length] = runtimeTree;
				serverTree.add(runtimeTree);  			
			}   
			%ifvar isPartial equals('true')%
				var icon = webFXTreeConfig.partialCompositeIcon;
			%else%
				var icon = webFXTreeConfig.compositeIcon;
			%endif%

			var compositeName = "%value compositeName%";
			%ifvar logicalServer -notempty%
				compositeName = compositeName + " (" + "%value logicalServer%" + ")";
			%endif%			


			var compositeTree = new WebFXTreeItem(compositeName + '%ifvar assetVersion -notempty% (%value assetVersion%)%endif%', 
												null, null, icon, icon, webFXTreeConfig.propertyClass);
												runtimeTree.add(compositeTree);
												
			var componentTypesList = new Array;
			var componentTypesTreeList = new Array;
			
			%loop componentTypes%
				componentTypesList[componentTypesList.length]='%value TypeName%'
				var compTypeNode = new WebFXTreeItem("%value TypeName%", null, 
								false, null, null, null,
								null, null, null, null, null);	 	
				componentTypesTreeList[componentTypesTreeList.length] = compTypeNode;
				compositeTree.add(compTypeNode);
			%endloop componentTypes%

			%ifvar isPartial equals('true')%
				%loop components%
					var componentTree = new WebFXTreeItem("%value componentDisplayName%", 
												null, null, getACDLIcon("%value componentType%"), getACDLIcon("%value componentType%"), webFXTreeConfig.propertyClass);

					//compositeTree.add(componentTree);
					var matchIndex = -1;
					for (var i=0;i<componentTypesList.length;i++) {
						if ('%value componentType%'==componentTypesList[i]) {
							matchIndex = i;
							i=componentTypesList.length;
						}
					}
      				componentTypesTreeList[matchIndex].add(componentTree);
				%endloop components%
			%endif%

			%rename ../../projectName projectName -copy%
			%rename ../../bundleName bundleName -copy%
			%rename ../serverAliasName serverAliasName -copy%

		%endloop composites%
	%endloop servers%
%endinvoke getBundleComposites%      	

w(bundle); 