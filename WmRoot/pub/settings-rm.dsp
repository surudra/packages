<html>
<head>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <meta http-equiv="Expires" content="-1">
  <link rel="stylesheet" TYPE="text/css" href="webMethods.css">
  <script src="webMethods.js.txt"></script>
  <script language="JavaScript">
	function populateForm(form , seqID ,oper)
	{
		if('close' == oper)
			if (!confirm ("OK to close '"+seqID+"'?")) {
				return false;
			}
			form.operation.value = 'rm_close';	
		if('terminate' == oper)
		{
			if (!confirm ("OK to terminate '"+seqID+"'?")) {
				return false;
			}
			form.operation.value = 'rm_terminate';	
		}
		if('sendAckReq' == oper)
		{
			if (!confirm ("OK to send acknowledgement request'"+seqID+"'?")) {
				return false;
			}
			form.operation.value = 'rm_sendAckReq';	
		}
		form.serverSequenceId.value = seqID;
		return true
	}
  </script>
 </head>
  <body onLoad="setNavigation('settings-rm.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_ReliableMessagingScrn');">
    <table width="100%">
		<tr>
			<td class="menusection-Settings" colspan="2"> Settings &gt; Web Services &gt; Reliable Messaging </td>
		</tr>
		 %ifvar operation equals('rm_close')%
			%invoke wm.server.ws:closeSequence%
				%ifvar message%
					<tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan="2">%value message%</td></tr>
				%endif%
				%onerror%
					<tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan=2>%value errorMessage%</td></tr>
			%endinvoke%
		%endif%	  
		%ifvar operation equals('rm_terminate')%
			%invoke wm.server.ws:terminateSequence%
				%ifvar message%
					<tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan="2">%value message%</td></tr>
				%endif%
				%onerror%
					<tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan=2>%value errorMessage%</td></tr>
			%endinvoke%
		%endif%	
		%ifvar operation equals('rm_sendAckReq')%
			%invoke wm.server.ws:sendAcknowledgementRequest%
				%ifvar message%
					<tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan="2">%value message%</td></tr>
				%endif%
				%onerror%
					<tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan=2>%value errorMessage%</td></tr>
			%endinvoke%
		%endif%	
		%ifvar operation equals('edit_rm_props')%
			%invoke wm.server.ws:setReliableMessagingConfiguration%
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
				    <li><a href="settings-wsendpoints.dsp">Return to Web Services</a></li>
					<li><a href="settings-rm-edit.dsp">Edit Reliable Messaging Configuration</a></li>
					
				</ul>
			</td>
		</tr>
		%invoke wm.server.ws:getReliableMessagingReport%
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
									<td class="heading" colspan="10">Client Sequences</td>
								</tr>
								<tr>
									<td class="oddcol-l">User Sequence Key</td>
									<td class="oddcol">Client Sequence Id</td>
									<td class="oddcol">Server Sequence Id</td>
									<td class="oddcol">To Address</td>
									<td class="oddcol">Status</td>
									<td class="oddcol">Number of Completed Messages</td>
									<td class="oddcol">Last Activated</td>
									<td class="oddcol">Acknowledgement Request</td>
									<td class="oddcol">Close</td>
									<td class="oddcol">Terminate</td>
								</tr>
								
									%loop reliableMessagingReport/clientRMSequenceReports%
										<tr>
											<script>writeTD("row-l");</script>
												%value sequenceKey%  
											</td>
											<script>writeTD("row-l");</script>
												%value clientSequenceId%  
											</td>
											<script>writeTD("row-l");</script>
												%value serverSequenceId%  
											</td>
											<script>writeTD("row-l");</script>
												%value toAddress%  
											</td>
											<script>writeTD("row-l");</script>
												%value statusMessage%  
											</td>
											<script>writeTD("row-l");</script>
												%value numberOfCompletedMessages%  
											</td>
											<script>writeTD("row-l");</script>
												%value lastActivatedTime%  
											</td>
											<script>writeTD("rowdata");</script>
												%ifvar status equals('4')%
													<p style="text-decoration:underline;color:grey">Send</p>
												%else%
													%ifvar status equals('3')%
														<p style="text-decoration:underline;color:grey">Send</p>
													%else%
														<a href="javascript:document.htmlform_sendAckReq.submit();" onClick="return populateForm(document.htmlform_sendAckReq,'%value serverSequenceId%','sendAckReq');">
															Send
														</a>
													%endif%
												%endif%
											</td>
											<script>writeTD("rowdata");</script>
												%ifvar status equals('2')%
													<a href="javascript:document.htmlform_close.submit();" onClick="return populateForm(document.htmlform_close,'%value serverSequenceId%','close');">
														Close
													</a>
												%else%
													<p style="text-decoration:underline;color:grey">Close</p>
												%endif%
											</td>						
											<script>writeTD("rowdata");</script>
												%ifvar status equals('4')%
													<p style="text-decoration:underline;color:grey">Terminate</p>
												%else%
													%ifvar status equals('3')%
														<p style="text-decoration:underline;color:grey">Terminate</p>
													%else%
														<a href="javascript:document.htmlform_terminate.submit();" onClick="return populateForm(document.htmlform_terminate,'%value serverSequenceId%','terminate');">
															Terminate
														</a>
													%endif%
												%endif%
											</td>
										</tr>
										<script>swapRows();</script>
									%endloop%
							
							</table>
							
							<br/>

							<script>resetRows();</script>

							<table class="tableView" width="100%">
								<tr>
									<td class="heading" colspan="6">Server Sequences</td>
								</tr>
								<tr>
									<td class="oddcol-l">Server Sequence Id</td>
									<td class="oddcol">Client Sequence Id</td>
									<td class="oddcol">To Address</td>
									<td class="oddcol">Status</td>
									<td class="oddcol">Number of Completed Messages</td>
									<td class="oddcol">Last Activated</td>
								</tr>
								
								%loop reliableMessagingReport/serverRMSequenceReports%
									<tr>
										<script>writeTD("row-l");</script>
											%value serverSequenceId%  
										</td>
										<script>writeTD("row-l");</script>
											%value clientSequenceId%  
										</td>
										<script>writeTD("row-l");</script>
											%value toAddress%  
										</td>
										<script>writeTD("row-l");</script>
											%value statusMessage%  
										</td>
										<script>writeTD("row-l");</script>
											%value numberOfCompletedMessages%  
										</td>
										<script>writeTD("row-l");</script>
											%value lastActivatedTime%
										</td>
									</tr>
									<script>swapRows();</script>
								%endloop%
							
							</table>
							
							
						</td>
					</tr>
				</table>
			</td>
		</tr>
		%endinvoke%
    </table>
	<form name="htmlform_close" action="settings-rm.dsp" method="POST">
		<input type="hidden" name="operation">
		<input type="hidden" name="serverSequenceId">
	</form>
	<form name="htmlform_terminate" action="settings-rm.dsp" method="POST">
		<input type="hidden" name="operation">
		<input type="hidden" name="serverSequenceId">
	</form>
	<form name="htmlform_sendAckReq" action="settings-rm.dsp" method="POST">
		<input type="hidden" name="operation">
		<input type="hidden" name="serverSequenceId">
	</form>
	</body> 	
</html>
