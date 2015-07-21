<HTML><HEAD>
<TITLE>Deployer Projects</TITLE>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META http-equiv="Expires" content="-1">
<SCRIPT src="webMethods.js"></SCRIPT>
<LINK href="webMethods.css" type="text/css" rel="stylesheet">
<BODY>

<SCRIPT language=JavaScript>
function confirmDelete (proj) {

	if (confirm("OK to Delete " + proj + "?\n\nThis action is not reversible.\n")) {
		startProgressBar("Deleting Project " + proj);
		return true;
	}
	return false;
}

function confirmUnlock(user) {
	if (confirm("Do you want to unlock the project locked by "+user)) {
		startProgressBar("Unlocking Project ");
		return true;
	}
	return false;
}

</SCRIPT>

<TABLE width="100%">
	<TR>
		<TD class="menusection-Deployer" colspan="2"> Projects </TD>
	</TR>
</TABLE>

<TABLE width="100%">
%ifvar action equals('add')%
	%invoke wm.deployer.gui.UIProject:addProject%
		%include error-handler.dsp%

		%ifvar status equals('Success')%
			<!- Auto bring up properties panel for newly added Project ->
			<script>
				startProgressBar('Opening %value projectName%');
				if(is_csrf_guard_enabled && needToInsertToken) {
   					parent.propertyFrame.document.location.href = "edit-project.dsp?projectName=%value -htmlcode projectName%&mode=list&projectType=%value -htmlcode projectType%&" + _csrfTokenNm_ + "=" + _csrfTokenVal_;
				} else {
					parent.propertyFrame.document.location.href = "edit-project.dsp?projectName=%value -htmlcode projectName%&mode=list&projectType=%value -htmlcode projectType%";
				}
			</script>
		%else%
			<script> stopProgressBar(); </script>
		%endif%
	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%end if%

%ifvar action equals('copy')%
	%invoke wm.deployer.gui.UIProject:copyProject%
		%include error-handler.dsp%

		%ifvar status equals('Success')%
			<!- Auto bring up properties panel for newly added Project ->
			<script>
				startProgressBar('Opening %value targetProject%');
				if(is_csrf_guard_enabled && needToInsertToken) {
   					parent.propertyFrame.document.location.href = "edit-project.dsp?projectName=%value -htmlcode targetProject%&mode=list&projectType=%value -htmlcode projectType%&" + _csrfTokenNm_ + "=" + _csrfTokenVal_;
				} else {
					parent.propertyFrame.document.location.href = "edit-project.dsp?projectName=%value -htmlcode targetProject%&mode=list&projectType=%value -htmlcode projectType%";
				}				
			</script>
		%else%
			stopProgressBar();
		%endif%
	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%end if%

%ifvar action equals('delete')%
	%invoke wm.deployer.gui.UIProject:deleteProject%
		%include error-handler.dsp%

		<!- property may be obsolete if bundle is deleted ->
		%ifvar status equals('Success')%
			<script>parent.propertyFrame.document.location.href = "blank.html";</script>
		%end if%

	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%end if%


<!-- Lock -->
%ifvar action equals('lock')%
	%invoke wm.deployer.UIAuthorization:lockProject%
		%ifvar status equals('Success')%	
      	<script>
			if(is_csrf_guard_enabled && needToInsertToken) {
   			   parent.propertyFrame.document.location.href = "edit-project.dsp?projectName=%value -htmlcode projectName%&projectType=%value -htmlcode projectType%&mode=list&" + _csrfTokenNm_ + "=" + _csrfTokenVal_;
			} else {
			   parent.propertyFrame.document.location.href = "edit-project.dsp?projectName=%value -htmlcode projectName%&projectType=%value -htmlcode projectType%&mode=list";
			}      	
       	</script>	
		%endif%
	%end invoke%
%end if%

<!-- UnLock -->
%ifvar action equals('unlock')%
	%invoke wm.deployer.UIAuthorization:unlockProject%
		%ifvar status equals('Success')%	
      		<script>
			if(is_csrf_guard_enabled && needToInsertToken) {
   			   parent.propertyFrame.document.location.href = "edit-project.dsp?projectName=%value -htmlcode projectName%&projectType=%value -htmlcode projectType%&mode=list&" + _csrfTokenNm_ + "=" + _csrfTokenVal_;
			} else {
			   parent.propertyFrame.document.location.href = "edit-project.dsp?projectName=%value -htmlcode projectName%&projectType=%value -htmlcode projectType%&mode=list";
			}       		
      		</script>	
		%endif%	
	%end invoke%
%end if%

</TABLE>

<!- Determine if this user is empowered to project creation/copy stuff ->
%invoke wm.deployer.UIAuthorization:isAuthorized%
%endinvoke%

<TABLE width="100%">
	<TBODY>
		<TR>
			<TD colspan="2">
          <UL>
            <LI><A onclick="startProgressBar('Refreshing Project list');" href="project-list.dsp">Refresh this Page</A>
					%ifvar /isAuth equals('true')% 
            <LI><A target="propertyFrame" href="add-project.dsp">Create Project</A>
            <LI><A target="propertyFrame" href="copy-project.dsp">Copy Project</A></LI>
					%endif%
          </UL>
        </TD>
      </TR>
      <TR>
        <TD>
          <TABLE class="tableView" width="100%">
            <TBODY>
              <TR>
                <TD class="heading" colspan="6">Projects</TD>
              </TR>
              <TR>
                <TD class="oddcol-l">Name</TD>
                <TD class="oddcol-l">Description</TD>
                <TD class="oddcol">Home</TD>
                <TD class="oddcol">Lock Status</TD>                  
                <TD class="oddcol">Authorize</TD>
                <TD class="oddcol">Delete</TD>
              </TR>
        <SCRIPT>resetRows();</SCRIPT>

	%invoke wm.deployer.gui.UIProject:listProjects%
	%ifvar projects -notempty%
	%loop projects%

	%invoke wm.deployer.UIAuthorization:checkLock%
    %endinvoke%

	<TR>
		<SCRIPT>writeTD('rowdata-l');</SCRIPT>
		<A onclick="return startProgressBar('Opening %value projectName%');" target="propertyFrame" href="edit-project.dsp?projectName=%value projectName%&mode=list&projectType=%value projectType%">%value projectName%</TD>

		<SCRIPT>writeTD('row-l');</SCRIPT> %value description%</TD>

		<script> writeTD("rowdata"); </script>
		<A class="imagelink" target="new" 
			href="%value homePage%">
			<IMG alt="Home Page for Project" src="images/icon_home.gif" 
			border="0" width="16" height="16"></A></TD>

		<SCRIPT>writeTD('rowdata');</SCRIPT>
		%ifvar canUserLock equals('true')%		
			  %ifvar isLockingEnabled equals('false')%
	          <A class="imagelink" >
			   	  <IMG title="Locking Disabled" src="images/LockDisabled.gif" border="0" width="16" height="16" ></A>		    		
		   	%else%
	       %ifvar /isAuth equals('true')%
	          %ifvar isLocked equals('true')%	
	              %ifvar sameUser equals('true')%          	
	                <A class="imagelink" 
	                href="project-list.dsp?action=unlock&projectName=%value projectName -urlencode%&projectType=%value -htmlcode projectType%">
	    			     	<IMG title="Locked by you (%value lockedByUser%)" src="images/Locked.gif" border="0" width="16" height="16"></A>
	    			    %else%
	    			      <A class="imagelink" 
	                href="project-list.dsp?action=unlock&projectName=%value projectName -urlencode%&projectType=%value -htmlcode projectType%">
	    			     	<IMG title="Locked by %value lockedByUser%" src="images/Locked.gif" border="0" width="16" height="16" onclick="return confirmUnlock('%value lockedByUser%');"></A>
	    			    %endif%
	    	     %else%        		
	    			       <A class="imagelink" 
	                href="project-list.dsp?action=lock&projectName=%value projectName -urlencode%&projectType=%value -htmlcode projectType%">
	    			     	<IMG title="Open" src="images/LockOpen.gif" border="0" width="16" height="16"></A>
	      	   %endif%				
	    		%else%
	        	  %ifvar isLocked equals('true')%	
	              %ifvar sameUser equals('true')%
	                <A class="imagelink" 
	                href="project-list.dsp?action=unlock&projectName=%value projectName -urlencode%&projectType=%value -htmlcode projectType%">
	    			     	<IMG title="Locked by you (%value lockedByUser%)" src="images/Locked.gif" border="0" width="16" height="16"></A>          
	              %else%	
	                <A class="imagelink" >
	    			   	  <IMG title="Locked by %value lockedByUser%" src="images/LockDisabled.gif" border="0" width="16" height="16" ></A>
	              %endif%                    
	    	     	%else%
	    			   <A class="imagelink" 
	                  href="project-list.dsp?action=lock&projectName=%value projectName -urlencode%&projectType=%value -htmlcode projectType%">
	    			     	  <IMG title="Open" src="images/LockOpen.gif" border="0" width="16" height="16"></A>
	    	     	%endif%          		
	    		%endif%			  
			%endif%
		%else%
	          <A class="imagelink" >
			   	  <IMG title="User Not Authorized" src="images/LockDisabled.gif" border="0" width="16" height="16" ></A>		    		
		%endif%			
			
			</TD>

		<SCRIPT>writeTD('rowdata');</SCRIPT>
		%ifvar /isAuth equals('true')%
			<A class="imagelink" target="propertyFrame" href="acls.dsp?projectName=%value -htmlcode projectName%&action=getGroupsOfType&groupType=local">
				<IMG alt="Authorization settings for this Project" src="images/acldot.gif" border="0" width="16" height="16"></A>
		%else%
			<A class="imagelink">
				<IMG alt="You are not authorized" src="images/acldot_disabled.gif" border="0" width="16" height="16"></A>
		%endif%
		</TD>

		<SCRIPT>writeTD('rowdata');swapRows();</SCRIPT>
		%ifvar /isAuth equals('true')%
			<A class="imagelink" onclick="return confirmDelete('%value projectName%');"
				href="project-list.dsp?action=delete&projectName=%value projectName -urlencode%">
			<IMG alt="Delete this Project" src="images/delete.gif" border="0" width="16" height="16"></A>
		%else%
			<IMG src="images/delete_disabled.gif" border="0" width="16" height="16">
		%endif%
		</TD>

	</TR>
	%endloop projects%
	%else%
	<TR>
		<TD colspan="5"><FONT color="red">* No Projects authorized for current User.</FONT></TD>
	</TR>
	%endif%
	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%endinvoke listprojects%
   </TBODY>
</TABLE>

<script>
%ifvar action equals('add')%
%else%
	%ifvar action equals('copy')%
	%else%
		stopProgressBar();
	%endif%
%endif%
</script>
</BODY>
</HTML>
