<HTML><HEAD><TITLE>Define %value pluginType%</TITLE>
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

<TABLE width="100%">
	<TBODY>
	<TR>
		<TD class=menusection-Deployer>%value bundleName% > %value pluginType%</TD>
	</TR>
	</TBODY>
</TABLE>

<TABLE width="100%">
	<TR>
		<TD colspan="2">
			<UL>
				<LI> <A onclick="return startProgressBar('Refreshing %value pluginType% assets');" href="define-plugin.dsp?pluginType=%value pluginType%&projectName=%value projectName%&bundleName=%value bundleName%&regExp=%value regExp%">Refresh this Page</A></LI> 
			 </UL>
		</TD>
	</TR>
</TABLE>

<TABLE class="tableView" width="100%">
	<TBODY>
	<SCRIPT>resetRows();</SCRIPT>		
	<TR>
		<TD><img border="0" src="images/blank.gif" width="20" height="1"></TD>
		<TD class="heading" valign="top"> Select %value pluginType% Assets </TD>
		<TD valign="top"> <img border="0" src="images/blank.gif" width="20" height="1"></td>
	</TR>

%comment%
	<FORM id="form" name="form" method="POST" target="treeFrame" action="under-construction.dsp">
%endcomment%
	<FORM id="form" name="form" method="POST" target="treeFrame" action="bundle-list.dsp">

	<!- Submit Button, placed at top for convenience ->
	<TR>
 		<TD valign="top"></td>
		<TD class="action">
			<INPUT onclick="return startProgressBar('Saving %value pluginType% assets');" align="center" type="submit" 
				VALUE="Save" name="submit"> </TD>
 		<TD valign="top"></td>
		<INPUT type="hidden" name="pluginType" value='%value pluginType%'>
		<INPUT type="hidden" name="projectName" value='%value projectName%'>
		<INPUT type="hidden" name="bundleName" value='%value bundleName%'>
		<INPUT type="hidden" name="regExp" value='%value regExp%'>
		<INPUT type="hidden" name="action" value="updatePlugin">
	</TR>

	<!- TODO: implement getPluginInfo service to get miscellaneous crap ->
	<SCRIPT>swapRows();</SCRIPT>		
	<TR>
 		<TD valign="top"></td>
		<script>writeTDspan("col-l","1");</script>%value pluginNote%
 		<TD valign="top"></td>
	</TR>

	<SCRIPT>swapRows();</SCRIPT>		
	<TR>
 		<TD valign="top"></td>
		<script> writeTD("rowdata-l", "width='100%'");</script>

<script>
	%invoke wm.deployer.gui.UISettings:getSettings%
    %endinvoke%
    
	// Enumerate over entire list of configured sources
	%invoke wm.deployer.gui.UIBundle:getBundleSourceServers%
		%ifvar servers -notempty%
			var devTree = new WebFXTree("%value pluginType%");

			var matchCnt = 0;
			var filterCnt = 0;
			var exceedCnt = 0;
			%loop servers%
				// Ping this server before investing too much in it
				%rename ../pluginType pluginType -copy%
				%rename serverAliasName name -copy%
				%ifvar ../optimisticNetwork equals('false')%
					%invoke wm.deployer.gui.UIPlugin:pingPluginServer%
					%endinvoke%
				%endif%
				
				%ifvar ../optimisticNetwork equals('true')%
					%include inc-plugin-tree.dsp%
				%else%	
					%ifvar status equals('Success')%
						%include inc-plugin-tree.dsp%
					%else%
						var serverTree = new WebFXTreeItem("%value serverAliasName% (Unavailable: %value message -code%)", null, null, 
							webFXTreeConfig.serverIcon, webFXTreeConfig.serverIcon);
					%endif%
				%endif%
				devTree.add(serverTree);
			%endloop serverAliases%
		%else%
			var devTree = new WebFXTree("%value pluginType% (no Source Servers configured)");
		%endif%
	%endinvoke servers%

// Remove dead leaves
trimTree(devTree);

// Render the tree 
w(devTree);
</script>
		</TD>
 		<TD valign="top"></td>
	</TR>

<!- If the regular expression is in force, let the user know>
	<TR>
		<TD valign="top"></td>
		<script>
		writeTDspan("col-l","1");
%ifvar regExp -notempty%
		if (exceedCnt == 0) {
			w(matchCnt + " assets displayed. &nbsp;Regular expression '%value regExp%' filtered " + filterCnt + " assets."); 
		}
		else {
			w(exceedCnt + " assets exceeded the " + maxPluginObjects + 
				" asset display limit. &nbsp;Regular expression '%value regExp%' filtered " + filterCnt + 
				" assets. &nbsp;Consider refining your Regular Expression."); 
		}
%else%
		if (matchCnt < maxPluginObjects) {
			w(matchCnt + " assets displayed.");
		}
		else {
			w(exceedCnt + " assets exceeded the " + maxPluginObjects + 
				" asset display limit. &nbsp;Consider a Regular Expression to reduce the list."); 
		}
%endif%
		</script>
		<TD valign="top"></td>
	</TR>

	<!- Submit Button, placed at bottom for convenience ->
	<TR>
 		<TD valign="top"></td>
		<TD class="action">
			<INPUT onclick="return startProgressBar('Saving %value pluginType% assets');" align="center" type="submit" 
				VALUE="Save" name="submit2"> </TD>
 		<TD valign="top"></td>
	</TR>

	</FORM>
	<TBODY>
</TABLE>

<script>
// This bit selects checkboxes from the current definition of the bundle ->

// getBundlePackages: projectName*, bundleName*
%invoke wm.deployer.gui.UIPlugin:getBundlePluginObjects%
	%loop plugins%
	// Only interested in junk of this bundleType (aka pluginType)
	%ifvar pluginType vequals(../pluginType)%
		%loop servers%
			%loop objectTypes%
				%loop objects%
					// Find the uniquely named Element and check it
					var p = (document.getElementsByName("%value ../../serverAliasName -urlencode%$PLUGINDEPLOYERDATA$%value ../objectTypeName -urlencode%$PLUGINDEPLOYERDATA$%value name -urlencode%$PLUGINDEPLOYERDATA$%value id -urlencode%$PLUGINDEPLOYERDATA$%value parentId -urlencode%$PLUGINDEPLOYERDATA$%value path -urlencode%$PLUGINDEPLOYERDATA$%value fullName -urlencode%")).item(0);
					if (p != null) 
						webFXTreeHandler.all[p.parentNode.id].setChecked(true);
				%endloop objects%
			%endloop objectTypes%
		%endloop servers%
	%endif%
	%endloop plugins%
%endinvoke%

stopProgressBar();

</script>

</BODY></HTML>
