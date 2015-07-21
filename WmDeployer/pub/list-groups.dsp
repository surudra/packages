<HTML><HEAD>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META http-equiv="Expires" content="-1">
<SCRIPT src="webMethods.js"></SCRIPT>
<script>

function addOption(selectbox,text,value )
{
	var optn = document.createElement("OPTION");
	optn.text = text;
	optn.value = value;
	selectbox.options.add(optn);
}

function populateVersionDropdown(valVersions) {
	var validVersions = valVersions;
	
	var validVersionsArray = validVersions.split(",");
	for (var i=0; i < validVersionsArray.length;++i)
	{
		addOption(document.getElementById("Version_list"), validVersionsArray[i], validVersionsArray[i]);
	}
}

</script>
<LINK href="webMethods.css" type="text/css" rel="stylesheet">
<BODY>

<TABLE width="100%">
	<TR>
		<TD class="menusection-DeployerTools" colspan="4"> Migrate Target Groups 
		</TD>
	</TR>

</TABLE>

<script>
  function enableDisableFields(id)
  {
    var allElements = document.getElementsByClassName('selectAll');
    var flag = false;
    var element;
	 for (var i = 0; (element = allElements[i]) != null; i++) {	    
	 if(document.getElementById(element.id).checked == true) {
	       flag = true;              
           }    
       }
     if(flag == true)
         document.getElementById("submit1").disabled = false;
     else
          document.getElementById("submit1").disabled = true;		
	  
  }
  
function selectAll(id)
  {
  var allElements = document.getElementsByClassName('selectAll');
  var element;
		for (var i = 0; (element = allElements[i]) != null; i++) {
		 if(document.getElementById(id).checked) {
      document.getElementById(element.id).checked = true;
      }
      else {
      document.getElementById(element.id).checked = false;    
      }
  }
  if(document.getElementById(id).checked)  
    document.getElementById("submit1").disabled = false;
  else
    document.getElementById("submit1").disabled = true;	    
}

document.getElementsByClassName = function(cl) 
{
  var retnode = [];
  var myclass = new RegExp('\\b'+cl+'\\b');
  var elem = this.getElementsByTagName('*');
  for (var i = 0; i < elem.length; i++) {
  var classes = elem[i].className;
  if (myclass.test(classes)) retnode.push(elem[i]);
  }
  return retnode;
}; 

function nextPage(pStart, prev, pageNumber) {  
    document.forms["pageForm"].host.value = document.forms["myFormUpdateAliases"].depHost.value;
    document.forms["pageForm"].port.value = document.forms["myFormUpdateAliases"].depPort.value;
    document.forms["pageForm"].userName.value = document.forms["myFormUpdateAliases"].depUserName.value;
    document.forms["pageForm"].password.value = document.forms["myFormUpdateAliases"].depPassword.value;
    document.forms["pageForm"].pluginType.value = document.forms["myFormUpdateAliases"].pluginType.value;
    
    document.forms["pageForm"].currentPage.value = pStart;
    document.forms["pageForm"].prev.value = prev;
    document.forms["pageForm"].pageNumber.value = pageNumber;

    document.forms["myFormUpdateAliases"].actionName.value = "listGroups";
    document.forms["pageForm"].submit();  
    return false;
}

function getAliases() {
      document.forms["myFormUpdateAliases"].pluginType.value = document.getElementById("selectedPluginType").value;
      document.forms["myFormUpdateAliases"].actionName.value = "listGroups";
      document.forms["myFormUpdateAliases"].host.value = document.forms["myFormUpdateAliases"].depHost.value;  
      document.forms["myFormUpdateAliases"].port.value = document.forms["myFormUpdateAliases"].depPort.value;             
      document.forms["myFormUpdateAliases"].userName.value = document.forms["myFormUpdateAliases"].depUserName.value;            
      document.forms["myFormUpdateAliases"].password.value = document.forms["myFormUpdateAliases"].depPassword.value;
      document.forms["myFormUpdateAliases"].submit();
      return false;
}

function getAliases1() {

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
		document.getElementById(divElement).style.display = "none";	
	}
}

  </script>

<TABLE width="100%">


%ifvar actionName equals('importGroups')%
	<!- buildName*  ->
	%invoke wm.deployer.gui.UIUpgrade:importGroups%
		%include error-handler.dsp%
	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%end if%

%ifvar actionName equals('testGroup')%
	<!- buildName*  ->
	%invoke wm.deployer.gui.UIUpgrade:testTargetGroup%
		%include error-handler.dsp%
	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%end if%


</TABLE>
<!- Determine if this user is empowered to project creation/copy stuff ->
%invoke wm.deployer.UIAuthorization:isAuthorized%
%endinvoke%
							
<TABLE>
	%invoke wm.deployer.gui.UIUpgrade:listGroupsByType%
	%include error-handler.dsp%
<FORM name="myFormUpdateAliases" method="POST" action="list-groups.dsp">
	<BR>
				<TABLE width="40%">		
          <tr> 
             	<script> writeTD("rowdata-l"); </script>  
                                     
                 <P>Select Server: &nbsp;&nbsp;&nbsp;<SELECT size="1" id="selectedPluginType" name="selectedPluginType"  onchange="getAliases()">
									%ifvar pluginType equals('IS')%
									   <OPTION VALUE="IS" selected>IS & TN</OPTION> 
									   %else%
									   <OPTION VALUE="IS">IS & TN</OPTION> 
									 %endif%  
									%invoke wm.deployer.gui.UIPlugin:listPlugins%  
										%ifvar plugins -notempty%
											%loop plugins%
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

	<TR>
		<TD><IMG height="10" src="images/blank.gif" width="20"></TD>
		<TD valign="top">
		

			<TABLE width="100%" class="tableForm">
				<div id="aliasContainer" name="aliasContainer" style="display:none">	
				
        <INPUT type="hidden" name="host">
        <INPUT type="hidden" name="port">
        <INPUT type="hidden" name="userName">
        <INPUT type="hidden" name="password">	
				<input type="hidden" name="pluginType" value="%value pluginType%" />

							<input type="hidden" name="depHost" value="%value host%"/>
              <input type="hidden" name="depPort" value="%value port%"/>
              <INPUT type="hidden" name="depUserName" value="%value userName%"/>
              <INPUT type="hidden" name="depPassword" value="%value password%"/>	 				
				
        <TR>
    			<TD class="heading" colspan=2>%value pluginLabel% Target Groups</TD>
    		</TR>
				  <INPUT type="hidden" VALUE="importGroups" name="actionName"/>			  
					<!- buildName*  ->

						%ifvar targetGroups -notempty%
						<TR>
							<TD colspan="2">
							<TABLE width="100%" class="tableForm">
								<TR>
							<TD class="heading" width="1%">
							<input id="alias_" type="checkbox"
				              		name="serverAliasName" value="%value serverAliasName%" onclick="selectAll(id);"> </TD>
									<TD class="heading" width="25%">Group Name</TD>
									<TD class="heading" width="20%">Description</TD>
									<TD class="heading" width="10%">Simulate Migration</TD>
                  <TD class="heading" width="10%">Migrated</TD>									
		  <TD class="heading" width="10%">Migrated Version</TD>
								</TR>
								<SCRIPT>resetRows();</SCRIPT>
								
							%loop targetGroups%
								<TR>
                  %ifvar aliasExists equals('Yes')%
					   			<SCRIPT>writeTD('row-l');</SCRIPT>
										<input id="alias_%value rtgName -urlencode%" type="checkbox"
				              		name="rtgName" value="%value rtgName%" onclick="enableDisableFields(id);" disabled></TD>
				          %else%
				          	<SCRIPT>writeTD('row-l');</SCRIPT>
										<input id="alias_%value rtgName -urlencode%" type="checkbox"
				              		name="rtgName" value="%value rtgName%" onclick="enableDisableFields(id);" class="selectAll"></TD>
				          %endif%
									<SCRIPT>writeTD('row-l');</SCRIPT> %value rtgName% 
									</TD>																											
									<SCRIPT>writeTD('row-l');</SCRIPT> %value rtgDescription% 
									</TD>
                  <SCRIPT>writeTD('row-l');</SCRIPT>
        					 %ifvar aliasExists equals('No')%
        						<A class="imagelink" onclick="startProgressBar();"
        							href="list-groups.dsp?rtgName=%value rtgName%&pluginType=%value ../pluginType%&actionName=testGroup&pageNumber1=%value -urlencode ../pStart1%">							
        							<IMG alt="Test Target Group" src="images/simulate.gif" border="0" width="14" height="14"></A>
                    %else%
                      <A class="imagelink"><IMG height="14" src="images/simulate_disabled.gif"></A>
                    %endif%							
        					</TD>										
			           	<SCRIPT>writeTD('row-l');</SCRIPT> %value aliasExists%
									</TD>
					       </TD>
<SCRIPT>writeTD('row-l');swapRows();</SCRIPT>%value runtimeVersion%</TD>
								</TR>
							%endloop%
							
							</TABLE>
							</TD>
						</TR>
      	<TD colspan="3">
          			 <div class="oddrowdata" id="paginationContainer" name="paginationContainer" style="display:;padding-top=2mm;">
                      %ifvar pStart equals('1')%
                   %else%
                          <a href="" onclick="nextPage(%value pStart%, true, null); return false;">« Previous</a>              
                   %endif%
                     %loop totalNosOfPages%
                      %ifvar totalNosOfPages -notempty%
                      <a href="" onclick="nextPage(%value pStart%, null , %value -urlencode totalNosOfPages%); return false;">                             
                          %ifvar totalNosOfPages vequals(/pStart)% 
                           <a><label style="color:#666666;font-weight:bold;">%value totalNosOfPages%</label>
                          %else%  
                               %ifvar totalNosOfPages equals('...')%
                                  </a><a href="javascript:showHidePageCriteria()">%value totalNosOfPages%</a>
                                 %else%
                                  %value totalNosOfPages%<a>
                               %endif%
                           %endif% 
                       %else%
                           %value pStart%
                       %endif%             
                      %endloop%  
                  %ifvar pStart vequals(pageSize)%   
                    <!-- Next -->
                  %else%
                    <a href="" onclick="nextPage(%value pStart%, false, null); return false;">Next >></a>
                  %endif%  
                 </div>    
          </TD>	
			   <TR>
					<input type="hidden" name="pageNumber" value="%value pStart%" />
					<TD class="action">
					<TABLE>
						<TR>
							<TD>Point Selected Aliases to Groups <SELECT NAME="Version_list" id="Version_list"></SELECT></TD>
							<TD><INPUT type="submit" id="submit1" onclick="javascript:showOrHideDiv('aliasContainer');" align="center" value="Migrate Target Groups" disabled></TD>
						</TR>
					</TABLE>						
					</TD>
				</TR>          					
	%else%
	<TR>
		<TD colspan="5"><FONT color="red">* No %value pluginLabel% Target Groups exist on the server.</FONT></TD>
	</TR>				
	%endif%


  		
        

			</FORM>
		
			</div>
			</TABLE>
			
	<FORM name="pageForm" method="POST" action="list-groups.dsp">  
        <INPUT type="hidden" name="host">
        <INPUT type="hidden" name="port">
        <INPUT type="hidden" name="userName">
        <INPUT type="hidden" name="password">
        <INPUT type="hidden" name="pluginType">
        <INPUT type="hidden" name="currentPage">
        <INPUT type="hidden" name="prev">
        <INPUT type="hidden" name="pageNumber">
        <INPUT type="hidden" name="actionName" value="listGroups">
      
      </FORM>
		</TD>
	</TR>
			
		%end invoke%
</TABLE>

<SCRIPT>

	%invoke wm.deployer.Util:listPluginVersions%
		populateVersionDropdown('%value validVersions%');
	%endinvoke%
  var allElements = document.getElementsByClassName('selectAll');
  if(allElements == null || allElements == "") 
    document.getElementById("alias_").disabled = true;

</SCRIPT>

</BODY>
</HTML>
