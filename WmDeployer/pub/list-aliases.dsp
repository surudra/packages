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

<BODY >

<TABLE width="100%">
	<TR>
		<TD class="menusection-DeployerTools" colspan="4"> Migrate Server Aliases 
		</TD>
	</TR>

</TABLE>

<script>
  function enableDisableFields(id, pluginType)
  {
    if(document.getElementById(id).checked) {
    	if(pluginType == 'UniversalMessaging'){
    		document.getElementById(id+"_realmURL").disabled = false;
    	}else{
	    	document.getElementById(id+"_host").disabled = false;
		  	document.getElementById(id+"_port").disabled = false;
		  	if(pluginType == 'IS' || pluginType == 'ProcessModel' || pluginType == 'MWS' || pluginType == 'Optimize' || pluginType == 'EDA' || pluginType == 'EventServer' || pluginType == 'RULES') {
	  	  	document.getElementById(id+"_user").disabled = false;
	  	    document.getElementById(id+"_password").disabled = false;
    	}
      }
    }
    else {
    	document.getElementById(id+"_realmURL").disabled = true;
    	document.getElementById(id+"_host").disabled = true;
	  	document.getElementById(id+"_port").disabled = true;
	  	document.getElementById(id+"_user").disabled = true;
	    document.getElementById(id+"_password").disabled = true;
    }

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
  
  function onChangePort(id) {
    var portValue = document.getElementById(id).value;
    	if (trim(portValue) == "" ) {
	     	alert("Port is required.");
		    return false;
  	 } 
    	if (isNaN(portValue)) {
	     	alert("Port Number must be positive integer. ");
		    return false;
  	 }   	 
  }
  
  function onChangeHost(id) 
  {
    var hostValue = document.getElementById(id).value;
    	if (trim(hostValue) == "" ) {
	     	alert("Host is required.");
		    return false;
  	 } 
   }
  
  function onSubmit() {
     var allElements = document.getElementsByClassName('selectAll');
     var element;
  		for (var i = 0; (element = allElements[i]) != null; i++) {
  		 if(document.getElementById(element.id).checked) {
  		 	if(pluginType == 'UniversalMessaging'){
	  		  var realmURL = document.getElementById(element.id+"_realmURL").value;
	  		  if (trim(realmURL) == "" ) {
	     	    alert("Realm URL is required.");
	     	    return false;
	       		}
  		 	}else{
	          var port = document.getElementById(element.id+"_port").value;
	          var host = document.getElementById(element.id+"_host").value;
  		 	}
          if (trim(host) == "" ) {
	     	    alert("Host is required.");
	     	    return false;
	       	}
          if((trim(port) == "") || isNaN(port) || (trim(port) < 0)) {
             alert("Port is required and must be a positive integer. ");
             return false;
          }
        }
      }   
      return true; 
  }
  
function selectAll(id , pluginType)
  {
  var allElements = document.getElementsByClassName('selectAll');
  var element;
		for (var i = 0; (element = allElements[i]) != null; i++) {
		 if(document.getElementById(id).checked) {
      document.getElementById(element.id).checked = true;
      if(pluginType == 'UniversalMessaging'){
      	document.getElementById(element.id+"_realmURL").disabled = false;
      }else{
	     document.getElementById(element.id+"_host").disabled = false;
		 document.getElementById(element.id+"_port").disabled = false;
      }
      if(pluginType == 'IS' || pluginType == 'ProcessModel' || pluginType == 'MWS' || pluginType == 'Optimize' || pluginType == 'EDA' || pluginType == 'EventServer' || pluginType == 'RULES') {
  	  	document.getElementById(element.id+"_user").disabled = false;
  	    document.getElementById(element.id+"_password").disabled = false;
      }
      }
      else {
      document.getElementById(element.id).checked = false;
      document.getElementById(element.id+"_realmURL").disabled = true;
      document.getElementById(element.id+"_host").disabled = true;
	  	document.getElementById(element.id+"_port").disabled = true;
	  	document.getElementById(element.id+"_user").disabled = true;
	    document.getElementById(element.id+"_password").disabled = true;      
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

    document.forms["myFormUpdateAliases"].actionName.value = "listAliases";
    document.forms["pageForm"].submit();  
    return false;
}

function getAliases() {
      document.forms["myFormUpdateAliases"].pluginType.value = document.getElementById("selectedPluginType").value;
      document.forms["myFormUpdateAliases"].actionName.value = "listAliases";
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
	var val =  onSubmit();
	return val;
}

  </script>

<TABLE width="100%">


%ifvar actionName equals('importaliases')%
	<!- buildName*  ->
	%invoke wm.deployer.gui.UIUpgrade:importAliases%
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
	%invoke wm.deployer.gui.UIUpgrade:listAliasesByType%
	%include error-handler.dsp%
	<FORM name="myFormUpdateAliases" method="POST" action="list-aliases.dsp">
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
				
			
        <INPUT type="hidden" name="host" >
        <INPUT type="hidden" name="port">
        <INPUT type="hidden" name="userName">
        <INPUT type="hidden" name="password">	
				<input type="hidden" name="pluginType" value="%value pluginType%" />

							<input type="hidden" name="depHost" value="%value host%"/>
              <input type="hidden" name="depPort" value="%value port%"/>
              <INPUT type="hidden" name="depUserName" value="%value userName%"/>
              <INPUT type="hidden" name="depPassword" value="%value password%"/>	 				
				
        <TR>
    			<TD class="heading" colspan=2>%value pluginType% Server Aliases</TD>
    		</TR>
				  <INPUT type="hidden" VALUE="importaliases" name="actionName"/>			  
					<!- buildName*  ->

						%ifvar serverAliases -notempty%
						<TR>
							<TD colspan="2">
							<TABLE width="100%" class="tableForm">
								<TR>
							<TD class="heading" width="1%">
							<input id="alias_" type="checkbox"
				              		name="serverAliasNameAll" value="%value serverAliasName%" onclick="selectAll(id , '%value pluginType%');"> </TD>
									<TD nowrap class="heading" width="25%">Alias  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
									 %ifvar pluginType equals('UniversalMessaging')%
									 	<TD class="heading" width="25%">Realm URL</TD>
									 %else%
										<TD class="heading" width="25%">Host</TD>
										<TD class="heading" width="5%">Port</TD>
									 %endif%
							     %ifvar pluginType equals('IS')%									
									<TD class="heading" width="15%">User</TD>
									<TD class="heading" width="10%">Password</TD>	
                  %endif%		
							     %ifvar pluginType equals('MWS')%									
									<TD class="heading" width="15%">User</TD>
									<TD class="heading" width="10%">Password</TD>	
                  %endif%	
							     %ifvar pluginType equals('ProcessModel')%									
									<TD class="heading" width="15%">User</TD>
									<TD class="heading" width="10%">Password</TD>	
                  %endif%	                                    			
                  					%ifvar pluginType equals('Optimize')%									
									<TD class="heading" width="15%">User</TD>
									<TD class="heading" width="10%">Password</TD>	
                  %endif%	            
                  					%ifvar pluginType equals('EDA')%									
									<TD class="heading" width="15%">User</TD>
									<TD class="heading" width="10%">Password</TD>	
                  %endif%	         
                  					%ifvar pluginType equals('EventServer')%									
									<TD class="heading" width="15%">User</TD>
									<TD class="heading" width="10%">Password</TD>	
                  %endif%	            
                  					%ifvar pluginType equals('RULES')%									
									<TD class="heading" width="15%">User</TD>
									<TD class="heading" width="10%">Password</TD>	
                  %endif%	                             					
                  <TD class="heading" width="10%">Migrated</TD>
		  <TD class="heading" width="10%">Migrated Version</TD>	
								</TR>

                           				<SCRIPT>resetRows();</SCRIPT>		
							%ifvar pluginType equals('IS')%
							%loop serverAliases%
								<TR>

									%ifvar aliasExists equals('false')%
					   				<SCRIPT>writeTD('row-l');</SCRIPT>
										<input id="alias_%value serverAliasName -urlencode%" type="checkbox"
				              		name="serverAliasName" value="%value serverAliasName%" onclick="enableDisableFields(id, '%value ../pluginType%');" class="selectAll"></TD>
									<SCRIPT>writeTD('row-l');</SCRIPT> %value serverAliasName% 
									</TD>									
									<input type="hidden" name="alias" value="%value serverAliasName%" />
									<SCRIPT>writeTD('row-l');</SCRIPT> <input id="alias_%value serverAliasName -urlencode%_host" name="host" size="25%" value="%value serverAliasHost%" disabled/>
									</TD>
									<SCRIPT>writeTD('row-l');</SCRIPT> <input id="alias_%value serverAliasName -urlencode%_port" name="port" size="5%" value="%value serverAliasPort%" disabled class="port"/>
									</TD>
									<SCRIPT>writeTD('row-l');</SCRIPT> <input id="alias_%value serverAliasName -urlencode%_user" name="user" size="15%"" value="%value serverAliasUser%" disabled/>
									</TD>
									<SCRIPT>writeTD('row-l');</SCRIPT> <input id="alias_%value serverAliasName -urlencode%_password" name="password" size="10%" type="password" value="********" disabled />
									</TD>
									<SCRIPT>writeTD('row-l');</SCRIPT> No
									</TD>										
									%else%
									<SCRIPT>writeTD('row-l');</SCRIPT>
										<input id="alias_%value serverAliasName -urlencode%" type="checkbox"
				              		name="serverAliasName" value="%value serverAliasName%" onclick="enableDisableFields(id);" disabled></TD>
									<SCRIPT>writeTD('row-l');</SCRIPT> %value serverAliasName% 
									</TD>
									<SCRIPT>writeTD('row-l');</SCRIPT> %value serverAliasHost%
									</TD>
									<SCRIPT>writeTD('row-l');</SCRIPT> %value serverAliasPort%
									</TD>
									<SCRIPT>writeTD('row-l');</SCRIPT> %value serverAliasUser%
									</TD>
									<SCRIPT>writeTD('row-l');</SCRIPT> ********
									</TD>
									<SCRIPT>writeTD('row-l');</SCRIPT> Yes
									</TD>										
									%endif%							
					       </TD>
					       <SCRIPT>writeTD('row-l');swapRows();</SCRIPT>%value runtimeVersion%</TD>
								</TR>
							%endloop%
							%else%
							%loop serverAliases%
								<TR>
                  %ifvar aliasExists equals('false')%
							   	<SCRIPT>writeTD('row-l');</SCRIPT>
										<input id="alias_%value name -urlencode%" type="checkbox"
				              		name="name" value="%value name%" onclick="enableDisableFields(id, '%value ../pluginType%');" class="selectAll"></TD>
									<SCRIPT>writeTD('row-l');</SCRIPT> %value name% 
									</TD>
									<input type="hidden" name="alias" value="%value name%" />
									%ifvar ../pluginType equals('UniversalMessaging')%
										<SCRIPT>writeTD('row-l');</SCRIPT> <input id="alias_%value name -urlencode%_realmURL" name="realmURL" size="30%" value="%value realmURL%" disabled/>
									%else%
										<SCRIPT>writeTD('row-l');</SCRIPT> <input id="alias_%value name -urlencode%_host" name="host" size="30%" value="%value host%" disabled/>
										</TD>
										<SCRIPT>writeTD('row-l');</SCRIPT> <input id="alias_%value name -urlencode%_port" name="port" size="5%" value="%value port%" disabled/>
										</TD>
									%endif%
									%ifvar ../pluginType equals('MWS')%
									<SCRIPT>writeTD('row-l');</SCRIPT> <input id="alias_%value name -urlencode%_user" name="user" size="10%" value="%value user%" disabled/>
									</TD>
									<SCRIPT>writeTD('row-l');</SCRIPT> <input id="alias_%value name -urlencode%_password" name="password" size="10%" type="password" value="********" disabled/>
									</TD>
									%endif%
									%ifvar ../pluginType equals('ProcessModel')%
									<SCRIPT>writeTD('row-l');</SCRIPT> <input id="alias_%value name -urlencode%_user" name="user" size="10%" value="%value user%" disabled/>
									</TD>
									<SCRIPT>writeTD('row-l');</SCRIPT> <input id="alias_%value name -urlencode%_password" name="password" size="10%" type="password" value="********" disabled/>
									</TD>
									%endif%	
									%ifvar ../pluginType equals('Optimize')%
									<SCRIPT>writeTD('row-l');</SCRIPT> <input id="alias_%value name -urlencode%_user" name="user" size="10%" value="%value user%"   disabled/>
									</TD>
									<SCRIPT>writeTD('row-l');</SCRIPT> <input id="alias_%value name -urlencode%_password" name="password" size="10%" type="password" value="********" disabled/>
									</TD>
									%endif%
									%ifvar ../pluginType equals('EDA')%
									<SCRIPT>writeTD('row-l');</SCRIPT> <input id="alias_%value name -urlencode%_user" name="user" size="10%" value="%value user%"   disabled/>
									</TD>
									<SCRIPT>writeTD('row-l');</SCRIPT> <input id="alias_%value name -urlencode%_password" name="password" size="10%" type="password" value="********" disabled/>
									</TD>
									%endif%
									%ifvar ../pluginType equals('EventServer')%
									<SCRIPT>writeTD('row-l');</SCRIPT> <input id="alias_%value name -urlencode%_user" name="user" size="10%" value="%value user%"   disabled/>
									</TD>
									<SCRIPT>writeTD('row-l');</SCRIPT> <input id="alias_%value name -urlencode%_password" name="password" size="10%" type="password" value="********" disabled/>
									</TD>
									%endif%
									%ifvar ../pluginType equals('RULES')%
									<SCRIPT>writeTD('row-l');</SCRIPT> <input id="alias_%value name -urlencode%_user" name="user" size="10%" value="%value user%"   disabled/>
									</TD>
									<SCRIPT>writeTD('row-l');</SCRIPT> <input id="alias_%value name -urlencode%_password" name="password" size="10%" type="password" value="********" disabled/>
									</TD>
									%endif%
									<SCRIPT>writeTD('row-l');</SCRIPT> No
									</TD>										
									%else%
									<SCRIPT>writeTD('row-l');</SCRIPT>
										<input id="alias_%value name -urlencode%" type="checkbox"
				              		name="name" value="%value name%" onclick="enableDisableFields(id);" disabled></TD>
									%ifvar ../pluginType equals('UniversalMessaging')%
										<SCRIPT>writeTD('row-l');</SCRIPT> %value name% 
										</TD>
										<SCRIPT>writeTD('row-l');</SCRIPT> %value realmURL%
										</TD>
									%else%
										<SCRIPT>writeTD('row-l');</SCRIPT> %value name% 
										</TD>
										<SCRIPT>writeTD('row-l');</SCRIPT> %value host%
										</TD>
										<SCRIPT>writeTD('row-l');</SCRIPT> %value port%
										</TD>
									%endif%
									%ifvar ../pluginType equals('MWS')%
									<SCRIPT>writeTD('row-l');</SCRIPT> %value user%
									</TD>
									<SCRIPT>writeTD('row-l');</SCRIPT> ********
									</TD>
									%endif%
									%ifvar ../pluginType equals('Optimize')%
									<SCRIPT>writeTD('row-l');</SCRIPT> %value user%
									</TD>
									<SCRIPT>writeTD('row-l');</SCRIPT> ********
									</TD>
									%endif%
									
									%ifvar ../pluginType equals('ProcessModel')%
									<SCRIPT>writeTD('row-l');</SCRIPT> %value user%
									</TD>
									<SCRIPT>writeTD('row-l');</SCRIPT> ********
									</TD>
									%endif%									
									
									%ifvar ../pluginType equals('EDA')%
									<SCRIPT>writeTD('row-l');</SCRIPT> %value user%
									</TD>
									<SCRIPT>writeTD('row-l');</SCRIPT> ********
									</TD>
									%endif%									
									
									%ifvar ../pluginType equals('EventServer')%
									<SCRIPT>writeTD('row-l');</SCRIPT> %value user%
									</TD>
									<SCRIPT>writeTD('row-l');</SCRIPT> ********
									</TD>
									%endif%									
									
									%ifvar ../pluginType equals('RULES')%
									<SCRIPT>writeTD('row-l');</SCRIPT> %value user%
									</TD>
									<SCRIPT>writeTD('row-l');</SCRIPT> ********
									</TD>
									%endif%									
									<SCRIPT>writeTD('row-l');</SCRIPT> Yes
									</TD>									
									%endif%
					       </TD>
					       <SCRIPT>writeTD('row-l');swapRows();</SCRIPT>%value runtimeVersion%</TD>

								</TR>
							%endloop%
							%endif%
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
                  %ifvar pStart vequals(totalPages)%   
                    <!-- Next -->
                  %else%
                    <a href="" onclick="nextPage(%value pStart%, false, null); return false;">Next >></a>
                  %endif%  
                 </div>    
          </TD>	
			   <TR>
					<input type="hidden" name="pageNumber" value="%value pStart%" />
					<TD class="action" style="color: black;">
					<TABLE>
						<TR>
							<TD>Point Selected Aliases to Servers <SELECT NAME="Version_list" id="Version_list"></SELECT></TD>
							<TD><INPUT type="submit" id="submit1" onclick="return showOrHideDiv('aliasContainer')" value="Migrate Server Aliases" disabled></TD>
						</TR>
					</TABLE>						
					</TD>
				</TR>          					
	%else%
	<TR>
		<TD colspan="5"><FONT color="red">* No %value pluginType% server aliases exist on the server.</FONT></TD>
	</TR>				
	%endif%


  		
        

			</FORM>
		
			</div>
			</TABLE>
			
	<FORM name="pageForm" method="POST" action="list-aliases.dsp">  
        <INPUT type="hidden" name="host">
        <INPUT type="hidden" name="port">
        <INPUT type="hidden" name="userName">
        <INPUT type="hidden" name="password">
        <INPUT type="hidden" name="pluginType">
        <INPUT type="hidden" name="currentPage">
        <INPUT type="hidden" name="prev">
        <INPUT type="hidden" name="pageNumber">
        <INPUT type="hidden" name="actionName" value="listaliases">
      
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
