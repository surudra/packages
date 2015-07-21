<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta http-equiv="Expires" content="-1">
  <title>Integration Server Settings</title>
  <link rel="stylesheet" type="text/css" href="webMethods.css">
  <script src="webMethods.js.txt"></script>
  <script language="JavaScript">
  </script>
</head>

 <body onLoad="setNavigation('settings-messaging.dsp',  '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Msging_JMS_TriggerMgmt_WSEndpontTrigger', true);">

  <table width="100%"><tbody>
  
  <!-- --------------------------------- -->
  <!-- Header Msg. (Invoke updates here) -->
  <!-- --------------------------------- -->
  
  <!-- Update the Trigger Properties -->
  
  %ifvar action equals('update')%
    %scope rparam(properties={enabled='';isConcurrent='';maxExecutionThreads=''})%
	%scope properties%	
	    %rename ../enabled enabled -copy%
	    %rename ../concurrent isConcurrent -copy%
	    %rename ../maxExecutionThreads maxExecutionThreads -copy%
	    %rename ../connectionCount connectionCount -copy%
	%endscope%
	    %invoke wm.server.jms:updateWSETrigger%
	      <script>writeMessage('Settings changed successfully');</script>
	    %onerror%
	      <script>writeMessage('%value -htmlcode errorMessage%');</script>
	    %endinvoke% 
    %endscope%
  %endif%
  
    <!-- ---------- -->
    <!-- Start Page -->
    <!-- ---------- -->
  
    %invoke wm.server.jms:getTriggerReport%
  
    <tr>
      <td class="menusection-Settings" colspan="4">Settings &gt; Messaging &gt; JMS Trigger Management &gt; Detail &gt; %value triggerName%<br>
      </td>
    </tr>
    <tr>
      <td colspan="2">
      <ul>
        <li><a href="settings-jms-trigger-management.dsp?type=soap">Return to JMS Trigger Management</a></li>
        <li><a href="endpoint-trigger-edit.dsp?triggerName=%value triggerName%">Edit Trigger</a></li>
        <li><a href="endpoint-trigger-details.dsp?triggerName=%value triggerName%">Refresh Page</a></li>
      </ul>
      </td>
    </tr>
    <tr>
      <td><img src="images/blank.gif" height="10" width="10" border="0"></td>
      <td>
      
      <!-- --------------------- -->
      <!-- JMS Destinations and Message Selectors Info -->
      <!-- --------------------- -->
      
      <table width="100%" class="tableView"><tbody>  
        <tr>
          <td class="heading" colspan="5">JMS Destinations and Message Selectors</td>
        </tr>
        <tr>
          <td class="oddcol-l">Destination Name</td>
          <td class="oddcol-l">Destination Type</td>
          <td class="oddcol-l">JMS Message Selector</td>
          <td class="oddcol-l">Durable Subscriber Name</td>
          <td class="oddcol-l">Ignore Local Published</td>
        </tr>
          
        %loop trigger/destinations%                  
            <tr>
                <script>writeTD("rowdata-l");</script>
                  %value destination%
                </td>
                <script>writeTD("rowdata-l");</script>
		   %switch destinationType%
			%case '0'% Queue
			%case '1'% XA Queue
			%case '2'% Topic
			%case '3'% XA Topic
		   %end%
                </td>
                <script>writeTD("rowdata-l");</script>
                  %ifvar messageSelector% %value messageSelector% %else% N/A %endif%
                </td>
		<script>writeTD("rowdata-l");</script>
                  %ifvar durableSubscriberName% %value durableSubscriberName% %else% N/A %endif%
                </td>
		<script>writeTD("rowdata-l");</script>
                  %ifvar durableSubscriberNoLocal% %value durableSubscriberNoLocal% %else% false %endif%
                </td>
            </tr>
          <script>swapRows();</script>
        %endloop%
	<TR>
		<TD><IMG SRC="images/blank.gif" width=10 height=10 border=0 colspan=2></TD>
       </TR>	

      </tbody></table>
      
      <!-- ----------------------- -->
      <!-- Write State Information -->
      <!-- ----------------------- -->
      
      <table width="100%"><tbody>
        <tr>
          <td class="heading" colspan="2">State</td>
        </tr>

        <tr>
            <td class="oddrow-l">Enabled</td>
            <td class="oddrowdata-l">%value trigger/enabled%</td>
        </tr>
        
        
        	<!-- Error message -->
	      %ifvar trigger/lastError%
	      <tr>
               <script>writeTDspan("row-l", 2);</script>
                  <font color="red">%value trigger/lastError%</font><br> 
               </td>
        </tr>
	      %endif%
        
        <tr>
            <td class="evenrow-l">Current Threads</td>
            <td class="evenrowdata-l">%ifvar trigger/currentThreads equals('-1')% Not Connected %else% %value trigger/currentThreads% %endif%</td>
        </tr>
        
        <tr>
        </tr>

        <!-- -------------------------- -->
        <!-- Write Settings Information -->
        <!-- -------------------------- -->
        <TR>
       <TD><IMG SRC="images/blank.gif" width=10 height=10 border=0 colspan=2></TD>
       </TR>	

        <tr>
          <td class="heading" colspan="2">Settings</td>
        </tr>
        <tr>
          <td class="oddrow-l">JMS Connection Alias</td>
          <td class="oddrowdata-l">%value trigger/aliasName%</td>
        </tr>
        <tr>
          <td class="evenrow-l">JMS Trigger Type</td>
          <td class="evenrowdata-l">
		 SOAP-JMS (WS Endpoint Trigger)
	  </td>
        </tr>

        <!-- -------------------------- -->
        <!-- Write Property Information -->
        <!-- -------------------------- -->
        <TR>
		      <TD><IMG SRC="images/blank.gif" width=10 height=10 border=0 colspan=2></TD>
        </TR>	

        <tr>
          <td class="heading" colspan="2">Properties</td>
        </tr>
        <tr>
          <td class="oddrow-l">Processing Mode</td>
          <td class="oddrowdata-l">%value trigger/processingModeLocalizedString%</td>
        </tr>

        <tr>
          <td class="evenrow-l">Maximum Execution Threads</td>
          <td class="evenrowdata-l">%value trigger/maxThreadsString%</td>
        </tr>     
        <tr>
          <td class="oddrow-l">Connection Count</td>
          <td class="oddrowdata-l">%value trigger/connectionCount%</td>
        </tr>         
       
    </tbody></table>
    </td>
    </tr>
  
  %onerror%
    <script>writeMessage('Error: %value -htmlcode errorMessage%');</script>
  %endinvoke%
  </tbody></table>

</body></html>