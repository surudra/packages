<html>
	<head>
	  <meta http-equiv="Pragma" content="no-cache">
	  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
	  <meta http-equiv="Expires" content="-1">
	  <link rel="stylesheet" TYPE="text/css" href="webMethods.css">
	  <script src="webMethods.js.txt"></script>
	  <script>
	  function validate(form) {
	  
		return true;
	  }
	  </script>
	</head>
	  <body onLoad="setNavigation('enterprisegateway-mobile-applications-edit.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_EnterpriseGatewayRules_MobileApplicationProtectionOptionsEditMobileApplicationsScrn');">
		<form name="html_comm" id="html_comm" action="enterprisegateway-mobile-app-protection.dsp" method="post">
		<input type="hidden" name="operation" id="operation" value="operation_edit_mobileApps">
		<table width="100%">
			<tr>
				<td class="menusection-Settings" colspan="2">Security&nbsp;&gt;&nbsp;Enterprise&nbsp;Gateway&nbsp;Rules&nbsp;&gt;&nbsp;Mobile&nbsp;Application&nbsp;Protection&nbsp;Options&nbsp;&gt;&nbsp;Mobile&nbsp;Applications&nbsp;&gt;&nbsp;Edit</td>
			</tr>
			%invoke wm.server.enterprisegateway:getMobileApplications%
				%ifvar message%
					<tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan="2">%value message%</td></tr>
				%endif%
				%onerror%
					<tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan=2>%value errorMessage%</td></tr>
			%endinvoke%
			<tr>
				<td colspan="2">
					<ul>
						<li><a href="enterprisegateway-mobile-app-protection.dsp">Return&nbsp;to&nbsp;Mobile&nbsp;Application&nbsp;Protection&nbsp;Options</a></li>
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
										<td class="heading" colspan="2">Mobile Applications</td>
									</tr>
				
								   				   
								  
								   <tr>
										<td class="oddrow" width="20%">
											Mobile Applications
										</td>
										<td class="oddrow-l">
											<textarea name="mobileApplications" wrap="off" id="mobileApplications"  rows="4" cols="50" style="width:100%">%value mobileApplications%</textarea> 
										</td>
									</tr>
									<tr>
									   <td class="oddrow"/>
									   <td class="oddrow-l" colspan=2>Enter one application per line</TD>
									</tr>
																	
									<tr class="action">
										<td  colspan="2" width="100%">
											<input type="submit" name="submit" value="Save Changes" onclick="return validate(this.form);">
										</td>
					
									</tr>
								</table>	
							</td>	
						</tr>	
					</table>	
				</td>	
			</tr>	
		</table>
		
		</form>
	</body>
</html>	