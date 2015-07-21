<HTML><HEAD><TITLE>Select Component</TITLE>
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META http-equiv=Pragma content=no-cache>
<META http-equiv=Expires content=-1>
<LINK href="webMethods.css" type=text/css rel=stylesheet>
<LINK href="xtree.css" type=text/css rel=stylesheet>
<SCRIPT src="webMethods.js"></SCRIPT>

<SCRIPT>

function selectAll(id,runtimeAndServeralias)
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
    refreshPropertiesPage(runtimeAndServeralias);
  }
 

function refreshFrs(){		
		
       top.bottomFrame.location.href = 'varsub-repoasset-page.dsp?projectName=%value -htmlcode projectName%&mapSetName=%value -htmlcode deploymentMapName%&runtimeType=%value -htmlcode runtimeType%&serverAliasName=%value -htmlcode serverAliasName%&assetCompositeName=%value -htmlcode assetCompositeName%';
	
	
}
</SCRIPT>
</HEAD>
<BODY>

<SCRIPT>
function refreshPropertiesPage(runtimeAndServeralias){

   var allElements = document.getElementsByName('componentName');  
   var cName = '';
   var j = 0;  
   var flag = false;
   for (var i = 0; i < allElements.length; i++) {
       var element = allElements[i];
       if(element.checked) {
           if(j==0)
             cName = element.id;
	   else
	     cName = cName+','+element.id;
	    j++;
	    flag = true;
       }
     }
     if(flag){
     		if(is_csrf_guard_enabled && needToInsertToken) {
     		  top.bottomFrame.location.href = 'varsub-repoasset-page.dsp?projectName=%value -htmlcode projectName%&mapSetName=%value -htmlcode mapSetName%&runtimeAndServeralias='+runtimeAndServeralias+'&assetCompositeName=%value -htmlcode assetCompositeName%&componentName='+cName+'&' + _csrfTokenNm_ + '=' + _csrfTokenVal_;
     		} else {
     		  top.bottomFrame.location.href = 'varsub-repoasset-page.dsp?projectName=%value -htmlcode projectName%&mapSetName=%value -htmlcode mapSetName%&runtimeAndServeralias='+runtimeAndServeralias+'&assetCompositeName=%value -htmlcode assetCompositeName%&componentName='+cName;     		
     		}
     } 
}
</SCRIPT>

<TABLE width="100%">
  <TR>
    <TD class=menusection-Deployer>%value assetCompositeName% >Configurable Components</TD>
  </TR>
</TABLE>

<TABLE class="tableView" width="100%">

	<FORM id="cForm" name="cForm" method="POST" target="middleFrame" action="varsub-component.dsp">

	

	<!- Submit Button, placed at top for convenience ->
	<TR>
 		<TD valign="top"></td>		
		<INPUT type="hidden" name="assetCompositeName" value='%value assetCompositeName%'>		
                <INPUT type="hidden" name="projectName" value='%value projectName%'>
		<INPUT type="hidden" name="bundleName" value='%value bundleName%'>
		<INPUT type="hidden" name="serverAliasName" value='%value serverAliasName%'>
		<INPUT type="hidden" name="runtimeType" value='%value runtimeType%'>
		<INPUT type="hidden" name="mapSetName" value='%value mapSetName%'>
		<INPUT type="hidden" name="depSetName" value='%value depSetName%'>
		
		
	</TR>
		%invoke wm.deployer.gui.UIRepository:listVarsubComponentsInComposite%
		<INPUT type="hidden" name="logicalServer" value='%value logicalServer%'>
		 %ifvar components -notempty%
				<TR>
					<TD class="heading" width="2%"><input id="targetserver_" type="checkbox"
				              		name="serverAliasName" value="selectAll" onclick="selectAll(id,'%value ../runtimeAndServeralias%');"></TD>
					<TD class="heading" width="30%">Name&nbsp(Implementation Type)</TD>
									  
				</TR>
		  %loop components%
		  <TR>
                   <SCRIPT> writeTD("row-l"); </SCRIPT>
		     <input type="checkbox" id=%value -htmlcode componentName%  name="componentName" class="selectAll" onClick="refreshPropertiesPage('%value ../runtimeAndServeralias%')" size=30>
		     </TD>
                  <SCRIPT> writeTD("row-l"); </SCRIPT>
		     %value componentDisplayName%&nbsp(%value componentType%)
		    </TD>
		   </TR>
		   <SCRIPT>swapRows();</SCRIPT>		      
		  %endloop components%

   %endinvoke listComponentsInComposite%	
	</TD>
	<TD valign="top"></td>
	</TR>
	<SCRIPT>swapRows();</SCRIPT>
	</FORM>
	</TABLE>
	</BODY>
</HTML>
