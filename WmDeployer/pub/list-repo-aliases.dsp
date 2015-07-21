<HTML><HEAD>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META http-equiv="Expires" content="-1">
<SCRIPT src="webMethods.js"></SCRIPT>
<LINK href="webMethods.css" type="text/css" rel="stylesheet">

<BODY >

<TABLE width="100%">
	<TR>
		<TD class="menusection-DeployerTools" colspan="4"> Migrate Repository Aliases 
		</TD>
	</TR>

</TABLE>

<script>
  function enableDisableFields(id)
  {
    if(document.getElementById(id).checked) {
    	document.getElementById(id+"_flatFileDirectory").disabled = false;
    }
    else {
    	document.getElementById(id+"_flatFileDirectory").disabled = true;
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
  
  
  function onChangeFlatFileDirectory(id) 
  {
    var flatFileDirectoryValue = document.getElementById(id).value;
    	if (trim(flatFileDirectoryValue) == "" ) {
	     	alert("FlatFileDirectory is required.");
		    return false;
  	 } 
   }
  
  function onSubmit() {
     var allElements = document.getElementsByClassName('selectAll');
     var element;
  		for (var i = 0; (element = allElements[i]) != null; i++) {
  		 if(document.getElementById(element.id).checked) {
          var flatFileDir = document.getElementById(element.id+"_flatFileDirectory").value;
          if (trim(flatFileDir) == "" ) {
	     	    alert("File Directory is required.");
	     	    return false;
	       	}
        }
      }   
      return true; 
  }
  
function selectAll(id)
  {
  var allElements = document.getElementsByClassName('selectAll');
  var element;
		for (var i = 0; (element = allElements[i]) != null; i++) {
		 if(document.getElementById(id).checked) {
      document.getElementById(element.id).checked = true;
      document.getElementById(element.id+"_flatFileDirectory").disabled = false;
      }
      else {
      document.getElementById(element.id).checked = false;
      document.getElementById(element.id+"_flatFileDirectory").disabled = true;  
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


%ifvar actionName equals('importrepoaliases')%
	<!- buildName*  ->
	%invoke wm.deployer.gui.UIUpgrade:importRepositoryAliases%
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



							
<TABLE width="100%">
	%invoke wm.deployer.gui.UIUpgrade:listRepositoryAliases%
	%include error-handler.dsp%
	<FORM name="myFormUpdateAliases" method="POST" action="list-repo-aliases.dsp">

	<TR>
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
    			<TD class="heading" >Repositories</TD>
    		</TR>
				  <INPUT type="hidden" VALUE="importrepoaliases" name="actionName"/>			  
					<!- buildName*  ->

						%ifvar serverAliases -notempty%
						<TR>
							<TD colspan="2">
							<TABLE width="100%" class="tableForm">
								<TR>
							<TD class="heading" width="1%">
							<input id="alias_" type="checkbox"
				              		name="serverAliasNameAll" value="%value serverAliasName%" onclick="selectAll(id);"> </TD>
									<TD nowrap class="heading" width="25%">Alias  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
									<TD class="heading" width="15%">File Directory</TD>
							        <TD class="heading" width="10%">Migrated</TD>	
								</TR>

                           				<SCRIPT>resetRows();</SCRIPT>		
							%loop serverAliases%
								<TR>

									%ifvar aliasExists equals('false')%
					   				<SCRIPT>writeTD('row-l');</SCRIPT>
										<input id="alias_%value aliasName -urlencode%" type="checkbox"
				              		name="serverAliasName" value="%value aliasName%" onclick="enableDisableFields(id);" class="selectAll"></TD>
									<SCRIPT>writeTD('row-l');</SCRIPT> %value aliasName% </TD>									
									<input type="hidden" name="alias" value="%value aliasName%" />
									<SCRIPT>writeTD('row-l');</SCRIPT> <input id="alias_%value aliasName -urlencode%_flatFileDirectory" name="flatFileDirectory" size="25%" value="%value flatFileDirectory%" disabled/> </TD>
                  					<SCRIPT>writeTD('row-l');</SCRIPT> No </TD>										
									%else%
                  					<SCRIPT>writeTD('row-l');</SCRIPT>
										<input id="alias_%value aliasName -urlencode%" type="checkbox"
				              		name="serverAliasName" value="%value aliasName%" onclick="enableDisableFields(id);" disabled></TD>
									<SCRIPT>writeTD('row-l');</SCRIPT> %value aliasName%</TD>
									<SCRIPT>writeTD('row-l');</SCRIPT> %value flatFileDirectory% </TD>
                  					<SCRIPT>writeTD('row-l');</SCRIPT> Yes </TD>										
									%endif%
								<SCRIPT>swapRows();</SCRIPT></TR>
							%endloop%
							</TABLE>
							</TD>
						</TR>
      	<TD colspan="4">
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
					<TABLE width="100%">
						<TR>
							<TD><INPUT type="submit" id="submit1" onclick="return showOrHideDiv('aliasContainer')" align="center" value="Migrate Repository Aliases" disabled></TD>
						</TR>
					</TABLE>						
					</TD>
				</TR>          					
	%else%
	<TR>
		<TD colspan="5"><FONT color="red">* No Repository server aliases exist on the server.</FONT></TD>
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
  var allElements = document.getElementsByClassName('selectAll');
  if(allElements == null || allElements == "") 
    document.getElementById("alias_").disabled = true;
   

</SCRIPT>

</BODY>
</HTML>
