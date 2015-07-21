<html>
<head>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <meta http-equiv="Expires" content="-1">
  <link rel="stylesheet" TYPE="text/css" href="webMethods.css">
  <script src="webMethods.js.txt"></script>
</head>
  
  <body onLoad="setNavigation('security-csrf.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_CSRFGuardScrn');">
   
    <table width="100%">
		<tr>
			<td class="menusection-Security" colspan="2"> Security &gt; CSRF Guard </td>
		</tr>
		%ifvar operation equals('edit')%
			
			%rename boolGuardEnabled isEnabled -copy%
			%invoke wm.server.csrfguard:saveCSRFGuardSettings%
				%ifvar message%
					<tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan="2">%value message%</td></tr>
				%endif%
				%onerror%
					<tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan=2>%value errorMessage%</td></tr>
			%endinvoke%
		%endif%
		<tr>
			<td colspan="2">
				<ul>
					<li><a href="security-csrf-edit.dsp">Edit&nbsp;CSRF&nbsp;Guard&nbsp;Settings</a></li>
					
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
							<table class="tableView" width="100%">
								<tr>
									<td class="heading" colspan="4">CSRF Guard Settings</td>
								</tr>
								
								%invoke wm.server.csrfguard:getCSRFGuardConfigDetails%
										<tr>
											<td class="oddrow">	Enabled </td>
											<td class="oddrowdata-l" width="75%">%value isEnabled%</td>
										</tr>
										<tr>
											<td class="evenrow"> Excluded User Agents </td>
											<td class="evenrowdata-l" width="75%">
											%ifvar excludedUserAgents -notempty%
													<TABLE width=100%>
														<TR>
															<TD class="evenrowdata-l">
																<PRE class="fixedwidth">%value excludedUserAgents% </PRE>
															</TD>
														</TR>
													</TABLE>
												%else%
													None
												%endif% 
											</td>						
										</tr>
										<tr>
											<td class="oddrow">	Landing Pages </td>
											<td class="oddrowdata-l" width="75%">
											%ifvar landingPages -notempty%
													<TABLE width=100%>
														<TR>
															<TD class="oddrowdata-l">
																<PRE class="fixedwidth">%value landingPages% </PRE>
															</TD>
														</TR>
													</TABLE>
												%else%
													None
												%endif% 
											</td>				
										</tr>
										<tr>
											<td class="evenrow">Unprotected URLs </td>
											<td class="evenrowdata-l" width="75%">
											%ifvar unprotectedURLs -notempty%
													<TABLE width=100%>
														<TR>
															<TD class="evenrowdata-l">
																<PRE class="fixedwidth">%value unprotectedURLs% </PRE>
															</TD>
														</TR>
													</TABLE>
												%else%
													None
												%endif% 
											</td>				
										</tr>
										<tr>
											<td class="oddrow">Denial Action</td>
											<td class="oddrowdata-l" width="75%">
											%switch denialAction%
												%case 'ERROR'%
													Error
												%case 'REDIRECT'%
													Redirect
											%endswitch%
											</td>
										</tr>
								%endinvoke%	
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
    </table>
  </body> 	
</html>
