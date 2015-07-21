<HTML><HEAD>
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META http-equiv=Pragma content=no-cache>
<META http-equiv=Expires content=-1>
<LINK href="webMethods.css" type=text/css rel=stylesheet>
<SCRIPT src="webMethods.js"></SCRIPT>
</HEAD>
<BODY>

<SCRIPT>
var dotargetPluginTypesExist = false;
function doAdd() {
    var returnVar = false;
    var doesCheckpointExistForAProject = document.getElementById("doesCheckpointExistForAProject").value;
    if(doesCheckpointExistForAProject == 'true') {
        returnVar = confirm("[DEP.0002.0172] When adding a new target server to the map, Deployer will remove any checkpoints created for the associated deployment candidates. You must recreate any checkpoints you want to use. \nDo you want to continue?")
        if (returnVar) {
            document.targetListForm.action = "edit-map-repository.dsp";
        	returnVar = true;
        } else {
            returnVar = false
        }
    } else {
        document.targetListForm.action = "edit-map-repository.dsp";
        returnVar = true;
    }
    return returnVar;
}

// Manage the Add button behavior
var checkBoxCount = 0;
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
}

function getAliases() {
      document.forms["targetListForm"].pluginType.value = document.getElementById("selectedPluginType").value;
      document.forms["targetListForm"].submit();
      return false;
}
</SCRIPT>

<TABLE width="100%">
  <TR>
    <TD class=menusection-Deployer>%value mapSetName% &gt; %value bundleName% &gt; Add Targets</TD>
  </TR>
</TABLE>

<TABLE width="100%">
  	<TR>
  		<TD colspan="2">
  			<UL>
  				<LI><A onclick="return startProgressBar('Refreshing Target Server list');" href="add-repository-target.dsp?projectName=%value projectName%&bundleName=%value bundleName%&mapSetName=%value mapSetName%&mapSetDescription=%value mapSetDescription%">
  						Refresh this Page</A></LI>
  				<LI><A onclick="return startProgressBar();" href="edit-map-repository.dsp?projectName=%value projectName%&mapSetName=%value mapSetName%&mapSetDescription=%value mapSetDescription%">
  						Return to %value mapSetName% > Properties</A></LI>
  			</UL>
			<DIV id="messageDiv" name="messageDiv">
			</DIV>
  		</TD>
  	</TR>
    <tr> 
     	<script> writeTD("rowdata-l"); </script>  
                             
         <P>Select Server: &nbsp;&nbsp;&nbsp;<SELECT size="1" id="selectedPluginType" name="selectedPluginType"  onchange="getAliases()">  
					 %invoke wm.deployer.gui.UIRepository:listRepositoryTargetServerTypes%
						%ifvar pluginServers -notempty%
							%loop pluginServers%
								<script>dotargetPluginTypesExist = true;</script>
  											%ifvar ../pluginType vequals(pluginType)%
                      		  <OPTION value="%value pluginType%" selected>%value pluginLabel%</OPTION>
  						          %else%
  					           	    <OPTION value="%value pluginType%">%value pluginLabel%</OPTION>
  						          %endif% 
							%endloop%
						%endif%        
					%endinvoke%        
				</SELECT>
				</P>
    </tr>
 </TABLE>
 

<TABLE width="100%" class="tableForm">
	<FORM name="targetListForm" method="POST" action="add-repository-target.dsp">
		<input type="hidden" name="action1" value="add">
		<input type="hidden" name="projectName" value="%value projectName%">
		<input type="hidden" name="bundleName" value="%value bundleName%">
		<input type="hidden" name="mapSetName" value="%value mapSetName%">
		<input type="hidden" name="mapSetDescription" value="%value mapSetDescription%">
		<input type="hidden" name="pluginType" value="%value pluginType%">		
    	
  %ifvar pluginType -notempty%
  
  %else%
   <script> 
   	if(dotargetPluginTypesExist == true)
   	{
      document.forms["targetListForm"].pluginType.value = document.getElementById("selectedPluginType").value;
      document.forms["targetListForm"].submit();
      }
   </script>
  %endif%

  <TABLE class="tableView" width="100%">
    <TR>
      <TD class="heading" colspan=6>Add %value pluginType% Target Servers </TD>
    </TR>
		
		%ifvar /pluginType equals('UniversalMessaging')% 
					<TR>
						<td class="oddcol">Add</td>
						<td class="oddcol-l">Runtime Type</td>
						<td class="oddcol-l">Alias</td>					
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
    			%loop pluginServers%
    			%ifvar /pluginType equals('UniversalMessaging')% 
    				<TR>
    					<script> writeTD("rowdata", "nowrap");</script>
    					<input id="alias_%value name -urlencode%_%value ../pluginType -urlencode%" type="checkbox" onclick="manageAddButtons(this,'%value clusterName%');" name="%value name%$%value ../pluginType%" value="SERVER_ALIAS"></TD>
  					  	<script> writeTD("rowdata-l", "nowrap");</script> %value ../pluginLabel% </TD>  		    					
    					<script> writeTD("rowdata-l", "nowrap");</script> %value name% </TD>
    					<script> writeTD("rowdata-l", "nowrap");</script> %value realmURL% </TD>
    					<script> writeTD("row-l", "nowrap");</script>%value runtimeVersion%</TD>
    				</TR>
    				%else%
    				<TR>
    					<script> writeTD("rowdata", "nowrap");</script>
    					<input id="alias_%value name -urlencode%_%value ../pluginType -urlencode%" type="checkbox" onclick="manageAddButtons(this,'%value clusterName%');" name="%value name%$%value ../pluginType%" value="SERVER_ALIAS"></TD>
  					  <script> writeTD("rowdata-l", "nowrap");</script> %value ../pluginLabel% </TD>  		    					
    					<script> writeTD("rowdata-l", "nowrap");</script> %value name% </TD>
    					<script> writeTD("row-l", "nowrap");</script><script>document.write(concatHostAndPortString('%value host%','%value port%'));</script></TD>
    					<script> writeTD("row-l", "nowrap");</script>%value user%</TD>		
					<script> writeTD("row-l", "nowrap");</script>%value runtimeVersion%</TD>
    				</TR>
    				%endif%	
    				<script>swapRows();</script>
    			%endloop%
    		
          %ifvar logicalServerAliases -notempty%        	
              <TR>
                <TD class="heading" colspan=6>Map Logical Servers </TD>
              </TR>
              %loop logicalServerAliases%
              <TR>
                <TD class="subheading" colspan=6>Logical Server : %value name% </TD>
              </TR>
               %loop pluginServers%    			
              				<TR>
              					<script> writeTD("rowdata", "nowrap");</script>
              					<input id="alias_%value name -urlencode%_%value ../name -urlencode%_%value ../type -urlencode%" type="checkbox" onclick="manageAddButtons(this,'%value clusterName%');" name="%value name%$%value ../name%$%value ../type%" value="LOGICAL_SERVER_ALIAS"></TD>
            					  <script> writeTD("rowdata-l", "nowrap");</script> %value pluginLabel% </TD>
              					<script> writeTD("rowdata-l", "nowrap");</script> %value name% </TD>
              					<script> writeTD("row-l", "nowrap");</script><script>document.write(concatHostAndPortString('%value host%','%value port%'));</script></TD>
              					<script> writeTD("row-l", "nowrap");</script>%value user%</TD>
						<script> writeTD("row-l", "nowrap");</script>%value runtimeVersion%</TD>
              				</TR>
              				<script>swapRows();</script>
                %endloop%       				
             %endloop logicalServerAliases% 
          %endif%
		  %ifvar filterVersion -notempty%
			<script>
				var messageDiv = document.getElementById("messageDiv");
				messageDiv.innerHTML = "<TABLE><TR><TD class=\"message\">[DEP.0002.0171] Deployer has applied a filter for targets of version %value filterVersion% on project %value projectName% for map %value mapSetName%.</TD></TR></TABLE>";
			</script>
			%endif%
            <input type="hidden" id="doesCheckpointExistForAProject" name="doesCheckpointExistForAProject" value="%value doesCheckpointExistForThisProject%"/>
		    %endinvoke%
		    
		    
		
  	 <TR>
      <TD>
      <INPUT type="submit" id="addButton" onclick="return doAdd()" align="center" value="Add" disabled>
       </TD>
    </TR>
	</TABLE>		

	</FORM>
	
</TABLE>

<script>
// Hide any rows that are already mapped to this mapSet
%invoke wm.deployer.gui.UITarget:listMapsInSet%
%loop maps%
	// document.all.item("alias_%value serverAliasName -urlencode%").disabled  = true;
	var logicalServerValue = "%value logicalServer%";
	var pluginName = "%value pluginName -urlencode%";	
	if(pluginName == 'IS+%26+TN') {
		pluginName = "IS";
	}
	if(logicalServerValue != null && logicalServerValue != '') {
		var obj = document.getElementById("alias_%value serverAlias -urlencode%_%value logicalServer -urlencode%_"+pluginName);		
		if (obj != null) {
			obj.checked = true;
			obj.disabled = true;
		}
	} else {
		var obj = document.getElementById("alias_%value serverAlias -urlencode%_%value pluginName -urlencode%");
		if (obj != null) {
			obj.checked = true;
			obj.disabled = true;
		}
	}
%endloop%

stopProgressBar();
</script>

</BODY></HTML>
