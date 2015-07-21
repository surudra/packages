<HTML><HEAD>
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META http-equiv=Pragma content=no-cache>
<META http-equiv=Expires content=-1>
<LINK href="webMethods.css" type=text/css rel=stylesheet>
<LINK href="xtree.css" type=text/css rel=stylesheet>
<SCRIPT src="webMethods.js"></SCRIPT>
<SCRIPT src="xtree.js"></SCRIPT>
<SCRIPT src="xtreecheckbox.js"></SCRIPT>
</HEAD>
<BODY>

<TABLE width="100%">
  <TR>
		<TD class="menusection-Deployer">%value bundleName% > Packages > %value serverAliasName%:%value packageName% > Suspend Triggers</TD>
  </TR>
</TABLE>

<TABLE width="100%">
<!- Save -> 
%ifvar action equals('suspendTriggers')%
	<!- All fields on form ->
	%invoke wm.deployer.gui.UIBundle:updateBundlePackageTriggers%
		%include error-handler.dsp%
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
				<LI><A onclick="return startProgressBar();" href="suspend-package-triggers.dsp?projectName=%value projectName%&bundleName=%value bundleName%&serverAliasName=%value serverAliasName%&packageName=%value packageName%&partialPackage=%value partialPackage%"> Refresh this Page</A></LI>
				<LI> <A href="package-properties.dsp?projectName=%value -htmlcode projectName%&bundleName=%value -htmlcode bundleName%&serverAliasName=%value -htmlcode serverAliasName%&packageName=%value -htmlcode packageName%"> Return to %value serverAliasName%:%value packageName% > Properties</A></LI>
			</UL>
		</TD>
	</TR>
</TABLE>

<TABLE class="tableView" width="100%">
	<TBODY>
	<SCRIPT>resetRows();</SCRIPT>		
  <TR>
		<TD><img border="0" src="images/blank.gif" width="20" height="1"></TD>
    <TD class="heading" valign="top"> Select Triggers to Suspend </TD>
		<TD valign="top"> <img border="0" src="images/blank.gif" width="20" height="1"></td>
  </TR>

%comment%
	<FORM id="form" name="form" method="POST" target="treeFrame" action="under-construction.dsp">
%endcomment%
	<FORM id="form" name="form" method="POST" action="suspend-package-triggers.dsp">

	<!- Submit Button, placed at top for convenience ->
	<TR>
 		<TD valign="top"></td>
		<TD class="action">
			<INPUT onclick="return startProgressBar();" align="center" type="submit" 
				VALUE="Suspend" name="submit"> </TD>
 		<TD valign="top"></td>
		<input type="hidden" name="action" value="suspendTriggers">
		<input type="hidden" name="projectName" value="%value projectName%">
		<input type="hidden" name="bundleName" value="%value bundleName%">
		<input type="hidden" name="serverAliasName" value="%value serverAliasName%">
		<input type="hidden" name="packageName" value="%value packageName%">
		<input type="hidden" name="partialPackage" value="%value partialPackage%">
	</TR>

	<SCRIPT>swapRows();</SCRIPT>		
	<TR>
 		<TD valign="top"></td>
		<script> writeTD("rowdata-l", "width='100%'");</script>

<script>
	var trigTree = new WebFXTree("Triggers");

	%invoke wm.deployer.gui.UIBundle:getBundlePackageTriggers%
	%ifvar triggers -notempty%

		var pkgTree = new WebFXCheckBoxTreeItem("%value packageName%", null, false, null, 
		%ifvar partialPackage equals('true')%
			webFXTreeConfig.ISPartialPackage, webFXTreeConfig.ISPartialPackage
		%else%
			webFXTreeConfig.ISPackage, webFXTreeConfig.ISPackage
		%endif%
			);
		%loop triggers%
	
			var p = new WebFXCheckBoxTreeItem("%value triggerName%", null, 
			%ifvar suspendFlag equals('true')% 
				true, 
			%else%
				false, 
			%endif%
				null, getNSIcon('Trigger'), getNSIcon('Trigger'),
				"%value triggerName -urlencode%", "TRIGGER_INCL");

			pkgTree.add(p);
		%endloop%
	%else%
		var pkgTree = new WebFXTreeItem("%value packageName% contains no Triggers", null, null, 
		%ifvar partialPackage equals('true')%
			webFXTreeConfig.ISPartialPackage, webFXTreeConfig.ISPartialPackage
		%else%
			webFXTreeConfig.ISPackage, webFXTreeConfig.ISPackage
		%endif%
			);
	%endif%
	%endinvoke%
	trigTree.add(pkgTree);
	// Render the tree 
	w(trigTree);
</script>
		</TD>
 		<TD valign="top"></td>
	</TR>

	<!- Submit Button, placed at bottom for convenience ->
	<TR>
 		<TD valign="top"></td>
		<TD class="action">
			<INPUT onclick="return startProgressBar();" align="center" type="submit" 
				VALUE="Suspend" name="submit2"> </TD>
 		<TD valign="top"></td>
	</TR>

	</FORM>
	<TBODY>
</TABLE>

<script>
stopProgressBar();
</script>

</BODY></HTML>
