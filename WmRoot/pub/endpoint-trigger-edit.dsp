<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta http-equiv="Expires" content="-1">
  <title>Integration Server Settings</title>
  <link rel="stylesheet" type="text/css" href="webMethods.css">
  <script src="webMethods.js.txt"></script>

  
  <script Language="JavaScript">
      
      var oldMaxExecutionThreads = "1";
      var oldConnectionCount = "1";
      var procModeIsSerial = false;
      
      %invoke wm.server.jms:getTriggerReport%
      var maxThreadsAsString = "%value trigger/maxThreadsString%";
      var maxThreads = maxThreadsAsString.substring(maxThreadsAsString.indexOf('(')+1, maxThreadsAsString.indexOf(')'));
      
      function init()
      {
		    %loop trigger/destinations%
			    document.editform.destinationName.value = "%value destination%";
		    %endloop%

		    %ifvar trigger/concurrent equals('true')%
			    document.editform.concurrent[0].checked = true;
		    %else%
			    document.editform.concurrent[1].checked = true;
			    document.editform.maxExecutionThreads.disabled=true;
			    document.editform.connectionCount.disabled=true;
			    procModeIsSerial=true;
		    %endif%
		
		    document.editform.maxExecutionThreads.value = maxThreads;
		
        /*
		    if ( document.editform.concurrent[0].checked == true) 
		    {
			    document.editform.maxExecutionThreads.value = maxThreads;
			    document.editform.maxExecutionThreads.disabled = false;
		    }
		      else
		    {
			    document.editform.maxExecutionThreads.value = "N/A";
			    document.editform.maxExecutionThreads.disabled = true;
		    }
		    */  
      }
     
    function modeChange()
    {
		  if ( document.editform.concurrent[0].checked == true) 
		  {
			  document.editform.maxExecutionThreads.value = maxThreads;
			  document.editform.maxExecutionThreads.disabled = false;
		  }
		  else
		  {
			  document.editform.maxExecutionThreads.value = "N/A";
			  document.editform.maxExecutionThreads.disabled = true;
		  }
    }
    
    function changeToSerial(f) {
      if (!procModeIsSerial) {
        procModeIsSerial=true;
        oldMaxExecutionThreads = f.maxExecutionThreads.value;
        oldConnectionCount = f.connectionCount.value;
        f.maxExecutionThreads.disabled=true;
        f.maxExecutionThreads.value="1";
        f.connectionCount.disabled=true;
        f.connectionCount.value="1";
      }
    }
    
    function changeToConcurrent(f) {
      procModeIsSerial=false;
      f.maxExecutionThreads.disabled=false;
      f.maxExecutionThreads.value=oldMaxExecutionThreads;
      f.connectionCount.disabled=false;
      f.connectionCount.value=oldConnectionCount;
    }
    
  </script>
  
  
</head>

<body onLoad="init(); setNavigation('endpoint-trigger-edit.dsp',  '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Msging_JMS_TriggerMgmt_Edit_WSEndpontTrigger');">

<table width="100%">
  <tbody>
    <tr>
      <td class="menusection-Settings" colspan="4">Settings &gt; Messaging &gt; JMS Trigger Management &gt; Edit Trigger &gt; WS Endpoint Trigger: %value trigger/wseAlias%<br>
      </td>
    </tr>
    <tr>
      <td colspan="2">
      <ul>
        <li><a href="settings-jms-trigger-management.dsp?type=soap">Return to JMS Trigger Management</a></li>
        <li><a href="endpoint-trigger-details.dsp?triggerName=%value triggerName%">Return to Trigger Detail</a></li>
      </ul>
      </td>
    </tr>
    <tr>
      <td><img src="images/blank.gif" height="10" width="10" border="0"></td>
      <td>
        <table>
        <tbody>
          <form name="editform" action="endpoint-trigger-details.dsp?triggerName=%value triggerName%" METHOD="POST">
	    
            <tr>
              <td class="heading" colspan="2">Properties</td>
            </tr>
  
            <tr>
              <td class="oddrow-l">JMS Connection Alias</td>
              <td class="oddrowdata-l">
			        %invoke wm.server.jms:getConnectionAliasReport%
			          <SELECT NAME="aliasName">
				        %loop aliasDataList%
					        <OPTION value="%value aliasName%" %ifvar aliasName vequals(../trigger/aliasName)% selected %endif%>%value aliasName%</OPTION>
				        %endloop%
			          </SELECT>
			        %endinvoke%
              </td>   
            </tr>
            
            <tr>
              <td class="evenrow-l">Destination Name</td>
              <td class="evenrowdata-l">
		            <input type="text" name="destinationName">
	            </td>
            </tr>
		
	          <tr>
              <td class="oddrow-l">Processing Mode</td>
              <td class="oddrowdata-l">
	             <input type="radio" name="concurrent" value="true" onclick="changeToConcurrent(this.form);">Concurrent</input>
		           <input type="radio" name="concurrent" value="false" onclick="changeToSerial(this.form);">Serial</input>
              </td>
            </tr>

            <tr>
                <td class="evenrow-l">Max Execution Threads</td>
                <td class="evenrowdata-l">
                  <input type="text" name="maxExecutionThreads">
                </td>
             </tr>
   
             <tr>
                <td class="oddrow-l">Connection Count</td>
                <td class="oddrowdata-l">
                  <input type="text" name="connectionCount" value="%value trigger/connectionCount%">
                </td>
             </tr>
          
            <tr>
              <td class="action" colspan=2>
                <input name="triggerName" type="hidden" value="%value triggerName%">
		            <input name="enabled" type="hidden" value="%value trigger/enabled%">
                <input name="action" type="hidden" value="update">
                <input type="submit" value="Save Changes">
              </td>
            </tr>
           </form>
         </tbody>
         </table>
      </td>
    </tr>
  </tbody>
</table>

 %endinvoke%
</body>
</html>
