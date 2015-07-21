<HTML><HEAD>
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META http-equiv=Pragma content=no-cache>
<META http-equiv=Expires content=-1>
<LINK href="webMethods.css" type=text/css rel=stylesheet>
<SCRIPT src="webMethods.js"></SCRIPT>
</HEAD>
<BODY>

<SCRIPT language=JavaScript>
function confirmDelete(targetGroup) {
  if (confirm("Delete " + targetGroup + "?  This operation cannot be reversed.")) {
		startProgressBar();
		return true;
	}
	return false;
}

</SCRIPT>

<!-- Determine if this user is empowered to modify server stuff -->
%invoke wm.deployer.UIAuthorization:isAuthorized%
%endinvoke%


<TABLE width="100%">
  <TR>
    <TD class=menusection-Server>IS & TN Target Groups</TD>
  </TR>
</TABLE>

<TABLE width="100%">
	<!-- Add Plugin Servers --> 
%ifvar action equals('add')%
	<!-- key-value pairs from table -->
	%invoke wm.deployer.gui.UITargetGroup:addTargetGroup%
		%include error-handler.dsp%

		%ifvar status equals('Success')%
			<!- Post newly created Plugin Server in Property frame ->
			<script>
				if(is_csrf_guard_enabled && needToInsertToken) {
	   			   parent.propertyFrame.document.location.href = "edit-ISTarget-group.dsp?pluginType=%value -htmlcode pluginType%&rtgName=%value -htmlcode rtgName%&rtgDescription=%value -htmlcode rtgDescription%&runtimeVersion=%value -htmlcode runtimeVersion%&" + _csrfTokenNm_ + "=" + _csrfTokenVal_;
				} else {
				   parent.propertyFrame.document.location.href = "edit-ISTarget-group.dsp?pluginType=%value -htmlcode pluginType%&rtgName=%value -htmlcode rtgName%&rtgDescription=%value -htmlcode rtgDescription%&runtimeVersion=%value -htmlcode runtimeVersion%";
				}
			</script>
		%end if%

	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%endif%

<!-- Test -->
<script language="javascript">
var isAuth = %value isAuth% ;
var testISTargetGroupStatus = 'notLoaded';
</script>
%ifvar action equals('test')%
%invoke wm.deployer.gui.UITargetGroup:testISTargetGroup%
		%include error-handler.dsp%
			%ifvar status equals('Success')%
				<script>
					if(is_csrf_guard_enabled && needToInsertToken) {
		   			   parent.propertyFrame.document.location.href = "edit-ISTarget-group.dsp?pluginType=IS&rtgName=%value -htmlcode rtgName%&rtgDescription=%value -htmlcode rtgDescription%&runtimeVersion=%value -htmlcode runtimeVersion%&" + _csrfTokenNm_ + "=" + _csrfTokenVal_;
					} else {
					   parent.propertyFrame.document.location.href = "edit-ISTarget-group.dsp?pluginType=IS&rtgName=%value -htmlcode rtgName%&rtgDescription=%value -htmlcode rtgDescription%&runtimeVersion=%value -htmlcode runtimeVersion%";
					}
				</script>
			%end if% 
			<script language="javascript">
			   testISTargetGroupStatus = "%value status%";
				function testButtonReplace(){
					document.getElementById('testButtonHref_%value rtgName%').target = 'propertyFrame';
					document.getElementById('testButtonHref_%value rtgName%').href = 'checkISInconsistencies.dsp?pluginType=IS&rtgName=%value rtgName%&rtgDescription=%value rtgDescription%&runtimeVersion=%value runtimeVersion%';
					
					document.getElementById('setStatus_%value rtgName%').src= 'images/dependency.gif';					
					if (isAuth)
						document.getElementById('testButton_%value rtgName%').innerHTML = 'Resolve';
					else
						document.getElementById('testButton_%value rtgName%').innerHTML = 'View';
				}
			</script>
	%end invoke%
%endif%

<!-- Resolve Inconsistencies -->
%ifvar action equals('resolveInconsistencies')%
%invoke wm.deployer.gui.UITargetGroup:getListOfServersFromString%
	%invoke wm.deployer.gui.UITargetGroup:resolveInconsistencies%
		%include error-handler.dsp%
			%ifvar status equals('Success')%
				<script>
					if(is_csrf_guard_enabled && needToInsertToken) {
		   			   parent.propertyFrame.document.location.href = "edit-ISTarget-group.dsp?pluginType=%value -htmlcode pluginType%&rtgName=%value -htmlcode rtgName%&rtgDescription=%value -htmlcode rtgDescription%&runtimeVersion=%value -htmlcode runtimeVersion%&" + _csrfTokenNm_ + "=" + _csrfTokenVal_;
					} else {
					   parent.propertyFrame.document.location.href = "edit-ISTarget-group.dsp?pluginType=%value -htmlcode pluginType%&rtgName=%value -htmlcode rtgName%&rtgDescription=%value -htmlcode rtgDescription%&runtimeVersion=%value -htmlcode runtimeVersion%";
					}
				</script>
			%end if%
	%end invoke%
	%end invoke%
%endif%

<!-- Delete --> 
 %ifvar action equals('delete')%
	<!- pluginType (i), name (i) ->
	%invoke wm.deployer.gui.UITargetGroup:deleteTargetGroup%
		%include error-handler.dsp%

		<!- property may be obsolete if bundle is deleted ->
		%ifvar status equals('Success')%
			<script>parent.propertyFrame.document.location.href = "blank.html";</script>
		%end if%
	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%endif% 

</TABLE>


<TABLE width="100%">
	<TR>
		<TD colspan="2">
			<UL>
			%ifvar /isAuth equals('true')%
				<LI><A target="propertyFrame" href="add-ISrtg.dsp?pluginType=%value -htmlcode pluginType%"> Create IS & TN Target Groups</A></LI>
				%endif%
				<LI><A onclick="startProgressBar();" HREF="target-groupsIS.dsp?pluginType=%value pluginType%"> Refresh this Page </A></LI>
			</UL>
		</TD>
	</TR>

	<FORM method="post" action="target-groupsIS.dsp">
		<input type="hidden" name="pluginType" value="%value pluginType%">
	<TR>
    <TD><IMG height="10" src="images/blank.gif" width="5"></TD>
    <TD>
      <TABLE class="tableView">
        <TR>
          <TD class="heading" colspan=5>IS & TN Target Groups</TD>
        </TR>

				<TR>
					<td style="width:160" class="oddcol-l">Group Name</td>
					<td style="width:160" class="oddcol-l">Description</td>
					<td style="width:160" class="oddcol-l">Version</td>
					<td style="width:160" class="oddcol">Test</td>
					<td style="width:160" class="oddcol">Delete</td>
				</TR>
		

				<script>resetRows();</script>


		%invoke wm.deployer.gui.UITargetGroup:listTargetGroups%
			%ifvar targetGroups -notempty%
			%loop targetGroups%
				<TR>

					<!-- Name -->
					<script> writeTD("rowdata-l");</script> 
						<A onclick="return startProgressBar();" target="propertyFrame" href="edit-ISTarget-group.dsp?pluginType=IS&rtgName=%value rtgName%&rtgDescription=%value rtgDescription%&isLogicalCluster=%value isLogicalCluster%&runtimeVersion=%value runtimeVersion%">%value rtgName% </TD>

					<!-- Description -->
					<script> writeTD("row-l");</script>%value rtgDescription%</TD>
					
					<!-- Version -->
					<script> writeTD("row-l");</script>%value runtimeVersion%</TD>

					<!-- Test -->
					<script> writeTD("rowdata");</script>
					<A onclick="return startProgressBar();" target="treeFrame" href="target-groupsIS.dsp?pluginType=%value /pluginType%&rtgName=%value rtgName%&rtgDescription=%value rtgDescription%&runtimeVersion=%value runtimeVersion%&action=test" id="testButtonHref_%value rtgName%"><IMG id="setStatus_%value rtgName%" alt="Test this Server" src="images/checkdot.gif" border="0" width="14" height="14"><span id="testButton_%value rtgName%"></span></A></TD>

					<!-- Delete  -->
					<script> writeTD("rowdata");</script>
					%ifvar /isAuth equals('true')% 
						<A class="imagelink" onclick="return confirmDelete('%value rtgName%');"
							href="target-groupsIS.dsp?pluginType=%value -htmlcode /pluginType%&rtgName=%value -htmlcode rtgName%&action=delete">
							<IMG alt="Delete this Server" src="images/delete.gif" border="0" width="16" height="16"></A>
					%else%
							<IMG src="images/delete_disabled.gif" border="0" width="16" height="16">
					%endif%
				</TR>
				<script>swapRows();</script>
			%endloop%

			%else%
				<TR>
					<TD colspan="5"><FONT color="red">* No IS & TN Target Group.</FONT></TD>
				</TR>
			%endif%
		%endinvoke%

			</TABLE>
		</TD>
	</TR>
	</FORM>
</TABLE>

<SCRIPT> 
if (testISTargetGroupStatus == 'Error' )
{
	testButtonReplace();
}
stopProgressBar(); 
</SCRIPT>
</BODY></HTML>
