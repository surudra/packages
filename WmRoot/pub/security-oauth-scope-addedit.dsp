<html>
<head>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <meta http-equiv="Expires" content="-1">
  <link rel="stylesheet" TYPE="text/css" href="webMethods.css">
  <script src="webMethods.js.txt"></script>
  
  <script LANGUAGE="JavaScript">
  	function valueAltered()
	{
		document.editform.isChanged.value = "true";
	}
	
	function confirmEdit ()
	{ 	
		if(isSpclChar(document.editform.name.value)){
			alert("The scope name contains illegal characters, provide a valid value.");
			document.editform.name.focus();
			return false;
		}
		document.editform.submit();
		return true;
	}	
	
  </script>
  
  %ifvar action equals('edit')%
	<body onLoad="setNavigation('security-oauth-scope-addedit.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_OAuthEditScopeScrn');">
  %else%
	<body onLoad="setNavigation('security-oauth-scope-addedit.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_OAuthAddScopeScrn');">
  %endif%
   
    <table width="100%">
	<tr>

	  %ifvar action equals('edit')%
		<td class="menusection-Settings" colspan="2"> Security &gt; OAuth &gt; Scope Management &gt; %value name% &gt; Edit</td>
	  %else%
		<td class="menusection-Settings" colspan="2"> Security &gt; OAuth &gt; Scope Management &gt; Add Scope</td>
	  %endif%
	
	</tr>

      <tr>
        <td colspan="2">
          <ul>
		    <li><a href="security-oauth-scope.dsp">Return to Scope Management</a></li>
          </ul>
        </td>
      </tr>		

    <TR>
	    <TD><IMG SRC="images/blank.gif" height=10 width=10></TD>
	    
	    <TD>
	    
		<FORM NAME="editform" ACTION="security-oauth-scope.dsp" METHOD="POST">
		 <TABLE class="tableView" width="40%">
	    		<TR>
	    			<TD class="heading" colspan=2>Scope Configuration</TD>
	    		</TR>
	    
	 	    	<TR>
	 	    		<TD class="oddrow" width="40%" nowrap>
						Name
	 	    		</TD>
					%ifvar action equals('edit')%
						%invoke wm.server.oauth:getScope%			
						%endinvoke%
					%endif%

					<TD class="oddrow-l">
						<input TYPE="hidden" NAME="isChanged" VALUE="false">
						%ifvar action equals('edit')%
							<input NAME="name" VALUE="%value name%" readonly="true" style="color:#808080;">
						%else%
							<input NAME="name">
						%endif%
					</TD>
	 	    	</TR>
			<TR>
				<TD class="evenrow" nowrap>Folders and services</TD>

				<TD class="evenrow-l">
					%ifvar action equals('edit')%
          			 	 <textarea name="dsp_values" id="redirectURI" rows="5" cols="40" onChange="valueAltered()">%loop values%%value% 
%endloop%</textarea> 
					%else%
						<textarea NAME="dsp_values" rows="5" cols="40" onChange="valueAltered()"></textarea>
					%endif%
				</TD>				
			</TR>
			
			<TR>
        	    <TD class="action" class="row"  colspan=2>
        	      <input TYPE="hidden" NAME="action" VALUE="%value action%">
        	      <input type="submit" name="submit" value="Save Changes" onclick="return confirmEdit()">
        	    </TD>
        	</TR>
			</TABLE>
	
        </FORM>
	    
	</TR>
	  
	  
	 </table>
  </body> 	
	
</head>
