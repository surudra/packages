<HTML><HEAD>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META http-equiv="Expires" content="-1">
<LINK href="webMethods.css" type="text/css" rel="stylesheet">
<LINK href="xtree.css" type="text/css" rel="stylesheet">
<SCRIPT src="webMethods.js"></SCRIPT>
<SCRIPT src="xtree.js"></SCRIPT>

<BODY>

<SCRIPT language=JavaScript>
function confirmDelete(map)
{
	if (confirm("OK to delete " + map + "?\n\nThis action is not reversible.")) {
		startProgressBar("Deleting Deployment Map " + map);
		return true;
	}
	return false;
}
function showOrHideDiv(divElement)
{

	divValue = document.getElementById(divElement).style.display;
	//alert('adf' + divValue);
	if (divValue == 'none')
	{
		document.getElementById(divElement).style.display = 'block';
	}
	else
	{
		document.getElementById(divElement).style.display = 'none';	
	}
}
</SCRIPT>

<TABLE width="100%">
	<TR>
		<TD class="menusection-Deployer" colspan="5"> %value projectName% %value projectType% &gt; Map
		</TD>
	</TR>

  %ifvar projectType equals('Repository')%
  	   %include navigation-bar-repository.dsp%
  %else%
    	%include navigation-bar.dsp%
	%endif%
</TABLE>

<TABLE width="100%">

<!-- Export map-->
%ifvar action equals('export')%
	%invoke wm.deployer.gui.UITarget:exportMap%
		%ifvar status equals('Success')%
			<script>writeMessage("Map File written to replicate\\outbound folder of WmDeployer Package on %sysvar host%.");</script>
			<script>window.open("projects/%value ../encodedProjName%/mapExports/%value ../encodedProjName%_%value mapSetName%.xml");</script>
		%else%
			%ifvar errorCode equals('100')%				
				<script>window.open("projects/%value ../encodedProjName%/mapExports/%value ../encodedProjName%_%value mapSetName%.xml");</script>
				%include error-handler.dsp%
			%else%
				%include error-handler.dsp%
			%endif%
		%endif%
	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%end if%

<!-- Import map-->
%ifvar action equals('import')%
	%invoke wm.deployer.gui.UITarget:importMap%
		%include error-handler.dsp%
	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%end if%
 
<!- Add MapSet -> 
%ifvar action equals('add')%
	<!- mapSetName, mapSetDescription, projectName ->
	%invoke wm.deployer.gui.UITarget:addMapSetToProject%
		%include error-handler.dsp%
		%ifvar status equals('Success')%
			<!- Clear property frame after good add ->
			<!- Auto bring up properties panel for newly added MapSet ->
        %ifvar projectType equals('Repository')%
    			<script>
    				startProgressBar("Opening Deployment Map %value mapSetName%");
					if(is_csrf_guard_enabled && needToInsertToken) {
		   			   parent.propertyFrame.document.location.href = "edit-map-repository.dsp?projectName=%value -htmlcode projectName%&mapSetName=%value -htmlcode mapSetName%&mapSetDescription=%value -htmlcode mapSetDescription%&" + _csrfTokenNm_ + "=" + _csrfTokenVal_;
					} else {
					   parent.propertyFrame.document.location.href = "edit-map-repository.dsp?projectName=%value -htmlcode projectName%&mapSetName=%value -htmlcode mapSetName%&mapSetDescription=%value -htmlcode mapSetDescription%";
					}
    			</script>
        %else%
    			<script>
    				startProgressBar("Opening Deployment Map %value mapSetName%");
					if(is_csrf_guard_enabled && needToInsertToken) {
		   			   parent.propertyFrame.document.location.href = "edit-map.dsp?projectName=%value -htmlcode projectName%&mapSetName=%value -htmlcode mapSetName%&mapSetDescription=%value -htmlcode mapSetDescription%&" + _csrfTokenNm_ + "=" + _csrfTokenVal_;
					} else {
					   parent.propertyFrame.document.location.href = "edit-map.dsp?projectName=%value -htmlcode projectName%&mapSetName=%value -htmlcode mapSetName%&mapSetDescription=%value -htmlcode mapSetDescription%";
					}
    			</script>
        %endif%

		%end if%
	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%end if%

<!- Delete MapSet -> 
%ifvar action equals('delete')%
	<!- projectName, mapSetName -> 
	%invoke wm.deployer.gui.UITarget:removeMapSetFromProject%
		%include error-handler.dsp%

		%ifvar status equals('Success')%
			<!- property may be obsolete if Map Set is deleted ->
			<script>parent.propertyFrame.document.location.href = "blank.html";</script>
		%end if%
	%onerror%
		%loop -struct%
			<TR><TD>%value $key%=%value%</TD></TR>
		%endloop%
	%end invoke%
%end if%

<!-- UnLock -->
%ifvar action equals('unlock')%
	%invoke wm.deployer.UIAuthorization:unlockProject%
			%ifvar status equals('Success')%
	      <script>parent.propertyFrame.document.location.href = "blank.html";</script>
	    %end if%
	%end invoke%
%end if%

<!-- Lock -->
%ifvar action equals('lock')%
	%invoke wm.deployer.UIAuthorization:lockProject%
			%ifvar status equals('Success')%
	      <script>parent.propertyFrame.location.href = "blank.html"</script>
	    %end if%
	%end invoke%
%end if%


</TABLE>

	%include navigation-links.dsp%
%invoke wm.deployer.UIAuthorization:checkLock%
%endinvoke%
%ifvar canUserLock equals('true')%	
  %ifvar isLockingEnabled equals('true')%
  	  %ifvar isLocked equals('true')%	
  	    %ifvar sameUser equals('true')%	
    		    Click <A onclick="return startProgressBar('Unlocking Project');" href="map-list.dsp?action=unlock&mode=&projectName=%value projectName%&projectType=%value projectType%">here</A> to unlock the project  		    
        %endif%
  	  %else%
  		    Click <A onclick="return startProgressBar('Locking Project');" href="map-list.dsp?action=lock&mode=&projectName=%value projectName%&projectType=%value projectType%">here</A> to lock the project
  
  	  %endif%
  %endif%	
%endif%

<TABLE width="100%">
	<TR>
		<TD colspan="2">
			<UL>
			%ifvar /mapAuthorized equals('true')%
				%ifvar /canBeMapped equals('true')%
				<LI><A target="propertyFrame" href="add-map.dsp?projectName=%value -htmlcode projectName%&projectType=%value -htmlcode projectType%"">Create Deployment Map</A></LI>
				%else%
				<LI><A href="javascript:void();" onclick="alert('This Project has no Deployment Sets.  Cannot create Deployment Map.'); return false;">Create Deployment Map</A></LI>
				%endif%
			%endif%

        <LI><A onclick="startProgressBar('Refreshing Deployment Map list');" href="map-list.dsp?projectName=%value projectName%&projectType=%value projectType%">Refresh this Page</A>
        <LI><a target="propertyFrame" href="edit-project.dsp?projectName=%value -htmlcode projectName%&mode=project">Project Properties</a>
		%ifvar /mapAuthorized equals('true')%                
        	<LI><a href="javascript:showOrHideDiv('mapContainer')">Import Map</a>
        %endif%
		<p>
		<form name="mapform" action="map-list.dsp">
		   <INPUT type="hidden" value="%value projectName%" name="projectName">
       <INPUT type="hidden" value="%value projectType%" name="projectType">					   
       <INPUT type="hidden" VALUE="import" name="action">

		<div id="mapContainer" style="display:none">

	%invoke wm.deployer.gui.UITarget:listMapsToImport%
		%ifvar importMaps -notempty%
		<select name="importFileName">
				%loop importMaps%
					<option value="%value%">%value%</option>
				%end loop%		
		</select>
		<input type="submit" value="Import Map">
		%else%
				<font color="red">* No Maps to import (*.map)</font>
		%endif%
	%end invoke%
		</div>
		</form>
		</p>
		

			</UL>
		</TD>
	</TR>

	<TR>
		<TD><IMG height="10" src="images/blank.gif" width="5"></TD>
		<TD>
			<TABLE class="tableView" width="100%">
				<TR>
					<TD class="heading" colspan="5">Deployment Maps</TD>
				</TR>
                              %invoke wm.deployer.gui.UITarget:listProjectMapSets%
				<TR>
					<TD class="oddcol">Name</TD>
					<TD class="oddcol">Description</TD>					
					 %ifvar ../projectType equals('Repository')%
					    <TD class="oddcol">Configure</TD> 
					 %endif%
					<TD class="oddcol">Export</TD>
					<TD class="oddcol">Delete</TD>
				</TR>

				<!- projectName ->
				
				%ifvar mapSets -notempty%
				%loop mapSets%
				<TR>
					<!- MapSet Name ->
          <SCRIPT>writeTD('rowdata-l');</SCRIPT> 
          %ifvar ../projectType equals('Repository')%
             <A onclick="startProgressBar('Opening %value mapSetName%');" target="propertyFrame" href="edit-map-repository.dsp?projectName=%value ../projectName%&mapSetName=%value mapSetName%&mapSetDescription=%value mapSetDescription%">%value mapSetName%</A></TD>
          %else%
					<A onclick="startProgressBar('Opening %value mapSetName%');" target="propertyFrame" href="edit-map.dsp?projectName=%value ../projectName%&mapSetName=%value mapSetName%&mapSetDescription=%value mapSetDescription%">%value mapSetName%</A></TD>
          %endif%
					<!- Description ->
					<SCRIPT>writeTD('rowdata', "ID='desc_%value -htmlcode mapSetName%'");</SCRIPT> %value mapSetDescription%																					
					
					<!- Configure ->	
					%ifvar ../projectType equals('Repository')%
					<SCRIPT>writeTD("rowdata");</SCRIPT> 										
					%ifvar /mapAuthorized equals('true')%	
						<A href="varsub-manager.dsp?projectName=%value -htmlcode ../projectName%&mapSetName=%value -htmlcode mapSetName%&mapSetDescription=%value -htmlcode mapSetDescription%" target="_blank">
							<IMG alt="Configure this Map" src="images/configureTargets.gif" border="no" width="24" height="24"></A></TD>
					%else%
							<IMG src="images/configureTargets.gif" border="no" width="16" height="16"></TD>
					%endif%
					%endif%
					<SCRIPT>swapRows();</SCRIPT>
				
					<!-- Export -->
					<form name="mapform2" action="map-list.dsp">
					   <INPUT type="hidden" value="%value ../projectName%" name="projectName">
             <INPUT type="hidden" value="%value ../projectType%" name="projectType">					   
					   <INPUT type="hidden" value="%value mapSetName%" name="mapSetName">
					   <INPUT type="hidden" VALUE="export" name="action">
					   %ifvar /mapAuthorized equals('true')%
							<SCRIPT>writeTD('rowdata', "ID='export_%value -htmlcode mapSetName%'");</SCRIPT><input type="image" ID="img_exp_%value -htmlcode mapSetName%" alt="Export this map" src="images/btn_export.gif" border="0" >
						%else%						
							<SCRIPT>writeTD('rowdata', "ID='export_%value -htmlcode mapSetName%'");</SCRIPT><IMG src="images/btn_export_disabled.gif" border="0"  width="16" height="16">
						%endif%						
						</TD>	
					</form>

					<!- Delete ->
					<SCRIPT>writeTD("rowdata");</SCRIPT> 
					%ifvar /mapAuthorized equals('true')%
						<A onclick="return confirmDelete('%value mapSetName%');"
							href="map-list.dsp?action=delete&projectName=%value -htmlcode ../projectName%&projectType=%value -htmlcode ../projectType%&mapSetName=%value -htmlcode mapSetName%">
							<IMG alt="Delete this Map" src="images/delete.gif" border="no" width="16" height="16"></A></TD>
					%else%
							<IMG src="images/delete_disabled.gif" border="no" width="16" height="16"></TD>
					%endif%
					<SCRIPT>swapRows();</SCRIPT>
				</TR>
	%endloop maps%
	%else%
				<TR>
					<TD colspan=3><FONT color="red"> * No Deployment Maps </FONT> </TD>
				</TR>
	%endif%

			</TABLE>
		</TD>
	</TR>
</TABLE>
<script>
	%ifvar action equals('add')%
	%else%
		stopProgressBar();
	%endif%
</script> 
</BODY>
</HTML>
