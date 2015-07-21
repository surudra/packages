<HTML><HEAD><TITLE>Bundle Dependencies</TITLE>
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META http-equiv=Pragma content=no-cache>
<META http-equiv=Expires content=-1>
<LINK href="webMethods.css" type="text/css" rel="stylesheet">
<LINK href="xtree.css" type="text/css" rel="stylesheet">
<SCRIPT src="webMethods.js"></SCRIPT>
<SCRIPT src="treetable.js"></SCRIPT>
<SCRIPT src="xtree.js"></SCRIPT>

<SCRIPT language=JavaScript>

function updateDS() {
	if (confirm("[DEP.0002.0173] When modifying the deletion set, Deployer will remove any checkpoints created for the associated deployment candidates. You must recreate any checkpoints you want to use. \nDo you want to continue?")) {
		return true;
	}
	
	return false;
}
</script>
</HEAD>

  <BODY>
  
  %ifvar action equals('addAssetReferencesToDeletionSet')%
  	%invoke wm.deployer.gui.UIBundle:addAssetReferencesToDeletionSet%
  		%include error-handler.dsp%
  		
  		<!- refresh project tree in left frame ->
		%ifvar status equals('Success')%
		<script>
			if(is_csrf_guard_enabled && needToInsertToken) {
   			   parent.treeFrame.document.location.href = "bundle-list.dsp?projectName=%value -htmlcode projectName%&projectType=%value -htmlcode projectType%&" + _csrfTokenNm_ + "=" + _csrfTokenVal_;
			} else {
			   parent.treeFrame.document.location.href = "bundle-list.dsp?projectName=%value -htmlcode projectName%&projectType=%value -htmlcode projectType%";
			}
		</script>
		%endif%
  
  	%onerror%
  		%loop -struct%
  			<tr><td>%value $key%=%value%</td></tr>
  		%endloop%
  	%endinvoke%
  %endif%
  
  %ifvar action equals('addAll')%
  	%invoke wm.deployer.gui.UIBundle:autoResolveAssetReferences%
  		%include error-handler.dsp%
  		
  		<!- refresh project tree in left frame ->
		%ifvar status equals('Success')%
		<script>
			if(is_csrf_guard_enabled && needToInsertToken) {
   			   parent.treeFrame.document.location.href = "bundle-list.dsp?projectName=%value -htmlcode projectName%&projectType=%value -htmlcode projectType%&" + _csrfTokenNm_ + "=" + _csrfTokenVal_;
			} else {
			   parent.treeFrame.document.location.href = "bundle-list.dsp?projectName=%value -htmlcode projectName%&projectType=%value -htmlcode projectType%";
			}
		</script>
		%endif%
  
  	%onerror%
  		%loop -struct%
  			<tr><td>%value $key%=%value%</td></tr>
  		%endloop%
  	%endinvoke%
  %endif%
  
  <TABLE width="100%">
      <TBODY>
      <TR>
        <TD class=menusection-Deployer>%value bundleName% > Unresolved Asset References</TD>
      </TR>
      
     
      </TBODY>
    </TABLE>
  <ul>
      <li><A href="deletionset-refrences.dsp?projectName=%value -htmlcode projectName%&bundleName=%value -htmlcode bundleName%&bundleType=%value -htmlcode bundleType%&projectType=%value -htmlcode projectType%">Refresh this Page</A></li>
      <li><A href="deletionset-refrences.dsp?projectName=%value -htmlcode projectName%&bundleName=%value -htmlcode bundleName%&bundleType=%value -htmlcode bundleType%&projectType=%value -htmlcode projectType%&action=addAll">Auto resolve dependencies</A></li>
  </UL>
  
  <form name="deletionSetRefrencesForm" id="deletionSetRefrencesForm" method="POST" action="deletionset-refrences.dsp">
  	<INPUT type="hidden" name="projectName" value="%value projectName%">
  	<INPUT type="hidden" name="projectType" value="%value projectType%">		
	<INPUT type="hidden" name="bundleName" value="%value bundleName%">
	<INPUT type="hidden" name="action" value="addAssetReferencesToDeletionSet">
  
    
    %invoke wm.deployer.gui.UIBundle:getUnresolvedAssetReferences%
    %include error-handler.dsp%
    <TABLE class="tableForm" align="center" width="100%">
      <TBODY>
        %ifvar showRefrencesResolved equals('true')%
            <TR>
    					<TD colspan="3">
    						<FONT color="green"><b>The deletion set has no unresolved dependencies.</b></FONT> 
    					</TD>
  				  </TR>
        %endif%
        
        %ifvar references -notempty%
    			%loop references%
        			
    			   <TR>
                <TD class="heading" colspan="3" nowrap>%value aliasName%(%value pluginLabel%)</TD>
            </TR>
            %ifvar message -notempty%
               <TR>
                <TD colspan="3" nowrap><FONT color="red"><b> %value -htmlcode message%</b></FONT></TD>
              </TR>
            %else%
              %ifvar assetReferences -notempty%
                  <TR>
                      <TD class="oddcol" nowrap>Add</TD>
                      <TD class="oddcol-l" nowrap>Referenced Assets</TD>
                      <TD class="oddcol-l" nowrap>Assets</TD>
                  </TR>
                  %loop assetReferences%
                    <TR>
                      <TD class="oddcol" rowspan="%value rowspan%" nowrap><input type=checkbox name="ASSET_REFRENCES" value="%value type%;%value id%;%value name%;%value compositeName%;%value compositeType%;%value path%;%value parentId%;%value fullName%;%value ../pluginType%;%value ../aliasName%;"></TD>
                      <TD class="oddcol-l" rowspan="%value rowspan%" nowrap>
      						    <script>
      							      var icon = getACDLIcon("%value type%");
      						        w("<img align=absmiddle src='" + icon + "'>");
      						        </script>
                      %value name%</TD>
                      <TD class="oddcol-l" nowrap>%value firstParentName%</TD>
                      </TR>
                      %ifvar otherParentIds -notempty%
	                      %loop otherParentIds%
	                      	<TR><TD class="oddcol-l" nowrap>%value name%</TD></TR>
	                      %endloop otherParentIds%
                      %endif%
                    
                  %endloop assetReferences%
              %endif%
           %endif%
            
    			%endloop references%
    			%ifvar showAddButton equals('true')%
            <TR>
            	%ifvar doesCheckpointExistForThisProject equals('true')%
    					<TD class="action" colspan="3">
    						<INPUT onclick="return updateDS();" align="center" type="submit" VALUE="Add" name="submit"> 
    					</TD>
    					%else%
    					<TD class="action" colspan="3">
    						<INPUT type="submit" VALUE="Add" name="submit"> 
    					</TD>
  				  </TR>
  				 %endif%
          %endif%    
    		%endif%
      </TBODY>
    </TABLE>
    %endinvoke%
  
  </form>
  </BODY>
</HTML>
