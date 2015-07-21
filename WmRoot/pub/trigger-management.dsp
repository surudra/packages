<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="no-cache" http-equiv="Pragma">
  <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  <meta content="-1" http-equiv="Expires">
  <title>Server &gt; Statistics</title>
  <link href="webMethods.css" type="text/css" rel="stylesheet">
  <script src="webMethods.js.txt"></script>
  
  <script language="JavaScript">
  
    var messageFlag = false;
    
    function getMessageFlag() { 
      return messageFlag;
    }
    
    function setMessageFlag(value) {
      messageFlag = value;
    }
    
    function this_writeMessage(value) {
    
      if (!messageFlag) // this will avoid more than one error message at a time.
        writeMessage(value);
    }
    
    function showCluster() {
      prop = "%sysvar property('watt.server.cluster.aliasList')%";
      if (prop == null || prop.length < 1)
        return false;
      else
        return true;
    }
    
  </script>
</head>

<body onLoad="setNavigation('trigger-management.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_TriggerMgmtScrn');">

  <table width="100%"><tbody>
  
    <!-- ---------------- -->
    <!-- Edit State Logic -->
    <!-- ---------------- -->
  
  
    <script>alert("editMode = %value editMode%", retrievalState = %value retrievalState%, processingState = %value processingState%");</script>
    
    
    %ifvar editMode equals('changeState')%
 
      %ifvar retrievalState equals('suspended')%
        %invoke pub.trigger:suspendRetrieval%
        %onerror%
          <script>this_writeMessage('%value encode(javascript) errorMessage%');</script>
          <script>setMessageFlag(true);</script>
        %endinvoke%
      %endif%
  
      %ifvar retrievalState equals('active')%
        %invoke pub.trigger:resumeRetrieval%
        %onerror%
          <script>this_writeMessage('%value encode(javascript) errorMessage%');</script>
          <script>setMessageFlag(true);</script>
        %endinvoke%
      %endif%
    
      %ifvar processingState equals('suspended')%
        %invoke pub.trigger:suspendProcessing%
        %onerror%
          <script>this_writeMessage('%value encode(javascript) errorMessage%');</script>
          <script>setMessageFlag(true);</script>
        %endinvoke%
      %endif%
  
      %ifvar processingState equals('active')%
        %invoke pub.trigger:resumeProcessing%
        %onerror%
          <script>this_writeMessage('%value encode(javascript) errorMessage%');</script>
          <script>setMessageFlag(true);</script>
        %endinvoke%
      %endif%
      
      <script>this_writeMessage('Settings changed successfully');</script>
  
    %endif%

    %ifvar editMode equals('changeStateAll')%

      %invoke wm.server.triggers:suspendTrigger%
        <script>writeMessage('Settings changed successfully');</script>
      %onerror%
        <script>writeMessage('%value encode(javascript) errorMessage%');</script>
      %endinvoke%
    %endif%
  
    <tr>
      <td class="menusection-Settings" colspan="3">Settings &gt; Messaging &gt; webMethods Messaging Trigger Management</td>
    </tr>
    
    <!-- -------------------- -->
    <!-- Edit Global Controls -->
    <!-- -------------------- -->
    
    <tr>
      %ifvar action equals('change')%
        %invoke wm.server.admin:setTriggerThrottleControlSettings%
          <tr><td colspan="2">&nbsp;</td></tr>
          %ifvar message -notempty%
            <tr><td class="message" colspan=2>%value message%</td></tr>
          %else%
            <tr><td class="message" colspan=2>Settings changed successfully</td></tr>
          %endif%
        %onerror%
          <script>writeMessage('%value errorMessage%');</script>
        %endinvoke%
      %endif%
    </tr>
  </tbody></table>

<!-- --------------- -->
<!-- Start Main Page -->
<!-- --------------- -->

  <table width="100%"><tbody>
  
    <tr>
      <td colspan="2">
      <ul>
        <li><a href="settings-messaging.dsp">Return to Messaging</a></li>
        <li><a href="trigger-management-throttle-controls-edit.dsp">Edit Global webMethods Messaging Trigger Controls</a></li>
        <li><a href="trigger-management.dsp">Refresh Page</a></li>
        <script>
          if (showCluster())
            w("<li><a href='trigger-management-cluster.dsp'>Cluster View</a></li>");
        </script>
      </ul> 
      </td>
    </tr>
    
    <tr>
    </tr>
    
    %rename triggerName none%
    %invoke wm.server.triggers:getTriggerReport%
    
    <tr>
      <td><img style="width: 10px; height: 10px;" alt="" src="images/blank.gif"><br>
      </td>
      <td>
      <table width="100%" class="tableForm">
        <tbody>
          <tr>
           <td class="heading">Global webMethods Messaging Trigger Controls</td>
          </tr>
        </tbody>
      </table>
      <table style="width: 100%;">
        <tbody>
          <tr>
            <td width="50%" colspan="2" class="oddcol">Document Retrieval</td>
            <td width="50%" colspan="2" class="oddcol">Document Processing</td>
          </tr>
          <tr>
            <td class="evenrow-l" nowrap>Current Threads</td>
            %ifvar globalSettings/maximumDocumentRetrievalThreadsPct -notempty%
              <td class="evenrow-l" nowrap>%value globalSettings/currentNumberDocumentRetrievalThreads%</td>
            %else%
              <td class="evenrow-l">N/A</td>
            %endif%
            <td class="evenrow-l" nowrap>Current Threads</td>
            <td class="evenrow-l" nowrap>%value globalSettings/currentNumberTriggerExecutionThreads%</td>
          </tr>
          <tr>
            <td class="oddrow-l" nowrap>Maximum Threads</td>
            %ifvar globalSettings/maximumDocumentRetrievalThreadsPct -notempty%
              <td class="oddrow-l" nowrap>%value globalSettings/maximumDocumentRetrievalThreadsCount% (%value globalSettings/maximumDocumentRetrievalThreadsPct%% of Server Thread Pool)</td>
            %else%
              <td class="oddrow-l" nowrap>(Broker Not Configured)</td>
            %endif%
            <td class="oddrow-l" nowrap>Maximum Threads</td>
            %ifvar globalSettings/maximumTriggerExecutionThreadsCount -notempty%
              <td class="oddrow-l" nowrap>%value globalSettings/maximumTriggerExecutionThreadsCount% (%value globalSettings/maximumTriggerExecutionThreadsPct%% of Server Thread Pool)</td>
            %else%
              <td class="oddrow-l" nowrap></td>
            %endif%
          </tr>
          <tr>
            <td class="evenrow-l" nowrap>Queue Capacity Throttle</td>
            <td class="evenrow-l">%value globalSettings/triggerDocumentStoreThrottle%%</td>
            <td class="evenrow-l" nowrap>Execution Threads Throttle</td>
            <td class="evenrow-l">%value globalSettings/triggerExecutionThreadsThrottle%%</td>
          </tr>

        </tbody>
      </table>
    </tr>

    <tr>
    </tr>
    
    <tr>
      <td><img style="width: 10px; height: 10px;" alt="" src="images/blank.gif"><br>
      </td>
      <td>
      <table width="100%" class="tableForm">
        <tbody>
          <tr>
            <td class="heading">Individual webMethods Messaging Trigger Controls</td>
          </tr>
        </tbody>
      </table>  
      <table style="width: 100%;">
        <tbody>
          <tr>
            <td colspan="3" class="oddcol">&nbsp;</td>
            <td colspan="3" class="oddcol">Document Retrieval</td>
            <td colspan="4" class="oddcol">Document Processing</td>
          </tr>
          <tr>
            <td class="oddcol-l">
              <!-- Trigger Name&nbsp;&#9660;&nbsp;&#9650; -->
              Trigger Name
            </td>
            
            <!-- <td class="oddcol-l">Connection Alias Name&nbsp;&#9660;&nbsp;&#9650;</td> -->
            <td class="oddcol-l">Connection Alias Name</td>
            <td class="oddcol-l">Type</td>
            <td class="oddcol">Active<br><a href="trigger-management-edit-state.dsp?triggerName=all">edit&nbsp;all</a></td>      
            <td class="oddcol-l">Queue Capacity</td>
            <td class="oddcol-l">Current Queue Count</td>          
            <td class="oddcol">Active<br><a href="trigger-management-edit-state.dsp?triggerName=all">edit&nbsp;all</a></td>            
            <td class="oddcol-l">Processing Mode</td>         
            <td class="oddcol-l">Maximum Threads</td>
            <td class="oddcol-l">Current Thread Count</td>   
          </tr>
          
          
          %loop triggers%    
          <tr>
            <script>writeTD("row-l");</script><a href="trigger-management-details.dsp?triggerName=%value name%">%value name%<br></a></td>
            
            <script>writeTD("row-l");</script>%value properties/aliasDisplayValueDSP%</td> 
            
            <script>writeTD("row-l");</script>%value properties/typeDisplayValueDSP%</td>  
            
            <!-- ----------------------- -->
            <!-- Document Retrieval info -->  
            <!-- ----------------------- -->
            
            %ifvar retrievalStatus/state -notempty%
	            %ifvar retrievalStatus/state equals('active')%
                <script>writeTD("rowdata");</script><a href="trigger-management-edit-state.dsp?triggerName=%value name%&setRetrievalStatus=suspended">
	              <img style="width: 13px; height: 13px;" alt="active" border="0" src="images/green_check.gif">Yes</a>&nbsp;</td>
	            %else% %ifvar retrievalStatus/state equals('active-temp')%
                <script>writeTD("rowdata");</script><a href="trigger-management-edit-state.dsp?triggerName=%value name%&setRetrievalStatus=suspended">
	              <img style="width: 13px; height: 13px;" alt="active" border="0" src="images/green_check.gif">Yes</a>*</td>
	            %else% %ifvar retrievalStatus/state equals('suspended')%
	              <script>writeTD("rowdata");</script><a href="trigger-management-edit-state.dsp?triggerName=%value name%&setRetrievalStatus=active">No</a>&nbsp;</td>
	            %else% %ifvar retrievalStatus/state equals('suspended-disabled')%
	              <script>writeTD("rowdata");</script><a href="trigger-management-edit-state.dsp?triggerName=%value name%&setRetrievalStatus=active">No (not&nbsp;connected)</a>&nbsp;</td>
	            %else% %ifvar retrievalStatus/state equals('active-disabled')%
	              <script>writeTD("rowdata");</script><a href="trigger-management-edit-state.dsp?triggerName=%value name%&setRetrievalStatus=suspended">Yes (not&nbsp;connected)</a>&nbsp;</td>
	            %else% <!-- else suspended-temp -->
	              <script>writeTD("rowdata");</script><a href="trigger-management-edit-state.dsp?triggerName=%value name%&setRetrievalStatus=active">No</a>*</td>
	            %endif%
	            %endif%
	            %endif%	   
              %endif%	
              %endif%	       
	          %else%
              <script>writeTD("rowdata-l");</script>N/A</td>
            %endif%  
            
            %ifvar retrievalStatus/state matches('active*')%
              %ifvar properties/queueCapacity vequals(properties/queueCapacityThrottle)%
                <script>writeTD("row-l");</script>%value properties/queueCapacity%</td>
              %else%
                <script>writeTD("row-l");</script>%value properties/queueCapacityThrottle%&nbsp;(%value properties/queueCapacity%)</td>
              %endif%   
            %else%
              <script>writeTD("row-l");</script>0&nbsp;(%value properties/queueCapacity%)</td> 
            %endif%
            
            <script>writeTD("row-l");</script>%value processingStatus/volatileQueueCount%</td> 
            
            <!-- ------------------------ -->
            <!-- Document Processing info -->
            <!-- ------------------------ -->
            
            %ifvar processingStatus/state -notempty%
	            %ifvar processingStatus/state equals('active')%
                <script>writeTD("rowdata");</script><a href="trigger-management-edit-state.dsp?triggerName=%value name%&setProcessingStatus=suspended">
	              <img style="width: 13px; height: 13px;" alt="active" border="0" src="images/green_check.gif">Yes</a>&nbsp;</td>
	            %else% %ifvar processingStatus/state equals('active-temp')%
                <script>writeTD("rowdata");</script><a href="trigger-management-edit-state.dsp?triggerName=%value name%&setProcessingStatus=suspended">
	              <img style="width: 13px; height: 13px;" alt="active" border="0" src="images/green_check.gif">Yes</a>*</td>
	            %else% %ifvar processingStatus/state equals('suspended')%
	              <script>writeTD("rowdata");</script><a href="trigger-management-edit-state.dsp?triggerName=%value name%&setProcessingStatus=active">No</a>&nbsp;</td>
	              
              %else% %ifvar processingStatus/state equals('suspended-disabled')%
	              <script>writeTD("rowdata");</script><a href="trigger-management-edit-state.dsp?triggerName=%value name%&setProcessingStatus=active">No (not&nbsp;connected)</a>&nbsp;</td>
	            %else% %ifvar processingStatus/state equals('active-disabled')%
	              <script>writeTD("rowdata");</script><a href="trigger-management-edit-state.dsp?triggerName=%value name%&setProcessingStatus=suspended">Yes (not&nbsp;connected)</a>&nbsp;</td>
	            
              %else% <!-- else suspended-temp -->
	              <script>writeTD("rowdata");</script><a href="trigger-management-edit-state.dsp?triggerName=%value name%&setProcessingStatus=active">No</a>*</td>
	            %endif%
	            %endif%
	            %endif%
	            %endif%
	            %endif%
	          %else%
              <script>writeTD("rowdata-l");</script>N/A</TD>
            %endif%   
            
            %ifvar properties/isConcurrent equals('true')%
              <script>writeTD("row-l");</script>Concurrent</td>
              %ifvar processingStatus/state matches('active*')%
                %ifvar properties/maxExecutionThreads vequals(properties/maxExecutionThreadsThrottle)%
                  <script>writeTD("row-l");</script>%value properties/maxExecutionThreads%</td>
                %else%
                  <script>writeTD("row-l");</script>%value properties/maxExecutionThreadsThrottle%&nbsp;(%value properties/maxExecutionThreads%)</td>
                %endif%
              %else%
                <script>writeTD("row-l");</script>0&nbsp;(%value properties/maxExecutionThreads%)</td> 
              %endif%
            %else%
              <script>writeTD("row-l");</script>Serial</td>
              %ifvar processingStatus/state matches('active*')%
                <script>writeTD("row-l");</script>1</td>
              %else%
                <script>writeTD("row-l");</script>0 (1)</td>
              %endif%
            %endif%
           
            <script>writeTD("row-l");</script>%value processingStatus/activeThreadCount%</td>
            
          </tr>
          
          
          %ifvar lastError -notempty%
            <script>writeTDspan("row-l", 10);</script>
              <font color="red">%value lastError%</font><br> 
            </td>
          %endif%
          
          <script>swapRows();</script>
          %endloop%

        </tbody>
      </table>
    </tr>
    
    <tr>
    %onerror%
      <script>this_writeMessage('%value errorMessage%');</script>
      <script>setMessageFlag(true);</script>
    %endinvoke%
    </td>  
    
  </tbody></table>
  <br><br>
</body>
</html>