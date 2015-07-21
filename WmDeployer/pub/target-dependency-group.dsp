<HTML><HEAD><TITLE>Target Dependencies</TITLE>
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META http-equiv=Pragma content=no-cache>
<META http-equiv=Expires content=-1>
<LINK href="webMethods.css" type="text/css" rel="stylesheet">
<LINK href="xtree.css" type="text/css" rel="stylesheet">
<SCRIPT src="webMethods.js"></SCRIPT>
<SCRIPT src="xtree.js"></SCRIPT>
<SCRIPT src="xtreecheckbox.js"></SCRIPT>
<script>
	function getIcon(type)
	{
		var icon = getNSIcon(type);
		if(icon == 'images/ns_unknown_node.gif')
		{
			switch (type) {
				case 'DocumentType':
					icon = "images/Broker/broker-doc.gif";
					break;
				case 'ClientGroup':
					icon = "images/Broker/client-group.gif";
					break;
			}
		}
		return icon;
	}

	function checkAll()
	{
		var el = document.getElementById("selectAll");
		if(el.checked)
		{
			var elArr = document.getElementsByName("select");
			for (var i = 0; i < elArr.length; i++)
			{
				elArr[i].checked = true;
			}
		}
		else
		{
			var elArr = document.getElementsByName("select");
			for (var i = 0; i < elArr.length; i++)
			{
				elArr[i].checked = false;
			}
		}
	}

	function onAdd()
	{
		alert("You need to re-build the project for your changes to take effect");
		var dependentData = "";
		var elArr = document.getElementsByName("select");

		for(var i = 0; i < elArr.length; i++)
		{
			if(elArr[i].checked)
			{	
				dependentData = dependentData + elArr[i].value + "$$";
			}
		}
		var data = document.getElementById('dependentData');
		data.value = dependentData;
	}

	function onRemove()
	{
		alert("You need to re-build the project for your changes to take effect");
		var action = document.getElementById("action");
		action.value = "removeComponents";
		var componentData = "";

		var elArr = document.getElementsByName("component");

		for(var i = 0; i < elArr.length; i++)
		{
			if(elArr[i].checked)
			{
				componentData = componentData + elArr[i].value + "$$";
			}
		}
		var data = document.getElementById("componentData");
		data.value = componentData;
	}
</script>
</HEAD>
<BODY>
%invoke wm.deployer.gui.UITargetGroup:listTargetGroupServers%
<TABLE width="100%">
  <TR>
  %ifvar bundleMode equals('Deploy')%
    <TD class=menusection-Deployer>%value mapSetName% > %value bundleName% > References missing on %value rtgName%</TD>
   %else%
	    <TD class=menusection-Deployer>%value mapSetName% > %value bundleName% > Dependent Assets present on %value rtgName%</TD>
	%endif%
  </TR>
</TABLE>

<TABLE width="100%" >
  <TR>
    <TD colspan="2"> 
			<UL> 
				<li> <A onclick="startProgressBar();" href="target-dependency-group.dsp?projectName=%value projectName%&bundleName=%value bundleName%&mapSetName=%value mapSetName%&rtgName=%value rtgName%&pluginType=%value pluginType%">Refresh this Page</A></li> 
				%ifvar projectType equals('Repository')%
				<LI><A onclick="startProgressBar();" href="edit-map-repository.dsp?projectName=%value projectName%&mapSetName=%value mapSetName%&mapSetDescription=%value mapSetDescription%">Return to %value mapSetName% > Properties</A></LI>
				%else%
				<LI><A onclick="startProgressBar();" href="edit-map.dsp?projectName=%value projectName%&mapSetName=%value mapSetName%&mapSetDescription=%value mapSetDescription%">Return to %value mapSetName% > Properties</A></LI>
				%endif%
			</UL> 
		</TD> 
  </TR>
</TABLE>
	<script>
	%ifvar bundleMode equals('Deploy')%
		var targetGroup = new WebFXTree("References missing on %value targetGroupAlias%");
	%else%
		var targetGroup = new WebFXTree("Dependent Assets present on %value targetGroupAlias%");
	%endif%
	</script>

%comment%
	<FORM id="form" name="form" method="POST" target="treeFrame" action="under-construction.dsp">
%endcomment%
	<FORM id="form" name="form" method="POST" target="propertyFrame" action="edit-map.dsp">
    <INPUT type="hidden" name="action" id="action" value="addDependents">
	<input type="hidden" name="dependentData" id="dependentData" value="">
    <input type="hidden" name="componentData" id="componentData" value="">
	<input type="hidden" name="bundleName" value="%value bundleName%" >
	<input type="hidden" name="projectName" value="%value projectName%" >
	<input type="hidden" name="mapSetName" value="%value mapSetName%" >
	<input type="hidden" name="mapSetDescription" value="%value mapSetDescription%" >
    <input type="hidden" name="rtgName" value="%value rtgName%" >
	<input type="hidden" name="pluginType" value="%value bundleType%" >

	<TABLE class="tableView" width="100%">

		<SCRIPT>resetRows();</SCRIPT>		
	  <TR>
			<TD><img border="0" src="images/blank.gif" width="20" height="1"></TD>
			%ifvar bundleMode equals('Deploy')%
		    <TD class="heading" valign="top"> References missing on %value rtgName% </TD>
			%else%
			<TD class="heading" valign="top"> Dependent Assets present on %value rtgName% </TD>
			%endif%
			<TD valign="top"> <img border="0" src="images/blank.gif" width="20" height="1"></td>
	  </TR>
	
	<tr>
	<TD><img border="0" src="images/blank.gif" width="20" height="1"></TD>
	<td class="rowdata-l" width="100%" colspan=2><FONT color="green"><b><div id="allGreenMessage"></div></b></FONT></td>	
	</tr>

	<tr>
	<TD><img border="0" src="images/blank.gif" width="20" height="1"></TD>
	<td class="rowdata-l" width="100%" colspan=2><FONT color="red"><b><div id="allRedMessage"></div></b></FONT></td>	
	</tr>

	  <script language="javascript">
		var targetGroupDependency = '';	
		var targetGroupDependents = false;
		var unknown = false;	
		var hasError = false;
		var displayDone = false;
		var emptyTargetGroup = false;
		var text = "<TR><TD class=\"action\"><INPUT onclick=\"javascript:onRemove();\" align=\"center\"" +
					" type=\"submit\" VALUE=\"Remove\" name=\"submit\"> </TD>" +
					"</TD><TD class=\"action\"><INPUT onclick=\"javascript:onAdd();\" align=\"center\"" + 
					" type=\"submit\" VALUE=\"Add\" name=\"submit\"> </TD></TR>" +
					" <TR> <TD class=\"oddcol\">Assets</TD><TD class=\"oddcol\">Dependent Assets</TD></TR> " +
					" <TR><TD></TD><TD><input type=\"checkbox\" id=\"selectAll\" onclick=\"javascript:checkAll();\" />Select All </TD></TR>";
	  </script>

  %ifvar missingReferences equals('unknown')%
     <script language="javascript">
		unknown = true;
		hasError = true;
     </script>
  %endif%
  %ifvar emptyTargetGroup equals('true')%
      <script language="javascript">
    		emptyTargetGroup = true;
     </script>
  %endif%  

  %ifvar status equals('Success')% 
  %ifvar bundleMode equals('Deploy')%
	%loop targetGroupServers%
		%rename name targetServerAliasName -copy%
		%rename ../projectName projectName -copy%	
		%rename ../bundleName bundleName -copy%		
		%rename ../mapSetName mapSetName -copy%
		%rename ../pluginType pluginType -copy%	

	  <TR>
		<TD valign="top"></td>
			<script> writeTD("rowdata-l", "width='100%'");</script>

				<script>
				
				%invoke wm.deployer.gui.UITarget:checkTargetDependencies%
				var root = new WebFXTree("References missing on %value targetServerAliasName%", null, null, 
							webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon);
				
				%ifvar status equals('Success')%
					%ifvar dependencies -notempty%
						targetGroupDependency = true;
						%loop dependencies%						
								%switch type%
								%case 'ACL'%
									var pkgTree = new WebFXTreeItem("%value serverAliasName%:ACLs", null, null, 
										webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon);
								%case 'Group'%
									var pkgTree = new WebFXTreeItem("%value serverAliasName%:Groups", null, null, 
										webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon);
								%case 'Port'%
									var pkgTree = new WebFXTreeItem("%value serverAliasName%:Ports", null, null, 
										webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon);
								%case 'User'%
									var pkgTree = new WebFXTreeItem("%value serverAliasName%:Users", null, null, 
										webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon);
								%case 'ScheduledService'%
									var pkgTree = new WebFXTreeItem("%value serverAliasName%:Scheduled Tasks", null, null, 
										webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon);
								%case 'Package'%
								
									var pkgTree = new WebFXTreeItem("%value serverAliasName%:%value referencedPackageName%", null, null, 
										webFXTreeConfig.ISPackage, webFXTreeConfig.ISPackage);
								%case 'TNDocumentAttribute'%
									var pkgTree = new WebFXTreeItem("%value serverAliasName%:Document Attributes", null, null, 
										webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon);
								%case 'TNDocumentType'%
									var pkgTree = new WebFXTreeItem("%value serverAliasName%:Document Types", null, null, 
										webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon);
								%case 'TNProcessingRule'%
									var pkgTree = new WebFXTreeItem("%value serverAliasName%:Processing Rules", null, null, 
										webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon);
								%case 'TNFieldDefinition'%
									var pkgTree = new WebFXTreeItem("%value serverAliasName%:Field Definitions", null, null, 
										webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon);
								%case 'TNFieldGroup'%
									var pkgTree = new WebFXTreeItem("%value serverAliasName%:Field Groups", null, null, 
										webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon);
								%case 'TNProfile'%
									var pkgTree = new WebFXTreeItem("%value serverAliasName%:Profiles", null, null, 
										webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon);
								%case 'TNProfileGroup'%
									var pkgTree = new WebFXTreeItem("%value serverAliasName%:Profile Groups", null, null, 
										webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon);
								%case 'TNIdType'%
									var pkgTree = new WebFXTreeItem("%value serverAliasName%:External ID Types", null, null, 
										webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon);
								%case 'TNContactType'%
									var pkgTree = new WebFXTreeItem("%value serverAliasName%:Contact Types", null, null, 
										webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon);
								%case 'TNBinaryType'%
									var pkgTree = new WebFXTreeItem("%value serverAliasName%:Binary Types", null, null, 
										webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon);
								%case 'TNExtendedField'%
									var pkgTree = new WebFXTreeItem("%value serverAliasName%:Extended Fields", null, null, 
										webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon);
								%case 'TNSecurityData'%
									var pkgTree = new WebFXTreeItem("%value serverAliasName%:Certficates", null, null, 
										webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon);
								%case 'TNTPA'%
									var pkgTree = new WebFXTreeItem("%value serverAliasName%:Agreements", null, null, 
										webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon);
								%case%
									var pkgTree = new WebFXTreeItem("%value serverAliasName%:%value typeLabel%", null, null, 
										webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon);
								%end%

							root.add(pkgTree);
							%loop referencedComponents%
								%ifvar referencedComponentIcon%
									var icon = "%value referencedComponentIcon%";
								%else%
									var icon = getNSIcon("%value referencedComponentType%");
								%endif%
								var itemTree = new WebFXTreeItem("%value referencedComponentName%", null, null, icon, icon);
								pkgTree.add(itemTree);
							%endloop referencedComponents%
						%endloop dependencies%
						w(root);						
					%else%		                
						   if (targetGroupDependency != true)
								targetGroupDependency = false;			
					     %endif%
				%else%				    
					w('<FONT color="red">%value message -code%</FONT>');  // error in  - ifvar status equals('Success')					
					hasError = true;
				%endif%
				%endinvoke%
				</script>
			</TD>
			<TD valign="top"></td>
		</TR>
		%endloop targetGroupServers%
  				
  
  	<!-- logical cluster -->
  	%loop targetGroupClusters%
  		%loop targetClusterServers%
  		%rename ../../projectName projectName -copy%	
  		%rename ../../bundleName bundleName -copy%	
  		%rename ../../mapSetName mapSetName -copy%
  		%rename ../../pluginType pluginType -copy%	  		
  		%rename clusterServer targetServerAliasName -copy%
  
  	 <TR>
		<TD valign="top"></td>
			<script> writeTD("rowdata-l", "width='100%'");</script>

				<script>
				
				%invoke wm.deployer.gui.UITarget:checkTargetDependencies%
				var root = new WebFXTree("References missing on %value targetServerAliasName%", null, null, 
							webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon);
				
				%ifvar status equals('Success')%
					%ifvar dependencies -notempty%
						targetGroupDependency = true;
						%loop dependencies%						
								%switch type%
								%case 'ACL'%
									var pkgTree = new WebFXTreeItem("%value serverAliasName%:ACLs", null, null, 
										webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon);
								%case 'Group'%
									var pkgTree = new WebFXTreeItem("%value serverAliasName%:Groups", null, null, 
										webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon);
								%case 'Port'%
									var pkgTree = new WebFXTreeItem("%value serverAliasName%:Ports", null, null, 
										webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon);
								%case 'User'%
									var pkgTree = new WebFXTreeItem("%value serverAliasName%:Users", null, null, 
										webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon);
								%case 'ScheduledService'%
									var pkgTree = new WebFXTreeItem("%value serverAliasName%:Scheduled Tasks", null, null, 
										webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon);
								%case 'Package'%
								
									var pkgTree = new WebFXTreeItem("%value serverAliasName%:%value referencedPackageName%", null, null, 
										webFXTreeConfig.ISPackage, webFXTreeConfig.ISPackage);
								%case 'TNDocumentAttribute'%
									var pkgTree = new WebFXTreeItem("%value serverAliasName%:Document Attributes", null, null, 
										webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon);
								%case 'TNDocumentType'%
									var pkgTree = new WebFXTreeItem("%value serverAliasName%:Document Types", null, null, 
										webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon);
								%case 'TNProcessingRule'%
									var pkgTree = new WebFXTreeItem("%value serverAliasName%:Processing Rules", null, null, 
										webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon);
								%case 'TNFieldDefinition'%
									var pkgTree = new WebFXTreeItem("%value serverAliasName%:Field Definitions", null, null, 
										webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon);
								%case 'TNFieldGroup'%
									var pkgTree = new WebFXTreeItem("%value serverAliasName%:Field Groups", null, null, 
										webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon);
								%case 'TNProfile'%
									var pkgTree = new WebFXTreeItem("%value serverAliasName%:Profiles", null, null, 
										webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon);
								%case 'TNProfileGroup'%
									var pkgTree = new WebFXTreeItem("%value serverAliasName%:Profile Groups", null, null, 
										webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon);
								%case 'TNIdType'%
									var pkgTree = new WebFXTreeItem("%value serverAliasName%:External ID Types", null, null, 
										webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon);
								%case 'TNContactType'%
									var pkgTree = new WebFXTreeItem("%value serverAliasName%:Contact Types", null, null, 
										webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon);
								%case 'TNBinaryType'%
									var pkgTree = new WebFXTreeItem("%value serverAliasName%:Binary Types", null, null, 
										webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon);
								%case 'TNExtendedField'%
									var pkgTree = new WebFXTreeItem("%value serverAliasName%:Extended Fields", null, null, 
										webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon);
								%case 'TNSecurityData'%
									var pkgTree = new WebFXTreeItem("%value serverAliasName%:Certficates", null, null, 
										webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon);
								%case 'TNTPA'%
									var pkgTree = new WebFXTreeItem("%value serverAliasName%:Agreements", null, null, 
										webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon);
								%case%
									var pkgTree = new WebFXTreeItem("%value serverAliasName%:%value typeLabel%", null, null, 
										webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon);
								%end%

							root.add(pkgTree);
							%loop referencedComponents%
								%ifvar referencedComponentIcon%
									var icon = "%value referencedComponentIcon%";
								%else%
									var icon = getNSIcon("%value referencedComponentType%");
								%endif%
								var itemTree = new WebFXTreeItem("%value referencedComponentName%", null, null, icon, icon);
								pkgTree.add(itemTree);
							%endloop referencedComponents%
						%endloop dependencies%
						w(root);						
					%else%		                
						   if (targetGroupDependency != true)
								targetGroupDependency = false;			
					     %endif%
				%else%				    
					w('<FONT color="red">%value message -code%</FONT>');  // error in  - ifvar status equals('Success')					
					hasError = true;
				%endif%
				%endinvoke%
				</script>
			</TD>
			<TD valign="top"></td>
		</TR>
  		%endloop targetClusterServers%
  	%endloop targetGroupClusters%		

	%else%

	<script>
		displayDone = false;
	</script>
	%loop targetGroupServers%
		%rename ../projectName projectName -copy%	
    %rename ../bundleName bundleName -copy%	
    %rename ../mapSetName mapSetName -copy%
    %rename ../pluginType pluginType -copy%
		%rename name targetServerAliasName -copy%
			

	  <TR>
		<TD valign="top"></td>
			<script> writeTD("rowdata-l", "width='100%'");</script>

					%invoke wm.deployer.gui.UITarget:checkTargetDependencies%
					%ifvar status equals('Success')%
    				<TABLE class="tableView" width="100%">
					
					%ifvar dependents -notempty%
					<script>
					targetGroupDependents = true;
					</script>

					<script>
							if(!displayDone)
							{
								document.write(text);
								displayDone = true;
							}
					</script>

								<TR>
									<TD colspan="2"><br></TD>
								</TR>
								<TR>
									<TD class="heading" valign="top" colspan="2"> Dependent Assets present on %value targetServerAliasName% </TD>
								</TR>
							%loop dependents%
							<TR>
								 <SCRIPT>writeTD('rowdata-l', 'nowrap');</SCRIPT>
								 <input type="checkbox" name="component" value="%value component -urlencode%COMPONENT_TYPE%value componentType -urlencode%" />
								 <img border="0" src="" id="%value component -urlencode%" name="%value component -urlencode%" > %value component%</TD>
								 <script>
									var icons = document.getElementsByName("%value component -urlencode%");
									for(var i = 0; i < icons.length; i++)
									{
										icons[i].src = getIcon("%value componentType%");
									}
								 </script>
								<SCRIPT>writeTD('rowdata', 'nowrap');</SCRIPT>
								<TABLE class="tableView" width="100%">
										%loop referencedBy%
										<TR>
										<TD nowrap>
										%ifvar nodeId%
										&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="select" value="%value nodeId -urlencode%DEPENDENT_TYPE%value nodeName -urlencode%DEPENDENT_TYPE%value nodeType -urlencode%TARGET_ALIAS%value ../../targetServerAliasName -urlencode%" />
										%else%
										&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="select" value="%value nodeName -urlencode%DEPENDENT_TYPE%value nodeType -urlencode%TARGET_ALIAS%value ../../targetServerAliasName -urlencode%" />
										%endif%
										<img border="0" src="" id="%value nodeName -urlencode%%value ../component -urlencode%" name="%value nodeName -urlencode%%value ../component -urlencode%">
										%value nodeName%
										 <script>
											var icons2 = document.getElementsByName("%value nodeName -urlencode%%value ../component -urlencode%");
											for(var i = 0; i < icons2.length; i++)
											{
												icons2[i].src = getIcon("%value nodeType%");
											}
										 </script>
										</TD>
										</TR>
										%endloop referencedBy%
								</TABLE>
							</TD>
							<SCRIPT>swapRows();</SCRIPT>
							</TR>
							%endloop dependents%
						</TABLE>
					%endif%
				%else%
				<script>
					w('<FONT color="red">%value message -code%</FONT>');  // error in  - ifvar status equals('Success')	
					hasError = true;
				%endif%
				%endinvoke%
				</script>
			</TD>
			<TD valign="top"></td>
		</TR>
	%endloop targetGroupServers%

	

	<!-- logical cluster -->
	<script>
		displayDone = false;
	</script>

	%loop targetGroupClusters%
		%loop targetClusterServers%
		%rename ../../projectName projectName -copy%	
		%rename ../../bundleName bundleName -copy%	
		%rename ../../mapSetName mapSetName -copy%
		%rename ../../pluginType pluginType -copy%	
		%rename clusterServer targetServerAliasName -copy%

	  <TR>
		<TD valign="top"></td>
			<script>writeTD("rowdata-l", "width='100%'");</script>

					%invoke wm.deployer.gui.UITarget:checkTargetDependencies%
					%ifvar status equals('Success')%
    				<TABLE class="tableView" width="100%">
					%ifvar dependents -notempty%
					<script>
					targetGroupDependents = true;
					if(!displayDone)
					{
						document.write(text);
						displayDone = true;
					}
					</script>
								<TR>
									<TD colspan="2"><br></TD>
								</TR>
								<TR>
									<TD class="heading" valign="top" colspan="2"> Dependent Assets present on %value targetServerAliasName% </TD>
								</TR>
							%loop dependents%
							<TR>
								 <SCRIPT>writeTD('rowdata-l', 'nowrap');</SCRIPT>
								 <input type="checkbox" name="component" value="%value component -urlencode%COMPONENT_TYPE%value componentType -urlencode%" />
								 <img border="0" src="" id="%value component -urlencode%" name="%value component -urlencode%" > %value component%</TD>
								 <script>
									var icons = document.getElementsByName("%value component -urlencode%");
									for(var i = 0; i < icons.length; i++)
									{
										icons[i].src = getIcon("%value componentType%");
									}
								 </script>
								<SCRIPT>writeTD('rowdata', 'nowrap');</SCRIPT>
								<TABLE class="tableView" width="100%">
										%loop referencedBy%
										<TR>
										<TD nowrap>
										&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="select" value="%value nodeName -urlencode%DEPENDENT_TYPE%value nodeType -urlencode%TARGET_ALIAS%value ../../targetServerAliasName -urlencode%" />
										<img border="0" src="" id="%value nodeName -urlencode%%value ../component -urlencode%" name="%value nodeName -urlencode%%value ../component -urlencode%">
										%value nodeName%
										 <script>
											var icons2 = document.getElementsByName("%value nodeName -urlencode%%value ../component -urlencode%");
											for(var i = 0; i < icons2.length; i++)
											{
												icons2[i].src = getIcon("%value nodeType%");
											}
										 </script>
										</TD>
										</TR>
										%endloop referencedBy%
								</TABLE>
							</TD>
							<SCRIPT>swapRows();</SCRIPT>
							</TR>
							%endloop dependents%
						</TABLE>
					%endif%
				%else%
				<script>
					w('<FONT color="red">%value message -code%</FONT>');  // error in  - ifvar status equals('Success')	
					hasError = true;
				%endif%
				%endinvoke%
				</script>
			</TD>
			<TD valign="top"></td>
		</TR>
		%endloop targetClusterServers%
	%endloop targetGroupClusters%

	%endif%

	%else%
	 <TR>
		<TD valign="top"></td>
		<script> writeTD("rowdata-l", "width='100%'");</script>
		<script>
		w('<FONT color="red">%value message -code%</FONT>');  // error in  - ifvar status equals('Success')					
		hasError = true;
	%endif%

		</script>
	</TD>
	<TD valign="top"></td>
	</TR>
	<script> 
		stopProgressBar();
		if (unknown == true && hasError == true)
		{
			document.getElementById('allRedMessage').innerHTML = 'WmDeployer Resource package might be missing on some target servers in the group.';
		}
		%ifvar bundleMode equals('Deploy')%
		  if(emptyTargetGroup == true) {
        document.getElementById('allGreenMessage').innerHTML = 'This target group has no servers in it.';
      }
      else 
  			if (targetGroupDependency == false && hasError == false)
  			{
  				document.getElementById('allGreenMessage').innerHTML = 'There are no references missing on this target Group.';
  			}
		%else%
			if(targetGroupDependents == false && hasError == false)
			{
				document.getElementById('allGreenMessage').innerHTML = 'There are no dependent Assets present on this target group.';
			}
		%endif%
</script> 
	</TABLE>
%endinvoke%	

</BODY></HTML>
 