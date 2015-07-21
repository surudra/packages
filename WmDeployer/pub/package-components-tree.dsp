// Make the Package the parent node
var folderList = new Array;
var folderTreeList = new Array;
folderList[0] = null;
folderTreeList[0] = pkgTree;

// Get Components: projectName, bundleName, serverAliasName, packageName*
%invoke wm.deployer.gui.UIBundle:getBundleISComponents%

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

	%loop nodes%
		var p = new WebFXTreeItem("%value name%", null, null, 
			getNSIcon("%value type%"), getNSIcon("%value type%"));
		var pItem = getFolderParent("%value folder%", folderList, folderTreeList); 
		pItem.add(p);
	%endloop nodes%

%endinvoke getBundleISComponents%
