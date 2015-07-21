<HTML><HEAD>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META http-equiv="Expires" content="-1">
<LINK href="webMethods.css" type="text/css" rel="stylesheet">
<SCRIPT src="webMethods.js"></SCRIPT>
<BODY>

<SCRIPT language=JavaScript>

function onAdd() {
	var n = document.addBundleForm.bundleName.value;

	if ( trim(n) == "" ) {
		alert("Deployment Set Name is required.");
		return false;
	} 
	else if (!isIllegalName(n)) {
		alert("Invalid Name.\nRefer to Integration Server Administrator's Guide for listed illegal characters.");
		return false;
	}

	var bundleMode = document.addBundleForm.bundleMode.value;
	if(bundleMode == "Delete")
	{
		var bundleType = document.addBundleForm.bundleType.value;
		if(bundleType != "IS" && bundleType != "Broker")
		{
			alert("Deletion Set for " + bundleType + " is not supported currently");
			return false;
		}
	}

	var regExp = document.getElementById("packageRegExp").value;
	if (!testRegularExpression(regExp)) {
		alert("The Regular Expression " + regExp + " is not valid.");
		document.getElementById("packageRegExp").focus();
		return false;
	}

	var regExp = document.getElementById("otherRegExp").value;
	if (!testRegularExpression(regExp)) {
		alert("The Regular Expression " + regExp + " is not valid.");
		document.getElementById("otherRegExp").focus();
		return false;
	}

	startProgressBar("Creating Set " + n);
	return true;
}

function changeNameSuggestion()
{
	if(document.addBundleForm.bundleMode.value == "Delete")
	{
		document.addBundleForm.suggestedName.value = document.addBundleForm.bundleName.value;
		document.addBundleForm.bundleName.value = document.addBundleForm.suggestedNameForDelete.value;
	}
	else
	{
		document.addBundleForm.suggestedNameForDelete.value = document.addBundleForm.bundleName.value;
		document.addBundleForm.bundleName.value = document.addBundleForm.suggestedName.value;
	}
}

function onSelectRepository(value) 
{
    document.getElementById('fetchById').disabled=value;
    document.getElementById('runtimeProperties').disabled=value;
    showOrHideDiv("runtimeProperties");
}

function showOrHideDiv(divElement)
{
	if(document.getElementById(divElement) == null || document.getElementById(divElement) == undefined)
	{		
		return;
	}	
	divValue = document.getElementById(divElement).style.display;	
	
	if (divValue == 'none')
	{
		document.getElementById(divElement).style.display = "block";
	}
	else
	{
		//alert("Into Else");
		document.getElementById(divElement).style.display = "none";	
	}
}

</SCRIPT>

<TABLE width="100%">
	<TR>
		<TD class="menusection-Deployer" colspan="3"> Create Set</TD>
	</TR>
</TABLE>

<TABLE width="100%">
	<TBODY>
		<TR>
      <TD colspan="2"><IMG height="10" src="images/blank.gif" width="10"></TD>
    </TR>
    <TR>
      <TD><IMG height="10" src="images/blank.gif" width="10"></TD>
      <TD valign="top">
        <TABLE class="tableForm">
          <TBODY>
            <TR>
              <TD class="heading" colspan="2">Create Set</TD>
            </TR>
%comment%
						<FORM name="addBundleForm" target="treeFrame" action=under-construction.dsp method=post>            
%endcomment%
						<FORM name="addBundleForm" target="treeFrame" action=bundle-list.dsp method=post>            
						<INPUT type="hidden" VALUE="%value projectName%" name="projectName">
					  <INPUT type="hidden" value="%value projectType%" name="projectType">								
						<INPUT type="hidden" VALUE="add" name="action">
						<input type="hidden" value="" name="suggestedName">
						<input type="hidden" value="" name="suggestedNameForDelete">
        %ifvar projectType equals('Repository')%
				<TR>
					<script> writeTD("row", "nowrap"); </script>Source Of Truth</TD>
					<script> writeTD("rowdata-l", "nowrap"); </script> Repository</TD>
   						<input type="hidden" value="FlatFile" name="sourceOfTruth">   
   						<input type="hidden" value="Repository" name="pluginType">          
        			<TR>
				</TR>
				%scope param(featureID='SPI_2')%
					%invoke wm.deployer.gui.UISettings:isFeatureEnabled%
					%endinvoke%
				%ifvar isActive equals('true')%
					<TR>
						<TD class="oddrow">Set</TD>
						<TD class="oddrow-l">
						<P><SELECT size="1" name="bundleMode" onChange="changeNameSuggestion();">
							<OPTION VALUE="Deploy">Deployment</OPTION>
				       		<OPTION value="Delete">Deletion</OPTION>
						</SELECT></P>
						</TD>
					</TR>
					%else%
					<TR>
						<input type="hidden" value="Deploy" name="bundleMode">
						<TD class="oddrow">Set</TD>
						<TD class="oddrow-l">Deployment
						</TD>
					</TR>
				%endif%
				%endscope%   
        %else%
  				<TR>
  					<script> writeTD("row", "nowrap"); </script>Source Of Truth</TD>
  					<script> writeTD("rowdata-l", "nowrap"); </script> Runtime</TD> 
  					<input type="hidden" value="Runtime" name="sourceOfTruth">   
   					<input type="hidden" value="Runtime" name="pluginType">
   					<!--    
					%ifvar sourceOfTruth equals('Runtime')%
						<INPUT type="radio" name="sourceOfTruth" value="Runtime" checked onClick="document.getElementById('fetchById').disabled=false">Runtime						
  						<INPUT type="radio" name="sourceOfTruth" value="FlatFile" onClick="onSelectRepository(true)">Repository
					%endif%
					%ifvar sourceOfTruth equals('FlatFile')%
  						<INPUT type="radio" name="sourceOfTruth" value="Runtime" onClick="onSelectRepository(false)">Runtime
						<INPUT type="radio" name="sourceOfTruth" value="FlatFile" checked>Repository
					%else%
  						<INPUT type="radio" name="sourceOfTruth" value="Runtime" checked onClick="onSelectRepository(false)">Runtime
  						<INPUT type="radio" name="sourceOfTruth" value="FlatFile" onClick="onSelectRepository(true)">Repository
					%endif%
					-->
				</TR>
				<SCRIPT>swapRows();</SCRIPT>

						<TR>
							<TD class="oddrow">Type</TD>
							<TD class="oddrow-l">
								<P><SELECT size="1" name="bundleType" id="fetchById">
									<OPTION VALUE="IS">IS & TN</OPTION>
									%invoke wm.deployer.gui.UIPlugin:listDeployerSupportedPlugins%  
										%ifvar plugins -notempty%
											%loop plugins%
               		<OPTION value="%value pluginType%">%value pluginLabel%</OPTION>
											%endloop%
										%endif%        
									%endinvoke%        
								</SELECT></P>
							</TD>
						</TR>
				<TR>
					<TD class="oddrow">Set</TD>
					<TD class="oddrow-l">
						<P><SELECT size="1" name="bundleMode" onChange="changeNameSuggestion();">
							<OPTION VALUE="Deploy">Deployment</OPTION>
				       		<OPTION value="Delete">Deletion</OPTION>
						</SELECT></P>
					</TD>
				</TR>
			%endif%
			
            <TR>
              <TD class="evenrow">* Name</TD>
              <TD class="evenrow-l"><INPUT name="bundleName" size="32" maxlength="32"></TD>
            </TR>


            <TR>
              <TD class="oddrow">Description</TD>
              <TD class="oddrow-l"><INPUT name="bundleDescription" size="32"></TD>
            </TR>


         %ifvar projectType equals('Runtime')%
	    <TR>
              <TD class="oddrow">Maximum TN Assets to Display</TD>
              <TD class="oddrow-l"><INPUT name="treeNodeCount" size="32" value='1000'></TD>
            </TR>

						<TR>
							<script>writeTDspan("col-l","2");</script>You can use the Packages and All other assets fields to narrow the display of assets.&nbsp;&nbsp;Specify a regular expression 
					that specifies the text that the asset names must contain in order to be displayed. <BR>For example, to narrow the display to assets whose name contains a certain string, 
					specify the regular expression <B><i>.*string.*</B></i>&nbsp;&nbsp;For more information, see the webMethods Deployer User's Guide.
						</TR>

            <TR>
              <TD class="evenrow">Packages</TD>
              <TD class="evenrow-l"><INPUT name="packageRegExp" size="32"></TD>
            </TR>

            <TR>
              <TD class="oddrow">All other assets</TD>
              <TD class="oddrow-l"><INPUT name="otherRegExp" size="32"></TD>
            </TR>
          %endif%
         		<TR>
           		<TD class="subheading" colspan="2">Required fields are indicated by *</TD>
         		</TR>
            <TR>
              <TD class="action" colspan="2">
                <INPUT onclick="return onAdd();" type="submit" value="Create">
              </TD>
            </TR>
          </TBODY>
        </TABLE>
      </TD>
    </TR>
    </FORM>
  </TBODY>
</TABLE>

<script>
	%invoke wm.deployer.gui.UISuggest:suggestBundleName%
		document.addBundleForm.bundleName.value = "%value bundleName%";
		document.addBundleForm.suggestedName.value = "%value bundleName%";
		document.addBundleForm.suggestedNameForDelete.value = "%value deleteBundleName%";
	%endinvoke%
	document.addBundleForm.bundleName.focus();
</script>

</BODY>
</HTML>
