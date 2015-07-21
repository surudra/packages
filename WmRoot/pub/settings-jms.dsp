<html>

<head>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <meta http-equiv="Expires" content="-1">
  <link rel="stylesheet" type="text/css" href="webMethods.css">
  <script src="webMethods.js.txt"></script>
  
  <script language ="javascript">
  
  function changeTriggerState() {
  
    return confirm("Would you like to make this change across the entire cluster?");  
  
  }
  
  function popUp(URL) {
	day = new Date();
	id = day.getTime();
	if(is_csrf_guard_enabled && needToInsertToken) {
		if(URL.indexOf("?") != -1){
			URL = URL+"&"+ _csrfTokenNm_ + "=" + _csrfTokenVal_;
		} else {
			URL = URL+"?"+ _csrfTokenNm_ + "=" + _csrfTokenVal_;
		}
	} 
	eval("page" + id + " = window.open(URL, '" + id + "', 'toolbar=0,scrollbars=0,location=0,statusbar=0,menubar=0,resizable=0,width=200,height=200,left = 540,top = 412');");
 }
  
  </script>
  
</head>

<body onLoad="setNavigation('settings-broker.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Msging_JMSsetScrn');">
  <table width="100%">
    <tr>
      <td class="menusection-Settings" colspan="2">Settings &gt; Messaging &gt; JMS Settings</td>
    </tr>

    <!-- Enable/Disable Logic -->

    %switch action%
    
    %case 'changeState'%
      %ifvar setEnabled equals('true')%
        %invoke wm.server.jms:enableConnectionAlias%
        <TR>
          <TD colspan="2">&nbsp;</td>
          </TR>
        <TR>
          <TD class="message" colspan=2>%value message%</TD>
        </TR>
        %endinvoke%
      %else%
        %invoke wm.server.jms:disableConnectionAlias%
        <TR>
          <TD colspan="2">&nbsp;</td>
          </TR>
        <TR>
          <TD class="message" colspan=2>%value message%</TD>
        </TR>
        %endinvoke%
      %endif%
      %rename aliasName editedAliasName%

    <!-- Delete Logic -->
   
    %case 'delete'%
      %invoke wm.server.jms:deleteConnectionAlias%
        <tr>
          <td colspan="2">&nbsp;</td>
            </tr>
            <tr>
          <td class="message" colspan=2>%value message%</td>
        </tr>
      %endinvoke%
      %rename aliasName editedAliasName%
   
    <!-- Create Logic -->
    
    %case 'create'%
      %invoke wm.server.jms:createConnectionAlias%
        <tr>
          <td colspan="2">&nbsp;</td>
        </tr>
        <tr>
          <td class="message" colspan=2>%value message%</td>
        </tr>
      %endinvoke%  
      %rename aliasName editedAliasName%
    
    <!-- Stop/Suspend/Enable Trigger Logic -->
    
    %case 'suspendTrigger'%
      %invoke wm.server.jms:suspendJMSTriggers%
        <tr>
          <td colspan="2">&nbsp;</td>
        </tr>
        <tr>
          <td class="message" colspan=2>%value message%</td>
        </tr>
      %onerror%
         <td class="message" colspan=2>%value errorMessage%</td>
      %endinvoke%  
      %rename triggerName editedTriggerName%
    
    %case 'enableTrigger'%
      %invoke wm.server.jms:enableJMSTriggers%
        <tr>
          <td colspan="2">&nbsp;</td>
        </tr>
        <tr>
          <td class="message" colspan=2>%value message%</td>
        </tr>
      %onerror%
         <td class="message" colspan=2>%value errorMessage%</td>
      %endinvoke%
      %rename triggerName editedTriggerName%
      
    %case 'disableTrigger'%
      %invoke wm.server.jms:disableJMSTriggers%
        <tr>
          <td colspan="2">&nbsp;</td>
        </tr>
        <tr>
          <td class="message" colspan=2>%value message%</td>
        </tr>
      %onerror%
         <td class="message" colspan=2>%value errorMessage%</td>
      %endinvoke%
      %rename triggerName editedTriggerName%

    <!-- Clear CSQ Logic -->
    
    %case 'clearCSQ'%
      %invoke wm.server.jms:clearCSQ%
        <tr>
          <td colspan="2">&nbsp;</td>
        </tr>
        <tr>
          <td class="message" colspan=2>%value message%</td>
        </tr>
      %endinvoke%  
      %rename aliasName editedAliasName%
      
    <!-- Set Global Trigger Settings -->
    
    %case 'setSettings'%
      %invoke wm.server.jms:setSettings%
        <tr>
          <td colspan="2">&nbsp;</td>
        </tr>
        <tr>
          <td class="message" colspan=2>%value message%</td>
        </tr>
      %endinvoke%  
    %end%
    
    %invoke wm.server.jms:getConnectionAliasReport%
    
<!-- Navigation Menu -->
    
    <tr>
      <td colspan="2">
        <ul>
          <li><a href="settings-messaging.dsp">Return to Messaging</a></li>
          <li><a href="settings-jms-create.dsp">Create JMS Connection Alias</a></li>
          <li><a href="settings-jms.dsp">Refresh Page</a></li>
        </ul>
      </td>
    </tr>
    
    <tr>
      <td><img src="images/blank.gif" height=10 width=10></td>
      <td>

<!-- Connection Alias -->

        <table class="tableView" width="100%">

          <!-- Headers -->

          <tr>
            <td class="heading" colspan=6>JMS Connection Alias Definitions</td>
          </tr>

          <tr>
            <td class="oddcol-l" nowrap>Connection Alias Name</td>
            <td class="oddcol-l">Description</td>
            <td class="oddcol-l">Transaction Type</td>
            <td class="oddcol-l">CSQ Count</td>
            <td class="oddcol">Enabled</td>
            <td class="oddcol">Delete</td>
          </tr> 
          
          %loop aliasDataList%
          
            <tr>
            
              <!-- Alias Name -->
              
              <script>writeTD("row-l");</script><a href="settings-jms-detail.dsp?aliasName=%value aliasName encode(url)%">
                %value aliasName%</a>
              </td>
                
              <!-- Description -->
              
              <script>writeTD("row-l");</script>%value description%</td>
              
              <!-- Transaction Mode -->
              
              <script>writeTD("row-l");</script>
                %switch transactionType%
                  %case '0'%NO TRANSACTION<br>
                  %case '1'%LOCAL TRANSACTION<br>
                  %case '2'%XA TRANSACTION<br>
                  %case%&nbsp;<br>
                %end%
              </td>
              
              <!-- CSQ Count -->

              <script>writeTD("row-l");</script>
                %value messageCount%
                
                <!--
                %ifvar messageCount equals('0')%
                  0<br>		
                %else%
                  %ifvar enabled equals('true')%
                    %value messageCount%
                  %else%
                    <a href="settings-jms.dsp?action=clearCSQ&aliasName=%value connectionAliasName%" onClick="javascript:return confirm('Are you sure you want to clear the CSQ for Connection Alias %value connectionAliasName%?')">%value messageCount%</a>
                  %endif%
                %endif%
                -->
              </td>

              <!-- Enabled? -->
              <script>writeTD("rowdata");</script>
              
              %ifvar connected equals('false')%
                %ifvar enabled equals('false')%
                  <a href="settings-jms.dsp?action=changeState&aliasName=%value aliasName encode(url)%&setEnabled=true">No</a>
                %else%
                  %ifvar lastError%
                    <a href="settings-jms.dsp?action=changeState&aliasName=%value aliasName encode(url)%&setEnabled=false"><img style="width: 13px; height: 13px;" alt="enabled" border="0" src="images/green_check.gif">Yes</a>
                  %else%
                    <a href="settings-jms.dsp"><img style="width: 13px; height: 13px;" alt="active" border="0" src="images/yellow_check.gif">In&nbsp;Progress</a>
                  %endif%
                %endif%
              %else%
                <a href="settings-jms.dsp?action=changeState&aliasName=%value aliasName encode(url)%&setEnabled=false"><img style="width: 13px; height: 13px;" alt="enabled" border="0" src="images/green_check.gif">Yes</a>              
              %endif%

              <!-- Delete --> 
              <script>writeTD("rowdata");</script>
                %ifvar enabled equals('true')%
                  <img style="width: 13px; height: 13px;" alt="active" border="0" src="icons/delete_disabled.gif">
                %else%
                 %ifvar hasTriggers equals('true')%
                    <a href="settings-jms.dsp?action=delete&aliasName=%value aliasName encode(url)%" onClick="javascript:return confirm('Connection Alias %value aliasName% is associated with one or more JMS Triggers. Are you sure you want to delete this Connection Alias?')">
                      <img style="width: 13px; height: 13px;" alt="active" border="0" src="icons/delete.gif">
                    </a>
                  %else%
                    <a href="settings-jms.dsp?action=delete&aliasName=%value aliasName encode(url)%" onClick="javascript:return confirm('Are you sure you want to delete Connection Alias %value encode(htmlattr) aliasName%?')">
                      <img style="width: 13px; height: 13px;" alt="active" border="0" src="icons/delete.gif">
                    </a>
                  %endif%
                %endif%
              <td>
              
              <!-- Error Message --> 
              
              %ifvar lastError%
                <tr>
                  <!-- <td class="subheading" colspan=6> -->
                  <script>writeTDspan("row-l", 6);</script>
                    <font color="red">%value lastError%</font>
                  </td>
                </tr>
              %endif%
              
              <script>swapRows();</script>
  
          %endloop%
          
          <!-- 
          <tr>
            <td class="subHeading" colspan=6>
              * Connection Aliases that are enabled or Connection Aliases that have one or more Triggers associated with them can not be deleted.
            </td>
          </tr>
          -->

          
          <tr>
            <td>&nbsp;</td>
          </tr>
        </table>
        

      </td>
    </tr>
                
   %onerror%
   
   <tr>
     <td class="message" colspan=2>%value errorService%<br>%value error%<br>%value errorMessage%<br></td>
   </tr>
                  
   %endinvoke%

  </table>
</body>
</html>