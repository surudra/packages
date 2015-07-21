<html>
<head>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <meta http-equiv="Expires" CONTENT="-1">
  <link rel="stylesheet" TYPE="text/css" href="webMethods.css">
  <script src="client.js.txt"></script>
  <script src="acls.js.txt"></script>
  <SCRIPT type="text/javascript" SRC="/WmRoot/webMethods.js.txt"></SCRIPT>
  <script type="text/javascript" src="/WmAssetPublisher/ap.js.txt"></script>
  
  <script language ="javascript">
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
  
  
  	<script language ="javascript">
  	
  	function getSelectedCategories(selectList, separator){
  	var i
  	var count = 0
  	var tempString = ""
  	for (i = 0; i < selectList.length; i++){
  	   if (selectList.options[i].selected){
  	      if (count > 0) tempString += separator
  	      tempString += selectList.options[i].text
  	      count++
  	      }
  	   }
          document.addform.categoriesVal.value = tempString    
          return tempString
  	
  	}
  	
  	var toggle = 1;
      function writeToggleClass() {
      	if(toggle == 0) {
      		toggle = 1;
      		document.write("<tr class='evenrow-l'>");
      	} else {
      		toggle = 0;
      		document.write("<tr class='oddrow-l'>");
      	}
      }
	</script> 
	
</head>


%switch loggerName%
	%case 'Document Logger'%
				<body onLoad="setNavigation('settings-auditing.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_EditDocumentLoggerScrn');">
	%case 'Error Logger'%
				<body onLoad="setNavigation('settings-auditing.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_EditErrorLoggerScrn');">				
	%case 'Guaranteed Delivery Inbound Logger'%
				<body onLoad="setNavigation('settings-auditing.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_EditGDInboundLoggerScrn');">				
	%case 'Guaranteed Delivery Outbound Logger'%
				<body onLoad="setNavigation('settings-auditing.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_EditGDOutboundLoggerScrn');">				
	%case 'Security Logger'%
				<body onLoad="setNavigation('settings-auditing.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_EditSecurityLoggerScrn');">				
	%case 'Service Logger'%
				<body onLoad="setNavigation('settings-auditing.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_EditServiceLoggerScrn');">				
	%case 'Session Logger'%
				<body onLoad="setNavigation('settings-auditing.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_EditSessionsLoggerScrn');">				
	%case 'Mediator Transaction Logger'%
				<body onLoad="setNavigation('settings-auditing.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_EditMediatorTransactionLoggerScrn');">
	%case%
				<body onLoad="setNavigation('settings-auditing.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_LoggingScrn');">
%endswitch%


%invoke wm.server.auditing:getAuditLoggerDetails%

<table name="pagetable" align='left' width="100%">

    <tr>
      <td class="menusection-Settings" colspan="4">Settings &gt; Logging &gt; Edit %value loggerNameDisplay% Details</td>
    </tr>

    <tr>
      <td colspan="2">
        <ul>
          <li><a href="settings-auditing.dsp">Return to Logger List</a></li>
          <li><a href="settings-auditing-detail.dsp?loggerNameDisplay=%value loggerNameDisplay encode(url)%&loggerName=%value loggerName encode(url)%">Return to View %value loggerNameDisplay% Details</a></li>
        </ul>
      </td>
    </tr>

    <form name="loggerform" action="settings-auditing-detail.dsp" METHOD="POST">
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
					    
					    <script>writeToggleClassData();</script>
						 <input name="isEnabled" type="radio" value="true" %ifvar hasSecurity equals('true') %onClick="checkStatus(this.value)" %endif% %ifvar isEnabled equals('true')%checked%endif% %ifvar canDisable equals('false')%disabled%endif%> Yes</input>
						 <BR/><input name="isEnabled" type="radio" value="false" %ifvar hasSecurity equals('true') %onClick="checkStatus(this.value)" %endif% %ifvar isEnabled equals('false')%checked%endif% %ifvar canDisable equals('false')%disabled%endif%> No</input>
					    </td>

					  </tr>

					  %ifvar hasLevel equals('true')%
						  <tr>
						    <input name="hasLevel" type = "hidden" value="true">
						    <script>writeToggleClassRow();</script>Level</td>
						    <script>writeToggleClassData();</script>
						    <SELECT NAME="level">
						       <OPTION %ifvar level equals('perSvc')% selected="selected" %endif% value ="perSvc">perSvc</OPTION>
						       <OPTION %ifvar level equals('brief')% selected="selected" %endif% value ="brief">brief</OPTION>
						       <OPTION %ifvar level equals('verbose')% selected="selected" %endif% value ="verbose">verbose</OPTION>						    
						    </SELECT
						    </td>
						  </tr>
					  %endif%

					  <tr>
					    <script>writeToggleClassRow();</script>Mode</td>
					    <script>writeToggleClassData();</script>
    						 <input name="isAsynchronous" type="radio" value="false" %ifvar isAsynchronous equals('false')%checked%endif%> Synchronous</input>
						 <BR/><input name="isAsynchronous" type="radio" value="true" %ifvar isAsynchronous equals('true')%checked%endif%> Asynchronous</input>
					    </td>
					  </tr>

					  <tr>
					    <script>writeToggleClassRow();</script>Guaranteed</td>
					    <script>writeToggleClassData();</script>
						 <input name="isGuaranteed" type="radio" value="true" %ifvar isGuaranteed equals('true')%checked%endif%> Yes</input>
						 <BR/><input name="isGuaranteed" type="radio" value="false" %ifvar isGuaranteed equals('false')%checked%endif%> No</input>
					    </td>
					  </tr> 

					  <tr>
					    <script>writeToggleClassRow();</script>Maximum Queue Size</td>
					    <script>writeToggleClassData();</script>
					    <INPUT NAME="maxQueueSize" size="10" value="%value maxQueueSize%"> log entries</td>
					  </tr> 

					  <tr>
					    <script>writeToggleClassRow();</script>Destination</td>
					    <script>writeToggleClassData();</script>
						 <input name="isDatabase" type="radio" value="true" %ifvar isDatabase equals('true')%checked%endif% %ifvar isDBAllowed equals('false')%disabled%endif%> Database</input>
						 <BR/><input name="isDatabase" type="radio" value="false" %ifvar isDatabase equals('false')%checked%endif% %ifvar isFSAllowed equals('false')%disabled%endif%> File</input>
					    </td>
					  </tr> 

					  <tr>
					     <script>writeToggleClassRow();</script>Maximum Retries</td>
					     
					     <script>writeToggleClassData();</script>
					     <INPUT NAME="maxRetries" size="10" value="%value maxRetries%"></td>
					  </tr> 

					  <tr>
					     <script>writeToggleClassRow();</script>Wait Between Retries</td>
					     <script>writeToggleClassData();</script>
					     <INPUT NAME="retryWait" size="3" value="%value retryWait%"> seconds</td>
					  </tr> 


					   %ifvar hasSecurity equals('true')%

			  			<tr>
					             <script>writeToggleClassRow();</script>Generate Auditing Data on Startup</td>
						    <script>writeToggleClassData();</script>
							 <input name="startup" type="radio" value="true" %ifvar startup equals('true')%checked%endif%> Yes</input>
							 <BR/><input name="startup" type="radio" value="false" %ifvar startup equals('false')%checked%endif%> No</input>
						    </td>
					        </tr>		


						<tr>
						    <script>writeToggleClassRow();</script>Generate Auditing Data on </td>	
						    <script>writeToggleClassData();</script>

							   <SELECT NAME="result">
							       <OPTION %ifvar result equals('Success')% selected="selected" %endif% value ="Success" >Success</OPTION>
							       <OPTION %ifvar result equals('Failure')% selected="selected" %endif% value ="Failure" >Failure</OPTION>
							       <OPTION %ifvar result equals('Success or Failure')% selected="selected" %endif% value ="Success or Failure" >Success or Failure</OPTION>
							   </SELECT>
						</tr>

					   %endif%

				    
				    </table>				
				</TD>
			
			
			</TR>
	
			%ifvar hasSecurity equals('true')%
			
			<tr>
		          	<input name="categoriesVal" type = "hidden">
		          	<input name="selAreas" type = "hidden">
		          	<input name="sec-audit-conf-saved" type = "hidden" value="03233">
		          	<input name="hasSecurity" type = "hidden" value="true">
			</tr>
			<tr>
				<td><img src="images/blank.gif" height=10 width=0 border=0></td>
			</tr>


					<tr>
						<td>
						<table width="100%">
					       <TR>
						    <TD class="heading" colspan="2" >Security Areas to Audit</TD>
					       </TR>
					       <script>var allCategories ="";</script>
					    %loop defaultAreas%
						<script>writeToggleClass();
							 allCategories  = allCategories +"%value%,";
						</script>
							<td>
							<input type="checkbox" name="%value%" id="%value%"></input>
							</td>
							<td width="100%">%value%</td>
						</tr>
						%endloop%
					</table>
					</td>
				</tr>


				<tr>
				    <script>writeTDspan('rowdata-l', 2)</script>
				      <div name="Aa" id="Aa">
					Select:
					<a href="#" onclick="SetOrUnset(true);">All</a>, 
					<a href="#" onclick="SetOrUnset(false);">None</a>
				     </div>
				    </td>
				</tr>

			%endif%
			
			<TR>
			    <TD>
			
			        <!-- Submit Button -->
			        
			        <TABLE class="tableView" width="100%">
			          <tr>
			              <td class="action" colspan=2>
			                
			                <input name="action" type="hidden" value="saveAuditData">
			                <input name="loggerName" type="hidden" value="%value loggerName%">
			                <input type="submit" value="Save Changes" onClick="javascript:return validateForm(this.form)">
			                
			                
			              </td>
			            </tr>
			        
			        </table>
			       </TD> 
			 </TR>

      	</TABLE>
      </td>

    </tr>

   </form>
</table>
</body>

<SCRIPT>

	var selCategories = "";
	%loop categories%
	selCategories  = selCategories +"%value%,";
	%endloop%
	selectCategories(selCategories);
	
	function selectCategories(scate) {
		var selOpt = scate.split(",");
		var selLen = selOpt.length;
		for (i = 0; i < selLen; i++){
			var opt = selOpt[i];
			var checkObj = document.getElementById(opt);
			if(checkObj!= null){
				checkObj.checked = true;
			}
		}
	}

	function SetOrUnset(val){
		var selOpt = allCategories.split(",");
		var selLen = selOpt.length;
		for (i = 0; i < selLen; i++){
			var opt = selOpt[i];
			var checkObj = document.getElementById(opt);
			if(checkObj!= null){
				checkObj.checked = val;
			}
		}
	}

	
	function getEnabledVals(){
		var selAreas ="";
	   	for(i=0;i<document.loggerform.length;i++){
			if(document.loggerform[i].type=="checkbox"&&document.loggerform[i].checked){
			   selAreas = selAreas +document.loggerform[i].name;
			   selAreas += ",";
			}
		}
		document.loggerform.selAreas.value = selAreas;
		return true;
 	}
 	
  function checkStatus(val) {
    	if(val == "true") {
  		disableElements(false);  		
  		document.getElementById("Aa").style.display="";
  		}
  	else {
  	 disableElements(true);
  	 }
  }
	
  function disableElements(disable) {
  	
  	for(i=0;i<document.loggerform.length;i++){
	    		var typ = document.loggerform[i].type;
				if(typ=="checkbox"){
			   		document.loggerform[i].disabled = disable;
	
				}
				
				if ( document.loggerform[i].name == "startup" ) {
					document.loggerform[i].disabled = disable;
				}
			}
			document.loggerform.result.disabled = disable;		
			document.getElementById("Aa").style.display="none";
  }
  
  function checkEnabled(){
        %ifvar hasSecurity equals('true')%
        	%ifvar isEnabled equals('false')%
        		disableElements(true);
        	%endif%
        %endif%

	return true;
 }

 function isValueInRange(dataValue, minValue, maxValue) {
 
       if (! isInteger(dataValue))
       {
       	return false;
       }
       
       if (parseInt(dataValue) < parseInt(minValue) || parseInt(dataValue) > parseInt(maxValue) ) 
       {
 	return false;
       }
       
       return true;
 }
 
 function validateForm(form) {

   var dataVal = form.maxQueueSize.value;
   var maxValue = 2147483647;
   var minValue = 0;

   if (dataVal == "") {
     alert("Maximum Queue Size must be specified.");
     
     return false;
   }

   if ( ! isValueInRange(dataVal, minValue, maxValue) ) {
     	alert("Invalid value for Maximum Queue Size specified. It must be >= " + minValue + " and <= " + maxValue);
     	return false;
   }


   dataVal = form.maxRetries.value;
   if (dataVal == "") {
     alert("Maximum Retries must be specified.");
     return false;
   }

   if ( ! isValueInRange(dataVal, minValue, maxValue) ) {
     	alert("Invalid value for Maximum Retries specified. It must be >= " + minValue + " and <= " + maxValue);
     	return false;
   }

   dataVal = form.retryWait.value;
   maxValue = 5;
   if (dataVal == "") {
     alert("Wait Between Retries must be specified.");
     return false;
   }

   if ( ! isValueInRange(dataVal, minValue, maxValue) ) {
     	alert("Invalid value for Wait Between Retries specified. It must be >= " + minValue + " and <= " + maxValue);
     	return false;
   }

   getEnabledVals();
   return true;
 }

</script>
</html>