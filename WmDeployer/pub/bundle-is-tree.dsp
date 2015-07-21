// This file must be included from within a <SCRIPT> tag 
%rename ../../projectName projectName -copy%
%invoke wm.deployer.gui.UIBundle:getBundleProperties%
	%ifvar sourceOfTruth equals('Runtime')%
	        var bundle = new WebFXTree("%value bundleName% (IS & TN)", 
		"define-is-sources.dsp?projectName=%value projectName%&bundleName=%value bundleName%",
		null, webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon, webFXTreeConfig.propertyClass);
		
	%else%
		var bundle = new WebFXTree("%value bundleName% (IS & TN)", 
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

// IS Security sub-tree -- wait until later to add this to tree in case it is empty
%ifvar /defineAuthorized equals('true')%
  %ifvar sourceOfTruth equals('Runtime')%
  	var secTree = new WebFXTreeItem("Administration", 
  		"define-security.dsp?projectName=%value ../projectName%&bundleName=%value bundleName%&regExp=%value otherRegExp%",
  		null, webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon, webFXTreeConfig.linkClass);
  %else%
    var secTree = new WebFXTreeItem("Administration", 
  		"define-security-flat.dsp?projectName=%value ../projectName%&bundleName=%value bundleName%&regExp=%value otherRegExp%",
  		null, webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon, webFXTreeConfig.linkClass);
  %endif%
%else%
	var secTree = new WebFXTreeItem("Administration", 
		null, 
		null, webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon, null);
%endif%

bundle.add(secTree);

// getBundleScheduledServices: projectName*, bundleName*
%invoke wm.deployer.gui.UIBundle:getBundleScheduledServices%
	%loop servers%
		var serverTree = getServerTree("%value serverAliasName%", serverList, secTreeList);
		if (serverTree.parentNode == null)
			secTree.add(serverTree);

		%ifvar services -notempty%
			var subTree = new WebFXTreeItem("Scheduled Tasks");
			serverTree.add(subTree);
			%loop services%
				var p = new WebFXTreeItem("%value serviceName%", null, null, 
					webFXTreeConfig.ISTask, webFXTreeConfig.ISTask);
				subTree.add(p);
			%endloop%
		%endif%
	%endloop servers%
%endinvoke%

// Get Bundle Ports: projectName*, bundleName*
%invoke wm.deployer.gui.UIBundle:getBundlePorts%
	%loop servers%
		var serverTree = getServerTree("%value serverAliasName%", serverList, secTreeList);
		if (serverTree.parentNode == null)
			secTree.add(serverTree);

		%ifvar ports -notempty%
		var subTree = new WebFXTreeItem("Ports");
		serverTree.add(subTree);
		%loop ports%
			var p = new WebFXTreeItem("%value -code portKey%", null, null, 
				webFXTreeConfig.ISPort, webFXTreeConfig.ISPort);
			subTree.add(p);
		%endloop%
		%endif%
	%endloop servers%
%endinvoke%

// Get Bundle Users: projectName*, bundleName*
%invoke wm.deployer.gui.UIBundle:getBundleUsers%
	%loop servers%
		var serverTree = getServerTree("%value serverAliasName%", serverList, secTreeList);
		if (serverTree.parentNode == null)
			secTree.add(serverTree);

		%ifvar users -notempty%
		var subTree = new WebFXTreeItem("Users");
		serverTree.add(subTree);
		%loop users%
			var p = new WebFXTreeItem("%value userName%", null, null, 
				webFXTreeConfig.ISUser, webFXTreeConfig.ISUser);
			subTree.add(p);
		%endloop%
		%endif%
	%endloop servers%
%endinvoke%

// Get Bundle Groups: projectName*, bundleName*
%invoke wm.deployer.gui.UIBundle:getBundleGroups%
	%loop servers%
		var serverTree = getServerTree("%value serverAliasName%", serverList, secTreeList);
		if (serverTree.parentNode == null)
			secTree.add(serverTree);

		%ifvar groups -notempty%
		var subTree = new WebFXTreeItem("Groups");
		serverTree.add(subTree);
		%loop groups%
			var p = new WebFXTreeItem("%value groupName%", null, null, 
				webFXTreeConfig.ISGroup, webFXTreeConfig.ISGroup);
			subTree.add(p);
		%endloop%
		%endif%
	%endloop servers%
%endinvoke%

// Get Bundle ACLs: projectName*, bundleName*
%invoke wm.deployer.gui.UIBundle:getBundleAcls%
	%loop servers%
		var serverTree = getServerTree("%value serverAliasName%", serverList, secTreeList);
		if (serverTree.parentNode == null)
			secTree.add(serverTree);

		%ifvar acls -notempty%
		var subTree = new WebFXTreeItem("ACLs");
		serverTree.add(subTree);
		%loop acls%
			var p = new WebFXTreeItem("%value aclName%", null, null, 
				webFXTreeConfig.ISAcl, webFXTreeConfig.ISAcl);
			subTree.add(p);
		%endloop%
		%endif%
	%endloop servers%
%endinvoke%

// Get Extended Settings
%invoke wm.deployer.gui.UIBundle:getBundleExtendedSettings%
	%loop servers%
		var serverTree = getServerTree("%value serverAliasName%", serverList, secTreeList);
		if (serverTree.parentNode == null)
			secTree.add(serverTree);

		%ifvar extended -notempty%
		var subTree = new WebFXTreeItem("Extended Settings");
		serverTree.add(subTree);
		%loop extended%
			var p = new WebFXTreeItem("%value name%", null, null, 
				webFXTreeConfig.ISExtended, webFXTreeConfig.ISExtended);
			subTree.add(p);
		%endloop%
		%endif%
	%endloop servers%
%endinvoke%

	

// Developer sub-tree
%ifvar /defineAuthorized equals('true')%
	%invoke wm.deployer.gui.UIBundle:getBundleSourceServers%
  %ifvar ../sourceOfTruth equals('FlatFile')%
     var devTree = new WebFXTreeItem("Packages", 
		"define-flatfile.dsp?projectName=%value ../projectName%&bundleName=%value bundleName%&regExp=%value packageRegExp%&regExp2=%value otherRegExp%&bundleMode=%value bundleMode%",
		null, webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon, webFXTreeConfig.linkClass);	
   %endif%  
 %ifvar ../sourceOfTruth equals('Registry')%
     %ifvar ../fetchBy equals('Latest Revisions')%
	   var devTree = new WebFXTreeItem("Packages", 
		"define-centrasite.dsp?projectName=%value ../projectName%&bundleName=%value bundleName%&regExp=%value packageRegExp%&regExp2=%value otherRegExp%&bundleMode=%value bundleMode%",
		null, webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon, webFXTreeConfig.linkClass);	
     %endif%
   %ifvar ../fetchBy equals('Checkpoints')%
	   var devTree = new WebFXTreeItem("Packages", 
  		"centrasite-bundle-manager.dsp?projectName=%value ../projectName%&bundleName=%value bundleName%&regExp=%value packageRegExp%&regExp2=%value otherRegExp%&bundleMode=%value bundleMode%",
  		null, webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon, webFXTreeConfig.linkClass);	 	
   %endif%
    %ifvar ../fetchBy equals('All Revisions')%
	   var devTree = new WebFXTreeItem("Packages", 
		"define-centrasite-revisions.dsp?projectName=%value ../projectName%&bundleName=%value bundleName%&regExp=%value packageRegExp%&regExp2=%value otherRegExp%&bundleMode=%value bundleMode%",
		null, webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon, webFXTreeConfig.linkClass);	
   %endif%  	
%endif%
 %ifvar ../sourceOfTruth equals('Runtime')%
    	var devTree = new WebFXTreeItem("Packages", 
		"define-developer.dsp?projectName=%value ../projectName%&bundleName=%value bundleName%&regExp=%value packageRegExp%&regExp2=%value otherRegExp%&bundleMode=%value bundleMode%",
		null, webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon, webFXTreeConfig.linkClass);	          
%endif%
	
 %endinvoke%
%else%
	var devTree = new WebFXTreeItem("Packages", 
		null,
		null, webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon, null);
%endif%

bundle.add(devTree);

// Get Bundle Packages: projectName*, bundleName*
%invoke wm.deployer.gui.UIBundle:getBundlePackages%
	%loop servers%

		var serverTree = new WebFXTreeItem("%value serverAliasName%", null, null, 
			webFXTreeConfig.serverIcon, webFXTreeConfig.serverIcon);
		devTree.add(serverTree);

		%loop packages%

			%ifvar componentsOrFiles equals('true')%
				var icon = webFXTreeConfig.ISPartialPackage;
			%else%
				var icon = webFXTreeConfig.ISPackage;
			%endif%

			var pkgTree = new WebFXTreeItem("%value packageName%", 
				"package-properties.dsp?projectName=%value ../../projectName%&bundleName=%value ../../bundleName%&serverAliasName=%value ../serverAliasName%&packageName=%value packageName%", null, icon, icon, webFXTreeConfig.propertyClass);
			serverTree.add(pkgTree);

			%rename ../../projectName projectName -copy%
			%rename ../../bundleName bundleName -copy%
			%rename ../serverAliasName serverAliasName -copy%

			// If partial with components, show components and resulting files
			%ifvar componentsOrFiles equals('true')%
				%ifvar containsComponents equals('true')%
					%include package-components-tree.dsp%
					%include package-files-tree.dsp%
				%else%
				// If partial with files...
					%include package-files-tree.dsp%
				%endif%
			%endif%

		%endloop packages%
	%endloop servers%
%endinvoke getBundlePackages%

// webMethods Files sub-tree
%ifvar /defineAuthorized equals('true')%
  %ifvar sourceOfTruth equals('Runtime')%
  	var FileTree = new WebFXTreeItem("webMethods Files", 
  		"define-webm-files.dsp?projectName=%value ../projectName%&bundleName=%value bundleName%&regExp=%value otherRegExp%",
  		null, webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon, webFXTreeConfig.linkClass);
  %else%
    	var FileTree = new WebFXTreeItem("webMethods Files", 
  		"define-webm-files-flat.dsp?projectName=%value ../projectName%&bundleName=%value bundleName%&regExp=%value otherRegExp%",
  		null, webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon, webFXTreeConfig.linkClass);
  %endif%
%else%
	var FileTree = new WebFXTreeItem("webMethods Files", 
		null,
		null, webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon, null);
%endif%

%invoke wm.deployer.gui.UIBundle:getBundleFiles%
	%loop servers%

		var serverTree = new WebFXTreeItem("%value serverAliasName%", null, null, 
			webFXTreeConfig.serverIcon, webFXTreeConfig.serverIcon);
		FileTree.add(serverTree);

		%loop files%

			var f = new WebFXTreeItem("%value name -code%", null, null, 
				getNSIcon("%value type%"), getNSIcon("%value type%"));
			serverTree.add(f);

		%endloop files%
	%endloop servers%
%endinvoke%
bundle.add(FileTree);


// TN sub-tree
%ifvar /defineAuthorized equals('true')%
  %ifvar sourceOfTruth equals('Runtime')%
    	var TNTree = new WebFXTreeItem("Trading Networks",     		
		"define-tn.dsp?projectName=%value ../projectName%&bundleName=%value bundleName%&bundleMode=%value bundleMode%&treeNodeCount=%value treeNodeCount%&regExp=%value otherRegExp%",
    		null, webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon, webFXTreeConfig.linkClass);
    %else%
    	var TNTree = new WebFXTreeItem("Trading Networks", 
    		"define-tn-flatfile.dsp?projectName=%value ../projectName%&bundleName=%value bundleName%&bundleMode=%value bundleMode%&treeNodeCount=%value treeNodeCount%&regExp=%value otherRegExp%",
    		null, webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon, webFXTreeConfig.linkClass);    
  %endif%

%else%
	var TNTree = new WebFXTreeItem("Trading Networks", 
		null,
		null, webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon, null);
%endif%

var serverIcon = webFXTreeConfig.serverIcon;
%include tn-tree.dsp%

// finally, add the TN leaf to the tree
bundle.add(TNTree);

w(bundle); 