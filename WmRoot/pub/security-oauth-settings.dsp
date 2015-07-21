<html>
<head>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <meta http-equiv="Expires" content="-1">
  <link rel="stylesheet" TYPE="text/css" href="webMethods.css">
  <script src="webMethods.js.txt"></script>
  
  <body onLoad="setNavigation('security-oauth-settings.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_OAuthScrn');">
   
    <table width="100%">
	<tr>
		<td class="menusection-Settings" colspan="2"> Security &gt; OAuth</td>
	</tr>

	%ifvar action equals('edit')%
	  %ifvar isChanged equals('true')%
		%invoke wm.server.oauth:setOAuthSettings%    
		
		<TR>
		  <TD colspan="2">&nbsp;</td>
		  </TR>
		<TR>
		  <TD class="message" colspan=2>%value message%</TD>
		</TR>
		
		%endinvoke%
	  %else%
		<TR>
		  <TD colspan="2">&nbsp;</td>
		</TR>
		<TR>
		  <TD class="message" colspan=2>No changes made to OAuth Global Settings.</TD>
		</TR>
	  %endif%
	%endif%
	
      <tr>
        <td colspan="2">
          <ul>
            <li><a href="security-oauth-client-registration.dsp">Client Registration</a></li>
            <li><a href="security-oauth-scope.dsp">Scope Management</a></li>
			<li><a href="security-oauth-tokens.dsp">Tokens</a></li>
            <li><a href="security-oauth-settings-edit.dsp">Edit OAuth Global Settings</a></li>			
          </ul>
        </td>
      </tr>		

		<tr>
			<td>
				<table width="50%">
					<tr>
						<td width="10px">
							<img src="images/blank.gif"  border=0>
						</td>
						<td>	
							<table class="tableView" width="50%">
								<tr>
									<td class="heading" colspan="2">Authorization Server Settings</td>
								</tr>
							  %invoke wm.server.oauth:getOAuthSettings%
							  <TR>
								 <TD nowrap class="oddrow">Require HTTPS</TD>
								 %ifvar requireHTTPS equals('true')%
									<TD nowrap class="oddrowdata-l">yes</TD>
								 %else%
									<TD nowrap class="oddrowdata-l">no</TD>
								 %endif%
							  </TR>
								
							  <TR>
								 <TD nowrap class="evenrow">Authorization code expiration interval</TD>
								 <TD nowrap class="evenrowdata-l">%value authCodeLifetime% seconds</TD>
							  </TR>

							  <TR>
								 <TD nowrap class="oddrow">Access token expiration interval</TD>
								 <TD nowrap class="oddrowdata-l">
								 %ifvar accessTokenLifetime equals('-1')%
								 	Never Expires
								 %else%
								 	 %value accessTokenLifetime% seconds
								 %endif%
								</TD>
							  </TR>

							  <tr>
								<td class="heading" colspan="2">Resource Server Settings</td>
							  </tr>

							  <TR>
								 <TD nowrap class="oddrow">Authorization server</TD>
								 <TD nowrap class="oddrowdata-l">%value remoteServerAlias%</TD>
							  </TR>
							  
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>	  
	 </table>
  </body> 	
</head>
