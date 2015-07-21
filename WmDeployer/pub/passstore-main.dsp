<HTML><HEAD>
<TITLE>Deployer Projects</TITLE>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META http-equiv="Expires" content="-1">
<SCRIPT src="webMethods.js"></SCRIPT>
<LINK href="webMethods.css" type="text/css" rel="stylesheet">
<BODY>

<SCRIPT language=JavaScript>
function confirmDelete (pwdHandle) {

	if (confirm("OK to Delete " + pwdHandle + "?\n\nThis action is not reversible.\n")) {
		startProgressBar("Deleting Password Handle " + pwdHandle);
		return true;
	}
	return false;
}

</SCRIPT>

<TABLE width="100%">
	<TR>
		<TD class="menusection-Deployer" colspan="2"> Password Store </TD>
	</TR>
</TABLE>

<TABLE width="100%">
%ifvar action equals('add')%
	%invoke wm.deployer.UIAuthorization:storePassword%
		%include error-handler.dsp%

		%ifvar status equals('Success')%
			<script>parent.propertyFrame.document.location.href = "blank.html";</script>
		%else%
			<script> stopProgressBar(); </script>
		%endif%
		
		%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%end if%

%ifvar action equals('delete')%
	%invoke wm.deployer.UIAuthorization:deletePassword%
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

%ifvar action equals('update')%
	%invoke wm.deployer.UIAuthorization:updatePassword%
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

</TABLE>

%invoke wm.deployer.UIAuthorization:isAuthorized%
%endinvoke%

<TABLE width="100%">
	%ifvar /isAuth equals('true')%
	<TBODY>
		<TR>
		 <TD colspan="2">
          <UL>            
            <LI><A onclick="startProgressBar('Refreshing Password Handle list');" href="passstore-main.dsp">Refresh this Page</A>
            <LI><A target="propertyFrame" href="create-passstore.dsp">Create Password Store Entry</A>
          </UL>
        </TD>
      </TR>
      <TR>
        <TD>
          <TABLE class="tableView" width="100%">
            <TBODY>
              <TR>
                <TD class="heading" colspan="6">Password Store Entries</TD>
              </TR>
              <TR>
                <TD class="oddcol-l">Handle Name</TD>
                <TD class="oddcol">Delete</TD>
              </TR>
        <SCRIPT>resetRows();</SCRIPT>

		%invoke wm.deployer.UIAuthorization:retrieveAvailablePasswordHandles%
			%ifvar pwdHandles -notempty%
				%loop pwdHandles%
					<TR>
						<SCRIPT>writeTD('rowdata-l');</SCRIPT>
						<A onclick="return startProgressBar('Opening %value -htmlcode pwdHandle%');" target="propertyFrame" href="edit-passstore.dsp?pwdHandle=%value pwdHandle%">%value pwdHandle%</TD>
						<SCRIPT>writeTD('rowdata');swapRows();</SCRIPT>
						<A class="imagelink" onclick="return confirmDelete('%value -htmlcode pwdHandle%');"
							href="passstore-main.dsp?action=delete&pwdHandle=%value pwdHandle -urlencode%">
						<IMG alt="Delete this Password Handle" src="images/delete.gif" border="0" width="16" height="16"></A></TD>
					</TR>
				%endloop pwdHandles%
		%endinvoke retrieveAvailablePasswordHandles%
			</TBODY>
   	</TBODY>
	%endif%
	%ifvar /isAuth equals('false')%
	<TR>
		<TD colspan="5"><FONT color="red">* Password Store operations not authorized for current User.</FONT></TD>
	</TR>
	%endif%
</TABLE>
</BODY>
</HTML>