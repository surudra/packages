<html>
<head>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <meta http-equiv="Expires" content="-1">
  <link rel="stylesheet" TYPE="text/css" href="webMethods.css">
  <script src="webMethods.js.txt"></script>
  <script language="JavaScript">

	function validate(thisform,oper)
	{
		/* Validations for Retransmission Interval*/
		var retransmissionInterval = thisform.retransmissionInterval.value;
		if( (isEmpty (retransmissionInterval) || isNaN(retransmissionInterval)) || parseInt(retransmissionInterval) < 1 || !isInteger(retransmissionInterval))
			{
				alert("Please enter valid number/integer greater than 0 for Retransmission Interval");
				thisform.retransmissionInterval.focus();
				return false;
			}
		thisform.retransmissionInterval.value = trim(retransmissionInterval);
		/* Validations for Acknowledgement Interval*/
		var acknowledgementInterval = thisform.acknowledgementInterval.value;
		if( (isEmpty (acknowledgementInterval) || isNaN(acknowledgementInterval)) || parseInt(acknowledgementInterval) < 1 || !isInteger(acknowledgementInterval))
			{
				alert("Please enter valid number/integer greater than 0 for Acknowledgement Interval");
				thisform.acknowledgementInterval.focus();
				return false;
			}
		thisform.acknowledgementInterval.value = trim(acknowledgementInterval);
		/* Validations for Inactivity Timeout*/
		var inactivityTimeout = thisform.inactivityTimeout.value;
		if( (isEmpty (inactivityTimeout) || isNaN(inactivityTimeout)) || parseInt(inactivityTimeout) < -1 || !isInteger(inactivityTimeout))
			{
				alert("Please enter valid number/integer greater than or equal to -1 for Inactivity Timeout");
				thisform.inactivityTimeout.focus();
				return false;
			}
		thisform.inactivityTimeout.value = trim(inactivityTimeout);
		/* Validations for Sequence Removal Timeout*/
		var sequenceRemovalTimeout = thisform.sequenceRemovalTimeout.value;
		if( (isEmpty (sequenceRemovalTimeout) || isNaN(sequenceRemovalTimeout)) || parseInt(sequenceRemovalTimeout) < 1 || !isInteger(sequenceRemovalTimeout))
			{
				alert("Please enter valid number/integer greater than 0 for Sequence Removal Timeout");
				thisform.sequenceRemovalTimeout.focus();
				return false;
			}
		thisform.sequenceRemovalTimeout.value = trim(sequenceRemovalTimeout);
		/* Validations for Maximum Retransmission Count*/
		var maximumRetransmissionCount = thisform.maximumRetransmissionCount.value;
		if( (isEmpty (maximumRetransmissionCount) || isNaN(maximumRetransmissionCount)) || parseInt(maximumRetransmissionCount) < -1 || !isInteger(maximumRetransmissionCount))
			{
				alert("Please enter valid number/integer greater than or equal to -1 for Maximum Retransmission Count");
				thisform.maximumRetransmissionCount.focus();
				return false;
			}
		thisform.maximumRetransmissionCount.value = trim(maximumRetransmissionCount);
		/* Validations for Housekeeping Interval*/
		var houseKeepingInterval = thisform.houseKeepingInterval.value;
		if( (isEmpty (houseKeepingInterval) || isNaN(houseKeepingInterval)) || parseInt(houseKeepingInterval) < 1 || !isInteger(houseKeepingInterval))
			{
				alert("Please enter valid number/integer greater than 0 for Housekeeping Interval");
				thisform.houseKeepingInterval.focus();
				return false;
			}
		thisform.houseKeepingInterval.value = trim(houseKeepingInterval);
		return true;
	}
	
	</script> 
 
	<body onLoad="setNavigation('settings-rm-edit.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_ReliableMessagingPropertiesScrn');">
 
    <table width="100%">
		<tr>
			<td class="menusection-Settings" colspan="2"> 
				Settings &gt; Web Services &gt; Reliable Messaging &gt; Edit Configuration
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<ul>
					<li><a href="settings-wsendpoints.dsp">Return to Web Service Endpoints</a></li>
					<li><a href="settings-rm.dsp">Return to Reliable Messaging</a></li>
				</ul>
			</td>
		</tr>
		<tr>
			<td>
			<form name="htmlform_glConfig" action="settings-rm.dsp" method="POST">
				<input type="hidden" name="operation" value="edit_rm_props">
				%invoke wm.server.ws:getReliableMessagingConfiguration%
			<table width="40%">
				<tr>
					<td width="10px">
						<img src="images/blank.gif"  border=0>
					</td>
					<td>	
						<table class="tableView" width="100%">
							<tr>
								<td class="heading" colspan="2">Reliable Messaging Properties</td>
							</tr>
							<tr>
								<td class="evenrow" width="40%">Retransmission Interval</td>	
								<td class="evenrow-l" width="60%">
									<input type="text" name="retransmissionInterval" id="retransmissionInterval" value="%value retransmissionInterval%" style="width:50%;"> &nbsp; milliseconds
								</td>
							</tr>
							<tr>
								<td class="oddrow">Acknowledgement Interval</td>	
								<td class="oddrow-l">
									<input type="text" name="acknowledgementInterval" id="acknowledgementInterval" value="%value acknowledgementInterval%" style="width:50%;"> &nbsp; milliseconds
								</td>
							</tr>
							<tr>
								<td class="evenrow">Exponential Backoff</td>	
								<td class="evenrow-l">
									<select name="exponentialBackoff" id="exponentialBackoff" style="width:50%;">
										<option value="true" %ifvar exponentialBackoff equals('true')% selected %endif% >true</option>
										<option value="false" %ifvar exponentialBackoff equals('false')% selected %endif% >false</option>
									</select>
								</td>
							</tr>
							<tr>
								<td class="oddrow">Inactivity Timeout Interval</td>	
								<td class="oddrow-l">
									<table cellpadding="0px" cellspacing="0px" width="100%">
										<tr>
											<td width="50%">
												<input type="text" name="inactivityTimeout" id="inactivityTimeout" value="%value inactivityTimeout%" style="width:100%;">
											</td>
											<td width="50%">
												<select name="inactivityTimeoutMeasure" id="inactivityTimeoutMeasure" style="width:100%;">
													<option value="seconds" %ifvar inactivityTimeoutMeasure equals('seconds')% selected %endif% >seconds</option>
													<option value="minutes" %ifvar inactivityTimeoutMeasure equals('minutes')% selected %endif% >minutes</option>
													<option value="hours" %ifvar inactivityTimeoutMeasure equals('hours')% selected %endif% >hours</option>
													<option value="days" %ifvar inactivityTimeoutMeasure equals('days')% selected %endif% >days</option>
												</select>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td class="evenrow">Sequence Removal Timeout Interval</td>	
								<td class="evenrow-l">
									<table cellpadding="0px" cellspacing="0px" width="100%">
										<tr>
											<td width="50%">
												<input type="text" name="sequenceRemovalTimeout" id="sequenceRemovalTimeout" value="%value sequenceRemovalTimeout%" style="width:100%;">
											</td>
											<td width="50%">
												<select name="sequenceRemovalTimeoutMeasure" id="sequenceRemovalTimeoutMeasure" style="width:100%;">
													<option value="seconds" %ifvar sequenceRemovalTimeoutMeasure equals('seconds')% selected %endif% >seconds</option>
													<option value="minutes" %ifvar sequenceRemovalTimeoutMeasure equals('minutes')% selected %endif% >minutes</option>
													<option value="hours" %ifvar sequenceRemovalTimeoutMeasure equals('hours')% selected %endif% >hours</option>
													<option value="days" %ifvar sequenceRemovalTimeoutMeasure equals('days')% selected %endif% >days</option>
												</select>
											</td>
										</tr>
									</table>
									
								</td>
							</tr>
							<tr>
								<td class="oddrow">In-Order Delivery Assurance</td>	
								<td class="oddrow-l">
									<select name="invokeInOrder" id="invokeInOrder" style="width:50%;">
										<option value="true" %ifvar invokeInOrder equals('true')% selected %endif% >true</option>
										<option value="false" %ifvar invokeInOrder equals('false')% selected %endif% >false</option>
									</select>
								</td>
							</tr>							
							<tr>
								<td class="evenrow">Maximum Retransmission Count</td>	
								<td class="evenrow-l">
									<input type="text" name="maximumRetransmissionCount" id="maximumRetransmissionCount" value="%value maximumRetransmissionCount%" style="width:50%;">
								</td>
							</tr>
							<tr>
								<td class="oddrow">Storage Type</td>	
								<td class="oddrow-l">
									<select name="storageType" id="storageType" style="width:50%;">
										<option value="nonpersistent" %ifvar storageType equals('nonpersistent')% selected %endif% >Non-Persistent</option>
										<option value="database" %ifvar storageType equals('database')% selected %endif% >Database</option>
									</select>
								</td>
							</tr>
							<tr>
								<td class="evenrow" >Housekeeping Interval</td>	
								<td class="evenrow-l">
									<input type="text" name="houseKeepingInterval" id="houseKeepingInterval" value="%value houseKeepingInterval%" style="width:50%;"> &nbsp; seconds
								</td>
							</tr>							
							<tr>
								<td class="action" colspan=3>
									<input type="submit" name="submit" value="Save Changes" onclick="return validate(this.form,'%value operation%');">
								</td>
							</tr>
						</table>
						%endinvoke%
					</td>
				
				</tr>
			</form>
			</table>
			</td>
		</tr>
		
    </table>
	
  </body> 	
</head>
