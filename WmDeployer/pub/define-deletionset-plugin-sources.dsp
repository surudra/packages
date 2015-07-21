<HTML><HEAD>
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META http-equiv=Pragma content=no-cache>
<META http-equiv=Expires content=-1>
<LINK href="webMethods.css" type=text/css rel=stylesheet>
<SCRIPT src="webMethods.js"></SCRIPT>
</HEAD>
<BODY>

<SCRIPT>
function updateDS() {
	if (confirm("[DEP.0002.0173] When modifying the deployment set, Deployer will remove any checkpoints created for the associated deployment candidates. You must recreate any checkpoints you want to use. \nDo you want to continue?")) {
		return true;
	}
	
	return false;
}

function enableSaveProperties() {
	document.getElementById("saveProperties").disabled = false;
}

function enableSaveSource(element) {
  var selectedId = element.id; 
  document.getElementById(selectedId).checked = true;
  document.getElementById("saveSource").disabled = false;
}

function onSaveProperties() {
	document.getElementById("action").value="updateDeploymentSet";
	document.getElementById("action1").value="";
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

	startProgressBar("Saving Set Properties.");
	return true;
}

var dotargetPluginTypesExist = false;
function doAdd() {
    var doesCheckpointExistForThisProject = document.getElementById("doesCheckpointExistForThisProject").value;
    if(doesCheckpointExistForThisProject == 'true') {
        var proceedAction = confirm("[DEP.0002.0183] When adding a new source server to the deletion set, Deployer will remove any checkpoints created for the associated deployment candidates. You must recreate any checkpoints you want to use. \nDo you want to continue?")
        if(proceedAction) {
            document.targetListForm.action = "define-deletionset-plugin-sources.dsp";
            return true;
        } else {
            return false;
        }
    } else {
        document.targetListForm.action = "define-deletionset-plugin-sources.dsp";
        return true;
    }
}

// Manage the Add button behavior
/*var checkBoxCount = 0;
function manageAddButtons(obj) {

	if (obj.checked)
		checkBoxCount++;
	else
		checkBoxCount--;

	if (checkBoxCount > 0) {
		document.getElementById("addButton").disabled = false;
	}
	else {
		document.getElementById("addButton").disabled = true;
	}
}*/
</SCRIPT>

<TABLE width="100%">
  <TR>
    <TD class=menusection-Deployer>%value bundleName% > Properties</TD>
  </TR>
</TABLE>

<TABLE width="100%">
%ifvar action equals('updateDeploymentSet')%
	<!- projectName, deploymentSetName, deploymentSetDescription ->
	%invoke wm.deployer.gui.UIBundle:updateDeploymentSet%
		%include error-handler.dsp%

		%ifvar status equals('Success')%
			<script> 
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

<!- Update Source Servers -> 
%ifvar action1 equals('updateSources')%
	<!- projectName, key-value pairs from table ->
	%invoke wm.deployer.gui.UIBundle:updateBundleSourceServerList%
		%include error-handler.dsp%
		%ifvar status equals('Success')%
		<script>
			if(is_csrf_guard_enabled && needToInsertToken) {
	   		   parent.treeFrame.document.location.href = "bundle-list.dsp?projectName=%value -htmlcode projectName%&projectType=Repository&" + _csrfTokenNm_ + "=" + _csrfTokenVal_;
			} else {
			   parent.treeFrame.document.location.href = "bundle-list.dsp?projectName=%value -htmlcode projectName%&projectType=Repository";
			}
		</script>
		%endif%		
	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%endif%
</TABLE>

<SCRIPT>
function getAliases() {
      document.forms["targetListForm"].action1.value = 'getAliases';
      document.forms["targetListForm"].pluginType.value = document.getElementById("selectedPluginType").value;
      document.forms["targetListForm"].submit();
      return false;
}
</SCRIPT>
%invoke wm.deployer.gui.UIProject:getProjectInfo%

<TABLE width="100%">
	<TR>
		<TD colspan="2">
			<UL>
				<LI><A onclick="return startProgressBar();" HREF="define-deletionset-plugin-sources.dsp?isRepositoryDeletionSet=true&projectName=%value projectName%&pluginType=%value bundleType%&bundleName=%value bundleName%"> Refresh this Page</A></LI>
			</UL>
		</TD>
	</TR>

	<TR>
    <TD><IMG height="10" src="images/blank.gif" width="5"></TD>
    <TD>
			
		</TD>
	</TR>
</TABLE>
			<SCRIPT>resetRows();</SCRIPT>
			<TABLE class="tableView" width="100%">
%comment%
				<FORM name="deploymentSetForm" method="POST" action="under-construction.dsp">
%endcomment%
				<FORM name="deploymentSetForm" method="POST" action="define-deletionset-plugin-sources.dsp">

				<TR>
					<TD class="heading" colspan="2">Set Properties</TD>
				</TR>

				<TR>
					<script> writeTD("row"); </script>Name</TD>
					<script> writeTD("rowdata-l"); </script> %value bundleName%</TD>
				</TR>
				<SCRIPT>swapRows();</SCRIPT>

			%invoke wm.deployer.gui.UIBundle:getBundleProperties%
				<TR>
					<script> writeTD("row"); </script>Source Of Truth</TD>
					<script> writeTD("rowdata-l"); </script>%value ../projectType%</TD>
				</TR>
				<SCRIPT>swapRows();</SCRIPT>
				%ifvar ../projectType equals ('Repository')%
				
				%else
				<TR>
					<script> writeTD("row"); </script>Type</TD>
					%ifvar pluginType%
				  	<script> writeTD("rowdata-l"); </script>%value pluginType%</TD>
				  %else%
				  	<script> writeTD("rowdata-l"); </script>IS & TN</TD>
					%endif%
				</TR>
				<SCRIPT>swapRows();</SCRIPT>
        %endif%

				<TR>
					<script> writeTD("row"); </script>Description</TD>
					<script> writeTD("rowdata-l"); </script> 
					%ifvar /defineAuthorized equals('true')% 
						<INPUT onchange="enableSaveProperties();" name="deploymentSetDescription" value="%value bundleDescription%" size="40">
					%else%
						%value bundleDescription%
					%endif%
					</TD>
				</TR>
				<SCRIPT>swapRows();</SCRIPT>
                  %comment%
				<TR>
					<script>writeTDspan("col-l","2");</script>You can use the Packages and All other assets fields to narrow the display of assets.&nbsp;&nbsp;Specify a regular expression 
					that specifies the text that the asset names must contain in order to be displayed. <BR>For example, to narrow the display to assets whose name contains a certain string, 
					specify the regular expression <B><i>.*string.*</B></i>&nbsp;&nbsp;For more information, see the webMethods Deployer User's Guide.
				</TR>

				<TR>
					<script> writeTD("row"); </script>Packages</TD>
					<script> writeTD("rowdata-l"); </script> 
					%ifvar /defineAuthorized equals('true')% 
						<INPUT onchange="enableSaveProperties();" name="packageRegExp" value="%value packageRegExp%" size="32">
					%else%
						%value packageRegExp%
					%endif%
					</TD>
				</TR>
				<SCRIPT>swapRows();</SCRIPT>
				<TR>
					<script> writeTD("row"); </script>All other assets</TD>
					<script> writeTD("rowdata-l"); </script> 
					%ifvar /defineAuthorized equals('true')% 
						<INPUT onchange="enableSaveProperties();" name="otherRegExp" value="%value otherRegExp%" size="32">
					%else%
						%value otherRegExp%
					%endif%
					</TD>
				</TR>
				<SCRIPT>swapRows();</SCRIPT>
			%endcomment%
			%endinvoke%

			%ifvar /defineAuthorized equals('true')%
				<TR>
					<INPUT type="hidden" name="projectName" value="%value projectName%">
					<INPUT type="hidden" name="deploymentSetName" value="%value bundleName%">
					<INPUT type="hidden" name="bundleName" value="%value bundleName%">
					<INPUT type="hidden" name="action" value="" id="action">
					<INPUT type="hidden" name="isRepositoryDeletionSet" value="true">
					<TD class="action" colspan="2">
						<INPUT id="saveProperties" onclick="return onSaveProperties();" align="center" type="submit" VALUE="Save" name="submit"> </TD>
				</TR>
			%endif%

				</FORM>
				
				
				<TR>
				<TD colspan="2">
					<BR><BR>
				</TD>
			</TR>
			</TABLE>



<!--
Plugin Sources Start here
-->
<TABLE width="100%">
  <TR>
    <TD class=menusection-Deployer>%value bundleName% &gt; Select Server</TD>
  </TR>
</TABLE>

<TABLE width="100%">  	
    <tr> 
     	<script> writeTD("rowdata-l"); </script>  
                             
         <P>Server Type: &nbsp;&nbsp;&nbsp;<SELECT size="1" id="selectedPluginType" name="selectedPluginType"  onchange="getAliases()">
         <OPTION value="None">--&nbsp;&nbsp;Select&nbsp;&nbsp;--</OPTION>
         	%invoke wm.deployer.gui.UIPlugin:listPlugins%
						%ifvar plugins -notempty%
							%loop plugins%
								<script>dotargetPluginTypesExist = true;</script>  											
                      		  	<OPTION value="%value pluginType%">%value pluginLabel%</OPTION>  						        
							%endloop%
						%endif%        
					%endinvoke%        
				</SELECT>
				</P>
    </tr>
 </TABLE>
 
<SCRIPT>
var pluginDropDown = document.getElementById("selectedPluginType");
var pluginDropDownLength = pluginDropDown.options.length;
for(var i=0; i<pluginDropDownLength;i++) {
      if(pluginDropDown.options[i].value == '%value pluginType%') {
		pluginDropDown.options[i].selected = true;
      }

}
</SCRIPT>
<TABLE width="100%" class="tableForm">
	<FORM name="targetListForm" method="POST" action="define-deletionset-plugin-sources.dsp">
		<input type="hidden" name="action1" value="updateSources">
		<input type="hidden" name="projectName" value="%value projectName%">
		<input type="hidden" name="bundleName" value="%value bundleName%">
		<input type="hidden" name="pluginType" value="%value pluginType%">
		<INPUT type="hidden" name="isRepositoryDeletionSet" value="true">		
    	

  <TABLE class="tableView" width="100%">
  		%ifvar /pluginType equals('UniversalMessaging')% 
					<TR>
						<td class="oddcol">Add</td>
						<td class="oddcol-l">Runtime Type</td>					
						<td class="oddcol-l">Realm URL</td>
						<td class="oddcol-l">Version</td>
					</TR>
				%else%
					<TR>
						<td class="oddcol">Add</td>
						<td class="oddcol-l">Runtime Type</td>					
						<td class="oddcol-l">Alias</td>
						<td class="oddcol-l">Server</td>
						<td class="oddcol-l">User</td>
						<td class="oddcol-l">Version</td>
					</TR>	
		%endif%	  
		<script>resetRows();</script>
      	%invoke wm.deployer.gui.UIRepository:listBundleTargetServers%
      	        <input type="hidden" id="doesCheckpointExistForThisProject" name="doesCheckpointExistForThisProject" value="%value doesCheckpointExistForThisProject%"/>
    			%loop pluginServers%
    			%ifvar /pluginType equals('UniversalMessaging')% 
    				<TR>
    					<script> writeTD("rowdata", "nowrap");</script>
    					<input id="alias_%value name -urlencode%_%value ../pluginType -urlencode%" type="checkbox" onclick="manageAddButtons(this,'%value clusterName%');" name="%value name%$%value ../pluginType%" value="SERVER_ALIAS"></TD>
  					  	<script> writeTD("rowdata-l", "nowrap");</script> %value ../pluginLabel% </TD>  		    					
    					<script> writeTD("rowdata-l", "nowrap");</script> %value realmURL% </TD>
    					<script> writeTD("row-l", "nowrap");</script>%value runtimeVersion%</TD>
    				</TR>
    			%else%
    				<TR>
    					<script> writeTD("rowdata", "nowrap");</script>
    					<input id="alias_%value name -urlencode%_%value ../pluginType -urlencode%" type="checkbox"  name="%value name%$%value ../pluginType%" value="SERVER_ALIAS"></TD>
  					  <script> writeTD("rowdata-l", "nowrap");</script> %value ../pluginLabel% </TD>  		    					
    					<script> writeTD("rowdata-l", "nowrap");</script> %value name% </TD>
    					<script> writeTD("row-l", "nowrap");</script>%value host%:%value port%</TD>
    					<script> writeTD("row-l", "nowrap");</script>%value user%</TD>		
					<script> writeTD("row-l", "nowrap");</script>%value runtimeVersion%</TD>
    				</TR>
    			%endif%	
    				<script>swapRows();</script>
    			%endloop%          
		  %ifvar filterVersion -notempty%
			<script>
				var messageDiv = document.getElementById("messageDiv");
				messageDiv.innerHTML = "<TABLE><TR><TD class=\"message\">[DEP.0002.0171] Deployer has applied a filter for targets of version %value filterVersion% on project %value projectName% for bundle %value bundleName%.</TD></TR></TABLE>";
			</script>
			%endif%		  
		    %endinvoke%
		    
		    
		
  	 <TR>
      <TD>
      <INPUT type="submit" id="addButton" onclick="return doAdd()" align="center" value="Add">
       </TD>
    </TR>
	</TABLE>		

	</FORM>
	
</TABLE>

<SCRIPT>
%invoke wm.deployer.gui.UIBundle:getBundleSourceServers%
%loop servers%	

	var serverStr = '%value serverAliasName%';
	var serverAliasParts = serverStr.split("$"); 	
	var pluginName = serverAliasParts[1];
	var serverAlias = serverAliasParts[0];
	if(pluginName == 'IS+%26+TN') {
		pluginName = "IS";
	}
	
	var obj = document.getElementById("alias_"+serverAlias+"_"+pluginName);
	if (obj != null) {
		obj.checked = true;
		//obj.disabled = true;
	}
	
%endloop%

stopProgressBar();
</SCRIPT>


</BODY>
</HTML>	
