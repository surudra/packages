var serverTree = new WebFXCheckBoxTreeItem("%value serverAliasName%", null, false, null, 
						webFXTreeConfig.serverIcon, webFXTreeConfig.serverIcon);

					// Retrieve Packages from Server
					// serverAlias		

					%ifvar ../sourceOfTruth equals('Registry')%
					%ifvar ../fetchBy equals('Latest Revisions')%
  					%invoke wm.deployer.gui.UICentrasite:getAssetsInRegistry%
                %loop packagesList%							
                var pkgNode = new WebFXCheckBoxTreeItem("%value packageName%", null, 
            						false, null, webFXTreeConfig.ISPackage, webFXTreeConfig.ISPackage,
            						"%value ../serverAlias -urlencode%$%value packageName%$PACKAGE_INCL", "PACKAGE_INCL", null);	 
            
                    %loop componentName%
                        var fldNode = new WebFXCheckBoxTreeItem("%value folderName%", null, 
            						false, null, webFXTreeConfig.ISFolder, webFXTreeConfig.ISFolder,
            						"%value fullFolderName%$Folder", "Folder", null);	 
            						 %loop servicesName%
                						 var srvNode = new WebFXCheckBoxTreeItem("%value serviceName% - Ver1.2", null, 
                						false, null, webFXTreeConfig.ISFolder, webFXTreeConfig.ISFolder,
                						"%value folderName%:%value serviceName%$FlowService", "COMPONENT_INCL", null);
                						fldNode.add(srvNode);
            						 %endloop servicesName%
            						pkgNode.add(fldNode);
                    %endloop componentName%
                    serverTree.add(pkgNode); 
                
                    matchCnt++;  
                %endloop packagesList%        
            	%endinvoke%
						%endif%
						%ifvar ../fetchBy equals('Checkpoints')%
						  	%invoke wm.deployer.gui.UICentrasite:getPackagesByCheckpoints%
                          %loop checkPoints%
                		
        									var pkgNode = new WebFXCheckBoxTreeItem("%value checkPointName%", 
        									"define-component.dsp?projectName=%value ../../../../projectName%&bundleName=%value ../../../../bundleName%&serverAliasName=%value ../serverAlias%&packageName=%value packageName%&regExp=%value /regExp%&regExp2=%value /regExp2%&bundleMode=%value ../../../../bundleMode%", 
        									false, null, webFXTreeConfig.ISPackage, webFXTreeConfig.ISPackage,
        									"%value ../serverAlias -urlencode%$%value packageName%$PACKAGE_INCL", "PACKAGE_INCL", webFXTreeConfig.linkClass);
        									serverTree.add(pkgNode);
        									matchCnt++;
        
        							%endloop checkPoints%
						  	%endinvoke%
						%endif%
  					%ifvar ../fetchBy equals('All Revisions')%
             	%invoke wm.deployer.gui.UICentrasite:getAssetsInRegistry%
                %loop packagesList%							
                var pkgNode = new WebFXCheckBoxTreeItem("%value packageName%", null, 
            						false, null, webFXTreeConfig.ISPackage, webFXTreeConfig.ISPackage,
            						"%value ../serverAlias -urlencode%$%value packageName%$PACKAGE_INCL", "PACKAGE_INCL", null);	 
            
                    %loop componentName%
                        var fldNode = new WebFXCheckBoxTreeItem("%value folderName%", null, 
            						false, null, webFXTreeConfig.ISFolder, webFXTreeConfig.ISFolder,
            						"%value fullFolderName%$Folder", "Folder", null);	 
            						 %loop servicesName%
                						 var srvNode = new WebFXCheckBoxTreeItem("%value serviceName%", null, 
                						false, null, webFXTreeConfig.ISFolder, webFXTreeConfig.ISFolder,
                						"%value folderName%:%value serviceName%$FlowService", "COMPONENT_INCL", null);
                						fldNode.add(srvNode);
            						 %endloop servicesName%
            						pkgNode.add(fldNode);
                    %endloop componentName%
                    serverTree.add(pkgNode); 
                
                    matchCnt++;  
                %endloop packagesList%        
            	%endinvoke%
              
   					%endif%						
					%else%
						%invoke wm.deployer.gui.server.IS:listPackages%
							%loop packages%
	
							if (matchRegularExpression("%value /regExp%", "%value packageName%")) 
							{
								var pkgNode = new WebFXCheckBoxTreeItem("%value packageName%", 
									"define-component.dsp?projectName=%value ../../../../projectName%&bundleName=%value ../../../../bundleName%&serverAliasName=%value ../serverAlias%&packageName=%value packageName%&regExp=%value /regExp%&regExp2=%value /regExp2%&bundleMode=%value ../../../../bundleMode%", 
									false, null, webFXTreeConfig.ISPackage, webFXTreeConfig.ISPackage,
									"%value ../serverAlias -urlencode%$%value packageName%$PACKAGE_INCL", "PACKAGE_INCL", webFXTreeConfig.linkClass);
								serverTree.add(pkgNode);
								matchCnt++;
							}
							else
							{
								filterCnt++;
							}
							%endloop packages%
						%endinvoke wm.deployer.gui.server.IS:listPackages%
					%endif%