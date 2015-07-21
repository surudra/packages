<HTML><HEAD><TITLE>Define Component</TITLE>
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META http-equiv=Pragma content=no-cache>
<META http-equiv=Expires content=-1>
<LINK href="webMethods.css" type=text/css rel=stylesheet>
<LINK href="xtree.css" type=text/css rel=stylesheet>
<SCRIPT src="webMethods.js"></SCRIPT>
<script type="text/javascript" src="xtree.js"></script>
<script type="text/javascript" src="xtreecheckbox.js"></script>
</HEAD>
<BODY>

<SCRIPT language=JavaScript>

// Click the parent Frame's hidden field to start the Progress Bar
function updateDS(doesCheckpointExistForThisProject) {

	if(doesCheckpointExistForThisProject == 'true'){
		if (confirm("[DEP.0002.0173] When modifying the deployment set, Deployer will remove any checkpoints created for the associated deployment candidates. You must recreate any checkpoints you want to use. \nDo you want to continue?")) {
			return true;
		}else{
			return false
		}
	}else{
		return true;
	}
}
</script>

<TABLE width="100%">
  <TR>
    <TD class=menusection-Deployer>%value bundleName% > Repository > %value serverAliasName%:%value assetCompositeName% > Components</TD>
  </TR>
</TABLE>

<TABLE width="100%">
  <TR>
    <TD>
      <UL>
    		<LI> <A href="define-repository-components.dsp?projectName=%value -htmlcode projectName%&bundleName=%value -htmlcode bundleName%&serverAliasName=%value -htmlcode serverAliasName%&packageName=%value -htmlcode packageName%&mode=%value mode -urlencode%&bundleMode=%value -htmlcode bundleMode%&parentServer=%value -htmlcode parentServer%&regExp=%value -htmlcode regExp%&regExp2=%value -htmlcode regExp2%&assetCompositeName=%value -htmlcode assetCompositeName%&runtimeType=%value -htmlcode runtimeType%">Refresh this Page</A> </LI>
	%ifvar mode equals('properties')%
				<LI> <A href="package-properties.dsp?projectName=%value -htmlcode projectName%&bundleName=%value -htmlcode bundleName%&serverAliasName=%value -htmlcode serverAliasName%&packageName=%value -htmlcode packageName%">Return to %value serverAliasName%:%value assetCompositeName% Properties</A> </LI>
	%else%
		%ifvar mode equals('plugin')%
    		<LI> <A href="define-plugin-packages.dsp?projectName=%value -htmlcode projectName%&bundleName=%value -htmlcode bundleName%&parentServerAliasName=%value -htmlcode parentServer%&regExp=%value -htmlcode regExp%&regExp2=%value -htmlcode regExp2%">Return to %value parentServer%:Composites</A> </LI>
		%else%
    		<LI> <A href="define-repository.dsp?projectName=%value -htmlcode projectName%&bundleName=%value -htmlcode bundleName%&regExp=%value -htmlcode regExp%&regExp2=%value -htmlcode regExp2%">Return to Composites</A> </LI>
		%endif%
	%endif%
       </UL>
    </TD>
  </TR>
</TABLE>

<TABLE class="tableView" width="100%">
  <TR>
		<TD><img border="0" src="images/blank.gif" width="20" height="1"></TD>
    <TD class="heading" valign="top" colspan="2"> Select Components </TD>
		<TD valign="top"> <img border="0" src="images/blank.gif" width="20" height="1"></td>
  </TR>

%comment%
	<FORM id="cForm" name="cForm" method="POST" action="under-construction.dsp">
%endcomment%
	<FORM id="cForm" name="cForm" method="POST" target="treeFrame" action="bundle-list.dsp">

	<!- Submit Button, placed at top for convenience ->
	<TR>
 		<TD valign="top"></td>
		<TD class="action" colspan="2">
			<INPUT onclick="return updateDS();" align="center" type="submit" VALUE="Save" name="submit"> </TD>
 		<TD valign="top"></td>
		<INPUT type="hidden" name="assetCompositeName" value='%value assetCompositeName%'>
    <INPUT type="hidden" name="projectName" value='%value projectName%'>
		<INPUT type="hidden" name="bundleName" value='%value bundleName%'>
		<INPUT type="hidden" name="serverAliasName" value='%value serverAliasName%'>
		<INPUT type="hidden" name="packageName" value='%value packageName%'>
		<INPUT type="hidden" name="mode" value='%value mode%'>
		<INPUT type="hidden" name="parentServer" value='%value parentServer%'>
		<INPUT type="hidden" name="regExp" value='%value regExp%'>
		<INPUT type="hidden" name="regExp2" value='%value regExp2%'>
		<INPUT type="hidden" name="action" value="updateComponent">
		<INPUT type="hidden" name="projectType" value="Repository">		
		<INPUT type="hidden" id="bundleMode" name="bundleMode" value="%value bundleMode%">
	</TR>

	<SCRIPT>resetRows();</SCRIPT>
	<SCRIPT>swapRows();</SCRIPT>
	<SCRIPT>swapRows();</SCRIPT>


	<TR>
 		<TD valign="top"></td>
		<script> writeTD("rowdata-l", "colspan='2' width='100%'");</script>

<script>

var pkgNode = new WebFXTree("%value packageName%", null, null, 
		webFXTreeConfig.ISPackageX, webFXTreeConfig.ISPartialPackage);
		
var compositeNode = new WebFXTree("%value assetCompositeName%", null, null, 
		webFXTreeConfig.compositeIcon, webFXTreeConfig.compositeIcon);		

// Make the Package the parent node
var folderList = new Array;
var folderTreeList = new Array;
folderList[0] = null;
folderTreeList[0] = pkgNode;

%invoke wm.deployer.gui.UIRepository:listComponentsInComposite%

	var doesCheckpointExistForThisProject = '%value doesCheckpointExistForThisProject%';
  var compositeTree = new WebFXCheckBoxTreeItem("%value assetCompositeName%", null, false, null, 
	      webFXTreeConfig.compositeIcon, webFXTreeConfig.compositeIcon, null, null, null, null, %value -urlencode isPartialDeploymentValid%);
	      
	var componentTypesList = new Array;
	var componentTypesTreeList = new Array;

	%loop componentTypes%
		componentTypesList[componentTypesList.length]='%value TypeName%'
		var compTypeNode = new WebFXCheckBoxTreeItem("%value TypeName%", null, 
						false, null, null, null,
						null, null, null, null,  %value ../isPartialDeploymentValid%);	 	
		componentTypesTreeList[componentTypesTreeList.length] = compTypeNode;
		compositeTree.add(compTypeNode);
	%endloop componentTypes%
	      
	
	var matchCnt = 0;
  %loop components%  	
      var componentNode = new WebFXCheckBoxTreeItem("%value componentDisplayName%", null, 
  						false, null, getACDLIcon("%value componentType%"), getACDLIcon("%value componentType%"),
  						"%value ../serverAliasName -urlencode%$%value ../runtimeType%$%value ../assetCompositeName -urlencode%$%value componentName -urlencode%$%value componentDisplayName -urlencode%$%value componentType -urlencode%$COMPONENT_INCL", "COMPONENT_INCL", null, null, %value ../isPartialDeploymentValid%);	 	
      //compositeTree.add(componentNode);
      var matchIndex = -1;
		for (var i=0;i<componentTypesList.length;i++) {
			if ('%value componentType%'==componentTypesList[i]) {
				matchIndex = i;
				i=componentTypesList.length;
			}
		}
      componentTypesTreeList[matchIndex].add(componentNode);
      matchCnt++;
  	   
  %endloop components%
  
  compositeNode.add(compositeTree);

%endinvoke listComponentsInComposite%

// Remove dead leaves
trimTree(pkgNode);

// Render the tree 
w(compositeTree);
</script>
		</TD>
 		<TD valign="top"></td>
	</TR>
	<SCRIPT>swapRows();</SCRIPT>

<!- If the regular expression is in force, let the user know>
	<TR>
		<TD valign="top"></td>
		<script>
		writeTDspan("col-l","1");
%ifvar regExp2 -notempty%
		w("Regular Expression '%value regExp2%' matched " + matchCnt + 
				" and filtered " + filterCnt + " assets.");
%else%
		w(matchCnt + " components displayed.");
%endif%
		</script>
		<TD valign="top"></td>
	</TR>

	<!- Submit Button, placed at bottom ->
	<TR>
 		<TD valign="top"></td>
		<TD class="action" colspan="2">
			<INPUT onclick="return updateDS(doesCheckpointExistForThisProject);" align="center" type="submit" VALUE="Save" name="submit2"> </TD>
 		<TD valign="top"></td>
	</TR>

	</FORM>
</TABLE>


<script>
// This bit selects checkboxes from the current definition of the project ->
// getBundleISComponents: projectName*, bundleName*, serverAliasName*, packageName*
%invoke wm.deployer.gui.UIBundle:getBundleComponents%
		%loop components%
			// Find the uniquely named Element and check it
			var p = (document.getElementsByName("%value ../serverAliasName -urlencode%$%value ../runtimeType%$%value ../assetCompositeName -urlencode%$%value componentName -urlencode%$%value componentDisplayName -urlencode%$%value componentType -urlencode%$COMPONENT_INCL")).item(0);
			if (p != null) {
				var parentID = p.parentNode.id;
				var anchor = document.getElementById(parentID + '-anchor');
				var icon = document.getElementById(parentID + '-icon');

				// Check this item, and trigger cascade behavior
				webFXTreeHandler.all[parentID].setChecked(true);
			}
		%endloop components%
%endinvoke%

stopProgressBar();
</script>


</BODY></HTML>
