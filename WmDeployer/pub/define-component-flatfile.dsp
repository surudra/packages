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
function updateDS() {
	startProgressBar("Saving selected Package components");
	return true;
}
</script>

<TABLE width="100%">
  <TR>
    <TD class=menusection-Deployer>%value bundleName% > Packages > %value serverAliasName%:%value packageName% > Components</TD>
  </TR>
</TABLE>

<TABLE width="100%">
  <TR>
    <TD>
      <UL>
    		<LI> <A href="define-component.dsp?projectName=%value -htmlcode projectName%&bundleName=%value -htmlcode bundleName%&serverAliasName=%value -htmlcode serverAliasName%&packageName=%value -htmlcode packageName%&mode=%value -htmlcode mode%&bundleMode=%value -htmlcode bundleMode%&parentServer=%value -htmlcode parentServer%&regExp=%value -htmlcode regExp%&regExp2=%value -htmlcode regExp2%">Refresh this Page</A> </LI>
			%ifvar bundleMode equals('Delete')%
			%else%
				<LI> <A href="define-files.dsp?projectName=%value -htmlcode projectName%&bundleName=%value -htmlcode bundleName%&serverAliasName=%value -htmlcode serverAliasName%&packageName=%value -htmlcode packageName%&mode=%value -htmlcode mode%&regExp=%value -htmlcode regExp%&regExp2=%value -htmlcode regExp2%">Select Files</A> </LI>
			%endif%
	%ifvar mode equals('properties')%
				<LI> <A href="package-properties.dsp?projectName=%value -htmlcode projectName%&bundleName=%value -htmlcode bundleName%&serverAliasName=%value -htmlcode serverAliasName%&packageName=%value -htmlcode packageName%">Return to %value serverAliasName%:%value packageName% Properties</A> </LI>
	%else%
		%ifvar mode equals('plugin')%
    		<LI> <A href="define-plugin-packages.dsp?projectName=%value -htmlcode projectName%&bundleName=%value -htmlcode bundleName%&parentServerAliasName=%value -htmlcode parentServer%&regExp=%value -htmlcode regExp%&regExp2=%value -htmlcode regExp2%">Return to %value parentServer%:Packages</A> </LI>
		%else%
    		<LI> <A href="define-developer.dsp?projectName=%value -htmlcode projectName%&bundleName=%value -htmlcode bundleName%&regExp=%value -htmlcode regExp%&regExp2=%value -htmlcode regExp2%">Return to Packages</A> </LI>
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
		<INPUT type="hidden" name="projectName" value='%value projectName%'>
		<INPUT type="hidden" name="bundleName" value='%value bundleName%'>
		<INPUT type="hidden" name="serverAliasName" value='%value serverAliasName%'>
		<INPUT type="hidden" name="packageName" value='%value packageName%'>
		<INPUT type="hidden" name="mode" value='%value mode%'>
		<INPUT type="hidden" name="parentServer" value='%value parentServer%'>
		<INPUT type="hidden" name="regExp" value='%value regExp%'>
		<INPUT type="hidden" name="regExp2" value='%value regExp2%'>
		<INPUT type="hidden" name="action" value="updateComponent">
		<INPUT type="hidden" id="bundleMode" name="bundleMode" value="%value bundleMode%">
	</TR>

	<SCRIPT>resetRows();</SCRIPT>
	<SCRIPT>swapRows();</SCRIPT>
	%ifvar bundleMode equals('Deploy')%
	<TR>
 		<TD valign="top"></td>
		<script>writeTDspan("col-l","2");</script>IMPORTANT: You can select components and files, but do so with caution.&nbsp;&nbsp;If you save components, certain file selections you have made will be lost. If you select package type full to partial and do not save without any assets,package will be removed from selected packages.
 		<TD valign="top"></td>
	</TR>
	%endif%
	<SCRIPT>swapRows();</SCRIPT>


	<TR>
 		<TD valign="top"></td>
		<script> writeTD("rowdata-l", "colspan='2' width='100%'");</script>

<script>

var pkgNode = new WebFXTree("%value packageName%", null, null, 
		webFXTreeConfig.ISPackageX, webFXTreeConfig.ISPartialPackage);

// Make the Package the parent node
var folderList = new Array;
var folderTreeList = new Array;
folderList[0] = null;
folderTreeList[0] = pkgNode;

// projectName*, bundleName*, packageName*, serverAliasName* 
%invoke wm.deployer.gui.UIFlatFile:listPackageContents%
	// part 1 of 3 pass algorithm: build folder list and cram into an array
	%loop folders% 
		// Create this folder beneath the parent
		var fItem = new WebFXCheckBoxTreeItem("%value folderName%", null, false, 
			null, webFXTreeConfig.folderIcon, webFXTreeConfig.openFolderIcon, "%value fullFolderName%$Folder", "Folder");
		folderList[folderList.length] = "%value fullFolderName%";
		folderTreeList[folderTreeList.length] = fItem;
	%endloop folders%

	// part 2 of 3: Iterate over nodes and place in their parent folder
	var filterCnt = 0;
	var matchCnt = 0;

	%loop nodes%

		if (matchRegularExpression("%value /regExp2%", "%value name%")) {
			var fItem = new WebFXCheckBoxTreeItem("%value name%", null, false, null, 
				getNSIcon("%value type%"), getNSIcon("%value type%"), 
				"%value fullName%$%value type%", "COMPONENT_INCL");
		
			var pItem = getFolderParent("%value folder%", folderList, folderTreeList); 
			pItem.add(fItem);
			matchCnt++;
		}
		else
			filterCnt++;

	%endloop nodes%

	// part 3 of 3: create folder hiearchy
	%loop folders% 
		var fItem = getFolderParent("%value fullFolderName%", folderList, folderTreeList); 
		var pItem = getFolderParent("%value parentFolder%", folderList, folderTreeList); 
		pItem.add(fItem);
	%endloop folders%

%endinvoke listPackageContents%

// Remove dead leaves
trimTree(pkgNode);

// Render the tree 
w(pkgNode);
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
			<INPUT onclick="return updateDS();" align="center" type="submit" VALUE="Save" name="submit2"> </TD>
 		<TD valign="top"></td>
	</TR>

	</FORM>
</TABLE>


<script>
// This bit selects checkboxes from the current definition of the project ->
// getBundleISComponents: projectName*, bundleName*, serverAliasName*, packageName*
%invoke wm.deployer.gui.UIBundle:getBundleISComponents%
	var folderNames = new Array();
	var i = 0;

	%loop folders%
		%ifvar selectedAllFiles equals('true')%
			folderNames[i] = "%value fullFolderName%";
			i++;
		%endif%
	%endloop%

	%loop nodes%
		// Find the uniquely named Element and check it
		var p = 
			document.getElementsByName("%value fullName%$%value type%");
		if (p.length == 1) {
			webFXTreeHandler.all[p.item(0).parentNode.id].setChecked(true, true, folderNames);
		}
	%endloop nodes%
%endinvoke%

stopProgressBar();
</script>


</BODY></HTML>
