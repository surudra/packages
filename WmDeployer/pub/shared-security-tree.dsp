				// Scheduled Tasks
				// serverAlias
				%invoke wm.deployer.gui.server.IS:listScheduledServices%
					%ifvar services -notempty%
						var schedTree = new WebFXCheckBoxTreeItem("Scheduled Tasks");
						%loop services%
						if (matchRegularExpression("%value /regExp%", "%value serviceName%")) {
							var p = new WebFXCheckBoxTreeItem("%value serviceName%", null, false, null, 
								webFXTreeConfig.ISTask, webFXTreeConfig.ISTask,
								"%value ../serverAlias -urlencode%$%value taskId%$%value serviceName%$%value runAsUser%", "SERVICE_INCL", null, "%value taskId%");
							schedTree.add(p);
							matchCnt++;
						}
						else
							filterCnt++;
						%endloop%
						if (schedTree.childNodes.length > 0) 
							serverTree.add(schedTree);
					%endif%
				%endinvoke listServices%

				// Ports
				// serverAlias
				%invoke wm.deployer.gui.server.IS:listPorts%
					%ifvar ports -notempty%
						var portTree = new WebFXCheckBoxTreeItem("Ports");
						%loop ports%
						if (matchRegularExpression("%value /regExp%", "%value -code portKey%")) {
							var p = new WebFXCheckBoxTreeItem("%value -code portKey%", null, false, null, 
								webFXTreeConfig.ISPort, webFXTreeConfig.ISPort,
								"%value ../serverAlias -urlencode%$PORT$%value portKey -urlencode%$PORT$%value portType%$PORT$PORT_INCL", "PORT_INCL");
							portTree.add(p);
							matchCnt++;
						}
						else
							filterCnt++;
						%endloop%
						if (portTree.childNodes.length > 0) 
							serverTree.add(portTree);
					%endif%
				%endinvoke listPorts%

				// Users
				// serverAlias
				%invoke wm.deployer.gui.server.IS:listUsers%
					%ifvar users -notempty%
						var userTree = new WebFXCheckBoxTreeItem("Users");
						%loop users%
						if (matchRegularExpression("%value /regExp%", "%value userName%")) {
							var p = new WebFXCheckBoxTreeItem("%value userName%", null, false, null, 
								webFXTreeConfig.ISUser, webFXTreeConfig.ISUser,
								"%value ../serverAlias -urlencode%$%value userName -urlencode%$USER_INCL", "USER_INCL");
							userTree.add(p);
							matchCnt++;
						}
						else
							filterCnt++;
						%endloop%
						if (userTree.childNodes.length > 0) 
							serverTree.add(userTree);
					%endif%
				%endinvoke listUsers%

				// Groups
				// serverAlias
				%invoke wm.deployer.gui.server.IS:listGroups%
					%ifvar groups -notempty%
						var groupTree = new WebFXCheckBoxTreeItem("Groups");
						%loop groups%
						if (matchRegularExpression("%value /regExp%", "%value groupName%")) {
							var p = new WebFXCheckBoxTreeItem("%value groupName%", null, false, null, 
								webFXTreeConfig.ISGroup, webFXTreeConfig.ISGroup,
								"%value ../serverAlias -urlencode%$%value groupName -urlencode%$GROUP_INCL", "GROUP_INCL");
							groupTree.add(p);
							matchCnt++;
						}
						else
							filterCnt++;
						%endloop%
						if (groupTree.childNodes.length > 0) 
							serverTree.add(groupTree);
					%endif%
				%endinvoke listGroups%

				// ACLs
				// serverAlias
				%invoke wm.deployer.gui.server.IS:listAcls%
					%ifvar acls -notempty%
						var aclTree = new WebFXCheckBoxTreeItem("ACLs");
						%loop acls%
						if (matchRegularExpression("%value /regExp%", "%value aclName%")) {
							var p = new WebFXCheckBoxTreeItem("%value aclName%", null, false, null, 
								webFXTreeConfig.ISAcl, webFXTreeConfig.ISAcl,
								"%value ../serverAlias -urlencode%$%value aclName%$ACL_INCL", "ACL_INCL");
							aclTree.add(p);
							matchCnt++;
						}
						else
							filterCnt++;
						%endloop%
						if (aclTree.childNodes.length > 0) 
							serverTree.add(aclTree);
					%endif%
				%endinvoke listAcls%

				// Extended Settings
				// serverAlias
				%invoke wm.deployer.gui.server.IS:listExtendedSettings%
					%ifvar extended -notempty%
						var extendTree = new WebFXCheckBoxTreeItem("Extended Settings");
						%loop extended%
						if (matchRegularExpression("%value /regExp%", "%value name%")) {
							var p = new WebFXCheckBoxTreeItem("%value name%", null, false, null, 
								webFXTreeConfig.ISExtended, webFXTreeConfig.ISExtended,
								"%value ../serverAlias -urlencode%$%value name%$EXTEND_INCL", "EXTEND_INCL");
							extendTree.add(p);
							matchCnt++;
						}
						else
							filterCnt++;
						%endloop%
						if (extendTree.childNodes.length > 0) 
							serverTree.add(extendTree);
					%endif%
				%endinvoke listExtended%
