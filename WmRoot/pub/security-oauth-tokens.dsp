<html>
<head>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <meta http-equiv="Expires" content="-1">
  <link rel="stylesheet" TYPE="text/css" href="webMethods.css">
  <script src="webMethods.js.txt"></script>
  
  <SCRIPT LANGUAGE="JavaScript">
  
	function removeToken(tokenId, accessTokenId, refreshTokenId) {
            var msg = null;
			
			if ( accessTokenId == "" && refreshTokenId == "" ) {
				msg = " OK to remove Token?";
			}
			else if ( accessTokenId == "" ) {
				msg = " OK to remove Refresh Token " + refreshTokenId + "?";
			}
			else if ( refreshTokenId == "" ) {
				msg = " OK to remove Access Token " + accessTokenId + "?";
			}
			else {
				msg = " OK to remove \n Access Token " + accessTokenId + " and \n Refresh Token " + refreshTokenId + "?";
			}
			
            if ( confirm(msg) ) {
				document.forms['tokens'].operation.value='delete';
				document.forms['tokens'].token_id.value=tokenId;
				document.forms['tokens'].access_token_id.value=accessTokenId;
				document.forms['tokens'].refresh_token_id.value=refreshTokenId;
             	return true;
            } else
                return false;
    }
    
    function editClient(id){
    	 document.forms['clientRegistrations'].client_id.value=id;
    	 document.forms['clientRegistrations'].edit.value='yes';
         document.forms['clientRegistrations'].action='security-oauth-client-registration-addedit.dsp';
        return true;
    }
    
    function editClientUsingName(clientName,version){
    	document.forms['clientRegistrations'].name.value=clientName;
    	document.forms['clientRegistrations'].version.value=version;
    	document.forms['clientRegistrations'].edit.value='yes';
    	document.forms['clientRegistrations'].action='security-oauth-client-registration-addedit.dsp';
    	return true;
    	
    }
  
  
	  function confirmDeleteToken(id) {
		var msg = "OK to Delete Token '"+id+"' ?";
		if (confirm (msg)) {
		  return true;
		} else return false;
	  }
  </SCRIPT>

  <body onLoad="setNavigation('security-oauth-tokens.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_OAuthTokens');">
   
    <table width="100%">
	<tr>
		<td class="menusection-Settings" colspan="2"> Security &gt; OAuth &gt; Tokens</td>
	</tr>

	  %ifvar operation equals('delete')%
		%invoke wm.server.oauth:removeToken%
            <TR><TD colspan="2">&nbsp;</TD></TR>
            <TR><TD class="message" colspan=2>%value message%</TD></TR>
            <TR><TD colspan="2">&nbsp;</TD></TR>
		%onerror%
			<tr><td colspan="2">&nbsp;</td></tr>
			<tr><td class="message" colspan=2>%value errorMessage% Token %value token_id% not deleted.</td></tr>			
        %endinvoke%	  
	  %endif%
	  
      <tr>
        <td colspan="2">
          <ul>
		    <li><a href="security-oauth-settings.dsp">Return to OAuth</a></li>
          </ul>
        </td>
      </tr>		

	  <TR> 
		<TD>
			&nbsp;
		</TD>
		<TD width="98%">
		   <TABLE width="80%">
		   <TR> 
		 
		  <TD class="heading" colspan="7">Tokens</TD>
		</TR>
	   
		<TR> 
		
		  <TD class="oddcol-l" nowrap>Client Application</TD>
		  <TD class="oddcol" nowrap>Owner ID</TD>
		  <TD class="oddcol" nowrap>Access Token</TD>
		  <TD class="oddcol" nowrap>Expiry Time</TD>
		  <TD class="oddcol" nowrap>Refresh Token</TD>
		  <TD class="oddcol" nowrap>Remaining Refresh Count</TD>
		  <TD class="oddcol" nowrap>Delete</TD>
		  
		</TR>

    %invoke wm.server.oauth:listTokens%		
	%loop tokens%
			  <TR>

				  <SCRIPT>writeTDnowrap("rowdata-l");</SCRIPT>
					<A href="javascript:document.forms['clientRegistrations'].submit()" onClick="return editClient('%value client_id%');">
					  %value client_name% (%value client_version%)
					</A>            
				  </TD>
			  
				  <SCRIPT>writeTDnowrap("rowdata");</SCRIPT>
					  %value owner_id%
				  </TD>

				  <SCRIPT>writeTDnowrap("rowdata");</SCRIPT>
					  %value access_token_id%
				  </TD>

				  <SCRIPT>writeTDnowrap("rowdata");</SCRIPT>
					  %value expire_time_str%
				  </TD>

				  <SCRIPT>writeTDnowrap("rowdata");</SCRIPT>
					  %value refresh_token_id%
				  </TD>

				  <SCRIPT>writeTDnowrap("rowdata");</SCRIPT>
					  %value remaining_refreshes%
				  </TD>

				  <SCRIPT>writeTDspan("rowdata","1");</SCRIPT>
					<A href="javascript:document.forms['tokens'].submit()" onClick="return removeToken('%value token_id%', '%value access_token_id%', '%value refresh_token_id%');">
					  <IMG src="icons/delete.gif" border="none">
					</A>
				  </TD>     
				  
				  <SCRIPT>swapRows();</SCRIPT>
			  </TR>
	%endloop%
		
		
		</TABLE>
	  
	  
	 </table>
	 
  <form name="clientRegistrations" action="security-oauth-client-registration.dsp" method="POST">
  	<input type="hidden" name="client_id">
  	<input type="hidden" name="operation">
  	<input type="hidden" name="name">
  	<input type="hidden" name="version">
  	<input type="hidden" name="edit">
  </form> 

  <form name="tokens" action="security-oauth-tokens.dsp" method="POST">
  	<input type="hidden" name="token_id">
	<input type="hidden" name="access_token_id">
	<input type="hidden" name="refresh_token_id">
  	<input type="hidden" name="operation">
  </form> 
  
  </body> 	
</head>
