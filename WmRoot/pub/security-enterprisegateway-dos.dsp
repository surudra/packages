<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv="'Content-Type'" content="'text/html;" charset="UTF-8'">
  <meta http-equiv="Expires" content="-1">
  <link rel="stylesheet" type="text/css" href="webMethods.css">
  <script src="webMethods.js.txt"></script>
  
  
  <script>
	function validate(currentForm)
	{	
				
		if(currentForm.enableDOS.checked) {
			currentForm.isDOSEnabled.value = "true";
	
			var maximumRequests = currentForm.maximumRequests.value;
			if( (isEmpty (maximumRequests) || isNaN(maximumRequests)) || parseInt(maximumRequests) < 1)
			{
				alert("Please enter valid number greater than 0 for Maximum Requests");
				currentForm.maximumRequests.focus();
				return false;
			}
			
			var requestsPerSeconds = currentForm.requestsPerSeconds.value;
			if( (isEmpty (requestsPerSeconds) || isNaN(requestsPerSeconds)) || parseInt(requestsPerSeconds) < 1)
			{
				alert("Please enter valid number greater than 0 for Request Interval in seconds");
				currentForm.requestsPerSeconds.focus();
				return false;
			}
				
			var inProgressRequests = currentForm.inProgressRequests.value;
			if( (isEmpty (inProgressRequests) || isNaN(inProgressRequests)) || parseInt(inProgressRequests) < 1)
			{
				alert("Please enter valid number greater than 0 for Maximum Requests in Progress");
				currentForm.inProgressRequests.focus();
				return false;
			}
						
			var blockInterval = currentForm.blockInterval.value;
			var block = document.getElementById("Block");
			if(!block || block.checked)
			{
				if( (isEmpty (blockInterval) || isNaN(blockInterval)) || parseInt(blockInterval) < 1)
				{
					alert("Please enter valid number greater than 0 for Block Interval");
					currentForm.blockInterval.focus();
					return false;
				}
			}
		} else {
			currentForm.isDOSEnabled.value = "false";
		}
		return true;
	}
	
	function  trim (msg)
	{
		return msg.replace(/^\s+|\s+$/g, "");
	}

	function isEmpty (msg)
	{
		return  trim (msg).length == 0;
	}
			
	function hideInterval()
	{
		var block = document.getElementById("Block");
		var row = document.getElementById("blockIntervalRow");
		var limitBy = document.getElementById("limitBy");
		if(block && !block.checked)
		{
			
			row.style.display = "none";
		}
		else
		{
			row.style.display = "";
		}
		
		for(j=0;j<row.cells.length;j++){
			col = row.cells[j];
			
			if(limitBy.value=='IP'){
				if((j%2)==0)
				{
					col.className='oddrow';
				}
				else{
					col.className='oddrow-l';
				}
			}
			else
			{
				if((j%2)==0)
				{
					col.className='evenrow';
				}
				else{
					col.className='evenrow-l';
				}
			}
			
		}
		
	}
  </script>
</head>
%ifvar limitBy equals('GLOBALIP')%
<body onLoad="setNavigation('security-enterprisegateway-dos.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_EnterpriseGatewayRules_DoSOptionsGlobalDenialofServiceScrn');">
%else%
<body onLoad="setNavigation('security-enterprisegateway-dos.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_EnterpriseGatewayRules_DoSOptionsDoSByIPAddressScrn');">
%endif%

%invoke wm.server.enterprisegateway:getDOS%

<table width="100%">
	<tr>
		<td class="menusection-Security" colspan="2">
			Security&nbsp;&gt;&nbsp;Enterprise&nbsp;Gateway&nbsp;Rules&nbsp;&gt;&nbsp;Denial&nbsp;of&nbsp;Service&nbsp;Options&nbsp;&gt;&nbsp;Configure&nbsp;%ifvar limitBy equals('GLOBALIP')%Global %endif%Denial of Service %ifvar limitBy equals('IP')% by IP Address %endif%		
		</td>
	</tr>

	<tr>
		<td colspan="2">
			<ul>
				<li><a href="enterprisegateway-dos-options.dsp">Return&nbsp;to&nbsp;Denial&nbsp;of&nbsp;Service&nbsp;Options</a></li>
			</ul>
		</td>
	</tr>
		
	<form method="post" name="createRule" action="enterprisegateway-dos-options.dsp" id="createRule">
		<input type="hidden" name="limitBy" id="limitBy" value="%value limitBy%">
		<input type="hidden" name="isDOSEnabled" id="isDOSEnabled" value="%value isDOSEnabled%">
			
	<tr>
		<td>
			<img src="images/blank.gif" width="2px" border=0>
		</td>
		<td>
			<table class="tableView" width="50%" id="filterTable">
				<tr>
					<td class="heading" colspan="3" width="100%">
						%ifvar limitBy equals('GLOBALIP')%Global %endif% Denial of Service %ifvar limitBy equals('IP')% by IP Address %endif%	
					</td>
				</tr>
				
				<tr name="denialOfService" id="denialOfService" class="oddrow-l">
					<td  class="oddrow">Enable</td>
					<td  class="oddrow-l">
						<input type="checkbox" name="enableDOS" id="enableDOS"  %ifvar isDOSEnabled equals('true')%checked%endif%>
					</td>
				</tr>
				<tr>
					<td class="evenrow">Maximum Requests</td>
					<td class="evenrow-l">
						<input type="text" name="maximumRequests" id="maximumRequests"  value="%value maximumRequests%" size="3" >&nbsp; in </input> 
						<input type="text" name="requestsPerSeconds"  id="requestsPerSeconds" value="%value requestsPerSeconds%" size="3"> seconds</input>
					</td>
				</tr>
				<tr>
					<td class="oddrow" width="40%">Maximum Requests in Progress</td>
					<td class="oddrow-l" width="60%">
						<input type="text" name="inProgressRequests" id="inProgressRequests" value="%value inProgressRequests%" size="3">
					</td>
				</tr>
				
				%ifvar limitBy equals('IP')%
				<tr>
					<td class="evenrow">When&nbsp;Limit&nbsp;Exceeds</td>
					<td class="evenrow-l">
						
							<input type="radio" name="whenLimitExceeds" id="denyList" value="Add to Deny List"  onclick="hideInterval()" checked>Add to Deny List</input>
							<input type="radio" name="whenLimitExceeds" id="Block" value="Block" onclick="hideInterval()" >Block</input>
							%ifvar whenLimitExceeds equals('Block')%
								<script>
									document.getElementById("Block").checked=true;
								</script>
							%else%
								<script>
									document.getElementById("denyList").checked=true;
								</script>
							%endif%
					</td >
				</tr>
				%else%
						<input type="hidden" name="whenLimitExceeds" id="whenLimitExceeds" value="Block" />
						<script>
							document.getElementById("Block").checked=true;
						</script>
				%endif%
				<tr name="blockIntervalRow" id="blockIntervalRow">
					<td>Block Interval</td>
					<td>
						<input type="text" name="blockInterval"  id="blockInterval" value="%value blockInterval%" size="3" > minutes</input>
					</td>
					<script>hideInterval();</script>
				</tr>
				<tr>
						<td class="oddrow" width="30%">Error Message</td>
						<td class="oddrow-l" width="30%">
							<input type="text" name="customErrorMessage" id="customErrorMessage" value="%value customErrorMessage%" size="50" />
						</td>
				</tr>
				<tr>
						<td class="evenrow" width="30%">Trusted IP Address Range<br/>
						
						</td>
						<td class="evenrow-l" width="30%">
							<textarea name="trustedIPRange" wrap="off" id="trustedIPRange"  rows="4" cols="50" style="width:100%">%value trustedIPRange%</textarea><br>Use commas (,) to separate entries.			
						</td>
				</tr>
				<tr class="action">
					<td  colspan="3" width="100%">
						<input type="submit" name="submit" value="Save Changes" onclick="return validate(this.form);" />
					</td>
				</tr>
			</table>
				<!-- End of Filter Table -->
		</td>
	</tr>
</form>
</p>
</table>
%endinvoke%
</body>
</html>