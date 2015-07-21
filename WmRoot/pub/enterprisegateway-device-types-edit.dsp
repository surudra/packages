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
	  <body onLoad="setNavigation('enterprisegateway-devicetypes-add.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_EnterpriseGatewayRules_MobileApplicationProtectionOptions_EditDeviceTypesScrn');">
		<form name="html_comm" id="html_comm" action="enterprisegateway-mobile-app-protection.dsp" method="post">
		<input type="hidden" name="operation" id="operation" value="operation_edit_deviceTypes">
		<table width="100%">
			<tr>
				<td class="menusection-Settings" colspan="2">Security&nbsp;&gt;&nbsp;Enterprise&nbsp;Gateway&nbsp;Rules&nbsp;&gt;&nbsp;Mobile&nbsp;Application&nbsp;Protection&nbsp;Options&nbsp;&gt;&nbsp;Device&nbsp;Types&nbsp;&gt;&nbsp;Edit</td>
			</tr>
			%invoke wm.server.enterprisegateway:getMobileDeviceTypes%
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
										<td class="heading" colspan="2">Device Types</td>
									</tr>
				
								   				   
								  
								   <tr>
										<td class="oddrow" width="20%">
											Device Types
										</td>
										<td class="oddrow-l">
											<textarea name="mobileAppDeviceTypes" wrap="off" id="mobileAppDeviceTypes"  rows="4" cols="50" style="width:100%">%value mobileAppDeviceTypes%</textarea> 
										</td>
									</tr>
									<tr>
									   <td class="oddrow"/>
									   <td class="oddrow-l" colspan=2>Enter one device type per line</TD>
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