<HTML>
	<HEAD>
		<META http-equiv="Pragma" content="no-cache">
		<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<META http-equiv="Expires" content="-1">
		<title>webMethods Deployer - Target Configuration</title>
		<LINK href="webMethods.css" type="text/css" rel="stylesheet">
		<SCRIPT src="webMethods.js"></SCRIPT>
	</HEAD>
	<SCRIPT>
	function confirmClearSubstitution()
	{
		return confirm("[DEP.0002.0169] Do you want to clear all substitutions? You cannot undo this action.");
	}
	</SCRIPT>	
	<TABLE width=100%>
		<TR>
			<TD class="menusection-Deployer">%value key% > Target Substitutions and Source Values</TD>
		</TR>
	</TABLE>
	<TABLE width="100%">
	%ifvar action equals('saveMultiple')%	
		%invoke wm.deployer.gui.UIVarsub:saveVarSubItemForMultipleServers%
			%include error-handler.dsp%
		
		%onerror%
			%loop -struct%
				<tr><td>%value $key%=%value%</td></tr>
			%endloop%
		%end invoke%
	%end if%
	
	%ifvar actionButton equals('Save Substitutions')%	
		%invoke wm.deployer.gui.UIVarsub:saveVarSubItem%
			%include error-handler.dsp%

		%onerror%
			%loop -struct%
				<tr><td>%value $key%=%value%</td></tr>
			%endloop%
		%end invoke%
	%end if%
	
	%ifvar actionButton equals('Clear Substitutions')%	
		%invoke wm.deployer.gui.UIVarsub:removeVarSubItem%
			%include error-handler.dsp%

		%onerror%
			%loop -struct%
				<tr><td>%value $key%=%value%</td></tr>
			%endloop%
		%end invoke%
	%end if%
	</TABLE>
	
	%ifvar /mode equals('edit')%
		%invoke wm.deployer.gui.UIVarsub:getVarSubWSD%
			%include error-handler.dsp%
		%onerror%
			%loop -struct%
				<tr><td>%value $key%=%value%</td></tr>
			%endloop%
		%end invoke%
	%end if%

	%ifvar /mode equals('assetListing')%
		%invoke wm.deployer.gui.UIVarsub:getVarSubWSDByAsset%
			%include error-handler.dsp%
		%onerror%
			%loop -struct%
				<tr><td>%value $key%=%value%</td></tr>
			%endloop%
		%end invoke%
	%end if%
	
	<BODY>
		<TABLE width=100%>
			<FORM NAME="properties" action="varsub-wsd-page.dsp" method="POST">
				<INPUT type="hidden" name="projectName" value="%value projectName%">
				<INPUT type="hidden" name="deploymentMapName" value="%value deploymentMapName%">
				<INPUT type="hidden" name="deploymentSetName" value="%value deploymentSetName%">
				<INPUT type="hidden" name="sourceServerAlias" value="%value sourceServerAlias%">
				<INPUT type="hidden" name="targetServerAlias" value="%value targetServerAlias%">
				<INPUT type="hidden" name="key" value="%value key%">
				<INPUT type="hidden" name="varSubItemType" value="%value varSubItemType%">
				<INPUT type="hidden" name="type" value="%value currentItem/type%">
				<INPUT type="hidden" name="packageName" value="%value packageName%">
				<INPUT type="hidden" name="mode" value="edit">
				<INPUT type="hidden" name="action" value="saveMultiple">
				<INPUT type="hidden" name="pluginType" value="%value pluginType%">
				<INPUT type="hidden" name="service" value="%value service%">
				<INPUT type="hidden" name="listOfTargetServerAlias" value="%value listOfTargetServerAlias%">
				<TR>
					<TD><IMG SRC="images/blank.gif" height=10 width=10></TD>
					<TD>
						<TABLE class="tableForm">
							<TR>
								<TD class="heading" colspan="2">Details for %value key%</TD>
							</TR>
							<TR>
								<TD class="evenrow">Web Service Descriptor Name</TD>
								<TD class="evenrowdata-l"> %value key% </TD>
							</TR>
							<TR>
								<TD class="oddrow">Package Name</TD>
								<TD class="oddrowdata-l"> %value packageName% </TD>
							</TR>			
							<TR>
								<TD class="heading" colspan="2">Web Service Descriptor Properties </TD>
							</TR>
							<SCRIPT> resetRows(); </SCRIPT>
							<TR>
								<TD class="heading" colspan="2">
									Handler Properties
								</TD>
							</TR>					
							<TR>
								<SCRIPT> 
									writeTD("row"); 
								</SCRIPT> Security Handler Name 
									</TD>
								<SCRIPT> 
									writeTD("row-l"); 
								</SCRIPT>
								<input id="handlerName" name="handlerName" value="%value /varSubItem/handlerData/securityHandlerName%" size=30><script> xl("%value /currentItem/securityHandlerName%"); </script>
									</TD>
							</TR>
							<TR>
								<SCRIPT> 
									writeTD("row"); 
								</SCRIPT> Policy Name 
									</TD>
								<SCRIPT> 
									writeTD("row-l"); 
								</SCRIPT>
								<input id="policyName" name="policyName" value="%value /varSubItem/handlerData/policyName%" size=30><script> xl("%value /currentItem/policyName%"); </script>
									</TD>
							</TR>
							<TR>
								<SCRIPT> 
									writeTD("row"); 
								</SCRIPT> Effective Policy Name 
									</TD>
								<SCRIPT> 
									writeTD("row-l"); 
								</SCRIPT>
								<input id="effectivePolicyName" name="effectivePolicyName" value="%value /varSubItem/handlerData/effectivePolicyName%" size=30><script> xl("%value /currentItem/effectivePolicyName%"); </script>
									</TD>
							</TR>														
							<SCRIPT> resetRows(); </SCRIPT>
							<TR>
								<TD class="heading" colspan="2">
									Binder Properties
								</TD>
							</TR>	
							<TR>
								<SCRIPT> 
									writeTD("row"); 
								</SCRIPT> Port Alias 
									</TD>
								<SCRIPT> 
									writeTD("row-l"); 
								</SCRIPT>
								<input id="portAlias" name="portAlias" value="%value /varSubItem/BinderData/portAlias%" size=30><script> xl("%value /currentItem/portAlias%"); </script>
									</TD>
							</TR>						
							<TR>
								<SCRIPT> 
									writeTD("row"); 
								</SCRIPT> Transport Type 
									</TD>
								<SCRIPT> 
									writeTD("row-l"); 
								</SCRIPT>
								<input id="transportType" name="transportType" value="%value /varSubItem/BinderData/transportType%" size=30><script> xl("%value /currentItem/transportType%"); </script>
									</TD>
							</TR>							
							<TR>
								<SCRIPT> 
									writeTD("row"); 
								</SCRIPT> Binding Name 
									</TD>
								<SCRIPT> 
									writeTD("row-l"); 
								</SCRIPT>
								<input id="bindingName" name="bindingName" value="%value /varSubItem/BinderData/bindingName%" size=30><script> xl("%value /currentItem/bindingName%"); </script>
									</TD>
							</TR>
							<TR>
								<SCRIPT> 
									writeTD("row"); 
								</SCRIPT> Port Type Name 
									</TD>
								<SCRIPT> 
									writeTD("row-l"); 
								</SCRIPT>
								<input id="portTypeName" name="portTypeName" value="%value /varSubItem/BinderData/portTypeName%" size=30><script> xl("%value /currentItem/portTypeName%"); </script>
									</TD>
							</TR>
							<TR>
								<SCRIPT> 
									writeTD("row"); 
								</SCRIPT> SOAP Protocol 
									</TD>
								<SCRIPT> 
									writeTD("row-l"); 
								</SCRIPT>
								<input id="soapProtocol" name="soapProtocol" value="%value /varSubItem/BinderData/soapProtocol%" size=30><script> xl("%value /currentItem/soapProtocol%"); </script>
									</TD>
							</TR>
							<TR>
								<SCRIPT> 
									writeTD("row"); 
								</SCRIPT> Binding Style 
									</TD>
								<SCRIPT> 
									writeTD("row-l"); 
								</SCRIPT>
								<input id="bindingStyle" name="bindingStyle" value="%value /varSubItem/BinderData/bindingStyle%" size=30><script> xl("%value /currentItem/bindingStyle%"); </script>
									</TD>
							</TR>
							<TR>
								<SCRIPT> 
									writeTD("row"); 
								</SCRIPT> Binding Use 
									</TD>
								<SCRIPT> 
									writeTD("row-l"); 
								</SCRIPT>
								<input id="bindingUse" name="bindingUse" value="%value /varSubItem/BinderData/bindingUse%" size=30><script> xl("%value /currentItem/bindingUse%"); </script>
									</TD>
							</TR>
							<TR>
								<TD colspan="1" class="action">
									<input name="actionButton" type="submit" value="Save Substitutions"> 
								</TD>
								<TD colspan="1" class="action">
									<input onclick="return confirmClearSubstitution();" name="actionButton" type="submit" value="Clear Substitutions"> 
								</TD>
							</TR>
              </FORM>
						</TABLE>
			%endif%
				</TR>
			
		</TABLE>
	</BODY>
</HTML>