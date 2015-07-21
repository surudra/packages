<html>
<head>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <meta http-equiv="Expires" content="-1">
  <link rel="stylesheet" TYPE="text/css" href="webMethods.css">
  <script src="webMethods.js.txt"></script>
 <script language="JavaScript">
 function validate(currentForm)
 {
	if(currentForm.isGuardEnabled.checked) {
		currentForm.boolGuardEnabled.value = "true";
	} else {
		currentForm.boolGuardEnabled.value = "false";
	}
	
	return true;
 }
 </script>
  
</head>
  
	<body onLoad="setNavigation('settings-csrf-edit.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_CSRFGuardEditScrn');">
  
    <table width="100%">
		<tr>
			<td class="menusection-Security" colspan="2"> 
				Security &gt; CSRF Guard &gt; Edit CSRF Guard Settings
			</td>
		</tr>
						
		<tr>
			<td colspan="2">
				<ul>
					<li><a href="security-csrf.dsp">Return to CSRF Guard Settings</a></li>
				</ul>
			</td>
		</tr>
		<tr>
			<td>
			<form name="htmlform_CSRFConfig" action="security-csrf.dsp" method="POST" id="htmlform_CSRFConfig">
				<input type="hidden" name="operation" value="edit">
				<input type="hidden" name="boolGuardEnabled" value="%value isEnabled%">
				<table>
				<tr>
					<td width="10px">
						<img src="images/blank.gif"  border=0>
					</td>
					<td>	
						<table class="tableView" width="100%">
						%invoke wm.server.csrfguard:getCSRFGuardConfigDetails%
							<tr>
								<td class="heading" colspan="2">CSRF Guard Settings</td>
							</tr>
							
							<tr>
								<td class="oddrow">Enabled</td>	
								<td class="oddrow-l">
									<input type="checkbox" name="isGuardEnabled" id="isGuardEnabled" value="%value isEnabled%" %ifvar isEnabled equals('true')%checked%endif% >
								</td>
							</tr>
							
							<tr>
								<td class="evenrow" >Excluded User Agents</td>
								<td class="evenrow-l" >
									<textarea name="excludedUserAgents" wrap="off" id="excludedUserAgents"  rows="4" cols="50" style="width:100%">%value excludedUserAgents%</textarea> 
								</td>
							</tr>
							<tr>
			        		   <td class="evenrow"/>
					           <td class="evenrow-l" colspan=2>Enter one user agent per line</TD>
							</tr>
							
							<tr>
								<td class="oddrow" >Landing Pages </td>
								<td class="oddrow-l" >
									<textarea name="landingPages" wrap="off" id="landingPages"  rows="4" cols="50" style="width:100%">%value landingPages%</textarea> 
								</td>
							</tr>
							<tr>
			        		   <td class="oddrow"/>
					           <td class="oddrow-l" colspan=2>Enter one landing page URL per line</TD>
							</tr>
							
							<tr>
								<td class="evenrow" >Unprotected URLs </td>
								<td class="evenrow-l" >
									<textarea name="unprotectedURLs" wrap="off" id="unprotectedURLs"  rows="4" cols="50" style="width:100%">%value unprotectedURLs%</textarea> 
								</td>
							</tr>
							<tr>
			        		   <td class="evenrow"/>
					           <td class="evenrow-l" colspan=2>Enter one URL per line</TD>
							</tr>
							<tr>
								<td class="oddrow" >Denial Action</td>
								<td class="oddrow-l" >									
								
									<input type="radio" name="denialAction" id="REDIRECT" checked value="REDIRECT" /> Redirect&nbsp;&nbsp;
									<input type="radio" name="denialAction" id="ERROR"  %ifvar denialAction equals('ERROR')% checked %endif% value="ERROR" /> Error
								</td>
							</tr>
							<tr>
								<td class="action" colspan=3>
									<input type="submit" name="submit" value="Save Changes" onclick="return validate(this.form);">
								</td>
							</tr> 
						%endinvoke%	
						</table>
					</td>
				
				</tr>
			</form>
			</table>
			</td>
		</tr>
		
    </table>
	
  </body> 	

</html>