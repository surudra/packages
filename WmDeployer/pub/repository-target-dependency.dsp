<HTML><HEAD><TITLE>Target Dependencies</TITLE>
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META http-equiv=Pragma content=no-cache>
<META http-equiv=Expires content=-1>
<LINK href="webMethods.css" type="text/css" rel="stylesheet">
<LINK href="xtree.css" type="text/css" rel="stylesheet">
<SCRIPT src="webMethods.js"></SCRIPT>
<SCRIPT src="xtree.js"></SCRIPT>
<script>
	function getIcon(type)
	{
		var icon = getNSIcon(type);
		if(icon == 'images/ns_unknown_node.gif')
		{
			switch (type) {
				case 'DocumentType':
					icon = "images/Broker/broker-doc.gif";
					break;
				case 'ClientGroup':
					icon = "images/Broker/client-group.gif";
					break;
			}
		}
		return icon;
	}

	function checkAll()
	{
		var el = document.getElementById("selectAll");
		if(el.checked)
		{
			var elArr = document.getElementsByName("select");
			for (var i = 0; i < elArr.length; i++)
			{
				elArr[i].checked = true;
			}
		}
		else
		{
			var elArr = document.getElementsByName("select");
			for (var i = 0; i < elArr.length; i++)
			{
				elArr[i].checked = false;
			}
		}
	}

	function onAdd()
	{
		alert("You need to re-build the project for your changes to take effect");
		var dependentData = "";
		var elArr = document.getElementsByName("select");

		for(var i = 0; i < elArr.length; i++)
		{
			if(elArr[i].checked)
			{	
				dependentData = dependentData + elArr[i].value + "$$";
			}
		}
		var data = document.getElementById('dependentData');
		data.value = dependentData;
	}

	function onRemove()
	{
		alert("You need to re-build the project for your changes to take effect");
		var action = document.getElementById("action");
		action.value = "removeComponents";
		var componentData = "";

		var elArr = document.getElementsByName("component");

		for(var i = 0; i < elArr.length; i++)
		{
			if(elArr[i].checked)
			{
				componentData = componentData + elArr[i].value + "$$";
			}
		}
		var data = document.getElementById("componentData");
		data.value = componentData;
	}
</script>
</HEAD>
<BODY>
<TABLE width="100%">
  <TR>
  %invoke wm.deployer.gui.UITarget:checkTargetDependenciesForRepository%
	%ifvar bundleMode equals('Deploy')%
    <TD class=menusection-Deployer>%value mapSetName% > %value bundleName% > References missing on %value targetServerAliasName%</TD>
	%else%
    <TD class=menusection-Deployer>%value mapSetName% > %value bundleName% > Dependent Assets present on %value targetServerAliasName%</TD>	
	%endif%
  </TR>
</TABLE>

<TABLE width="100%" >
  <TR>
    <TD colspan="2"> 
			<UL> 
				<li> <A onclick="startProgressBar();" href="repository-target-dependency.dsp?projectName=%value projectName%&bundleName=%value bundleName%&mapSetName=%value mapSetName%&targetServerAliasName=%value targetServerAliasName%&pluginType=%value pluginType -urlencode%&projectType=%value projectType%">Refresh this Page</A></li> 
				%ifvar projectType equals('Repository')%
				<LI><A onclick="startProgressBar();" href="edit-map-repository.dsp?projectName=%value projectName%&mapSetName=%value mapSetName%&mapSetDescription=%value mapSetDescription%">Return to %value mapSetName% > Properties</A></LI>
				%else%
				<LI><A onclick="startProgressBar();" href="edit-map-repository.dsp?projectName=%value projectName%&mapSetName=%value mapSetName%&mapSetDescription=%value mapSetDescription%">Return to %value mapSetName% > Properties</A></LI>
				%endif%
				
			</UL> 
		</TD> 
  </TR>
</TABLE>
%comment%
	<FORM id="form" name="form" method="POST" target="treeFrame" action="under-construction.dsp">
%endcomment%
	<FORM id="form" name="form" method="POST" target="propertyFrame" action="edit-map.dsp">
	<INPUT type="hidden" name="action" id="action" value="addDependents">
	<input type="hidden" name="dependentData" id="dependentData" value="">
    <input type="hidden" name="componentData" id="componentData" value="">
	<input type="hidden" name="bundleName" value="%value bundleName%" >
	<input type="hidden" name="projectName" value="%value projectName%" >
	<input type="hidden" name="targetAlias" value="%value targetServerAliasName%" >
	<input type="hidden" name="mapSetName" value="%value mapSetName%" >
	<input type="hidden" name="mapSetDescription" value="%value mapSetDescription%" >


<TABLE class="tableView" width="100%">
	<TBODY>
	<SCRIPT>resetRows();</SCRIPT>	
	<script>
	%ifvar bundleMode equals('Deploy')%
	</script>
  <TR>
		<TD><img border="0" src="images/blank.gif" width="20" height="1"></TD>
    <TD class="heading" valign="top"> Status of %value targetServerAliasName% </TD>
		<TD valign="top"> <img border="0" src="images/blank.gif" width="20" height="1"></td>
  </TR>

  <TR>
    <TD valign="top"></td>
		<script> writeTD("rowdata-l", "width='100%'");</script>

	<script>
	var root = new WebFXTree("Status of %value targetServerAliasName%");
	%ifvar status equals('Success')%
	        w('<FONT color="green"> The target server is up and ready to be deployed.</FONT>');
	%else%
		w('<FONT color="red">%value message -code%</FONT>');
	%endif%
	%endif%
	</script>
	</TD>
 		<TD valign="top"></td>
	</TR>
	<TR>
		<TD colspan="3">
		<BR>
		</TD>
	</TR>
	
		<script>
	%ifvar bundleMode equals('Delete')%
	</script>
  <TR>
		<TD><img border="0" src="images/blank.gif" width="20" height="1"></TD>
    <TD class="heading" valign="top"> Dependent Assets present on %value targetServerAliasName% </TD>
		<TD valign="top"> <img border="0" src="images/blank.gif" width="20" height="1"></td>
  </TR>

	<TR>
	 <TD></td>
	 <script>writeTD("rowdata-l", "width='100%'");</script>
	<script>
	%ifvar status equals('Success')%
	%ifvar dependents -notempty%
	</script>
	
	<TABLE class="tableView" width="100%">
	<TR>
		<TD class="action">
		<INPUT onclick="javascript:onRemove();" align="center" 
			type="submit" VALUE="Remove" name="submit"> </TD>
		</TD>
		<TD class="action">
			<INPUT onclick="javascript:onAdd();" align="center" 
			type="submit" VALUE="Add" name="submit"> </TD>
	</TR>
	
	<TR>
		<TD class="oddcol">Assets</TD>
		<TD class="oddcol">Dependent Assets</TD>
	</TR>
	<TR>
			<TD></TD>
			<TD colspan="2">
				<input type="checkbox" id="selectAll" onclick="javascript:checkAll();" />Select All 
			</TD>
		</TR>
	%loop dependents%
		
		<TR>
		 <SCRIPT>writeTD('rowdata-l', 'nowrap');</SCRIPT>
		 <input type="checkbox" name="component" value="%value component -urlencode%COMPONENT_TYPE%value componentType -urlencode%" />
		 <img border="0" src="" id="%value component -urlencode%" > %value component%</TD>
		 <script>
			var icon = document.getElementById("%value component -urlencode%");
			icon.src = getIcon("%value componentType%");
		 </script>
		<SCRIPT>writeTD('rowdata', 'nowrap');</SCRIPT>
		<TABLE class="tableView" width="100%">
		%loop referencedBy%
			<TR>
			<TD nowrap>
			%ifvar nodeId%
			&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="select" value="%value nodeId -urlencode%DEPENDENT_TYPE%value nodeName -urlencode%DEPENDENT_TYPE%value nodeType -urlencode%" />
			%else%
			&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="select" value="%value nodeName -urlencode%DEPENDENT_TYPE%value nodeType -urlencode%" />
			%endif%
			<img border="0" src="" id="%value nodeName -urlencode%%value ../component -urlencode%" >
			%value nodeName%
			 <script>
				var icon2 = document.getElementById("%value nodeName -urlencode%%value ../component -urlencode%");
				icon2.src = getIcon("%value nodeType%");
			 </script>
			</TD>
			</TR>
		%endloop referencedBy%
		</TABLE>
		</TD>
		<SCRIPT>swapRows();</SCRIPT>
		</TR>
	%endloop dependents%
	</TABLE>
	<script>
	%else%
	     w('<FONT color="green"> There are no dependent components present on this target server.</FONT>');
	%endif%
	%else%
		w('<FONT color="red">%value message -code%</FONT>');
	%endif%
	%endif%
   %endinvoke%
	</script>
</TD>
 		<TD valign="top"></td>
	</TR>
	<TR>
		<TD colspan="3">
		<BR>
		</TD>
	</TR>
</TABLE>
</form>
<script> stopProgressBar(); </script> 
</BODY></HTML>
