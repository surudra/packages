<HTML><HEAD>
<TITLE>Deployer Projects</TITLE>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META http-equiv="Expires" content="-1">
<LINK href="webMethods.css" type="text/css" rel="stylesheet">
<LINK href="xtree.css" type="text/css" rel="stylesheet">
<SCRIPT src="webMethods.js"></SCRIPT>
<SCRIPT src="xtree.js"></SCRIPT>
<script src="xtreecheckbox.js"></script>    
<BODY>

<SCRIPT language=JavaScript>
function confirmDelete (proj) {

	if (confirm("OK to Delete " + proj + "?\n\nThis action is not reversible.\n")) {
		startProgressBar("Deleting Project " + proj);
		return true;
	}
	return false;
}

function confirmUnlock(user) {
	if (confirm("Do you want to unlock the project locked by "+user)) {
		startProgressBar("Unlocking Project ");
		return true;
	}
	return false;
}

function test() {
 // alert("Test"+ "%value listOfCheckedPackages%");
  var listOfCheckedPackages = "%value listOfCheckedPackages%";
  	var pkgTr = pkgTree;
	var size =  pkgTr.childNodes.length;
  
}

function resolveDependency() {

    var listOfCheckedComponents = "%value listOfCheckedComponents%";
    var listOfCheckedPackages = "";
  	var p = isTree01;
	var pkgTr = pkgTree;
	var size =  pkgTr.childNodes.length;
	var temp = 0;
	var partialSelect = 0;
	listOfCheckedComponents = listOfCheckedComponents + ","
	for (var i = 0; i < size; i++) {
    if (pkgTr.childNodes[i].getChecked()) {
    	var pkgNode = pkgTr.childNodes[i];
    	listOfCheckedPackages = listOfCheckedPackages + pkgNode.text + ",";   
    	//alert(pkgNode.text);
    	
      var fldrSize = pkgNode.childNodes.length; 
      	for (var j = 0; j < fldrSize; j++) {
      	    var fldrNode = pkgNode.childNodes[j];
            var cmp = fldrNode.text;      	    
      	    listOfCheckedComponents = listOfCheckedComponents + pkgNode.text + ":" + fldrNode.text +",";

      	} // For Folder Loop      	
    	} // If Package Checked
    }  // For Package Loop 
    //alert(listOfCheckedComponents + " - "+ listOfCheckedPackages);       
        	document.getElementById("listOfCheckedComponents").value= "%value listOfCheckedComponents%"; //listOfCheckedComponents.substring(0,listOfCheckedComponents.length -1);    
        	document.getElementById("listOfResolvedPackages").value=listOfCheckedPackages.substring(0,listOfCheckedPackages.length -1);
}

var autoResolvedPackages = "%value listOfCheckedComponents%"+",";

function autoResolveDependency() {
  //alert("autoResolveDependency "+autoResolvedPackages);
  document.getElementById("listOfCheckedComponents").value=autoResolvedPackages.substring(0,autoResolvedPackages.length -1);
  //alert("1: "+document.getElementById("listOfCheckedComponents").value);
  document.getElementById("depedencyForm").submit();

}

function autoCheckDependency(pkgName) {
  //alert("autoCheckDependency "+ pkgName);
  autoResolvedPackages = autoResolvedPackages + pkgName + ",";
}

function updateRegistry() {

      var listOfCheckedComponents = "%value listOfCheckedComponents%";
     // alert(listOfCheckedComponents);
      document.getElementById("listOfCheckedComponents1").value=listOfCheckedComponents.substring(0,listOfCheckedComponents.length);
     // alert(document.getElementById("listOfCheckedComponents1").value);
     //document.getElementById("updateRegistryForm").submit();
}

function enableLabelName() {
  if(document.getElementById("isCheckpoint").checked == true) {
    document.getElementById("checkPointName").disabled = false;
  }
  else {
    document.getElementById("checkPointName").disabled = true;
  }
}

function changeCSServer() { 
  document.getElementById("csAliasName").value = document.getElementById("csServerList").value;  
}


</SCRIPT>

<TABLE width="100%">
	<TR>
		<TD class="menusection-Deployer" colspan="2"> %value serverAlias% Dependencies %value autoResolve%</TD>
	</TR>
</TABLE>

<TABLE>            
<!- Update CentraSite registry -> 
%ifvar action equals('updateRegistry')%
	<!- projectName, key-value pairs from table ->
	%invoke wm.deployer.gui.UICSExtractor:createISRegistryObjects%
    %ifvar status equals('Success')%
		<script>
			writeMessage('%value -htmlcode message%.');
		</script>
		%else%
			writeMessage('Error Occurred while creating Registry Objects.');
		%endif%		
	%end invoke%
%endif%

</TABLE>

<TABLE class="tableForm" align="center" width="98%">
	<TBODY>
	 



%invoke wm.deployer.gui.UICSExtractor:getPackageDependencies%
	%ifvar dependencies -notempty%
	
%comment%
	<form id="form" name="form" method="POST" action="under-construction.dsp">
%endcomment%
	<form id="form" name="form" method="POST" action="extractor-dependencies.dsp.dsp">
	<!- Submit Button, placed at top for convenience ->
		<INPUT type="hidden" name="projectName" value="%value projectName%">
		<INPUT type="hidden" name="bundleName" value="%value bundleName%">
		<INPUT type="hidden" name="bundleType" value="%value bundleType%">
		<INPUT type="hidden" name="action" value="save">

<TR>
			<script> writeTD("rowdata-l");</script>
			<script>  
					%rename serverAliasName serverAlias -copy%			
    var isTree01 = new WebFXTree("Dependencies");
    var adminTree = new WebFXCheckBoxTreeItem("Administration");								
			var userTree = new WebFXCheckBoxTreeItem("Users");
					%invoke wm.deployer.gui.server.IS:listUsers%
						%loop users%
              	var usrNode = new WebFXCheckBoxTreeItem("%value userName%");
								userTree.add(usrNode);										
						%endloop users%
					%endinvoke listUsers%		
			adminTree.add(userTree);
			
			var portTree = new WebFXCheckBoxTreeItem("Ports");
					%invoke wm.deployer.gui.server.IS:listPorts%
						%loop ports%
              	var portNode = new WebFXCheckBoxTreeItem("%value portNumber%");
								portTree.add(portNode);										
						%endloop ports%
					%endinvoke listPorts%		
			adminTree.add(portTree);
			
			var groupTree = new WebFXCheckBoxTreeItem("Groups");
					%invoke wm.deployer.gui.server.IS:listGroups%
						%loop groups%
              	var groupNode = new WebFXCheckBoxTreeItem("%value groupName%");
								groupTree.add(groupNode);										
						%endloop groups%
					%endinvoke listGroups%		
			adminTree.add(groupTree);
			
    var pkgTree = new WebFXCheckBoxTreeItem("Packages");
    var aclTree = new WebFXCheckBoxTreeItem("ACLs");
    %invoke wm.deployer.gui.UICSExtractor:getPackageDependencies%  
    	%ifvar autoResolve equals('true')%
      	%loop dependencies%
      	 %ifvar type equals('Package')%
      	   
      	   %loop referencedComponents%	
      	     autoCheckDependency("%value ../referencedPackageName%:%value referencedComponentName%");
      	   %endloop%
      	 %endif%
      	%endloop%
      	 	
	     %else%
				%loop dependencies%		  		
        %ifvar type equals('Package')%	
                  			
          var pkgNode = new WebFXCheckBoxTreeItem("%value referencedPackageName%", null, 
							false, null, webFXTreeConfig.ISPackage, webFXTreeConfig.ISPackage,
							"%value type -urlencode%$%value referencedPackageName%", "PACKAGE_INCL", null);	 
					%loop referencedComponents%	   						
    					%ifvar referencedComponentIcon%
    						var icon = "%value referencedComponentIcon%";
    					%else%
    						var icon = getNSIcon("%value referencedComponentType%");
    					%endif%	
    					%ifvar referencedComponentName%
                var srvNode = new WebFXTreeItem("%value referencedComponentName%*", null,false, icon, icon, null, null);	 
            		pkgNode.add(srvNode);    
            	%else%
            	  var packageAlreadyAdded = true;
              %endif%                      					
					%endloop referencedComponents%
					
					%loop nonReferencedComponents%	  
          %ifvar nonReferencedComponentName%					
    						var icon = getNSIcon("%value nonReferencedComponentType%");
              var srvNode = new WebFXTreeItem("%value nonReferencedComponentName%", null,false, icon, icon, null, null);	 
          		pkgNode.add(srvNode);      
           %endif%    					
					%endloop nonReferencedComponents%		
          
          if(pkgNode.childNodes.length != 0) {
            pkgTree.add(pkgNode);
          }    					          
					
        %endif%		
        
        %ifvar type equals('ACL')%				
         %loop referencedComponents%
                 var aclNode = new WebFXCheckBoxTreeItem("%value referencedComponentName%*", null, 
        							false, null, getNSIcon("%value referencedComponentType%"), getNSIcon("%value referencedComponentType%"),
        							"%value type -urlencode%$%value referencedPackageName%", "PACKAGE_INCL", null);	 
              aclTree.add(aclNode);	
         %endloop%
				
        %endif%	
                										
				%endloop dependencies%
			%endif%
		%endinvoke getPackageDependencies%		
			isTree01.add(pkgTree);
      isTree01.add(aclTree);				
      			
		//	isTree01.add(adminTree);
      			w(isTree01);	                
			
			</script>		
	
		</TR>
	<!- ................ Begin Dependency (Package) Loop ................ ->
	<script> resetRows();</script>
	


	</FORM>
	%endif%
	</TBODY>
</TABLE>

      <FORM id="depedencyForm" name="form" method="POST" target="treeFrame" action="select-runtime.dsp">  
      <INPUT type="hidden" name="action" value="resolve">
      <INPUT type="hidden" name="serverAlias" value='%value serverAlias%'>
      <INPUT type="hidden" id="listOfCheckedComponents" name="listOfCheckedComponents">
      <INPUT type="hidden" id="listOfResolvedPackages" name="listOfResolvedPackages">
    	<TABLE width="100%">			
          <tr>
    <input type="submit" name="action" id="resolveDependencies" value="Resolve Dependencies" onclick="javascript:resolveDependency();">   
             	<script> writeTD("rowdata-l"); </script> 
                   Select Registry/Repository:                               
                  <SELECT size="1" name="bundleType" onchange="changeCSServer();" id="csServerList">
            	   	%invoke wm.deployer.gui.UICSServer:listCentrasiteServers%
            		    	%loop repositoryServers%                  
        						  <OPTION name = "csAliasName">%value aliasName%</OPTION>		
                     %endloop%                                       	                                          														                        			
    							</SELECT>
                	
          </tr>
          </TABLE>
        </FORM>
        
        <script> 
         %ifvar autoResolve equals('true')%
           autoResolveDependency();
         %endif%
        </script>
        
        <FORM id="updateRegistryForm" name="form" method="POST">
          <TABLE>
          <tr>
            <script>writeTD("rowdata-l")</script>                         
                <P>	
                	<input id="isCheckpoint" type="checkbox" name="Create Label" value="%value isCheckpoint%" onclick="return enableLabelName()">Create Label
    							<INPUT id="checkPointName" name="checkPointName" value="%value checkPointName%" size="32" disabled="true">   
                  <INPUT type="hidden" id="runtimeServerAlias" name="runtimeServerAlias" value="%value serverAlias%" size="32">   		
                  <INPUT type="hidden" id="csAliasName" name="csAliasName" value="%value csAliasName%" size="32">                     					
    						   <input type="submit" name="action" value="updateRegistry" id="updateRegistry" onclick="return updateRegistry();" disabled="true">   
                   <INPUT type="hidden" name="checkPointName" value='%value checkPointName%' id="checkPointName">
                    <INPUT type="hidden" name="listOfCheckedComponents" value='%value listOfCheckedComponents%' id="listOfCheckedComponents1">
                       <INPUT type="hidden" name="isCheckpoint" id="isCheckpointPassed">  
    							</P>
          </tr>			
      
        <script>
          if(pkgTree.childNodes.length == 0) {
            document.getElementById("updateRegistry").disabled = false;
            document.getElementById("resolveDependencies").disabled = true;
          }   
          
          </script>
          
      </TABLE>	
      </FORM>


</BODY>
</HTML>
