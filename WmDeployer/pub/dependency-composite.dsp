<HTML><HEAD><TITLE>Bundle Dependencies</TITLE>
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META http-equiv=Pragma content=no-cache>
<META http-equiv=Expires content=-1>
<LINK href="webMethods.css" type="text/css" rel="stylesheet">
<LINK href="xtree.css" type="text/css" rel="stylesheet">
<SCRIPT src="webMethods.js"></SCRIPT>
<SCRIPT src="treetable.js"></SCRIPT>
<SCRIPT src="xtree.js"></SCRIPT>
</HEAD>

<BODY>
<SCRIPT>
function onAutoResolveFull() {
	document.autoResolveForm.action.value = "autoResolve";
	document.autoResolveForm.projectName.value = "%value projectName%";
	document.autoResolveForm.bundleName.value = "%value bundleName%";
	document.autoResolveForm.bundleType.value = "%value bundleType%";
	document.autoResolveForm.autoResolve.value = "full";
        document.autoResolveForm.submit();
}
function onAutoResolvePartial() {
	document.autoResolveForm.action.value = "autoResolve";
	document.autoResolveForm.projectName.value = "%value projectName%";
	document.autoResolveForm.bundleName.value = "%value bundleName%";
	document.autoResolveForm.bundleType.value = "%value bundleType%";
	document.autoResolveForm.autoResolve.value = "partial";
        document.autoResolveForm.submit();
}
function ignoreMissingDependenciesFun(){
	document.dependencyform.action.value = "updateignoreMissingDependencies";
	if(document.dependencyform.ignoreMissingDependenciesRadio.checked)
		document.dependencyform.ignoreMissingDependencies.value = "true";
	else
		document.dependencyform.ignoreMissingDependencies.value = "false";
	document.dependencyform.submit();
}
</SCRIPT>

<TABLE width="100%">
  <TBODY>
  <TR>
    <TD class=menusection-Deployer>%value bundleName% > Unresolved Dependencies</TD>
  </TR>
  
 
  </TBODY>
</TABLE>
<ul>
      <li><A onclick="return startProgressBar('Refreshing Dependencies');" href="dependency-composite.dsp?projectName=%value projectName%&bundleName=%value bundleName%&bundleType=%value bundleType%&projectType=%value projectType%">Refresh this Page</A></li>
      <li><A id="autoResolveFull" onclick="return startProgressBar('Refreshing Dependencies');" href="dependency-composite.dsp?projectName=%value projectName%&bundleName=%value bundleName%&bundleType=%value bundleType%&action=autoResolve&autoResolve=full&projectType=%value projectType%">Auto resolve by Composite</A></li>
      <li><A id="autoResolvePartial" onclick="return startProgressBar('Refreshing Dependencies');" href="dependency-composite.dsp?projectName=%value projectName%&bundleName=%value bundleName%&bundleType=%value bundleType%&action=autoResolve&autoResolve=partial&projectType=%value projectType%">Auto resolve by Asset</A></li>
      </UL>

<!- Results from Submit ->
<TABLE>
%ifvar action equals('save')%
	<!- projectName, bundleName and tag-value pairs from treetable ->
	%invoke wm.deployer.gui.UIDependency:resolveBundleDependenciesFromComposite%
		%include error-handler.dsp%

		<!- refresh project tree in left frame ->
		%ifvar status equals('Success')%
		<script>
			startProgressBar("Displaying new Project definition");
			if(is_csrf_guard_enabled && needToInsertToken) {
   			   parent.treeFrame.document.location.href = "bundle-list.dsp?projectName=%value -htmlcode projectName%&projectType=%value -htmlcode projectType%&" + _csrfTokenNm_ + "=" + _csrfTokenVal_;
			} else {
			   parent.treeFrame.document.location.href = "bundle-list.dsp?projectName=%value -htmlcode projectName%&projectType=%value -htmlcode projectType%";
			}			
			var saveOK = true;
		</script>
		%else%
			<script>var saveOK = false;</script>
		%endif%

	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%endinvoke%
%endif%

%ifvar action equals('updateignoreMissingDependencies')%
	<!- projectName ->
	%invoke wm.deployer.gui.UIProject:updateIgnoreMissingDependendcyProjectProperty%
		%include error-handler.dsp%

	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%endinvoke%
%endif%

%ifvar action equals('autoResolve')%
	<!- projectName, bundleName and tag-value pairs from treetable ->
	%invoke wm.deployer.gui.UIDependency:autoResolveBundleDependenciesFromComposite%
		%include error-handler.dsp%

		<!- refresh project tree in left frame ->
		%ifvar status equals('Success')%
		<script>
			startProgressBar("Displaying new Project definition");
			if(is_csrf_guard_enabled && needToInsertToken) {
   			   parent.treeFrame.document.location.href = "bundle-list.dsp?projectName=%value -htmlcode projectName%&projectType=%value -htmlcode projectType%&" + _csrfTokenNm_ + "=" + _csrfTokenVal_;
			} else {
			   parent.treeFrame.document.location.href = "bundle-list.dsp?projectName=%value -htmlcode projectName%&projectType=%value -htmlcode projectType%";
			}			
			var saveOK = true;
		</script>
		<TABLE class="tableView" width="100%">
      <TR>
        <TD class="heading" colspan="1" valign="top"> Auto Resolved Dependencies</TD>
      </TR>
      %loop messages%   
        <TR>
            <TD class="rowdata" align="left"> %value -htmlcode message%</TD>
        </TR> 
				<SCRIPT>swapRows();</SCRIPT>             
      %endloop messages%		
    </TABLE>
		%else%
			<script>var saveOK = false;</script>
		%endif%

	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%endinvoke%
%endif%
</TABLE>



%invoke wm.deployer.gui.UIProject:getProjectInfo%

<! ------------------ Definition of the Main Table.  3 Columns ->

<TABLE class="tableForm" align="center" width="98%">
  <TBODY>
    
	<form name="dependencyform" id="dependencyform" method="POST" action="dependency-composite.dsp">
	<!- Submit Button, placed at top for convenience ->
		<INPUT type="hidden" name="projectName" value="%value projectName%">
		<INPUT type="hidden" name="projectType" value="%value projectType%">		
		<INPUT type="hidden" name="bundleName" value="%value bundleName%">
		<INPUT type="hidden" name="bundleType" value="%value bundleType%">
		<INPUT type="hidden" name="action" value="save">
    <INPUT type="hidden" name="test" value="Test">  

	<!- ../projectName, bundleName* ->
%rename ../projectName projectName -copy%
<script>var dependenciesExist = 'false'; </script>
%invoke wm.deployer.gui.UIDependency:getUnresolvedBundleDependenciesFromComposite%

	%include error-handler.dsp%

	<!- ................ Begin Dependency (Composite) Loop ................ ->
	<script> resetRows();</script>
%loop dependencies1%       
	<script>swapRows();</script>	
	
   %ifvar conflictDependencies -notempty%
             <TR><TD colspan="3"><FONT color="blue"><b> There are components with conflict dependencies. </b></FONT></TD></TR>
    %endif% 
   %ifvar dependencies -notempty%     
        <TR>
          <TD class="heading" colspan="3" valign="top"> Unresolved Dependencies</TD>
        </TR>
	
      	%ifvar /defineAuthorized equals('true')%
      	<TR>
      		<TD class="action" colspan="3">
      			<INPUT onclick="return startProgressBar('Updating Dependencies');" align="center" 
      			type="submit" VALUE="Save" name="submit"> </TD>
      	</TR>
      	%endif%      
      
        <TR>
          <TD class="oddcol-l" nowrap>Referenced Asset Composites</TD>
          <TD class="oddcol" nowrap>Unset/Add/Ignore</TD>
          <TD class="oddcol" nowrap>Assets</TD>
        </TR>		
  		
  	%else%
		%ifvar conflictDependencies -notempty%
                        
		  %else%
			<TR><TD class="heading" colspan="3" valign="top"> Unresolved Dependencies</TD></TR>
			<TR><TD colspan="3"><FONT color="green"><b> Deployment Set has no unresolved dependencies. </b></FONT></TD></TR>
			<script>
			document.getElementById("autoResolveFull").disabled = "true";
			document.getElementById("autoResolveFull").removeAttribute("href");
			document.getElementById("autoResolvePartial").disabled = "true";
			document.getElementById("autoResolvePartial").removeAttribute("href");
				// update Dependency Icon on left-frame to avoid expensive page refreshing
				parent.treeFrame.document.all["img_%value bundleName -urlencode%"].src = "images/green_check.gif";
			</script>
	%endif%	
      %endif%		
    
  %ifvar dependencies -notempty%
  	<script>var dependenciesExist = 'true'; </script>
	%loop dependencies%   
            <script>
		 var sName = "%value ../serverAliasName -urlencode%%value dependentCompositeName -urlencode%%value logicalServer -urlencode%";
		// Initialize this current instance of package
		var compositeName = sName;
		composites[compositeName] = ["placeholder"];
		composites[compositeName].length = 0;                      	   	 
            </script>         
             <tr>
		<script>writeTD("row-l", "nowrap valign=\"top\"");</script>
		<img align=absmiddle border="0" src="images/blank.gif" width="0" height="15">
		<img align=absmiddle hspace=0 border="0" src="images/tree_minus.gif" 
			style="cursor: hand;" id="tree_%value ../serverAliasName -urlencode%%value dependentCompositeName -urlencode%%value logicalServer -urlencode%" 
			onclick="toggleComposite('%value ../serverAliasName -urlencode%%value dependentCompositeName -urlencode%%value logicalServer -urlencode%');" width="9" height="9">

			<img align=absmiddle border="0" src="images/composite.png" 
				align="absmiddle"> %value ../serverAliasName%:%value dependentCompositeName% %ifvar logicalServer -notempty% <b> ( %value logicalServer% )</b> %endif%  </td>
				
                               <script>writeTD("rowdata", "nowrap valign=\"top\"")</script> 
				<INPUT type=radio 
					ID="%value ../serverAliasName -urlencode%%value dependentCompositeName -urlencode%%value logicalServer -urlencode%" 
					NAME="%value ../serverAliasName -urlencode%$%value dependentCompositeName -urlencode%$%value logicalServer -urlencode%$%value dependentCompositeType%" 
					onclick="setCompositeChildren('UNSET', this, '%value isPartialDeploymentValid%');"
					CHECKED
				%ifvar /defineAuthorized equals('false')% DISABLED %endif%>&nbsp;


				<INPUT type=radio 
					ID="%value ../serverAliasName -urlencode%%value dependentCompositeName -urlencode%%value logicalServer -urlencode%" 
					NAME="%value ../serverAliasName -urlencode%$%value dependentCompositeName -urlencode%$%value logicalServer -urlencode%$%value dependentCompositeType%" 

					VALUE="DEPENDENCY_PKG_ADD"
					onclick="setCompositeChildren('ADD', this, '%value isPartialDeploymentValid%');"

				%ifvar /defineAuthorized equals('false')% DISABLED %else% %ifvar dependentCompositeName matches('Wm*')% DISABLED %endif% %ifvar logicalServer -notempty% %ifvar dependentCompositeType equals('MWS')% %else% %ifvar dependentCompositeType equals('RULES')% %else% DISABLED %endif% %endif% %endif% %endif%>&nbsp;

				<INPUT type=radio 
					ID="%value ../serverAliasName -urlencode%%value dependentCompositeName -urlencode%%value logicalServer -urlencode%" 
					NAME="%value ../serverAliasName -urlencode%$%value dependentCompositeName -urlencode%$%value logicalServer -urlencode%$%value dependentCompositeType%" 

					onclick="setCompositeChildren('IGNORE', this, '%value isPartialDeploymentValid%');"

				%ifvar /defineAuthorized equals('false')% DISABLED %endif%>&nbsp;
		  </TD>
		<script>writeTD("rowdata", "nowrap valign=\"top\"");</script></td>
             </tr>                        					
                                                                                    				
  	     %loop dependentComponents%	  
                    %ifvar dependentComponentName -notempty%			                        			                            
                            <script>
				// Append the Component Name to the current Package array  - increments length implicitly
				var rName = "%value dependentComponentDisplayName -urlencode%";
				composites[compositeName][composites[compositeName].length] = rName;				
                        	</script>
                        
				<tr id="resource_%value ../../serverAliasName -urlencode%%value ../dependentCompositeName -urlencode%%value ../logicalServer -urlencode%%value dependentComponentDisplayName -urlencode%">
					
					<!- Column 1 ->
					<script>writeTD("row-l", "nowrap valign=\"top\"");</script>
						<img align=absmiddle src="images/blank.gif" width="30" height="1">
						<script>
							var icon = getACDLIcon("%value dependentComponentType%");
						w("<img align=absmiddle src='" + icon + "'>");
						</script>
						%value dependentComponentDisplayName% (%value dependentComponentType%)</td>
	
					<!- Column 2, Checkbox  The NAME:VALUE for this box must agree with Service pipeline ->
					<script>writeTD("rowdata", "nowrap valign=\"top\"")</script> 
						<INPUT type=radio 
							id="UNSET%value ../../serverAliasName -urlencode%%value ../dependentCompositeName -urlencode%%value ../logicalServer -urlencode%%value dependentComponentDisplayName -urlencode%"
							name="%value ../../serverAliasName -urlencode%$%value ../dependentCompositeName -urlencode%$%value ../logicalServer -urlencode%$%value dependentCompositeType%$%value dependentComponentId -urlencode%$%value dependentComponentDisplayName -urlencode%$%value dependentComponentType%" value="DEPENDENCY_UNSET"
						%ifvar /defineAuthorized equals('false')% DISABLED %else% %ifvar ../isPartialDeploymentValid equals('false')% DISABLED %else% CHECKED %endif%%endif%>&nbsp;
						<INPUT type=radio 
							id="ADD%value ../../serverAliasName -urlencode%%value ../dependentCompositeName -urlencode%%value ../logicalServer -urlencode%%value dependentComponentDisplayName -urlencode%"
							name="%value ../../serverAliasName -urlencode%$%value ../dependentCompositeName -urlencode%$%value ../logicalServer -urlencode%$%value dependentCompositeType%$%value dependentComponentId -urlencode%$%value dependentComponentDisplayName -urlencode%$%value dependentComponentType%" value="DEPENDENCY_ADD"
						%ifvar /defineAuthorized equals('false')% DISABLED %else% %ifvar referencedComponentManualType equals('true')% DISABLED %else% %ifvar dependentComponentName matches('system/*')% DISABLED %endif% %else% %ifvar referencedComponentName matches('LDAP/*')% DISABLED %endif% %else% %ifvar ../isPartialDeploymentValid equals('false')% DISABLED %endif%%endif%>&nbsp;
						<INPUT type=radio 
							id="IGNORE%value ../../serverAliasName -urlencode%%value ../dependentCompositeName -urlencode%%value ../logicalServer -urlencode%%value dependentComponentDisplayName -urlencode%"
							name="%value ../../serverAliasName -urlencode%$%value ../dependentCompositeName -urlencode%$%value ../logicalServer -urlencode%$%value dependentCompositeType%$%value dependentComponentId -urlencode%$%value dependentComponentDisplayName -urlencode%$%value dependentComponentType%" value="DEPENDENCY_IGNORE"
						%ifvar /defineAuthorized equals('false')% DISABLED %else% %ifvar ../isPartialDeploymentValid equals('false')% DISABLED %endif%%endif%>&nbsp;
					   </TD>

					   <script>writeTD("row-l", "nowrap valign=\"top\"");</script>	
					   %loop bundledComponents%
						<!- Column 3: The Dependency Tree ->                        				
						
							<img align=absmiddle src="images/blank.gif" width="30" height="1">                        					
							<script>
								var icon = getACDLIcon("%value refComponentType%");
							w("<img align=absmiddle src='" + icon + "'>");
							</script>
							%value refComponentDisplayName% (%value refComponentType%)	</br>						
					  %endloop bundledComponents%
					  </td>
				   </tr>
                      		   <script> numPackages++; </script>  
                        %endif%                                       		
  	     %endloop dependentComponents%
	%endloop dependencies%    
  %endif%   
%endloop dependencies1%
%endinvoke%  

%invoke wm.deployer.gui.UIDependency:getUnresolvedBundleDependenciesFromComposite%
%loop dependencies1%
   
  %ifvar conflictDependencies -notempty%
  	<script>var dependenciesExist = 'true'; </script>
	%ifvar /defineAuthorized equals('true')%
		%ifvar dependencies -notempty%
		%else%
			%ifvar conflictDependencies -notempty%
			<TR>
				<TD class="action" colspan="3">
					<INPUT onclick="return startProgressBar('Updating Dependencies');" align="center" type="submit" VALUE="Save" name="submit3"> 
				</TD>
			</TR>
			%endif%
		%endif%
	%endif%
	 <TR>
          <TD class="oddcol-l" nowrap>Referenced Conflict Asset Composites</TD>
          <TD class="oddcol" nowrap>Unset/Add/Ignore</TD>
          <TD class="oddcol" nowrap>Assets</TD>
        </TR>	
   %endif%
  %ifvar conflictDependencies -notempty%
  	<script>var dependenciesExist = 'true'; </script>
	%loop conflictDependencies%   
            <script>
		 var sName = "%value ../serverAliasName -urlencode%%value dependentCompositeName -urlencode%_%value ../../conflictSuffix -urlencode%%value logicalServer -urlencode%";
		// Initialize this current instance of package
		var compositeName = sName;
		composites[compositeName] = ["placeholder"];
		composites[compositeName].length = 0;                      	   	 
            </script>         
             <tr>
		<script>writeTD("row-l", "nowrap valign=\"top\"");</script>
		<img align=absmiddle border="0" src="images/blank.gif" width="0" height="15">
		<img align=absmiddle hspace=0 border="0" src="images/tree_minus.gif" 
			style="cursor: hand;" id="tree_%value ../serverAliasName -urlencode%%value dependentCompositeName -urlencode%_%value ../../conflictSuffix -urlencode%%value logicalServer -urlencode%" 
			onclick="toggleComposite('%value ../serverAliasName -urlencode%%value dependentCompositeName -urlencode%%value logicalServer -urlencode%');" width="9" height="9">

			<img align=absmiddle border="0" src="images/composite.png" 
				align="absmiddle"> %value ../serverAliasName%:%value dependentCompositeName% %ifvar logicalServer -notempty% <b> ( %value logicalServer% )</b> %endif%  </td>
				
                               <script>writeTD("rowdata", "nowrap valign=\"top\"")</script> 
				<INPUT type=radio 
					ID="%value ../serverAliasName -urlencode%%value dependentCompositeName -urlencode%_%value ../../conflictSuffix -urlencode%%value logicalServer -urlencode%" 
					NAME="%value ../serverAliasName -urlencode%$%value dependentCompositeName -urlencode%$%value logicalServer urlencode%$%value dependentCompositeType%" 
					onclick="setCompositeChildren('UNSET', this, '%value ../isPartialDeploymentValid%');"
					CHECKED
				%ifvar /defineAuthorized equals('false')% DISABLED %endif%>&nbsp;


				<INPUT type=radio 
					ID="%value ../serverAliasName -urlencode%%value dependentCompositeName -urlencode%_%value ../../conflictSuffix -urlencode%%value logicalServer -urlencode%" 
					NAME="%value ../serverAliasName -urlencode%$%value dependentCompositeName -urlencode%$%value logicalServer -urlencode%$%value dependentCompositeType%" 

					VALUE="DEPENDENCY_PKG_ADD"
					onclick="setCompositeChildren('ADD', this, '%value ../isPartialDeploymentValid%');"

				%ifvar /defineAuthorized equals('false')% DISABLED %else% %ifvar dependentCompositeName matches('Wm*')% DISABLED %endif% %ifvar logicalServer -notempty% %ifvar dependentCompositeType equals('MWS')% %else% %ifvar dependentCompositeType equals('RULES')% %else% DISABLED %endif% %endif% %endif% %endif%>&nbsp;

				<INPUT type=radio 
					ID="%value ../serverAliasName -urlencode%%value dependentCompositeName -urlencode%_%value ../../conflictSuffix -urlencode%%value logicalServer -urlencode%" 
					NAME="%value ../serverAliasName -urlencode%$%value dependentCompositeName -urlencode%$%value logicalServer -urlencode%$%value dependentCompositeType%" 

					onclick="setCompositeChildren('IGNORE', this, '%value ../isPartialDeploymentValid%');"

				%ifvar /defineAuthorized equals('false')% DISABLED %endif%>&nbsp;
		  </TD>
		<script>writeTD("rowdata", "nowrap valign=\"top\"");</script></td>
             </tr>                        					
                                                                                    				
  	     %loop conflictDependentComponents%	  
                    %ifvar dependentComponentName -notempty%			                        			                            
                               <script>
				// Append the Component Name to the current Package array  - increments length implicitly
				var rName = "%value dependentComponentDisplayName -urlencode%";
				composites[compositeName][composites[compositeName].length] = rName;
                        	</script>
                        
				<tr id="resource_%value ../../serverAliasName -urlencode%%value ../dependentCompositeName -urlencode%%value ../logicalServer -urlencode%%value dependentComponentDisplayName -urlencode%">
					
					<!- Column 1 ->
					<script>writeTD("row-l", "nowrap valign=\"top\"");</script>
						<img align=absmiddle src="images/blank.gif" width="30" height="1">
						<script>
							var icon = getACDLIcon("%value dependentComponentType%");
						w("<img align=absmiddle src='" + icon + "'>");
						</script>
						%value dependentComponentDisplayName% (%value dependentComponentType%)</td>
	
					<!- Column 2, Checkbox  The NAME:VALUE for this box must agree with Service pipeline ->
					<script>writeTD("rowdata", "nowrap valign=\"top\"")</script> 
						<INPUT type=radio 
							id="UNSET%value ../../serverAliasName -urlencode%%value ../dependentCompositeName -urlencode%_%value ../../../conflictSuffix -urlencode%%value ../logicalServer -urlencode%%value dependentComponentDisplayName -urlencode%"
							name="%value ../../serverAliasName -urlencode%$%value ../dependentCompositeName -urlencode%$%value ../logicalServer -urlencode%$%value dependentCompositeType%$%value dependentComponentId -urlencode%$%value dependentComponentDisplayName -urlencode%$%value dependentComponentType%" value="DEPENDENCY_UNSET" CHECKED
						%ifvar /defineAuthorized equals('false')% DISABLED %endif%>&nbsp;
						<INPUT type=radio 
							id="ADD%value ../../serverAliasName -urlencode%%value ../dependentCompositeName -urlencode%_%value ../../../conflictSuffix -urlencode%%value ../logicalServer -urlencode%%value dependentComponentDisplayName -urlencode%"
							name="%value ../../serverAliasName -urlencode%$%value ../dependentCompositeName -urlencode%$%value ../logicalServer -urlencode%$%value dependentCompositeType%$%value dependentComponentId -urlencode%$%value dependentComponentDisplayName -urlencode%$%value dependentComponentType%" value="DEPENDENCY_ADD"
						%ifvar /defineAuthorized equals('false')% DISABLED %else% %ifvar referencedComponentManualType equals('true')% DISABLED %else% %ifvar dependentComponentName matches('system/*')% DISABLED %endif% %else% %ifvar referencedComponentName matches('LDAP/*')% DISABLED %endif% %else% %ifvar ../isPartialDeploymentValid equals('false')% DISABLED %endif%%endif%>&nbsp;
						<INPUT type=radio 
							id="IGNORE%value ../../serverAliasName -urlencode%%value ../dependentCompositeName -urlencode%_%value ../../../conflictSuffix -urlencode%%value ../logicalServer -urlencode%%value dependentComponentDisplayName -urlencode%"
							name="%value ../../serverAliasName -urlencode%$%value ../dependentCompositeName -urlencode%$%value ../logicalServer -urlencode%$%value dependentCompositeType%$%value dependentComponentId -urlencode%$%value dependentComponentDisplayName -urlencode%$%value dependentComponentType%" value="DEPENDENCY_IGNORE"
						%ifvar /defineAuthorized equals('false')% DISABLED %endif%>&nbsp;
					   </TD>
	                                   <script>writeTD("row-l", "nowrap valign=\"top\"");</script>
					   %loop bundledComponents%
						<!- Column 3: The Dependency Tree ->                        				
						
							<img align=absmiddle src="images/blank.gif" width="30" height="1">                        					
							<script>
								var icon = getACDLIcon("%value refComponentType%");
							w("<img align=absmiddle src='" + icon + "'>");
							</script>
							%value refComponentDisplayName% (%value refComponentType%)</br>						
					  %endloop bundledComponents%
					  </td>	
				   </tr>                      		     
                    %endif%                                       		
  	     %endloop conflictDependentComponents%
	%endloop conflictDependencies%    
  %endif%   	
%endloop dependencies1%
%endinvoke% 

%invoke wm.deployer.gui.UIDependency:getUnresolvedBundleDependenciesFromComposite%
 			 
%loop dependencies1% 		
		<!- Submit Button, placed on bottom for convenience ->
        	%ifvar /defineAuthorized equals('true')%
			%ifvar dependencies -notempty%
			<TR>
				<TD class="action" colspan="3">
					<INPUT onclick="return startProgressBar('Updating Dependencies');" align="center" type="submit" VALUE="Save" name="submit2"> 
				</TD>
			</TR>
			%else%
				%ifvar conflictDependencies -notempty%
				<TR>
					<TD class="action" colspan="3">
						<INPUT onclick="return startProgressBar('Updating Dependencies');" align="center" type="submit" VALUE="Save" name="submit2"> 
					</TD>
				</TR>
				%endif%
			%endif%
		%endif%		                       
			%ifvar missingDependencies -notempty%
			  	%ifvar /ignoreMissingDependencies equals('true')%
				%else%
					<script>var dependenciesExist = 'true'; </script>
				%endif%

				
				
  		      <TR>

              <TD class="heading" colspan="3" valign="top" width="100%"> Missing Dependencies</TD>
            </TR>

	    <INPUT type="hidden" name="projectName" value="%value projectName%">
				<INPUT type="hidden" name="ignoreMissingDependencies" value="%value ignoreMissingDependencies %">
				<INPUT type="hidden" name="bundleName" value="%value bundleName%">
				<INPUT type="hidden" name="bundleType" value="%value bundleType%">
				<TR>	
					
					<script>writeTD("row-l", "nowrap colspan=3 valign=\"top\"");</script> 
						%ifvar /defineAuthorized equals('true')%					
							<INPUT type="checkbox" name="ignoreMissingDependenciesRadio" value="true" %ifvar /ignoreMissingDependencies equals('true')% checked %endif%>
						%else%
							%ifvar /ignoreMissingDependencies equals('true')% 
								Yes
							%else% 
								No
							%endif%							
						%endif%
						&nbsp;<b>Ignore Missing Dependencies (Project Level)</b>&nbsp;&nbsp;&nbsp;<input type="submit" value="Apply" onclick="ignoreMissingDependenciesFun();">
					</TD>
				</TR>
 
            <TR>
              <TD class="oddcol" nowrap>Missing Assets</TD>
              <TD class="oddcol" nowrap>Runtime</TD>              
              <TD class="oddcol" nowrap>Assets</TD>
            </TR>	
  			%loop missingDependencies%
  					<script>swapRows();</script>
                      <tr>
                        	<script>writeTD("row-l", "nowrap valign=\"top\"");</script>
                        					<img align=absmiddle src="images/blank.gif" width="30" height="1">
                        					<script>
                        					w("<img align=absmiddle src='" + images/component.gif + "'>");
                        					</script> %value missingComponentName%</td>
				
				
                    			<script>writeTD("row-l", "nowrap valign=\"top\" ");</script>
                        			   	%value missingComponentRuntimeType%</td>                          					
         
                    			<script>writeTD("row-l", "nowrap valign=\"top\"");</script>
                        					<img align=absmiddle src="images/blank.gif" width="30" height="1">
                        					<script>
                        					w("<img align=absmiddle src='" + images/component.gif + "'>");
                        					</script>
                        					%value bundledComponentName%</td>               					
        %endloop missingDependencies%
      %endif%        
  %endloop dependencies1%              

%endinvoke%    
  
  	<script>
      if(dependenciesExist == 'true') {
    		// update Dependency Icon on left-frame to avoid expensive page refreshing
    		parent.treeFrame.document.all["img_%value bundleName -urlencode%"].src = "images/dependency.gif";
    	}
    	else  {
           		parent.treeFrame.document.all["img_%value bundleName -urlencode%"].src = "images/green_check.gif";
      }
  	</script>
    


	</FORM>
	
	<FORM name="autoResolveForm" method="POST" action="dependency-composite.dsp">
		<INPUT type="hidden" name="projectName" value="%value projectName%">
		<INPUT type="hidden" name="projectType" value="%value projectType%">				
		<INPUT type="hidden" name="bundleName" value="%value bundleName%">
		<INPUT type="hidden" name="bundleType" value="%value bundleType%">	
		<INPUT type="hidden" name="autoResolve" value="%value autoResolve%">
		<INPUT type="hidden" name="action" value="save">
    <INPUT type="hidden" name="test1" value="Test">  
	
	</FORM>
	</TBODY>
</TABLE>

%endinvoke%

<script> 
// Stop Progress bar after refresh unless a left-frame refresh is underway
%ifvar action equals('save')%
	if (saveOK == false) 
		stopProgressBar();
%else%
	stopProgressBar();
%end if%
</script> 

</BODY></HTML>
