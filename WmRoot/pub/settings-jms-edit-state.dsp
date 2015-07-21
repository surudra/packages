<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta http-equiv="Expires" content="-1">
  <title>Integration Server Settings</title>
  <link rel="stylesheet" type="text/css" href="webMethods.css">
  <script src="webMethods.js.txt"></script>
  <script>
  
    function showCluster() {
      prop = "%sysvar property('watt.server.cluster.aliasList')%";
      if (prop == null || prop.length < 1)
        return false;
      else
        return true;
    }

  </script>
</head>

%ifvar triggerName equals('all')%
   <body onLoad="setNavigation('trigger-management-edit-state.dsp',  '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Msging_JMS_TriggerEditStateAll');">
%else%
   <body onLoad="setNavigation('trigger-management-edit-state.dsp',  '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Msging_JMS_TriggerEditStateIndiv');">
%endif%

<table width="100%">
  <tbody>
    <tr>
      %ifvar triggerName equals('all')%
        <td class="menusection-Settings" colspan="4">Settings &gt; Messaging &gt; JMS Trigger Management &gt; Edit State<br>
      %else%
        <td class="menusection-Settings" colspan="4">Settings &gt; Messaging &gt; JMS Trigger Management &gt; Edit State: %value triggerName%<br>
      %endif%
      </td>
    </tr>
    <tr>
      <td colspan="2">
      <ul>
        <li><a href="settings-jms-trigger-management.dsp?type=%value type%">Return to JMS Trigger Management</a></li>
      </ul>
      </td>
    </tr>
    <tr>
      <td> <!-- <img src="images/blank.gif" height="10" width="10" border="0"> --> </td>
      <td>
        <table>
        <tbody>
        
          <!-- --------- -->
          <!-- Edit Form -->
          <!-- --------- -->
          
          <form name="editform" action="settings-jms-trigger-management.dsp" METHOD="POST">
        
            
            %ifvar triggerName equals('all')%
              <tr>
                <td class="heading" colspan="2">Edit Triggers State</td>
              </tr>
              <tr>
                <td class="oddrow-l">New State</td>
                <td class="oddrowdata-l">
                  <SELECT SIZE ="1" NAME="action">
                  <OPTION VALUE="enableTrigger">Enabled</OPTION>
                  <OPTION VALUE="disableTrigger">Disabled</OPTION>
                  <OPTION VALUE="suspendTrigger">Suspended</OPTION>
                </td>
              </tr>
              <tr>
                <td class="evenrow-l">JMS Trigger Type</td>
                <td class="evenrowdata-l">
                  <SELECT SIZE ="1" NAME="jmsTriggerType">
                 
                  %switch jmsTriggerTypeReq%
                    %case '1'%
                      <OPTION VALUE="-1">All</OPTION>
                      <OPTION VALUE="0">Standard</OPTION>
                      <OPTION VALUE="1" selected>SOAP</OPTION>
                    %case '0'%
                      <OPTION VALUE="-1">All</OPTION>
                      <OPTION VALUE="0" selected>Standard</OPTION>
                      <OPTION VALUE="1">SOAP</OPTION>
                  %end%
                </td>
              </tr>
            %else%
              <tr>
                <td class="heading" colspan="2">Edit Trigger State</td>
              </tr>
              <tr>
                <td class="oddrow-l">New State</td>
                <td class="oddrowdata-l">
                  <SELECT SIZE ="1" NAME="action">
                 
                  %switch setState%
                    %case 'Enabled'%
                      <OPTION VALUE="disableTrigger">Disabled</OPTION>
                      <OPTION VALUE="suspendTrigger" selected>Suspended</OPTION>
                    %case 'EnabledButNotConnected'%
                      <OPTION VALUE="disableTrigger">Disabled</OPTION>
                    %case 'Disabled'%
                      <OPTION VALUE="enableTrigger">Enabled</OPTION>
                    %case 'Suspended'%
                      <OPTION VALUE="enableTrigger" selected>Enabled</OPTION>
                      <OPTION VALUE="disableTrigger">Disabled</OPTION>
                  %end%
                </td>
              </tr>
            %endif%
           
            <script>
              if (showCluster()) {
                w("<tr>");
                w("<td class='evenrow-l'>Apply change across cluster</td>");
                w("<td class='evenrowdata-l'><INPUT TYPE='CHECKBOX' NAME='applyChangeAcrossCluster' value='true'></td>");
                w("</tr>");
              }
            </script>
            
            <tr>
              <td class="action" colspan=2>
                <input name="triggerName" type="hidden" value="%value triggerName%">

                %ifvar setState equals('Suspend')%
                  <input name="action" type="hidden" value="suspendTrigger">
                %else%
                  %ifvar setState equals('Enable')%
                    <input name="action" type="hidden" value="enableTrigger">
                  %endif%
                %endif%
                <input name="type" type="hidden" value="%value type%">
                
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

</body>
</html>
