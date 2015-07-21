<HTML><HEAD><TITLE>Define Developer</TITLE>
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META http-equiv=Pragma content=no-cache>
<META http-equiv=Expires content=-1>
<LINK href="webMethods.css" type=text/css rel=stylesheet>
<LINK href="xtree.css" type=text/css rel=stylesheet>
<SCRIPT src="webMethods.js"></SCRIPT>
<script src="xtree.js"></script>
<script src="xtreecheckbox.js"></script>
</HEAD>
<BODY>

<SCRIPT language=JavaScript>

// Click the parent Frame's hidden field to start the Progress Bar
function updateDS() {
	if (confirm("[DEP.0002.0173] When modifying the deployment set, Deployer will remove any checkpoints created for the associated deployment candidates. You must recreate any checkpoints you want to use. \nDo you want to continue?")) {
		return true;
	}
	
	return false;
}

function test() {
  alert(" Test");
}

</script>
<TABLE width="100%">
  <TBODY>
  <TR>
    <TD class=menusection-Deployer>%value bundleName% > Repository</TD>
  </TR>
  </TBODY>
</TABLE>

<TABLE width="100%">
<!- Update Developer (packages) -> 
%ifvar action equals('updateDeveloper')%
	<!- Packages: projectName, bundleName and tag-value pairs from tree ->
	%invoke wm.deployer.gui.UIBundle:updateBundlePackageList%
		%include error-handler.dsp%

		%ifvar status equals('Success')%
		<script>
		    var checkpointExists = %value doesCheckpointExistForThisProject%;
		    if(checkpointExists) {
		        updateDS();
		    }

			// refresh Project left-frame 
			startProgressBar("Displaying new Project definition");
			if(is_csrf_guard_enabled && needToInsertToken) {
			   parent.treeFrame.document.location.href = "bundle-list.dsp?projectName=%value -htmlcode projectName%&projectType=Repository&" + _csrfTokenNm_ + "=" + _csrfTokenVal_;
			} else {
			   parent.treeFrame.document.location.href = "bundle-list.dsp?projectName=%value -htmlcode projectName%&projectType=Repository";
			}				
		</script>
		%else%
		<script>
			// stop the progress bar that was started during the submit
			stopProgressBar(); 
		</script>

		%endif%
	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%end if%
</TABLE>

<TABLE width="100%">
  <TR>
    <TD colspan="2">
      <UL>
				<LI> <A onclick="return startProgressBar('Refreshing Package list');" href="define-repository.dsp?projectName=%value projectName%&bundleName=%value bundleName%&regExp=%value regExp%&regExp2=%value regExp2%">Refresh this Page</A></LI> 
       </UL>
    </TD>
  </TR>
</TABLE>

<TABLE class="tableView" width="100%">
	<TBODY>
	<SCRIPT>resetRows();</SCRIPT>		
  <TR>
		<TD><img border="0" src="images/blank.gif" width="20" height="1"></TD>
    <TD class="heading" valign="top">Select Composites from the Repository</TD>
		<TD valign="top"> <img border="0" src="images/blank.gif" width="20" height="1"></td>
  </TR>

%comment%
	<FORM id="form" name="form" method="POST" target="treeFrame" action="under-construction.dsp">
%endcomment%
	<FORM id="form" name="form" method="POST" action="define-repository.dsp">

	<!- Submit Button, placed at top for convenience ->
	<TR>
 		<TD valign="top"></td>
		<TD class="action">
			<INPUT align="center" type="submit"
				VALUE="Save" name="submit"> </TD>
 		<TD valign="top"></td>
		<INPUT type="hidden" name="projectName" value='%value projectName%'>
		<INPUT type="hidden" name="bundleName" value='%value bundleName%'>
		<INPUT type="hidden" name="regExp" value='%value regExp%'>
		<INPUT type="hidden" name="regExp2" value='%value regExp2%'>
		<INPUT type="hidden" name="action" value="updateDeveloper">
	</TR>
	<SCRIPT>swapRows();</SCRIPT>		

	<SCRIPT>swapRows();</SCRIPT>		
	<TR>
 		<TD valign="top"></td>
		<script> writeTD("rowdata-l", "width='100%'");</script>

<script>

	// Enumerate over entire list of configured sources
	%invoke wm.deployer.gui.UIBundle:getBundleSourceServers%

		%ifvar servers -notempty%
			var devTree = new WebFXTree("Repository");

			var filterCnt = 0;
			var matchCnt = 0;
			%loop servers%
				%rename serverAliasName serverAlias -copy%
				// Ping this Integration server before investing too much in it
				%rename serverAlias aliasName -copy%	

  				// Retrieve Packages from Server
					// serverAlias	
					%ifvar ../sourceOfTruth equals('FlatFile')%					
  					%invoke wm.deployer.gui.UIRepository:listComposites%
  
             %ifvar status equals('Success')%
       					var serverTree = new WebFXCheckBoxTreeItem("%value serverAliasName%", null, false, null, 
	                		webFXTreeConfig.serverIcon, webFXTreeConfig.serverIcon);
              %loop assetComposites%		
              
                  var runtimeTree = new WebFXCheckBoxTreeItem("%value runtimeType%", null, false, null, 
      						      webFXTreeConfig.runtimeIcon, webFXTreeConfig.runtimeIcon);
              					
                  %loop assets%            					
        						var assetCompositeNode = new WebFXCheckBoxTreeItem('%value assetCompositeName%%ifvar assetVersion -notempty% (%value assetVersion%)%endif%', "define-repository-components.dsp?projectName=%value ../../../../projectName%&bundleName=%value ../../../../bundleName%&serverAliasName=%value ../../serverAlias%&assetCompositeName=%value assetCompositeName%&runtimeType=%value ../runtimeType%&regExp=%value /regExp%&regExp2=%value /regExp2%&bundleMode=%value ../../../../bundleMode%", 
        											false, null, webFXTreeConfig.compositeIcon, webFXTreeConfig.compositeIcon,
        											"%value ../../serverAlias -urlencode%$%value ../runtimeType%$%value assetCompositeName -urlencode%$COMPOSITE_INCL", "COMPOSITE_INCL", webFXTreeConfig.linkClass);	 
        					        						   
    						    runtimeTree.add(assetCompositeNode);
    						    matchCnt++;  
                  %endloop assets%
                
                  serverTree.add(runtimeTree);
  
  						%endloop assetComposites%  
            %else%
                	var serverTree = new WebFXCheckBoxTreeItem("%value serverAliasName% (Unavailable: %value message%)", null, false, null, 
	                		webFXTreeConfig.serverIcon, webFXTreeConfig.serverIcon);
  					%endif%
   
           %endinvoke%
				 %endif%

				devTree.add(serverTree);
			%endloop servers%
		%else%
			var devTree = new WebFXTree("Composites (no Source Repositories configured)");
		%endif%
%endinvoke wm.deployer.gui.UIBundle:getBundleSourceServers%

// Render the tree 
w(devTree);
</script>

	
	<script> w(pkgTree1); </script>
	
		</TD>
 		<TD valign="top"></td>
	</TR>

<!- If the regular expression is in force, let the user know>
	<TR>
		<TD valign="top"></td>
		<script>
		writeTDspan("col-l","1");
%ifvar regExp -notempty%
		w("Regular expression '%value regExp%' matched " + matchCnt + 
				" and filtered " + filterCnt + " Composites.");
%else%
		w(matchCnt + " Composites displayed.");
%endif%
		</script>
		<TD valign="top"></td>
	</TR>

	<!- Submit Button, placed at bottom for convenience ->
	<TR>
 		<TD valign="top"></td>
		<TD class="action">
			<INPUT align="center" type="submit"
				VALUE="Save" name="submit2"> </TD>
 		<TD valign="top"></td>
	</TR>

	</FORM>
	<TBODY>
</TABLE>



<script>


// This bit selects checkboxes from the current definition of the project ->

// getBundlePackages: projectName*, bundleName*
%invoke wm.deployer.gui.UIBundle:getBundleComposites%
	%loop servers%
		%loop composites%
			// Find the uniquely named Element and check it
			var p = (document.getElementsByName("%value ../serverAliasName -urlencode%$%value runtimeType%$%value compositeName -urlencode%$COMPOSITE_INCL")).item(0);
			if (p != null) {
				var parentID = p.parentNode.id;
				var anchor = document.getElementById(parentID + '-anchor');
				var icon = document.getElementById(parentID + '-icon');
							
				// Check this item, and trigger cascade behavior
				webFXTreeHandler.all[parentID].setChecked(true);
				%ifvar isPartial equals('true')%	
          				webFXTreeHandler.all[parentID].disabled = true;			
          				p.disabled = true;
				%else%
					anchor.href = webFXTreeConfig.defaultAction;
					anchor.onclick = 'return true;';
					p.parentNode.className = webFXTreeConfig.defaultClass;
        			%endif%
			}
		%endloop composites%
	%endloop servers%
%endinvoke%

%ifvar action equals('updateDeveloper')%
%else%
	stopProgressBar();
%endif%

</script>

</BODY></HTML>
