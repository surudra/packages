// getBundleTNTypes: projectName*, bundleName*

%invoke wm.deployer.gui.TN:getBundleTNTypes%
	%loop servers%
		var serverTree = new WebFXTreeItem("%value serverAliasName%", null, null, 
			serverIcon, serverIcon);
		TNTree.add(serverTree);

		// Processing Rules
		%ifvar rules -notempty%
			var subTree = new WebFXTreeItem("Processing Rules");
			serverTree.add(subTree);
			%loop rules%
				var p = new WebFXTreeItem("%value ruleName%", null, null, 
					webFXTreeConfig.TNrule, webFXTreeConfig.TNrule);
				subTree.add(p);
			%endloop%
		%endif%

		// Document Attributes
		%ifvar attribs -notempty%
			var subTree = new WebFXTreeItem("Document Attributes");
			serverTree.add(subTree);
			%loop attribs%
				var p = new WebFXTreeItem("%value attribName%", null, null, 
					webFXTreeConfig.TNattribute, webFXTreeConfig.TNattribute);
				subTree.add(p);
			%endloop%
		%endif%

		// Document Types
		%ifvar types -notempty%
			var subTree = new WebFXTreeItem("Document Types");
			serverTree.add(subTree);
			%loop types%
				var p = new WebFXTreeItem("%value typeName%", null, null, 
					webFXTreeConfig.TNtype, webFXTreeConfig.TNtype);
				subTree.add(p);
			%endloop%
		%endif%

		// TPAs
		%ifvar tpas -notempty%
			var subTree = new WebFXTreeItem("Agreements");
			serverTree.add(subTree);
			%loop tpas%
				var p = new WebFXTreeItem("%value tpaName%", null, null, 
					webFXTreeConfig.TNagreement, webFXTreeConfig.TNagreement);
				subTree.add(p);
			%endloop%
		%endif%

		// Field Groups
		%ifvar fldgrps -notempty%
			var subTree = new WebFXTreeItem("Field Groups");
			serverTree.add(subTree);
			%loop fldgrps%
				var p = new WebFXTreeItem("%value fldgrpName%", null, null, 
					webFXTreeConfig.TNprofileFld, webFXTreeConfig.TNprofileFld);
				subTree.add(p);
			%endloop%
		%endif%

		// Field Definitions
		%ifvar flddefs -notempty%
			var subTree = new WebFXTreeItem("Field Definitions");
			serverTree.add(subTree);
			%loop flddefs%
				var p = new WebFXTreeItem("%value flddefName%", null, null, 
					webFXTreeConfig.TNprofileFld, webFXTreeConfig.TNprofileFld);
				subTree.add(p);
			%endloop%
		%endif%

		// External ID types
		%ifvar idTypes -notempty%
			var subTree = new WebFXTreeItem("External ID Types");
			serverTree.add(subTree);
			%loop idTypes%
				var p = new WebFXTreeItem("%value idTypeName%", null, null, 
					webFXTreeConfig.TNprofileFld, webFXTreeConfig.TNprofileFld);
				subTree.add(p);
			%endloop%
		%endif%

		// Contact Types
		%ifvar contactTypes -notempty%
			var subTree = new WebFXTreeItem("Contact Types");
			serverTree.add(subTree);
			%loop contactTypes%
				var p = new WebFXTreeItem("%value contactTypeName%", null, null, 
					webFXTreeConfig.TNprofileFld, webFXTreeConfig.TNprofileFld);
				subTree.add(p);
			%endloop%
		%endif%

		// Binary Types
		%ifvar binaryTypes -notempty%
			var subTree = new WebFXTreeItem("Binary Types");
			serverTree.add(subTree);
			%loop binaryTypes%
				var p = new WebFXTreeItem("%value binaryTypeName%", null, null, 
					webFXTreeConfig.TNprofileFld, webFXTreeConfig.TNprofileFld);
				subTree.add(p);
			%endloop%
		%endif%

		// Profile Groups
		%ifvar profileGroups -notempty%
			var subTree = new WebFXTreeItem("Profile Groups");
			serverTree.add(subTree);
			%loop profileGroups%
				var p = new WebFXTreeItem("%value profileGroupName%", null, null, 
					webFXTreeConfig.TNprofile, webFXTreeConfig.TNprofile);
				subTree.add(p);
			%endloop%
		%endif%

		// Queues
		%ifvar queues -notempty%
			var subTree = new WebFXTreeItem("Public Queues");
			serverTree.add(subTree);
			%loop queues%
				var p = new WebFXTreeItem("%value queueName%", null, null, 
					webFXTreeConfig.TNqueue, webFXTreeConfig.TNqueue);
				subTree.add(p);
			%endloop%
		%endif%
		
		// DLS
		%ifvar dls -notempty%
			var subTree = new WebFXTreeItem("DLS");
			serverTree.add(subTree);
			%loop dls%
				var p = new WebFXTreeItem("%value dlsName%", null, null, 
					webFXTreeConfig.TNdls, webFXTreeConfig.TNdls);
				subTree.add(p);
			%endloop%
		%endif%
		
		// Fp
		%ifvar fp -notempty%
			var subTree = new WebFXTreeItem("Functional Permissions");
			serverTree.add(subTree);
			%loop fp%
				var p = new WebFXTreeItem("%value fpName%", null, null, 
					webFXTreeConfig.TNfp, webFXTreeConfig.TNfp);
				subTree.add(p);
			%endloop%
		%endif%


             // Archival Services
		%ifvar archSvcs -notempty%
			var subTree = new WebFXTreeItem("Archival Services");
			serverTree.add(subTree);
			%loop archSvcs%
				var p = new WebFXTreeItem("%value archSvcsName%", null, null, 
					webFXTreeConfig.TNArchivalSvc, webFXTreeConfig.TNArchivalSvc);
				subTree.add(p);
			%endloop%
		%endif%


		// To guarantee a unique Partner Data folder 
		var partnerList = new Array;
		var partnerTreeList = new Array;

		var subTree = new WebFXTreeItem("Partner Data");

		// Partner Data: Profiles
		%loop profiles%
			var partnerTree = new WebFXTreeItem("Partner: %value profileName%");
			var p = new WebFXTreeItem("Profile", null, null, 
				webFXTreeConfig.TNprofile, webFXTreeConfig.TNprofile);
			partnerTree.add(p);
			subTree.add(partnerTree);

			// Stow away the Profile Key for later lookup
			partnerList[partnerList.length] = "%value profileKey%";
			partnerTreeList[partnerTreeList.length] = partnerTree;
		%endloop%

		// Partner Data: Extended Fields
		%loop extflds%
			var p = new WebFXTreeItem("%value extfldName%", null, null, 
				webFXTreeConfig.TNprofileFld, webFXTreeConfig.TNprofileFld);

			var partnerTree = getServerTree("%value extfldParentKey%", partnerList, partnerTreeList);

			// In the odd case where the Profile was not selected, provide a folder
			if (partnerTree == null) {
				var partnerTree = new WebFXTreeItem("Partner: %value extfldParentName%");
				subTree.add(partnerTree);

				// Stow away the Profile Key for later lookup
				partnerList[partnerList.length] = "%value extfldParentKey%";
				partnerTreeList[partnerTreeList.length] = partnerTree;
			}

			partnerTree.add(p);
		%endloop%

		// Partner Data: Security Data
		%loop securityData%
			var p = new WebFXTreeItem("Security Data", null, null, 
				webFXTreeConfig.TNcertificate, webFXTreeConfig.TNcertificate);
			var partnerTree = getServerTree("%value securityDataParentKey%", partnerList, partnerTreeList);

			// In the odd case where the Profile was not selected, provide a folder
			if (partnerTree == null) {
				var partnerTree = new WebFXTreeItem("Partner: %value securityDataParentName%");
				subTree.add(partnerTree);

				// Stow away the Profile Key for later lookup
				partnerList[partnerList.length] = "%value securityDataParentKey%";
				partnerTreeList[partnerTreeList.length] = partnerTree;
			}

			partnerTree.add(p);
		%endloop%

		if (subTree.childNodes.length > 0)
			serverTree.add(subTree);
	%endloop servers%
%endinvoke%
