<HTML><HEAD>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META http-equiv="Expires" content="-1">
<LINK href="webMethods.css" type="text/css" rel="stylesheet">
<LINK href="xtree.css" type="text/css" rel="stylesheet">
<SCRIPT src="webMethods.js"></SCRIPT>
<SCRIPT src="xtree.js"></SCRIPT>
<SCRIPT src="xtreeradiobutton.js"></SCRIPT>
<BODY>

<SCRIPT language=JavaScript>

function selectAll(id)
{
  var allElements = document.getElementsByTagName('input');
  var element;
   var flag = false;
   for (var i = 0; (element = allElements[i]) != null; i++) {           
	    if(allElements[i].id == id && allElements[i].checked) {
	      flag = true;
	      break;
	    } 
   }   
   if(flag)
   for (var i = 0; (element = allElements[i]) != null; i++) {  
           if(allElements[i].type == "checkbox") 
	      allElements[i].checked = true;
	    
   }else 
   for (var i = 0; (element = allElements[i]) != null; i++) { 
           if(allElements[i].type == "checkbox") 
	      allElements[i].checked = false;
	    
   }

   refreshMiddleFrame()
}

function refreshMiddleFrame(){

    var result = getSelectedServers(); 
    var flag = false;
    var runTimeTypes = getSelectedRunTimeTypes();    
    var allElements = document.getElementsByTagName('input');
    var element;
    for (var i = 0; (element = allElements[i]) != null; i++) {
	if(allElements[i].type == "checkbox" && allElements[i].checked ) {	   
		 flag = true;
		  break;
	 }
   }   
   // if(flag)
		if(is_csrf_guard_enabled && needToInsertToken) {
		   parent.middleFrame.document.location.href = 'varsub-composite.dsp?projectName=%value -htmlcode projectName%&mapSetName=%value -htmlcode mapSetName%&serverAlias=%value -htmlcode serverAlias%&servers='+result+'&runTimeTypes='+runTimeTypes+ '&' + _csrfTokenNm_ + '=' + _csrfTokenVal_;
		} else {
		    parent.middleFrame.document.location.href = 'varsub-composite.dsp?projectName=%value -htmlcode projectName%&mapSetName=%value -htmlcode mapSetName%&serverAlias=%value -htmlcode serverAlias%&servers='+result+'&runTimeTypes='+runTimeTypes;
		}  
}

function getSelectedServers()
  {
   var servers = '';
    var allElements = document.getElementsByTagName('input');
    var element;
    var j=0;      
    if(typeof(document.cForm.serverAlias.value) == "undefined" ) {
	    for (var i = 0; (element = allElements[i]) != null && j<document.cForm.serverAlias.length; i++){
		if(allElements[i].type == "checkbox" && allElements[i].checked ) {
		      var str = allElements[i].value;
		      j++;
			 if(servers ==''){
			    servers = str;
			 
			 }else{
			      servers = servers + ',' + str;
			 }
		 } 
	     }
     }else{
       servers = document.cForm.serverAlias.value;
     }
    return servers;
  }

function getSelectedRunTimeTypes()
  {
    var runtimetypes = '';
    var allElements = document.getElementsByTagName('input');
    var element;
    var j=0;   
   if(typeof(document.cForm.serverAlias.value) == "undefined" ) {
	    for (var i = 0; (element = allElements[i]) != null && j<document.cForm.serverAlias.length; i++){
		if(allElements[i].type == "checkbox" && allElements[i].checked ) {
		      var str = allElements[i].value;
		      j++;
		     var pos = runtimetypes.indexOf(str.split("$")[1]+',')	     
	              if(pos == -1)
			 if(runtimetypes ==''){
			    runtimetypes = str.split("$")[1];
			 
			 }else{
			      runtimetypes = runtimetypes + ',' + str.split("$")[1];
			 }
		 } 
	     }
     }else{
       runtimetypes = document.cForm.serverAlias.value.split("$")[1];
     }   
    return runtimetypes;
  }
 
</SCRIPT>

<TABLE width="100%">
    <TR>
      <TD class="menusection-Deployer" colspan="2">%value projectName% >%value mapSetName% >Target Servers</TD>
    </TR>
</TABLE>

<TABLE class="tableView" width="100%">

	<FORM id="cForm" name="cForm" method="POST" target="leftFrame" action="varsub-targetservers.dsp">

	<!- Submit Button, placed at top for convenience ->
	
 		<TD valign="top"></td>		
		<INPUT type="hidden" name="assetCompositeName" value='%value assetCompositeName%'>
                <INPUT type="hidden" name="projectName" value='%value projectName%'>
		<INPUT type="hidden" name="bundleName" value='%value bundleName%'>
		<INPUT type="hidden" name="serverAliasName" value='%value serverAliasName%'>
		<INPUT type="hidden" name="runtimeType" value='%value runtimeType%'>
		<INPUT type="hidden" name="deploymentMapName" value='%value deploymentMapName%'>
		<INPUT type="hidden" name="servers" value='%'>
		
	      
		%invoke wm.deployer.gui.UIRepository:listTargetServersInMap%
                 %ifvar maps -notempty%
				<TR>
					<TD class="heading" width="2%"> <input id="targetserver_" type="checkbox"
				              		name="serverAliasName" value="selectAll" onclick="selectAll(id);"></TD>
					<TD class="heading" width="30%">Name (RunTime Type)</TD>
					<TD class="heading" width="30%">Target Group</TD>
									  
				</TR>

		%loop maps%
		  <TR>
                   <SCRIPT> writeTD("row-l"); </SCRIPT>
		     <input type="checkBox" id="serverAlias_%value serverAlias -urlencode%"  value="%value serverAlias%$%value pluginName%%ifvar logicalServer -notempty%:%value logicalServer%%endif%" class="selectAll" name="serverAlias" size=25 onChange="refreshMiddleFrame()">
		     </TD>
		      <SCRIPT> writeTD("row-l"); </SCRIPT>
		      %value serverAlias% (%value pluginName%%ifvar logicalServer -notempty% : %value logicalServer%%endif%)
		       </TD>
		        <SCRIPT> writeTD("row-l"); </SCRIPT>
			%value tgName%
			 </TD>
		   </TR>
		   <SCRIPT>swapRows();</SCRIPT>
		      
		  %endloop maps%
	     %else%
	     <TR><TD colspan="3"><FONT color="red"><b> There are no target servers mapped in a Deployment Map </b></FONT></TD></TR>
	    %endif%
           %endinvoke listTargetServersInMap%	
	</TD>
 </TR>
</FORM>
</TABLE>
</BODY>
</HTML>
