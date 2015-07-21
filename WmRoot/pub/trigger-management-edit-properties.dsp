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
     
      function showCluster() {
        prop = "%sysvar property('watt.server.cluster.aliasList')%";
        if (prop == null || prop.length < 1)
          return false;
        else
          return true;
      }
  </script>
  
  
</head>

<body onLoad="setNavigation('trigger-management-edit-properties.dsp',  '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_EditTriggerPropertiesScrn');">

%invoke wm.server.triggers:getProperties%

<table width="100%">
  <tbody>
    <tr>
      <td class="menusection-Settings" colspan="4">Settings &gt; Messaging &gt; webMethods Messaging Trigger Management &gt; %value triggerName% &gt; Edit Properties<br>
      </td>
    </tr>
    <tr>
      <td colspan="2">
      <ul>
       <!-- <li><a href="trigger-management.dsp">Return to webMethods Messaging Trigger Management</a></li>  -->
        <li><a href="trigger-management-details.dsp?triggerName=%value triggerName%">Return to webMethods Messaging Trigger</a></li>
      </ul>
      </td>
    </tr>
    <tr>
      <td><img src="images/blank.gif" height="10" width="10" border="0"></td>
      <td>
        <table>
        <tbody>
          <form name="editform" action="trigger-management-details.dsp?triggerName=%value triggerName%" METHOD="POST">
            <tr>
              <td class="heading" colspan="2">Properties</td>
            </tr>
  
            <tr>
              <td class="evenrow-l">Queue Capacity</td>
              <td class="evenrowdata-l">
                %ifvar typeDisplayValue equals('UM')%
                  <input type="text" name="na" value="N/A" disabled="true">
                %else%
                  <input type="text" name="queueCapacity" value="%value queueCapacity%">
                %endif%
              </td>   
            </tr>
            <tr>
              <td class="oddrow-l">Queue Refill Level</td>
              <td class="oddrowdata-l">
              %ifvar typeDisplayValue equals('UM')%
                <input type="text" name="na" value="N/A" disabled="true">
              %else%
                <input type="text" name="queueRefillLevel" value="%value queueRefillLevel%">
              %endif%
              </td>
            </tr>
     
            %ifvar isConcurrent equals('true')%
    
              <tr>
                <td class="evenrow-l">Max Execution Threads</td>
                <td class="evenrowdata-l">
                  <input type="text" name="maxExecutionThreads" value="%value maxExecutionThreads%">
                </td>
              </tr>
   
            %else%
    
              <tr>
                <td class="evenrow-l">Max Execution Threads</td>
                <td class="evenrowdata-l">
                  <input type="text" name="maxExecutionThreads" value="N/A" disabled="true"> 
              </tr>
          
            %endif%        
  
            <script>
              if (showCluster()) {
                w("<tr>");
                w("<td class='heading' colspan='2'>Change Mode</td>");
                w("</tr>");
                w("<tr>");
                
                w("<td class='evenrow-l'>Apply change across cluster</td>");
                w("<td class='evenrowdata-l'><INPUT TYPE='CHECKBOX' NAME='applyChangeAcrossCluster' value='true'></td>");
                w("</tr>");
              }
            </script>
          
            <tr>
              <td class="action" colspan=2>
                <input name="triggerName" type="hidden" value="%value triggerName%">
                <input name="editMode" type="hidden" value="changeProperties">
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

%onerror%
  %value errorMessage%
%endinvoke%

</body>
</html>
