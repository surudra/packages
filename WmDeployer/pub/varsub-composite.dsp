<HTML><HEAD>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META http-equiv="Expires" content="-1">
<LINK href="webMethods.css" type="text/css" rel="stylesheet">
<LINK href="xtree.css" type="text/css" rel="stylesheet">
<SCRIPT src="webMethods.js"></SCRIPT>
<SCRIPT src="xtree.js"></SCRIPT>
<BODY onload="refreshPropertiesComponentsPage('', '')">

<SCRIPT language=JavaScript>
function refreshPropertiesComponentsPage(runtimeAndServeralias,assetCompositeName){
if(is_csrf_guard_enabled && needToInsertToken) {
   parent.rightFrame.location.href = 'varsub-component.dsp?projectName=%value -htmlcode projectName%&mapSetName=%value -htmlcode mapSetName%&runtimeAndServeralias='+runtimeAndServeralias+'&assetCompositeName='+assetCompositeName+'&'+ _csrfTokenNm_ + '=' + _csrfTokenVal_;
   top.bottomFrame.location.href = 'varsub-repoasset-page.dsp?projectName=%value -htmlcode projectName%&mapSetName=%value -htmlcode mapSetName%&runtimeAndServeralias='+runtimeAndServeralias+'&assetCompositeName='+assetCompositeName+'&'+ _csrfTokenNm_ + '=' + _csrfTokenVal_;
} else {
    parent.rightFrame.location.href = 'varsub-component.dsp?projectName=%value -htmlcode projectName%&mapSetName=%value -htmlcode mapSetName%&runtimeAndServeralias='+runtimeAndServeralias+'&assetCompositeName='+assetCompositeName;
    top.bottomFrame.location.href = 'varsub-repoasset-page.dsp?projectName=%value -htmlcode projectName%&mapSetName=%value -htmlcode mapSetName%&runtimeAndServeralias='+runtimeAndServeralias+'&assetCompositeName='+assetCompositeName;
}   

}
</SCRIPT>

<TABLE width="100%">
    <TR>
      <TD class="menusection-Deployer" colspan="2"> Configurable Composites</TD>
    </TR>
</TABLE>
         
<TABLE width="100%">

   %invoke wm.deployer.gui.UIRepository:listVarsubCompositesInProject%
	%ifvar assetComposites -notempty% 
		%loop assetComposites%
		<TR  valign="top">			
			<td class="heading" colspan="2">%value name%</td>
			
		</TR>
		%loop assets%
			<TR  valign="top">			
			<SCRIPT> writeTD("row-l"); </SCRIPT> <input type="radio" id="assetCompositeName"  name="assetCompositeName"  onClick="refreshPropertiesComponentsPage('%value ../name%','%value assetCompositeName%')" size=30> %value assetCompositeName%</td>
			
		</TR>	
		<SCRIPT>swapRows();</SCRIPT>
		%endloop assets%		

		%endloop assetComposites%	    
	%else% 
		<TR>
			<SCRIPT> writeTD("row-l"); </SCRIPT> <FONT color="red"> * No configurable assets </FONT> </TD>
		</TR>
	%endif% 
 %endinvoke listVarsubCompositesInProject%				
 </TABLE>
</BODY>
</HTML>
