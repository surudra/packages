<HTML><HEAD><TITLE>My New Tree</TITLE>
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META http-equiv=Pragma content=no-cache>
<META http-equiv=Expires content=-1>
<LINK href="webMethods.css" type=text/css rel=stylesheet>
<LINK href="xtree.css" type=text/css rel=stylesheet>
<SCRIPT src="webMethods.js"></SCRIPT>
<script src="xtree.js"></script>
<script src="xtreecheckbox.js"></script>
<script src="xtreecheckboxasync.js"></script>
</HEAD>
<BODY>
	<SCRIPT language=JavaScript>

	function updateBundleDeletionSet(tree,nodeId) {		
			var nodes = returnSelectedTreeNodesAsString(tree);
			document.getElementById(nodeId).value = nodes;
			return true;
	}
	
	function returnSelectedTreeNodesAsString(tree){
		var selectedNodes = new Array();
		for (var i = 0; i < tree.childNodes.length; i++) {
			returnSubNodes(tree.childNodes[i], selectedNodes);
		}
		return selectedNodes;
	}

	function returnSubNodes(subTree , selectedNodes){
		if(subTree.childNodes.length > 0 ){
			for(var i = 0; i < subTree.childNodes.length; i++){
				returnSubNodes(subTree.childNodes[i], selectedNodes);
			}
		}
		else {
			if (subTree.getChecked()){
				selectedNodes.push(subTree._fqAssetNameStr);
			}
		}
	}
	
	function parseAndExpandTree(treePath, startFrom){
		var nodeArray = treePath.split("/");
		if(startFrom > nodeArray.length){
			return;
		}
		var path = "";
		for(var i=0; i< startFrom; i++){
			path = path + nodeArray[i] +"/";
		}
		path = path.substring(0,path.lastIndexOf("/"));
		var p = (document.getElementsByName(path)).item(0);
		if (p != null) {
			var parentID = p.parentNode.id;
			webFXTreeHandler.all[parentID].expand();
		}
		startFrom = startFrom + 1;
		parseAndExpandTree(treePath, startFrom);
	}
	</script>
<TABLE width="100%">
  <TBODY>
  <TR>
    <TD class=menusection-Deployer>%value bundleName% > %value serverAlias%</TD>
  </TR>
  </TBODY>
</TABLE>
<TABLE width="100%">
  <TR>
    <TD colspan="2">
      <UL>
				<LI> <A onclick="return startProgressBar('Refreshing Package list');" href="define-delete-bundle-repository-tree.dsp?projectName=%value projectName%&bundleName=%value bundleName%&serverAlias=%value serverAlias%&pluginType=%value pluginType%">Refresh this Page</A></LI> 
       </UL>
    </TD>
  </TR>
</TABLE>
		%rename serverAlias name -copy%
		%invoke wm.deployer.gui.UIPlugin:pingPluginServer%
			
			%ifvar status equals('Error')%
				<TABLE class="tableView" width="100%">
				<TBODY>
				<TR>
				<script>
					writeError("[DEP.0005.0304] Target Server %value serverAlias% is unavailable.");
				</script>
				</TR>
				</TBODY>
				</TABLE>
			%end if%
			
		%ifvar status equals('Success')%
		
<TABLE class="tableView" width="100%">
	<TBODY>
		<SCRIPT>resetRows();</SCRIPT>		
  		<script>
			var tree = new WebFXTree("%value serverAlias% ( %value pluginLabel% )");							
			tree.add(new WebFXCheckBoxAsyncTreeItem("%value serverAlias%", '/rest/wm.deployer.listAssetsRestHook.listAssetsByCategory?pluginType=%value pluginType%&serverAlias=%value serverAlias%',null,true,false,null,false,null,null, null,"%value serverAlias%"));
		</script>		
  		<TR>
			<TD><img border="0" src="images/blank.gif" width="20" height="1"></TD>
    		<TD class="heading" valign="top"> Select Assets or Assets Components </TD>
			<TD valign="top"> <img border="0" src="images/blank.gif" width="20" height="1"></td>
 		</TR>
		<FORM id="form" name="form" method="POST" target="treeFrame" action="bundle-list.dsp">
		<TR>
 			<TD valign="top"></td>
			<TD class="action">
			<INPUT align="center" onclick="return updateBundleDeletionSet(tree,'selectedNodesIdUp');" type="submit" 
				VALUE="Save" name="submit"> </TD>
 			<TD valign="top"></td>
 			<INPUT type="hidden" name="selectedNodes" id = "selectedNodesIdUp">
 			<INPUT type="hidden" name="projectName" value = '%value projectName%'>
 			<INPUT type="hidden" name="bundleName" value = '%value bundleName%'>
 			<INPUT type="hidden" name="serverAlias" value = '%value serverAlias%'>
 			<INPUT type="hidden" name="pluginType" value = '%value pluginType%'>
			<INPUT type="hidden" name="action" value="updateBundleDeletionSet">
			<INPUT type="hidden" name="projectType" value="Repository">
		</TR>
		</FORM>	
 		<TR>
 			<TD valign="top"></td>
			<script>writeTDspan("col-l","1");</script>Expand Asset Category to select individual Asset components to add to the Deletion Set.
 			<TD valign="top"></td>
		</TR>
		
		<TR>
 			<TD valign="top"></TD>
			<script> writeTD("rowdata-l", "width='100%'");</script>
			<script>				
				w(tree);
			</script>
		</TR>
		<FORM id="form" name="form" method="POST" target="treeFrame" action="bundle-list.dsp">
		<TR>
 			<TD valign="top"></td>
			<TD class="action">
			<INPUT align="center" onclick="return updateBundleDeletionSet(tree,'selectedNodesIdDown');" type="submit" 
				VALUE="Save" name="submit"> </TD>
 			<TD valign="top"></td>
 			<INPUT type="hidden" name="selectedNodes" id = "selectedNodesIdDown">
 			<INPUT type="hidden" name="projectName" value = '%value projectName%'>
 			<INPUT type="hidden" name="bundleName" value = '%value bundleName%'>
 			<INPUT type="hidden" name="serverAlias" value = '%value serverAlias%'>
 			<INPUT type="hidden" name="pluginType" value = '%value pluginType%'>
			<INPUT type="hidden" name="action" value="updateBundleDeletionSet">
			<INPUT type="hidden" name="projectType" value="Repository">
		</TR>
		</FORM>
		%end if%
		%end invoke%
	</TBODY>
</TABLE>
					
<script>
%invoke wm.deployer.gui.UIBundle:getSelectedAssetsFromDeletionSet%
		%ifvar assets -notempty%
			var rootTreeObj = (document.getElementsByName("%value serverAlias%")).item(0);
			if (rootTreeObj != null) {
				var rootTreeParentID = rootTreeObj.parentNode.id;
				webFXTreeHandler.all[rootTreeParentID].expand();
			}		
		%loop assets%
			parseAndExpandTree(escape("%value fqAssetName%"),0);
			var p = (document.getElementsByName(escape("%value fqAssetName%"))).item(0);
			if (p != null) {
				var parentID = p.parentNode.id;
				webFXTreeHandler.all[parentID].setChecked(true);
			}
		%endloop%
		%endif%
%endinvoke%
</script>
</BODY></HTML>