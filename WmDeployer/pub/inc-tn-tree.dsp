var invokeError = "";
			var serverTree = new WebFXCheckBoxTreeItem("%value serverAliasName%", null, false, null, 
				webFXTreeConfig.serverIcon, webFXTreeConfig.serverIcon);

			// Retrieve TN crapola from Server
			// listTnTypes: serverAlias, various booleans
				%scope param(attribs='false') param(types='false') param(rules='false') param(flddefs='false') param(profiles='false') param(lookups='false') param(tpas='false') param(extflds='false') param(securityData='false') param(queues='false') param(dls='false') param(fp='false') param(all='true')%
				%invoke wm.deployer.gui.TN:listTNTypes%
					%ifvar status equals('Success')%

						// Processing Rules
						%ifvar rules -notempty%
							var subTree = new WebFXCheckBoxTreeItem("Processing Rules");
							%loop rules%
							if (matchRegularExpression("%value /regExp%", "%value ruleName%")) {
								var p = new WebFXCheckBoxTreeItem("%value ruleName%", null, false, null, 
									webFXTreeConfig.TNrule, webFXTreeConfig.TNrule, 
									"%value ../serverAliasName -urlencode%$TNDEPLOYERDATA$%value ruleKey -urlencode%$TNDEPLOYERDATA$%value ruleName -urlencode%", "TNProcessingRule_INCL");
								subTree.add(p);
								matchCnt++;
							}
							else
								filterCnt++;
							%endloop%
						if (subTree.childNodes.length > 0) 
							serverTree.add(subTree);
						%endif%
	
						// Document Attributes
						%ifvar attribs -notempty%
						%ifvar /bundleMode equals('Deploy')%
							var subTree = new WebFXCheckBoxTreeItem("Document Attributes");
							%loop attribs%
							if (matchRegularExpression("%value /regExp%", "%value attribName%")) {
								var p = new WebFXCheckBoxTreeItem("%value attribName%", null, false, null, 
									webFXTreeConfig.TNattribute, webFXTreeConfig.TNattribute, 
									"%value ../serverAliasName -urlencode%$TNDEPLOYERDATA$%value attribKey -urlencode%$TNDEPLOYERDATA$%value attribName -urlencode%", "TNDocumentAttribute_INCL");
								subTree.add(p);
								matchCnt++;
							}
							else
								filterCnt++;
							%endloop%
							if (subTree.childNodes.length > 0) 
								serverTree.add(subTree);
						%endif%
						%endif%
	
						// Document Types
						%ifvar types -notempty%
							var subTree = new WebFXCheckBoxTreeItem("Document Types");
							%loop types%
							if (matchRegularExpression("%value /regExp%", "%value typeName%")) {
								var p = new WebFXCheckBoxTreeItem("%value typeName%", null, false, null, 
									webFXTreeConfig.TNtype, webFXTreeConfig.TNtype, 
									"%value ../serverAliasName -urlencode%$TNDEPLOYERDATA$%value typeKey -urlencode%$TNDEPLOYERDATA$%value typeName -urlencode%", "TNDocumentType_INCL");
								subTree.add(p);
								matchCnt++;
							}
							else
								filterCnt++;
							%endloop%
							if (subTree.childNodes.length > 0) 
								serverTree.add(subTree);
						%endif%
	
						// Agreements
						%ifvar tpas -notempty%
							var subTree = new WebFXCheckBoxTreeItem("Agreements");
							%loop tpas%
							if (matchRegularExpression("%value /regExp%", "%value tpaName%")) {
								var p = new WebFXCheckBoxTreeItem("%value tpaName%", null, false, null, 
									webFXTreeConfig.TNagreement, webFXTreeConfig.TNagreement, 
									"%value ../serverAliasName -urlencode%$TNDEPLOYERDATA$%value tpaKey -urlencode%$TNDEPLOYERDATA$%value tpaName -urlencode%", "TNTPA_INCL");
								subTree.add(p);
								matchCnt++;
							}
							else
								filterCnt++;
							%endloop%
							if (subTree.childNodes.length > 0) 
								serverTree.add(subTree);
						%endif%
	
						// Field Groups
						%ifvar fldgrps -notempty%
							var subTree = new WebFXCheckBoxTreeItem("Field Groups");
							%loop fldgrps%
							if (matchRegularExpression("%value /regExp%", "%value fldgrpName%")) {
								var p = new WebFXCheckBoxTreeItem("%value fldgrpName%", null, false, null, 
									webFXTreeConfig.TNprofileFld, webFXTreeConfig.TNprofileFld, 
									"%value ../serverAliasName -urlencode%$TNDEPLOYERDATA$%value fldgrpKey -urlencode%$TNDEPLOYERDATA$%value fldgrpName -urlencode%", "TNFieldGroup_INCL");
								subTree.add(p);
								matchCnt++;
							}
							else
								filterCnt++;
							%endloop%
							if (subTree.childNodes.length > 0) 
								serverTree.add(subTree);
						%endif%
	
						// Field Definitions
						%ifvar flddefs -notempty%
						%ifvar /bundleMode equals('Deploy')%
							var subTree = new WebFXCheckBoxTreeItem("Field Definitions");
							%loop flddefs%
							if (matchRegularExpression("%value /regExp%", "%value flddefName%")) {
								var p = new WebFXCheckBoxTreeItem("%value flddefName%", null, false, null, 
									webFXTreeConfig.TNprofileFld, webFXTreeConfig.TNprofileFld, 
									"%value ../serverAliasName -urlencode%$TNDEPLOYERDATA$%value flddefKey -urlencode%$TNDEPLOYERDATA$%value flddefName -urlencode%", "TNFieldDefinition_INCL");
								subTree.add(p);
								matchCnt++;
							}
							else
								filterCnt++;
							%endloop%
							if (subTree.childNodes.length > 0) 
								serverTree.add(subTree);
						%endif%
						%endif%
	
						// External ID Types
						%ifvar idTypes -notempty%
							var subTree = new WebFXCheckBoxTreeItem("External ID Types");
							%loop idTypes%
							if (matchRegularExpression("%value /regExp%", "%value idTypeName%")) {
								var p = new WebFXCheckBoxTreeItem("%value idTypeName%", null, false, null, 
									webFXTreeConfig.TNprofileFld, webFXTreeConfig.TNprofileFld, 
									"%value ../serverAliasName -urlencode%$TNDEPLOYERDATA$%value idTypeKey -urlencode%$TNDEPLOYERDATA$%value idTypeName -urlencode%", "TNIdType_INCL");
								subTree.add(p);
								matchCnt++;
							}
							else
								filterCnt++;
							%endloop%
							if (subTree.childNodes.length > 0) 
								serverTree.add(subTree);
						%endif%
	
						// Contact Types
						%ifvar contactTypes -notempty%
							var subTree = new WebFXCheckBoxTreeItem("Contact Types");
							%loop contactTypes%
							if (matchRegularExpression("%value /regExp%", "%value contactTypeName%")) {
								var p = new WebFXCheckBoxTreeItem("%value contactTypeName%", null, false, null, 
									webFXTreeConfig.TNprofileFld, webFXTreeConfig.TNprofileFld, 
									"%value ../serverAliasName -urlencode%$TNDEPLOYERDATA$%value contactTypeKey -urlencode%$TNDEPLOYERDATA$%value contactTypeName -urlencode%", "TNContactType_INCL");
								subTree.add(p);
								matchCnt++;
							}
							else
								filterCnt++;
							%endloop%
							if (subTree.childNodes.length > 0) 
								serverTree.add(subTree);
						%endif%
	
						// Binary Types
						%ifvar binaryTypes -notempty%
						%ifvar /bundleMode equals('Deploy')%
							var subTree = new WebFXCheckBoxTreeItem("Binary Types");
							%loop binaryTypes%
							if (matchRegularExpression("%value /regExp%", "%value binaryTypeName%")) {
								var p = new WebFXCheckBoxTreeItem("%value binaryTypeName%", null, false, null, 
									webFXTreeConfig.TNprofileFld, webFXTreeConfig.TNprofileFld, 
									"%value ../serverAliasName -urlencode%$TNDEPLOYERDATA$%value binaryTypeKey -urlencode%$TNDEPLOYERDATA$%value binaryTypeName -urlencode%", "TNBinaryType_INCL");
								subTree.add(p);
								matchCnt++;
							}
							else
								filterCnt++;
							%endloop%
							if (subTree.childNodes.length > 0) 
								serverTree.add(subTree);
						%endif%
						%endif%
	
						// Profile Groups
						%ifvar profileGroups -notempty%
							var subTree = new WebFXCheckBoxTreeItem("Profile Groups");
							%loop profileGroups%
							if (matchRegularExpression("%value /regExp%", "%value profileGroupName%")) {
								var p = new WebFXCheckBoxTreeItem("%value profileGroupName%", null, false, null, 
									webFXTreeConfig.TNprofile, webFXTreeConfig.TNprofile, 
									"%value ../serverAliasName -urlencode%$TNDEPLOYERDATA$%value profileGroupKey -urlencode%$TNDEPLOYERDATA$%value profileGroupName -urlencode%", "TNProfileGroup_INCL");
								subTree.add(p);
								matchCnt++;
							}
							else
								filterCnt++;
							%endloop%
							if (subTree.childNodes.length > 0) 
								serverTree.add(subTree);
						%endif%
	
						// Queues
						%ifvar queues -notempty%
							var subTree = new WebFXCheckBoxTreeItem("Public Queues");
							%loop queues%
							if (matchRegularExpression("%value /regExp%", "%value queueName%")) {
								var p = new WebFXCheckBoxTreeItem("%value queueName%", null, false, null, 
									webFXTreeConfig.TNqueue, webFXTreeConfig.TNqueue, 
									"%value ../serverAliasName -urlencode%$TNDEPLOYERDATA$%value queueKey -urlencode%$TNDEPLOYERDATA$%value queueName -urlencode%", "TNQueue_INCL");
								subTree.add(p);
								matchCnt++;
							}
							else
								filterCnt++;
							%endloop%
							if (subTree.childNodes.length > 0) 
								serverTree.add(subTree);
						%endif%
						
						// Dls
						%ifvar dls -notempty%
							var subTree = new WebFXCheckBoxTreeItem("DLS");
							%loop dls%
							if (matchRegularExpression("%value /regExp%", "%value dlsName%")) {
								var p = new WebFXCheckBoxTreeItem("%value dlsName%", null, false, null, 
									webFXTreeConfig.TNdls, webFXTreeConfig.TNdls, 
									"%value ../serverAliasName -urlencode%$TNDEPLOYERDATA$%value dlsKey -urlencode%$TNDEPLOYERDATA$%value dlsName -urlencode%", "TNDls_INCL");
								subTree.add(p);
								matchCnt++;
							}
							else
								filterCnt++;
							%endloop%
							if (subTree.childNodes.length > 0) 
								serverTree.add(subTree);
						%endif%
						
						// Fp
						%ifvar fp -notempty%
							var subTree = new WebFXCheckBoxTreeItem("Functional Permissions");
							%loop fp%
							if (matchRegularExpression("%value /regExp%", "%value fpName%")) {
								var p = new WebFXCheckBoxTreeItem("%value fpName%", null, false, null, 
									webFXTreeConfig.TNfp, webFXTreeConfig.TNfp, 
									"%value ../serverAliasName -urlencode%$TNDEPLOYERDATA$%value fpKey -urlencode%$TNDEPLOYERDATA$%value fpName -urlencode%", "TNFp_INCL");
								subTree.add(p);
								matchCnt++;
							}
							else
								filterCnt++;
							%endloop%
							if (subTree.childNodes.length > 0) 
								serverTree.add(subTree);
						%endif%

						// Archival Services
						%ifvar archSvcs -notempty%
							var subTree = new WebFXCheckBoxTreeItem("Archival Services");
							%loop archSvcs%
							if (matchRegularExpression("%value /regExp%", "%value archSvcsName %")) {
								var p = new WebFXCheckBoxTreeItem("%value archSvcsName %", null, false, null, 
									webFXTreeConfig.TNArchivalSvc, webFXTreeConfig.TNArchivalSvc, 
									"%value ../serverAliasName -urlencode%$TNDEPLOYERDATA$%value archSvcsKey -urlencode%$TNDEPLOYERDATA$%value archSvcsName  -urlencode%", "TNArchivalSvcs_INCL");
								subTree.add(p);
								matchCnt++;
							}
							else
								filterCnt++;
							%endloop%
							if (subTree.childNodes.length > 0) 
								serverTree.add(subTree);
						%endif%
	
						// To guarantee a unique Partner Data folder 
						var partnerList = new Array;
						var partnerTreeList = new Array;
	
						var subTree = new WebFXCheckBoxTreeItem("Partner Data");
	
						// Partner Data: Profiles
						%loop profiles%
							if (matchRegularExpression("%value /regExp%", "%value profileName%")) {
								var partnerTree = new WebFXCheckBoxTreeItem("Partner: %value profileName%");
								var p = new WebFXCheckBoxTreeItem("Profile", null, false, null, 
									webFXTreeConfig.TNprofile, webFXTreeConfig.TNprofile, 
									"%value ../serverAliasName -urlencode%$TNDEPLOYERDATA$%value profileKey -urlencode%$TNDEPLOYERDATA$%value profileName -urlencode%", "TNProfile_INCL");
								partnerTree.add(p);
								subTree.add(partnerTree);
	
								// Stow away the Profile Key for later lookup
								partnerList[partnerList.length] = "%value profileKey%";
								partnerTreeList[partnerTreeList.length] = partnerTree;
								matchCnt++;
							}
							else
								filterCnt++;
						%endloop%
	
						// Partner Data: Extended Fields
						%loop extflds%
							var partnerTree = getServerTree("%value extfldParentKey%", partnerList, partnerTreeList);
							if (partnerTree != null) {
								var p = new WebFXCheckBoxTreeItem("%value extfldName%", null, false, null, 
									webFXTreeConfig.TNprofileFld, webFXTreeConfig.TNprofileFld, 
								"%value ../serverAliasName -urlencode%$TNDEPLOYERDATA$%value extfldKey -urlencode%$TNDEPLOYERDATA$%value extfldName -urlencode%$TNDEPLOYERDATA$%value extfldParentKey -urlencode%$TNDEPLOYERDATA$%value extfldParentName -urlencode%", "TNExtendedField_INCL");
								partnerTree.add(p);
                				matchCnt++;
							}
             				 else
                				filerCnt++;
						%endloop%
	
						// Partner Data: Security Data
						%loop securityData%
						%ifvar /bundleMode equals('Deploy')%
							var partnerTree = getServerTree("%value securityDataParentKey%", partnerList, partnerTreeList);
							if (partnerTree != null) {
								var p = new WebFXCheckBoxTreeItem("Security Data", null, false, null, 
									webFXTreeConfig.TNcertificate, webFXTreeConfig.TNcertificate, 
									"%value ../serverAliasName -urlencode%$TNDEPLOYERDATA$%value securityDataKey -urlencode%$TNDEPLOYERDATA$SecurityData$TNDEPLOYERDATA$%value securityDataParentKey -urlencode%$TNDEPLOYERDATA$%value securityDataParentName -urlencode%", "TNSecurityData_INCL");
								partnerTree.add(p);
                				matchCnt++;
							}
             				 else
                				filterCnt++
						%endif%
						%endloop%

						if (subTree.childNodes.length > 0)
							serverTree.add(subTree);
					%ifvar treeNodeCountExceeded equals('true')%
						treeNodeCountExceeded = 'true';
					%endif%
					%else%
						invokeError = "%value ../serverAliasName% (Could not retrieve Trading Networks objects: %value message%)";						
					%endif%
				%onerror%
						invokeError = "%value ../serverAliasName% (Unexpected error.  Please check Integration Server Error Log.)";
				%endinvoke listTNTypes%
			%endscope%

			if (serverTree.childNodes.length == 0) {
				var msg = "%value serverAliasName% (No Trading Networks objects retrieved)";
				if (invokeError != "") msg = invokeError;
				var serverTree = new WebFXTreeItem(msg, 
					null, null, webFXTreeConfig.serverIcon, webFXTreeConfig.serverIcon);
			}