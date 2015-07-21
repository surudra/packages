%scope param(recurse='false') param(topDir='..')%

				var serverTree = new WebFXCheckBoxTreeItem("%value serverAliasName%", 
					null, false, null, webFXTreeConfig.serverIcon, webFXTreeConfig.serverIcon);

				// webMethods Files
				%invoke wm.deployer.gui.server.IS:listFiles%

					// A 1-pass algorithm works since folder list is flat
					%loop folders% 
						// Create this folder beneath the parent
						var fItem = new WebFXCheckBoxTreeItem("%value folderName -code%", 
							"define-webm-branch.dsp?projectName=%value /projectName%&bundleName=%value /bundleName%&serverAliasName=%value ../serverAliasName%&topDir=%value fullFolderName -urlencode%&regExp=%value /regExp%", 
							false, null, webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon,
							"%value ../serverAliasName -urlencode%$DEPLOYERDATA$%value fullFolderName -urlencode%$DEPLOYERDATA$FOLDER_INCL",
							"FOLDER_INCL", webFXTreeConfig.linkClass);

						serverTree.add(fItem);
					%endloop folders%

					%loop nodes%
						var nItem = new WebFXCheckBoxTreeItem("%value name -code%", null, false, null, 
							getNSIcon("%value type%"), getNSIcon("%value type%"),
							"%value ../serverAliasName -urlencode%$DEPLOYERDATA$%value fullName -urlencode%$DEPLOYERDATA$FILE_INCL", 
							"FILE_INCL");
						serverTree.add(nItem);
					%endloop nodes%

				%endinvoke listFiles%
				%endscope%