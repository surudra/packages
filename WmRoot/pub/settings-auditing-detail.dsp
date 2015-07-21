<html>
<head>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <meta http-equiv="Expires" CONTENT="-1">
  <link rel="stylesheet" TYPE="text/css" href="webMethods.css">
  <script src="webMethods.js.txt">
  </script>
  
  <script>
      var toggleRow = 1;
      function writeToggleClassRow() {
      	if(toggleRow == 0) {
      	   toggleRow = 1;
      	   document.write("<td class='evenrow-l'>");
      	} 
      	else {
      	   toggleRow = 0;
      	   document.write("<td class='oddrow-l'>");
      	}
    }

    var toggleData = 1;
      function writeToggleClassData() {
      	if(toggleData == 0) {
      	   toggleData = 1;
      	   document.write("<td class='evenrowdata-l'>");
      	} 
      	else {
      	   toggleData = 0;
      	   document.write("<td class='oddrowdata-l'>");
      	}
    }
  
  
  </script>
  
</head>

%switch loggerName%
	%case 'Document Logger'%
				<body onLoad="setNavigation('settings-auditing.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_DocumentLoggerScrn');">
	%case 'Error Logger'%
				<body onLoad="setNavigation('settings-auditing.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_ErrorLoggerScrn');">				
	%case 'Guaranteed Delivery Inbound Logger'%
				<body onLoad="setNavigation('settings-auditing.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_GDInboundLoggerScrn');">				
	%case 'Guaranteed Delivery Outbound Logger'%
				<body onLoad="setNavigation('settings-auditing.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_GDOutboundLoggerScrn');">				
	%case 'Security Logger'%
				<body onLoad="setNavigation('settings-auditing.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_SecurityLoggerScrn');">				
	%case 'Service Logger'%
				<body onLoad="setNavigation('settings-auditing.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_ServiceLoggerScrn');">				
	%case 'Session Logger'%
				<body onLoad="setNavigation('settings-auditing.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_SessionsLoggerScrn');">				
	%case 'Mediator Transaction Logger'%
				<body onLoad="setNavigation('settings-auditing.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_MediatorTransactionLoggerScrn');">
	%case%
				<body onLoad="setNavigation('settings-auditing.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_LoggingScrn');">	
%endswitch%



<table name="pagetable" align='left' width="100%">

    <tr>
      <td class="menusection-Settings" colspan="4">Settings &gt; Logging &gt; View %value loggerNameDisplay% Details</td>
    </tr>

	%ifvar action equals('saveAuditData')%

		%ifvar sec-audit-conf-saved -notempty%  
			%ifvar status -notempty%
		  		%rename status status -copy%
			%endif%

			%ifvar result -notempty%
			  %rename result result -copy%
			%endif%

			%ifvar selAreas -notempty%
			   %rename selAreas categories -copy%
			%endif%

			%ifvar startup -notempty%
			  %rename startup startup -copy%
			%endif%

		%endif%

		%invoke wm.server.auditing:setAuditLoggerDetails%    

			%ifvar message%
				<tr>
				  <td colspan="2">&nbsp;</td>
				</tr>
				<tr>
				  <td class="message" colspan=2>%value none message%</td>
				</tr>
			%endif%
		%onerror%
			<tr>
			  <td class="message" colspan=2>%value none errorMessage%</td>
			</tr>
		%endinvoke%
	%endif%


%invoke wm.server.auditing:getAuditLoggerDetails%

  <script>
  	var catlist = new Array();
  	var j=0;
  	%loop categories%
  		catlist[j]="%value%";
  		j++;
  	%endloop%
  	    function writeImageForEnabled(val) {
  	    	
  	    	for(i = 0; i < catlist.length; i++) {
  	    		if(val==catlist[i]) {
  	    			document.write("<div align='center'><img src='images/green_check.gif' border='0' alt='Selected' height='13' width='13'></div>");
  	    			return true;
  	    		}
  	    	}
  	    	
  	    }
  	    var toggle = 1;
  	    function writeToggleClass() {
  	    	if(toggle == 0) {
  	    		toggle = 1;
  	    		document.write("<tr class='oddrow-l'>");
  	    	} else {
  	    		toggle = 0;
  	    		document.write("<tr class='evenrow-l'>");
  	    	}
  	    }
 </script>


    <tr>
      <td colspan="2">
        <ul>
          <li><a href="settings-auditing.dsp">Return to Logger List</a></li>
          <li><a href="settings-auditing-edit.dsp?loggerName=%value loggerName encode(url)%">Edit %value loggerNameDisplay%</a></li>
        </ul>
      </td>
    </tr>

    <tr>

      <td><img src="images/blank.gif" height=10 width=10></td>
      <td>
      	<TABLE name="tableToHoldConfigurationAndActions" class="tableForm">
      	
			<TR>
				<TD>
				    <table width="100%">
					<TR>
		    	 			<TD colspan="2" class="heading">Audit Logger Configuration</TD>
		    			</TR>				    

					  <tr>
					    <script>writeToggleClassRow();</script>Name</td>
					    <script>writeToggleClassData();</script>%value loggerNameDisplay%</td>
					  </tr>

					  <tr>
					    <script>writeToggleClassRow();</script>Enabled</td>
					    %ifvar isEnabled equals('true')%
						<script>writeToggleClassData();</script>Yes</td>
					    %else%
						<script>writeToggleClassData();</script>No</td>
					    %endif%

					  </tr>

					  %ifvar hasLevel equals('true')%
						  <tr>
						    <script>writeToggleClassRow();</script>Level</td>
						    <script>writeToggleClassData();</script>%value level%</td>
						  </tr>
					  %endif%

					  <tr>
					    <script>writeToggleClassRow();</script>Mode</td>
					    %ifvar isAsynchronous equals('true')%
						<script>writeToggleClassData();</script>Asynchronous</td>
					    %else%
						<script>writeToggleClassData();</script>Synchronous</td>
					    %endif%
					  </tr>

					  <tr>
					    <script>writeToggleClassRow();</script>Guaranteed</td>
					    %ifvar isGuaranteed equals('true')%
						<script>writeToggleClassData();</script>Yes</td>
					    %else%
						<script>writeToggleClassData();</script>No</td>
					    %endif%
					  </tr> 

					  <tr>
					    <script>writeToggleClassRow();</script>Maximum Queue Size</td>
					    <script>writeToggleClassData();</script>%value maxQueueSize% log entries</td>
					  </tr> 

					  <tr>
					    <script>writeToggleClassRow();</script>Destination</td>

					    %ifvar isDatabase equals('true')%
						<script>writeToggleClassData();</script>Database</td>
					    %else%
						<script>writeToggleClassData();</script>File</td>
					    %endif%	

					  </tr> 

					  <tr>
					     <script>writeToggleClassRow();</script>Maximum Retries</td>
					     <script>writeToggleClassData();</script>%value maxRetries%</td>
					  </tr> 

					  <tr>
					     <script>writeToggleClassRow();</script>Wait Between Retries</td>
					     <script>writeToggleClassData();</script>%value retryWait% seconds</td>
					  </tr> 


					   %ifvar hasSecurity equals('true')%

			  			<tr>
					             <script>writeToggleClassRow();</script>Generate Auditing Data on Startup</td>
					             <script>writeToggleClassData();</script>
						             %ifvar startup equals('true')%
								        Yes
								 %else%
								 	No
								 %endif%
					             </td>
					        </tr>		


						<tr>
						    <script>writeToggleClassRow();</script>Generate Auditing Data on </td>	
						    <script>writeToggleClassData();</script>

							%ifvar result equals('Success')%
							   Success
							%endif%

							%ifvar result equals('Failure')%
							   Failure
							%endif%

							%ifvar result equals('Success or Failure')%
							   Success or Failure
							%endif%           	    
						    </td>
						</tr>

					   %endif%

				    
				    </table>				
				</TD>
			
			
			</TR>
	
			%ifvar hasSecurity equals('true')%
			<tr>
				<td><img src="images/blank.gif" height=10 width=0 border=0></td>
			</tr>
		

			<TR>
				<TD>
				    <table width="100%">
					<TR>
		    	 			<TD colspan="2" class="heading">Security Areas to Audit</TD>
		    			</TR>				    
		
					 %ifvar status equals('true')%
						%loop defaultAreas%
							<script>writeToggleClass();</script>
									<td>
										<script>
										writeImageForEnabled("%value%");
									</script>
								</td>
							<td>%value%</td>
							</tr>
							%endloop%
					%else%
							%loop defaultAreas%
							<script>writeToggleClass();</script>
									<td>
										<script>

									</script>
								</td>
							<td>%value%</td>
							</tr>
							%endloop%
					%endif%		
		
				    </table>				
				</TD>
			
			
			</TR>
			%endif%
      	</TABLE>
      </td>

    </tr>

</table>
</body>
</html>