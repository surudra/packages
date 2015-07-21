<HTML><HEAD>
 <TITLE>Check Inconsistencies</TITLE>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META http-equiv="Expires" content="-1">
<LINK href="webMethods.css" type="text/css" rel="stylesheet">
<SCRIPT src="webMethods.js"></SCRIPT>
<SCRIPT src="xtree.js"></SCRIPT>
<SCRIPT src="xtreecheckbox.js"></SCRIPT>

<SCRIPT language=JavaScript>

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

</SCRIPT>
</HEAD>
<BODY>

<TABLE width="100%">
	<TR>
		<TD class="menusection-Server" colspan="4"> %value rtgName% &gt; Check Inconsistencies
		</TD>
	</TR>
</TABLE>



<TABLE>
	

<!- Determine if this user is empowered to modify server stuff ->
%invoke wm.deployer.UIAuthorization:isAuthorized%
%endinvoke%

<!- Get Plugin Info: (i) pluginType, (i) name ->

	

	<TR>
		<TD><IMG height="0" src="images/blank.gif" width="10"></TD>
			<SCRIPT>resetRows();</SCRIPT>
		
	</TR>

<TR>

<!-- start -->

<TABLE class="tableView">
	<TBODY>
	<SCRIPT>resetRows();</SCRIPT>		
  <TR>
		<TD><img border="0" src="images/blank.gif" width="14" height="1"></TD>
    <TD class="heading" valign="top"> Check Inconsistencies</TD>
		<TD valign="top"> <img border="0" src="images/blank.gif" width="20" height="1"></td>
  </TR>


	<FORM id="form" name="form" method="POST" action="target-groups.dsp" target="treeFrame">
	<INPUT type="hidden" VALUE="%value pluginType%" name="pluginType">
	<INPUT type="hidden" VALUE="%value rtgName%" name="rtgName">
	<INPUT type="hidden" VALUE="%value rtgDescription%" name="rtgDescription">

	<!-- Submit Button, placed at top for convenience -->
	%ifvar /isAuth equals('true')% 
	<TR>
 		<TD valign="top"></td>
		<TD class="action">
			<INPUT onclick="updateTargetGroup1();" align="center" type="submit" 
				VALUE="Resolve Inconsistencies" name="submit"> </TD>
 		<TD valign="top"></td>
		<INPUT id="listOfServers" type="hidden" name="servers">
		<INPUT type="hidden" name="action" value="resolveInconsistencies">
		<INPUT type="hidden" name="pluginType" value="%value pluginType%">
		<INPUT type="hidden" name="rtgName" value="%value rtgName%">
	</TR>
	%endif%

	<SCRIPT>swapRows();</SCRIPT>		
	<TR>
 		<TD valign="top"></td>
		<script>writeTDspan("col-l","1");</script>Following servers are unreachable. Resolving them would remove them from the target group.
 		<TD valign="top"></td>
	</TR>

	<SCRIPT>swapRows();</SCRIPT>		
	<TR>
 		<TD valign="top"></td>
		<script> writeTD("rowdata-l", "width='100%'");</script>


<script>

			var devTree1 = new WebFXTree("List Of Unreachable Servers");

			var matchCnt1 = 0;
			

					var serverTree1 = new WebFXCheckBoxTreeItem("%value rtgName%", null, false, null, 
						webFXTreeConfig.targetGroupIcon, webFXTreeConfig.targetGroupIcon);

					%invoke wm.deployer.gui.UITargetGroup:findErroneousServerInTargetGroup%
						%loop erroneousTargetServers%

								var pkgNode1 = new WebFXCheckBoxTreeItem("%value name%", 
									null, 
									false, null, webFXTreeConfig.serverIcon, webFXTreeConfig.serverIcon,
									"anurag$%value name%$PACKAGE_INCL", "PACKAGE_INCL", webFXTreeConfig.linkClass);
								serverTree1.add(pkgNode1);
								matchCnt1++;

						%endloop erroneousTargetServers%
					%endinvoke findErroneousssssServerInTargetGroup%
				devTree1.add(serverTree1);
</script>

<SCRIPT LANGUAGE="JavaScript">

function updateTargetGroup1(){
	//alert("updateTargetGroup1() is called.");
	var listOfServers="";
	var p1 = serverTree1;
	var size=p1.childNodes.length;
	for(var i=0;i<size;i++){
		//alert("p1.childNodes[i]._checked:: "+p1.childNodes[i]._checked);
		if(p1.childNodes[i]._checked==true){
			listOfServers = listOfServers + p1.childNodes[i].text+",";
		}
	}
		listOfServers = listOfServers.substring(0,listOfServers.length-1);
	
	//alert("listOfServers:: "+listOfServers);
	document.getElementById("listOfServers").value=listOfServers;
}

</SCRIPT>

<table>
	<tr>
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
		//var server="";
		//var server1="";
		//if(matchCnt>1){
		//server=" servers";
		//}else{
		//server=" server";
		//}
		//if(matchCnt1>1){
		//server1=" servers";
		//}else{
		//server1=" server";
		//}
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
			<INPUT onclick="updateTargetGroup1();" align="center" type="submit" 
				VALUE="Resolve Inconsistencies" name="submit2"> </TD>
 		<TD valign="top"></td>
	</TR>
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
