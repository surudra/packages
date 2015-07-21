<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <meta http-equiv="Expires" content="-1">
  <link rel="stylesheet" TYPE="text/css" href="webMethods.css">
  <script src="webMethods.js.txt"></script>

 </head>

<body onLoad="setNavigation('enterprisegateway-dos-options.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_EnterpriseGatewayRules_DoSOptionsScrn');">
	<table width="100%">
		<tr>
			<td class="menusection-Security" colspan="2">Security&nbsp;&gt;&nbsp;Enterprise&nbsp;Gateway&nbsp;Rules&nbsp;&gt;&nbsp;Denial&nbsp;of&nbsp;Service&nbsp;Options</td>
		</tr>
		
		<tr>
			<td colspan="2">
				<table width="50%">
					%ifvar limitBy%
						%invoke wm.server.enterprisegateway:saveDOS%
							%ifvar message%
								<tr><td colspan="2">&nbsp;</td></tr>
								<tr><td class="message" colspan="2">%value message%</td></tr>
							%endif%
							%onerror%
								<tr><td colspan="2">&nbsp;</td></tr>
								<tr><td class="message" colspan=2>%value errorMessage%</td></tr>
						%endinvoke%
					%endif%
					%ifvar action equals('delete')%
						%invoke wm.server.enterprisegateway:deleteIPFromDeniedList%
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
								<li><a href="security-enterprisegateway-dos.dsp?limitBy=GLOBALIP">Configure&nbsp;Global&nbsp;Denial&nbsp;of&nbsp;Service</a></li>
								<li><a href="security-enterprisegateway-dos.dsp?limitBy=IP">Configure&nbsp;Denial&nbsp;of&nbsp;Service&nbsp;by&nbsp;IP&nbsp;Address</a></li>
							</ul>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>
							%include security-enterprisegateway-dos-global.dsp%
						</td>
					</tr>
					<tr>
						<td span="2">
					</tr>
					<tr>
						<td width="5%">&nbsp;</td>
						<td>
							%include security-enterprisegateway-dos-IP.dsp%
						</td>
					</tr> 
					<tr>
						<td span="2">
					</tr>

					<tr>
						<td>&nbsp;</td>
						<td>
							%include enterprisegateway-denied-ip-list.dsp%
						</td>
					</tr> 
				</table>
			</td>
		</tr>
			
    </table> 
  </body> 	
</html>
