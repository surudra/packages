<html>
<head>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <meta http-equiv="Expires" content="-1">
  <link rel="stylesheet" TYPE="text/css" href="webMethods.css">
  <script src="webMethods.js.txt"></script>
 
  <body onLoad="setNavigation('enterprisegateway-mobile-app-protection.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_EnterpriseGatewayRules_MobileApplicationProtectionOptionsScrn');">
   
    <table width="100%">
		<tr>
			<td class="menusection-Settings" colspan="2">Security&nbsp;&gt;&nbsp;Enterprise&nbsp;Gateway&nbsp;Rules&nbsp;&gt;&nbsp;Mobile&nbsp;Application&nbsp;Protection&nbsp;Options</td>
		</tr>
		
		%ifvar operation equals('operation_edit_deviceTypes')%
			%invoke wm.server.enterprisegateway:updateMobileDeviceTypes%
				%ifvar message%
					<tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan="2">%value message%</td></tr>
				%endif%
				%onerror%
					<tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan=2>%value errorMessage%</td></tr>
			%endinvoke%
		%endif%	

		%ifvar operation equals('operation_edit_mobileApps')%
			%invoke wm.server.enterprisegateway:updateMobileApplications%
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
					<li><a href="security-enterprisegateway-rules.dsp">Return&nbsp;to&nbsp;Enterprise&nbsp;Gateway&nbsp;Rules</a></li>
					<li><a href="enterprisegateway-device-types-edit.dsp">Edit&nbsp;Device Types</a></li>
					<li><a href="enterprisegateway-mobile-applications-edit.dsp">Edit&nbsp;Mobile&nbsp;Applications</a></li>
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
									<td class="heading" colspan="4">Device Types</td>
								</tr>
								<tr>
									<td class="oddrow" width="20%">
										Device Types
									</td>
									<td class="oddrowdata-l">
										%invoke wm.server.enterprisegateway:getMobileDeviceTypes%	
											%ifvar mobileAppDeviceTypes equals('')%
												None
											%else%
												<TABLE width=100%>
													<TR>
														<TD class="oddrowdata-l">
															<PRE class="fixedwidth">%value mobileAppDeviceTypes% </PRE>
														</TD>
													</TR>
												</TABLE>
											%endif%
										%endinvoke%
									</td>
								</tr>
								
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>	
		<tr>
			<td >
				<img src="images/blank.gif"  border="0" width="5px" height="2px">
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
									<td class="heading" colspan="4">Mobile Applications</td>
								</tr>
								<tr>
									<td class="oddrow" width="20%">
										Mobile Applications
									</td>
									<td class="oddrowdata-l">
										%invoke wm.server.enterprisegateway:getMobileApplications%	
											%ifvar mobileApplications equals('')%
												None
											%else%
												<TABLE width=100%>
													<TR>
														<TD class="oddrowdata-l">
															<PRE class="fixedwidth">%value mobileApplications% </PRE>
														</TD>
													</TR>
												</TABLE>
											%endif%
										%endinvoke%
									</td>
								</tr>
								
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>	
    </table>
  </body> 	
</head>
