<HTML><HEAD>
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META http-equiv=Pragma content=no-cache>
<META http-equiv=Expires content=-1>
<LINK href="webMethods.css" type=text/css rel=stylesheet>
<SCRIPT src="webMethods.js"></SCRIPT>
<SCRIPT src="test.js"></SCRIPT>
</HEAD>
<BODY>

<SCRIPT language=JavaScript>
function getCsType(groupType)
{		

   if(groupType.options[groupType.selectedIndex].value == "WebDav"){
    document.getElementById("cmdtime").disabled = true;
    document.getElementById("wrkFold").disabled = true;
    document.getElementById("projName").disabled = true;    
  	hiddenAction.value="getGroupsOfType";
  	document.getElementById("editform1").submit();	
    return;	
  }
  else  {
    document.getElementById("cmdtime").disabled = false;
    document.getElementById("wrkFold").disabled = false;
    document.getElementById("projName").disabled = false;    
  	hiddenAction.value="getGroupsOfType";
  	document.getElementById("editform1").submit();	
    return;	
  }
	hiddenSave.value = groupType.options[groupType.selectedIndex].value;
	hiddenAction.value="getGroupsOfType";
	document.getElementById("editform1").submit();	
}

function onChangeProtocolType() {
 //alert("onChangeProtocolType "+document.getElementById("protocolType").value);
  if(document.getElementById("protocolType").value == "LOCAL") {
    document.getElementById("protocolUser").disabled = true;
    document.getElementById("protocolUser").value = null;
    document.getElementById("protocolPwd").disabled = true;
    document.getElementById("protocolPwd").value = null;
  }
  else {
    document.getElementById("protocolUser").disabled = false;
    document.getElementById("protocolPwd").disabled = false;
  }
}

function onUpdate() {
	// URL is always required
	var value = document.getElementById("repositoryURL").value;	
	if ( trim(value) == "" ) {
		alert("Repositoryserver URL is required.");		
		return false;
	} 
	// URL is always required
	var value = document.getElementById("repositoryUser").value;
	if ( trim(value) == "" ) {
		alert("Repositoryserver user name is required.");		
		return false;
	} 
	// URL is always required
	var value = document.getElementById("repositoryPassword").value;
	if ( trim(value) == "" ) {
		alert("Repositoryserver password is required.");		
		return false;
	}
	
	var errorContainer = document.getElementById("extractMessageContainer");
	errorContainer.style.display = "none";
	var extractMessageContainer = document.getElementById("messageContainer");
	extractMessageContainer.style.display = "block";
  
	return true;
}

function toggleMessageContainers() 
{ 
 var errorContainer = document.getElementById("extractMessageContainer");
 errorContainer.style.display = "none";
 var extractMessageContainer = document.getElementById("messageContainer");
  extractMessageContainer.style.display = "block";

   
}
</SCRIPT>

<TABLE width="100%">
	<TR>
		<TD class="menusection-DeployerServers" colspan="4">Repository Properties</TD>
	</TR>
	<TR>
  <TD><IMG height="10" src="images/blank.gif" width="5"></TD>
<TD>
</TABLE>


<TABLE>
 <TR>
  <TD id="extractMessageTD" colspan=4>
   <div id="extractMessageContainer" style="display:none">    
   </div> 
  </TD>
 </TR>
</TABLE>
<TABLE>
 <TR>
  <TD colspan="4">
   <div id="messageContainer" style="display:none" class="warning" >   
   Preparing repository. Preparation could take several minutes to complete....please wait for successful completion before continuing or your repository might be corrupted.   
   </div>
  </TD>
 </TR>
</TABLE>

<TABLE>
%ifvar action equals('Save Changes')%
	<!-- key-value pairs from table -->
	%invoke wm.deployer.gui.UICSServer:updateCentrasiteServer%
  <script>
    var errorContainer = document.getElementById("extractMessageContainer");
    errorContainer.innerHTML = "%value -htmlcode message%";    
    errorContainer.style.display = "block";
    var extractMessageContainer = document.getElementById("messageContainer");
    extractMessageContainer.style.display = "none";
    errorContainer.className = "message";
   </script>
	%end invoke%
%endif%
</TABLE>



%invoke wm.deployer.gui.UICSServer:getCSServerDetails%

%ifvar registryType equals('Centrasite')%
<TABLE width="100%">  
   <tr>
    <td>
      <table class="tableView1" width="100%">
	
        <form name="editform" action="cs-server-properties.dsp" method="POST">

	 
		<INPUT type="hidden" value="%value aliasName%" name="aliasName">
		 <INPUT type="hidden" value="registryChanges" name="actionType">

		<tr>
		   <td class="heading" colspan="2">Registry Configuration</td>
		</tr>

		<tr>
	       <script>writeTD("row-l")</script>IS Identifier</td>
		     <script>writeTD("rowdata-l")</script>
		    <input type="text" name="isHost" value="%value isHost%" style="width:50%"/>
		    <script>swapRows();</script>
		</tr>

		<tr>
		    <script>writeTD("row-l")</script>Library</td>
		     <script>writeTD("rowdata-l")</script>
		    <input type="text" name="library" value="%value library%" style="width:100%" />
		    <script>swapRows();</script>
		</tr>
		
		<tr>
		    <script>writeTD("row-l")</script>User Name</td>
		    <script>writeTD("rowdata-l")</script>
		    <input type="text" name="user" value="%value user%" style="width:50%"/>
		    <script>swapRows();</script>
		</tr>
		
		<tr>
		    <script>writeTD("row-l")</script>Password</td>
		    <script>writeTD("rowdata-l")</script>
		    <input type="password" name="password" value="%value password%" style="width:50%"/>
		    <script>swapRows();</script>
		</tr>

		<tr>
		    <td class="action" colspan="2">
			<input type="submit" name="action" value="Save Changes" onclick="return onUpdate();">
		    </td>
		</tr>
	</form>
    </table>
  </td>
  </tr>
   	<TR>
        <TD><IMG height="10" src="images/blank.gif" width="5"></TD>
        <TD>
</TABLE>

%endif%
           
<TABLE width="100%">
	<tr>
	<td>
	    <table class="tableView1" width="100%">

	      <form name="editform1"  action="repository-server-properties.dsp"  method="POST">

	      <INPUT type="hidden" value="%value aliasName%" name="aliasName">
	      <INPUT type="hidden" value="repositoryChanges" name="actionType">
	      <INPUT type="hidden" value="%value repositoryType%" name="repositoryType">

		<tr>
		    <td class="heading" colspan="2">Repository Configuration</td>
		</tr>

		<tr>
		    <script>writeTD("row-l")</script>Alias</td>
		     <script>writeTD("rowdata-l")</script>
			%value aliasName%
			 <script>swapRows();</script>
		</tr>

		<tr>
		    <script>writeTD("row-l")</script>Repository Type</td>
		     <script>writeTD("rowdata-l")</script>
			%value repositoryType%
			 <script>swapRows();</script>
		</tr>
	%ifvar repositoryType equals('VSS')%		
		 <tr>
		    <script>writeTD("row-l")</script>Command Timeout (msec)</td>
		     <script>writeTD("rowdata-l")</script>
		    <input type="text" name="commandTimeout" value="%value commandTimeout%" style="width:50%"/>
		    <script>swapRows();</script>
		</tr>
		
		<tr>
		    <script>writeTD("row-l")</script>Working Folder</td>
		    <script>writeTD("rowdata-l")</script>
		    <input type="text" name="workingFolder" value="%value workingFolder%" style="width:100%"/>
		    <script>swapRows();</script>
		</tr>
		
		<tr>
		    <script>writeTD("row-l")</script>VSS Project Name</td>
		    <script>writeTD("rowdata-l")</script>
		    <input type="text" name="vssProjName"  value="%value vssProjName%" style="width:100%"/>
		    <script>swapRows();</script>
		</tr>
         %endif%
	 %ifvar repositoryType equals('SVN')%

            <tr>
	            <script>writeTD("row-l")</script>URL</td>
		     <script>writeTD("rowdata-l")</script>
		    <input type="text" name="repositoryURL" id="repositoryURL" value="%value repositoryURL%" style="width:100%"/>
		    <script>swapRows();</script>
		</tr>

		<tr>
		    <script>writeTD("row-l")</script>User Name</td>
		     <script>writeTD("rowdata-l")</script>
		    <input type="text" name="repositoryUser"  id="repositoryUser" value="%value repositoryUser%" style="width:50%" />
		    <script>swapRows();</script>
		</tr>
		
		<tr>
		    <script>writeTD("row-l")</script>Password</td>
		    <script>writeTD("rowdata-l")</script>
		    <input type="password" name="repositoryPassword" id="repositoryPassword" value="********" style="width:50%"/>
		    <script>swapRows();</script>
		</tr>

	  %endif%
	 %ifvar repositoryType equals('FLATFILE')%

    <tr>
	       <script>writeTD("row-l")</script>File Directory</td>
		     <script>writeTD("rowdata-l")</script>
		    <input type="text" name="flatFileDirectory" value="%value flatFileDirectory%"  style="width:100%"/>
		    <script>swapRows();</script>
		</tr>


	  %endif%	  
	  
	 %ifvar repositoryType equals('WEBDAV')%

		<tr>
	       <script>writeTD("row-l")</script>IS Identifier</td>
		     <script>writeTD("rowdata-l")</script>
		    <input type="text" name="isHost" value="%value isHost%" style="width:50%"/>
		    <script>swapRows();</script>
		</tr>

		<tr>
		    <script>writeTD("row-l")</script>Library</td>
		     <script>writeTD("rowdata-l")</script>
		    <input type="text" name="library" value="%value library%" style="width:100%" />
		    <script>swapRows();</script>
		</tr>
		
		<tr>
		    <script>writeTD("row-l")</script>User Name</td>
		    <script>writeTD("rowdata-l")</script>
		    <input type="text" name="user" value="%value user%" style="width:50%"/>
		    <script>swapRows();</script>
		</tr>
		
		<tr>
		    <script>writeTD("row-l")</script>Password</td>
		    <script>writeTD("rowdata-l")</script>
		    <input type="password" name="password" value="%value password%" style="width:50%"/>
		    <script>swapRows();</script>
		</tr>


	  %endif%	 
    	  
		<tr>
		    <td class="action" colspan="2">
			<input type="submit" name="action" value="Save Changes" onclick="return onUpdate();">
		    </td>
		</tr>
	</form>
     </table>
  </td>
</tr>

<TR>
  <TD><IMG height="10" src="images/blank.gif" width="5"></TD>
<TD>
</TR>
</TABLE>
%endinvoke%
<SCRIPT> stopProgressBar(); </SCRIPT>
</BODY></HTML>
