<HTML><HEAD>
 <TITLE>Edit Target Group </TITLE>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META http-equiv="Expires" content="-1">
<LINK href="webMethods.css" type="text/css" rel="stylesheet">
<SCRIPT src="webMethods.js"></SCRIPT>
<SCRIPT src="xtree.js"></SCRIPT>
<SCRIPT src="xtreecheckbox.js"></SCRIPT>

<SCRIPT language=JavaScript>

function enableSaveProperties() {
	document.getElementById("save").disabled = false;
}

// Stow the configurable required fields here

function onUpdate() {

	// Name is always required
	var value = document.serverForm.name.value;

	if (!isIllegalName(value)) {
		alert("Invalid Name.\nRefer to Integration Server Administrator's Guide for listed illegal characters.");
		document.serverForm.name.focus();
		return false;
	}
  startProgressBar();
	return true;
}

function onLoad() {
	var validVersions = document.getElementById("validVersions").value;	
	var validVersionsArray = validVersions.split(",");
	var versionSelectObject = document.getElementById("runtimeVersion");
	var selectedVersion = "%value runtimeVersion%";
	if(selectedVersion == null || selectedVersion == '') {
		selectedVersion = document.getElementById("groupVersion").value
	}
	versionSelectObject.options.length = validVersionsArray.length;
	for (i=0;i<validVersionsArray.length;i++) {		
		versionSelectObject.options[i].text = validVersionsArray[i];
		versionSelectObject.options[i].value = validVersionsArray[i];		
		if(selectedVersion != null && selectedVersion == validVersionsArray[i]) {
			versionSelectObject.options[i].selected = true;
		}
	}
}
</SCRIPT>
</HEAD>
<BODY onload="updateAvailableServerCount('avblServers');updateSelectedServerCount('selectedServers');onLoad();">
<!- Determine if this user is empowered to modify server stuff ->
%invoke wm.deployer.UIAuthorization:isAuthorized%
%endinvoke%
<TABLE width="100%">
	<TR>
	%ifvar /isAuth equals('true')% 
		<TD class="menusection-Server" colspan="4"> %value rtgName% &gt; Configure Target Group 
		%else%
		<TD class="menusection-Server" colspan="4"> %value rtgName% &gt; View Target Group 
		%endif%
		</TD>
	</TR>
</TABLE>
<DIV id="messageDiv" name="messageDiv">
</DIV>
<TABLE>
<!-- Description -->
%ifvar action equals('updateTargetGroup')%
	%invoke wm.deployer.gui.UITargetGroup:updateTGDescription%
		%include error-handler.dsp%
			%ifvar status equals('Success')%
				<script>
				if(is_csrf_guard_enabled && needToInsertToken) {
	   			   parent.treeFrame.document.location.href = "target-groups.dsp?pluginType=%value -htmlcode pluginType%&pluginLabel=%value -htmlcode pluginLabel%&rtgName=%value -htmlcode rtgName%&rtgDescription=%value -htmlcode rtgDescription%&isLogicalCluster=%value -htmlcode isLogicalCluster%&" + _csrfTokenNm_ + "=" + _csrfTokenVal_;
				} else {
				   parent.treeFrame.document.location.href = "target-groups.dsp?pluginType=%value -htmlcode pluginType%&pluginLabel=%value -htmlcode pluginLabel%&rtgName=%value -htmlcode rtgName%&rtgDescription=%value -htmlcode rtgDescription%&isLogicalCluster=%value -htmlcode isLogicalCluster%";
				}
				</script>
			%end if%

	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%endif%

<!-- Update Servers -->
%ifvar action equals('updateServers')%
	%invoke wm.deployer.gui.UITargetGroup:getListOfServersFromString%
			%invoke wm.deployer.gui.UITargetGroup:updateTargetGroup%
			%include error-handler.dsp%
				%ifvar status equals('Success')%
				<script>
				if(is_csrf_guard_enabled && needToInsertToken) {
	   			   parent.treeFrame.document.location.href = "target-groups.dsp?pluginType=%value -htmlcode pluginType%&pluginLabel=%value -htmlcode pluginLabel%&rtgName=%value -htmlcode rtgName%&rtgDescription=%value -htmlcode rtgDescription%&isLogicalCluster=%value -htmlcode isLogicalCluster%&" + _csrfTokenNm_ + "=" + _csrfTokenVal_;
				} else {
				   parent.treeFrame.document.location.href = "target-groups.dsp?pluginType=%value -htmlcode pluginType%&pluginLabel=%value -htmlcode pluginLabel%&rtgName=%value -htmlcode rtgName%&rtgDescription=%value -htmlcode rtgDescription%&isLogicalCluster=%value -htmlcode isLogicalCluster%";
				}
				</script>
			  	%end if%
			%endinvoke%
	%endinvoke%
%end if% 
</TABLE>

<TABLE>
	<TR>
		<TD colspan="2">
     	<UL>	
        <LI><a onclick="startProgressBar();" href="edit-target-group.dsp?pluginType=%value /pluginType%&pluginLabel=%value /pluginLabel%&rtgName=%value rtgName%&rtgDescription=%value rtgDescription%&isLogicalCluster=%value isLogicalCluster%&runtimeVersion=%value runtimeVersion%">Refresh this Page</a>
     	</UL>	
		</TD>
	</TR>

<!- Get Plugin Info: (i) pluginType, (i) name ->

	
	%invoke wm.deployer.gui.UIPlugin:getValidVersionsForPluginType%
	%endinvoke%
	<TR>
		<TD><IMG height="0" src="images/blank.gif" width="10"></TD>
			<SCRIPT>resetRows();</SCRIPT>
		<TD>
			<TABLE class="tableView">
				<TR>
					<TD class="heading" colspan="2">Target Group: %value pluginLabel%</TD>
				</TR>

				<FORM name="serverForm" method="POST" action="edit-target-group.dsp" target="propertyFrame">  <!-- edit-target-group.dsp -->
				<INPUT type="hidden" VALUE="%value pluginType%" name="pluginType">
				<INPUT type="hidden" VALUE="%value pluginLabel%" name="pluginLabel">
				<INPUT type="hidden" VALUE="%value rtgName%" name="rtgName">
				
				<TR>
					<script> writeTD("row"); </script>Group Name</TD>
					<script> writeTD("rowdata-l"); </script> %value rtgName%</TD>
				</TR>
				<SCRIPT>swapRows();</SCRIPT>

				<!-- Description -->
				<TR>
					<script> writeTD("row"); </script> Description</TD>
					<script> writeTD("rowdata-l"); </script> 
					%ifvar /isAuth equals('true')% 
						<INPUT onchange="enableSaveProperties();" name="rtgDescription" value="%value rtgDescription%" size="32">
					%else%
						%value rtgDescription%
					%endif%
					</TD>
				</TR>
				<SCRIPT>swapRows();</SCRIPT>
				
				<!-- Version -->
				<TR>
					<script> writeTD("row"); </script> Version</TD>
					<script> writeTD("rowdata-l"); </script> 
					%ifvar /isAuth equals('true')%		
					<INPUT name="validVersions" id="validVersions" type="hidden" value="%value validVersions%">			  					
					<select onchange="enableSaveProperties();" name="runtimeVersion" id="runtimeVersion">								
					</select>
					%else%
						%value runtimeVersion%
					%endif%
					</TD>
				</TR>
				<SCRIPT>swapRows();</SCRIPT>

				
					<TR>
					<script> writeTD("row", "nowrap"); </script>Rollback All on Failure</TD>
					<script> writeTD("rowdata-l", "nowrap"); </script> 
					%ifvar /isAuth equals('true')%					
			            <INPUT onchange="enableSaveProperties();" type="radio" name="isLogicalCluster" value="true" 
										%ifvar isLogicalCluster equals('true')% checked %endif%>Yes
						<INPUT onchange="enableSaveProperties();" type="radio" name="isLogicalCluster" value="false"
										%ifvar isLogicalCluster equals('false')% checked %endif%>No
						%else%
							%ifvar isLogicalCluster equals('true')% Yes
		           		%else% 
		              		No
		           		 %endif%							
					%endif%
					</TR>
					<SCRIPT>swapRows();</SCRIPT>
				

			%ifvar /isAuth equals('true')% 
				<TR>
					<INPUT type="hidden" name="pluginType" value='%value pluginType%'>
					<INPUT type="hidden" name="pluginLabel" value='%value pluginLabel%'>					
					<INPUT type="hidden" name="rtgName" value='%value rtgName%'>
					<INPUT type="hidden" name="isLogicalCluster" value="%value isLogicalCluster%">
					<INPUT type="hidden" name="groupVersion" id="groupVersion" value="%value groupVersion%">					
					<INPUT type="hidden" name="regExp" value=''>
					<INPUT type="hidden" name="regExp2" value=''>
					<INPUT type="hidden" name="action" value="updateTargetGroup">
					<TD class="action" colspan="2">
						<INPUT disabled onclick="return onUpdate();" type="submit" VALUE="Save" name="submit" id="save">
					</TD>
				</TR>
			%endif%

				</FORM>
			</TABLE>
		</TD>
	</TR>

<TR>

<!-- start -->

<TABLE class="tableView">
	<TBODY>
	<SCRIPT>resetRows();</SCRIPT>		
  <TR>
		<TD><img border="0" src="images/blank.gif" width="14" height="1"></TD>
    <TD class="heading" valign="top"> Select Servers </TD>
		<TD valign="top"> <img border="0" src="images/blank.gif" width="20" height="1"></td>
  </TR>


	<FORM id="form" name="form" method="POST" action="edit-target-group.dsp" target="propertyFrame">
	<INPUT type="hidden" name="pluginType" value="%value pluginType%">
	<INPUT type="hidden" name="pluginLabel" value="%value pluginLabel%">
	<INPUT type="hidden" name="rtgName" value="%value rtgName%">
	<INPUT type="hidden" name="rtgDescription" value="%value rtgDescription%">
	<INPUT type="hidden" name="isLogicalCluster" value="%value isLogicalCluster%">
	
	
	<!-- Submit Button, placed at top for convenience -->
	%ifvar /isAuth equals('true')% 
	<TR>
 		<TD valign="top"></td>
		<TD class="action">
			<INPUT disabled onclick="updateTargetGroup1();" align="center" type="submit" 
				VALUE="Save" name="submit" id="save1"> </TD>
 		<TD valign="top"></td>
		<INPUT id="listOfServers" type="hidden" name="servers">
		<INPUT id="clusterNames" type="hidden" name="clusterNames">		
		<INPUT type="hidden" name="action" value="updateServers">
		<INPUT type="hidden" name="pluginType" value="%value pluginType%">
		<INPUT type="hidden" name="pluginLabel" value="%value pluginLabel%">		
		<INPUT type="hidden" name="rtgName" value="%value rtgName%">
		<INPUT type="hidden" name="groupVersion" id="groupVersion" value="%value groupVersion%">
	</TR>
	%endif%
	<SCRIPT>swapRows();</SCRIPT>		
	<TR>
 		<TD valign="top"></td>
		<script>writeTDspan("col-l","1");</script>Click on a Server Name to select individual server or servers to add to the Target Group.
 		<TD valign="top"></td>
	</TR>

	<SCRIPT>swapRows();</SCRIPT>		
	<TR>
 		<TD valign="top"></td>
		<script> writeTD("rowdata-l", "width='100%'");</script>


<script>

var devTree = new WebFXTree("Available Servers");
			var matchCnt = 0;
			var pluginType="%value pluginType%";
					var serverTree = new WebFXCheckBoxTreeItem("%value pluginLabel%", null, false, null, 
						webFXTreeConfig.targetGroupIcon, webFXTreeConfig.targetGroupIcon);

%invoke wm.deployer.gui.UITargetGroup:listAvailableServers%
	%loop availableServers%
				var pkgNode = new WebFXCheckBoxTreeItem("%value name%", 
					null, 
					false, null, webFXTreeConfig.serverIcon, webFXTreeConfig.serverIcon,
					"anurag$%value name%$PACKAGE_INCL", "PACKAGE_INCL", webFXTreeConfig.linkClass);
				serverTree.add(pkgNode);
				matchCnt++;

	%endloop availableServers%
	
  	%loop availableClusters%
  		%ifvar clusterName%
  			var pkgNode0 = new WebFXCheckBoxTreeItem("%value clusterName%",	null, 
  			false, null, webFXTreeConfig.clusterServer, webFXTreeConfig.clusterServer,
  			"clusterNode$%value name%$PACKAGE_INCL", "PACKAGE_INCL", webFXTreeConfig.linkClass);
  					
  					%loop definedClusterServers%
  								var pkgNode1 = new WebFXCheckBoxTreeItem("%value name%",	null, 
            			false, null, webFXTreeConfig.serverIcon, webFXTreeConfig.serverIcon,
            			"clusterServer$%value name%$PACKAGE_INCL", "PACKAGE_INCL", webFXTreeConfig.linkClass);
            			
            			pkgNode0.add(pkgNode1);
            			matchCnt++;
  					%endloop definedClusterServers%
  					
  					%loop addedClusterServers%
  
  								var pkgNode3 = new WebFXCheckBoxTreeItem("%value name%",	null, 
            			false, null, webFXTreeConfig.serverIcon, webFXTreeConfig.serverIcon,
            			"clusterServer$%value name%$PACKAGE_INCL", "PACKAGE_INCL", webFXTreeConfig.linkClass, null , false );
            			pkgNode0.add(pkgNode3);
            			matchCnt++;
  					%endloop addedClusterServers%		
  					
  					%loop nonDefinedClusterServers%
  
  								var pkgNode2 = new WebFXCheckBoxTreeItem(concatHostAndPortString("%value host%",%value port%),	null, 
            			false, null, webFXTreeConfig.serverIcon, webFXTreeConfig.serverIcon,
            			"clusterServer$%value name%$PACKAGE_INCL", "PACKAGE_INCL", webFXTreeConfig.linkClass, null , false );
            			pkgNode0.add(pkgNode2);
            			matchCnt++;
  					%endloop nonDefinedClusterServers%		
            			
  					
  					serverTree.add(pkgNode0);
  			%endif%
  	%endloop availableClusters%	
  	
%endinvoke%
	
	
	


				devTree.add(serverTree);

</script>
<script>

			var devTree1 = new WebFXTree("Selected Servers");

			var matchCnt1 = 0;
			

					var serverTree1 = new WebFXCheckBoxTreeItem("%value rtgName%", null, false, null, 
						webFXTreeConfig.targetGroupIcon, webFXTreeConfig.targetGroupIcon);

					%invoke wm.deployer.gui.UITargetGroup:listTargetGroupServers%
						%loop targetGroupServers%

								var pkgNode1 = new WebFXCheckBoxTreeItem("%value name%", 
									null, 
									false, null, webFXTreeConfig.serverIcon, webFXTreeConfig.serverIcon,
									"anurag$%value name%$PACKAGE_INCL", "PACKAGE_INCL", webFXTreeConfig.linkClass);
								serverTree1.add(pkgNode1);
								matchCnt1++;

						%endloop targetGroupServers%
				
						%loop targetGroupClusters%

								var pkgNode0 = new WebFXCheckBoxTreeItem("%value clusterName%", 
									null, 
									false, null, webFXTreeConfig.clusterServer, webFXTreeConfig.clusterServer,
									"anurag$%value clusterName%$PACKAGE_INCL", "PACKAGE_INCL", webFXTreeConfig.linkClass);
									
                    	%loop targetClusterServers%
                    								var pkgNode1 = new WebFXCheckBoxTreeItem("%value clusterServer%",	null, 
                              			false, null, webFXTreeConfig.serverIcon, webFXTreeConfig.serverIcon,
                              			"clusterServer$%value clusterServer%$PACKAGE_INCL", "PACKAGE_INCL", webFXTreeConfig.linkClass);
                              			
                              			pkgNode0.add(pkgNode1);
                              			matchCnt1++;
                    	%endloop targetClusterServers%				
                      					
								serverTree1.add(pkgNode0);								

						%endloop targetGroupClusters%						
						
					%endinvoke listTargetGroupServers%
				devTree1.add(serverTree1);
				var status = '%value status%';
				var message = '%value -htmlcode message%';
				if(status == 'Error' && message != null && message.indexOf("Version Mismatch Error") != -1) {
					var messageDiv = document.getElementById("messageDiv");
					messageDiv.innerHTML = "<TABLE><TR><TD class=\"message\" colspan=4>&nbsp;&nbsp;&nbsp;&nbsp;"+message+"</TD></TR></TABLE>";
					//alert("%value message%");
				}
</script>

<SCRIPT LANGUAGE="JavaScript">



function add1(){

	var p = serverTree;
	var p1 = serverTree1;
	var size =  p.childNodes.length;
	var temp = 0;
	//debugger;
	for (var i = 0; i < size; i++) {
    if (p.childNodes[i-temp].getChecked()) {
    	var node = p.childNodes[i-temp];
    	
      if(node.childNodes.length == 0) {
  			p.childNodes[i-temp].remove();
        var pTemp = new WebFXCheckBoxTreeItem(node.text, null, 
  									false, null, webFXTreeConfig.serverIcon, webFXTreeConfig.serverIcon,
  									"$PACKAGE_INCL", "PACKAGE_INCL", webFXTreeConfig.linkClass);
  								p1.add(pTemp);
  			temp++;
      }
      else {
        //alert(" Cluster");
         for(var j = 0; j < node.childNodes.length; j++) {
            var clusterNodes = node.childNodes[j];
            //alert(clusterNodes.text + " is " +clusterNodes.getChecked());
            if(!clusterNodes.getChecked()) {
              var clustersUnchecked = true;            
            }     
          }          
          if(clustersUnchecked) {
          //alert(" clustersUnchecked ");
            var response = confirm('You have not selected all the nodes of the Cluster which would break the Cluster. Click OK to confirm and proceed '); 
            if(response ) {
               for(var j = 0; j < node.childNodes.length; j++) {
                      var clusterNodes = node.childNodes[j];
                      if(clusterNodes.getChecked()) {
                          clusterServersChecked++ ;
                         // alert(" Adding only "+clusterNodes.text);
                          var clusterNodes = new WebFXCheckBoxTreeItem(clusterNodes.text,	null, 
                              			false, null, webFXTreeConfig.serverIcon, webFXTreeConfig.serverIcon,
                              			"clusterServer$%value name%$PACKAGE_INCL", "PACKAGE_INCL", webFXTreeConfig.linkClass);
                              p1.add(clusterNodes);
                          }  
                          else {
                          //alert(" NOT SEL " +clusterNodes.text);
                          p.add(clusterNodes);
                          }
                    
                  } // endof for loop throug all cluster server nodes               
            }

          }
          else {
         // alert(" Clusters checked");
          response = true;
          // Add the servers as subtree to the cluster
        			var clusterNode = new WebFXCheckBoxTreeItem(node.text,	null, 
                          			false, null, webFXTreeConfig.clusterServer, webFXTreeConfig.clusterServer,
                          			"clusterNode$%value name%$PACKAGE_INCL", "PACKAGE_INCL", webFXTreeConfig.linkClass);      
                                    var clusterServersChecked = 0;   
                                    
              for(var j = 0; j < node.childNodes.length; j++) {
                  var clusterNodes = node.childNodes[j];
                  if(clusterNodes.getChecked()) {
                      clusterServersChecked++ ;
                    //  alert(" Adding only "+clusterNodes.text);
                      var clusterNodes = new WebFXCheckBoxTreeItem(clusterNodes.text,	null, 
                          			false, null, webFXTreeConfig.serverIcon, webFXTreeConfig.serverIcon,
                          			"clusterServer$%value name%$PACKAGE_INCL", "PACKAGE_INCL", webFXTreeConfig.linkClass);
                      clusterNode.add(clusterNodes);
                      }  
              } // endof for loop throug all cluster server nodes   
           p1.add(clusterNode);
          } // endof else clustersUnchecked
  			                
        if(response) {
          node.remove();        
        }

        temp++;        
      }
    } // endof ChildNodes checked
  } // endof FOR
	
	for (var j = 0; j < p1.childNodes.length; j++) {
			p1.childNodes[j].setChecked(false);
	}
	p.setChecked(false);

	updateAvailableServerCount("avblServers");
	updateSelectedServerCount("selectedServers");

	document.getElementById("save1").disabled = false;
	document.getElementById("save2").disabled = false;
}

function updateAvailableServerCount(divName)
{
	var server = "";
	if(serverTree.childNodes.length>1){
		server=" servers";
	}
	else{
		server=" server";
	}
	//document.getElementById(divName).innerHTML = serverTree.childNodes.length + server +" displayed.";
	document.getElementById(divName).innerHTML = matchCnt + server +" displayed.";
}

function updateSelectedServerCount(divName)
{
	var server = "";
	if(serverTree1.childNodes.length>1){
		server=" servers";
	}
	else{
		server=" server";
	}
	//document.getElementById(divName).innerHTML = serverTree1.childNodes.length + server +" displayed.";
	document.getElementById(divName).innerHTML = matchCnt1 + server +" displayed.";
}

function remove1(){
	var p = serverTree;
	var p1 = serverTree1;
	var size =  p1.childNodes.length;
	var temp=0;
	for (var i = 0; i < size; i++) {
		if (p1.childNodes[i-temp].getChecked()){
			var node = p1.childNodes[i-temp];
			  if(node.childNodes.length == 0) { 
    			p1.childNodes[i-temp].remove();
    		    	var pTemp = new WebFXCheckBoxTreeItem(node.text, null, 
    									false, null, webFXTreeConfig.serverIcon, webFXTreeConfig.serverIcon,
    									"$PACKAGE_INCL", "PACKAGE_INCL", webFXTreeConfig.linkClass);
    			p.add(pTemp);
    			temp++;
			  }
			  else {
        //alert(" Removing Cluster Group");
           for(var j = 0; j < node.childNodes.length; j++) {
            var clusterNodes = node.childNodes[j];
            //alert(clusterNodes.text + " is " +clusterNodes.getChecked());
            if(!clusterNodes.getChecked()) {
              var clustersUnchecked = true;            
            }     
          } 
          if(clustersUnchecked) {
          //alert("clustersUnchecked");
            var response = confirm('You have not selected all the nodes of a Cluster which would break the Cluster. Click OK to confirm and proceed'); 
            if(response ) {
               for(var j = 0; j < node.childNodes.length; j++) {
                      var clusterNodes = node.childNodes[j];
                      if(clusterNodes.getChecked()) {
                          clusterServersChecked++ ;
                         // alert(" Adding only "+clusterNodes.text);
                          var clusterNodes = new WebFXCheckBoxTreeItem(clusterNodes.text,	null, 
                              			false, null, webFXTreeConfig.serverIcon, webFXTreeConfig.serverIcon,
                              			"clusterServer$%value name%$PACKAGE_INCL", "PACKAGE_INCL", webFXTreeConfig.linkClass);
                              p.add(clusterNodes);
                          }  
                          else {
                         // alert(" NOT SEL Addind to P1 " +clusterNodes.text);
                          var clusterNodes = new WebFXCheckBoxTreeItem(clusterNodes.text,	null, 
                              			false, null, webFXTreeConfig.serverIcon, webFXTreeConfig.serverIcon,
                              			"clusterServer$%value name%$PACKAGE_INCL", "PACKAGE_INCL", webFXTreeConfig.linkClass);                          
                          p1.add(clusterNodes);
                          }
                    
                  } // endof for loop throug all cluster server nodes               
            }          
          }
          else {
         // alert(" All clusters checked");
          response = true;
        	var clusterNode = new WebFXCheckBoxTreeItem(node.text,	null, 
          			false, null, webFXTreeConfig.clusterServer, webFXTreeConfig.clusterServer,
          			"clusterNode$%value name%$PACKAGE_INCL", "PACKAGE_INCL", webFXTreeConfig.linkClass);      
                    var clusterServersChecked = 0;
                for(var j = 0; j < node.childNodes.length; j++) {
                    var clusterNodes = node.childNodes[j];                  
                    if(clusterNodes.getChecked()) {
                       clusterServersChecked++ ;
                    
                   var clusterNodes = new WebFXCheckBoxTreeItem(clusterNodes.text,	null, 
              		  	false, null, webFXTreeConfig.serverIcon, webFXTreeConfig.serverIcon,
              			  "clusterServer$%value name%$PACKAGE_INCL", "PACKAGE_INCL", webFXTreeConfig.linkClass);
                  clusterNode.add(clusterNodes);
                    }           
                  }
                p.add(clusterNode);          
          } // endof else clustersUnchecked

          if(response) {
            node.remove();        
          }
         temp++;        
        }

		}
	}
	for (var j = 0; j < p.childNodes.length; j++) {
			p.childNodes[j].setChecked(false);
	}
	p1.setChecked(false);
	updateAvailableServerCount("avblServers");
	updateSelectedServerCount("selectedServers");
	document.getElementById("save1").disabled = false;
	document.getElementById("save2").disabled = false;
}
function updateTargetGroup1(){
	//alert("updateTargetGroup1() is called.");
	var listOfServers="";
	var clusterNames="";
	var p1 = serverTree1;
	var size = p1.childNodes.length;
//	alert(" Size = "+size)
	for(var i=0; i<size; i++){
	var t = p1.childNodes[i];
//	alert(i+" - " + t.childNodes.length+" Len = "+t.text+" : ");
	if(t.childNodes.length == 0) {
//    alert(" ZEROO ");
    		listOfServers = listOfServers + p1.childNodes[i].text+",";
  }
  else {
  //  alert(" NOT ZEROO "+t.childNodes.length);
    clusterNames = clusterNames + p1.childNodes[i].text ;
    for(var j=0; j<t.childNodes.length; j++ ) {
    clusterNames = clusterNames + ";" + t.childNodes[j].text ;
    }
    clusterNames = clusterNames + ",";

  }

	//	alert(p1.childNodes[i].text);
		
	}
	//listOfServers = listOfServers + p1.childNodes[p1.childNodes.length-1].text;
	// alert("listOfServers:: "+listOfServers);
	document.getElementById("listOfServers").value=listOfServers;
	document.getElementById("clusterNames").value=clusterNames;
}


</SCRIPT>
<table>
	<tr>
		<td valign="top">
		<script>w(devTree);</script>
		</td>
		<td>
			<table>
%ifvar /isAuth equals('true')% 
				<tr><td><INPUT TYPE="button" size="10" onclick="javascript:add1();" value=">"></td></tr>
				<tr><td><INPUT TYPE="button" size="10" onclick="javascript:remove1();" value="<"></td></tr>
%else%
				<tr><td><INPUT TYPE="button" disabled size="10" onclick="javascript:add1();" value=">"></td></tr>
				<tr><td><INPUT TYPE="button" disabled size="10" onclick="javascript:remove1();" value="<"></td></tr>
%endif%
			</table>
		</td>
		<td valign="top">
		<script>w(devTree1);</script>
		</td>
	</tr>
</table>

		</TD>
 		<TD valign="top"></td>
	</TR>

<!-- If the regular expression is in force, let the user know-->
	<TR>
		<TD valign="top"></td>
		<script>
		writeTDspan("col-l","1");
		var server="";
		var server1="";
		if(matchCnt>1){
		server=" servers";
		}else{
		server=" server";
		}
		if(matchCnt1>1){
		server1=" servers";
		}else{
		server1=" server";
		}
		</script>
		
		<table>
		<tr><td width="310">

		<div id="avblServers"></div>

		</td>
		<td width="300">
		<div id="selectedServers"></div>

		</td></tr>
		</table>
		
		</TD>
		<TD valign="top"></td>
	</TR>

	<!-- Submit Button, placed at bottom for convenience -->
	%ifvar /isAuth equals('true')% 
	<TR>
 		<TD valign="top"></td>
		<TD class="action">
			<INPUT disabled onclick="updateTargetGroup1();" align="center" type="submit" 
				VALUE="Save" name="submit2" id="save2"> </TD>
 		<TD valign="top"></td>
	</TR>
	%endif%
	%ifvar status equals ('Error')%
	<h1>%value -htmlcode message%</h1>
	%endif%
	</FORM>
	</TBODY>
</TABLE>


<!-- end -->

</TR>

</TABLE>

<script>
stopProgressBar();
//document.serverForm.host.focus();
</script>

</BODY>
</HTML>
