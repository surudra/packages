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
		  if(URL.indexOf("?") != -1) {
			  URL = URL+"&"+ _csrfTokenNm_ + "=" + _csrfTokenVal_;
		  }else {
			  URL = URL+"?"+ _csrfTokenNm_ + "=" + _csrfTokenVal_;
		  }
	  } 
	  eval("page" + id + " = window.open(URL, '" + id + "', 'toolbar=0,scrollbars=0,location=0,statusbar=0,menubar=0,resizable=0,width=200,height=200,left = 540,top = 412');");
  }
  
  
  
  
  
  

  function switchToQuiesceMode(form , mode) {
  
    delayTime = prompt("OK to enter quiesce mode?\nSpecify the maximum number of minutes to wait before disabling packages:",0);
    if(delayTime == null) { 
      return false;
    else{
      return true;
    }
	}
  
  </script>
  
</head>

<body onLoad="setNavigation('settings-broker.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Messaging_webMMsgingSettingsScrn');">
  <table width="100%">
  
    <tr>
      <td class="menusection-Settings" colspan="2">Settings &gt; Messaging &gt; webMethods Messaging Settings</td>
    </tr>
    
    <!--                 -->
    <!-- Handle 'action' -->
    <!--                 -->
    
    %switch action%
    
    %case 'error-broker-exists'%
      <script>alert("Cannot create new Broker alias. Only one Broker alias can exist at a time.")</script>
    %case 'changeState'%
      %ifvar setEnabled equals('true')%
        %invoke wm.server.messaging:enableConnectionAlias%
        <TR>
          <TD colspan="2">&nbsp;</td>
          </TR>
        <TR>
          <TD class="message" colspan=2>%value message%</TD>
        </TR>
        %endinvoke%
      %else%
        %invoke wm.server.messaging:disableConnectionAlias%
        <TR>
          <TD colspan="2">&nbsp;</td>
          </TR>
        <TR>
          <TD class="message" colspan=2>%value message%</TD>
        </TR>
        %endinvoke%
      %endif%
      %rename aliasName editedAliasName%
    
    %case 'delete'%
      %invoke wm.server.messaging:deleteConnectionAlias%
      <tr>
        <td colspan="2">&nbsp;</td>
      </tr>
      <tr>
        <td class="message" colspan=2>%value message%</td>
      </tr>
      %endinvoke%
      %rename aliasName editedAliasName%
    
    %case 'create'%
      %invoke wm.server.messaging:createConnectionAlias%
      <tr>
        <td colspan="2">&nbsp;</td>
      </tr>
      <tr>
        <td class="message" colspan=2>%value message%</td>
      </tr>
      %endinvoke%  
      %rename aliasName editedAliasName%
    
    %case 'setSettings'%
      %invoke wm.server.messaging:setSettings%
      <tr>
        <td colspan="2">&nbsp;</td>
      </tr>
      <tr>
        <td class="message" colspan=2>%value message%</td>
      </tr>
      %endinvoke%  
      %rename aliasName editedAliasName%
      
    %case 'changeDefaultConnectionAlias'%
      %invoke wm.server.messaging:changeDefaultConnectionAlias%
      <tr>
        <td colspan="2">&nbsp;</td>
      </tr>
      <tr>
        <td class="message" colspan=2>%value message%</td>
      </tr>
      %endinvoke%  
      %rename aliasName editedAliasName%
      
    %end%
    
    <!--                                                  -->
    <!-- Get main connection alias report for all aliases -->
    <!--                                                  -->
    
    %invoke wm.server.messaging:getConnectionAliasReport%
    
    <!-- Navigation Menu -->
    
    <tr>
      <td colspan="2">
        <ul>
          <li><a href="settings-messaging.dsp">Return to Messaging</a></li>
          %ifvar isBrokerConfigured equals('true')%
            <li><a href="settings-wm-messaging.dsp?action=error-broker-exists">Create Broker Connection Alias</a></li>
          %else%
            <li><a href="settings-wm-broker-create.dsp">Create Broker Connection Alias</a></li>
          %endif%
          <li><a href="settings-wm-um-create.dsp">Create Universal Messaging Connection Alias</a></li>
          <li><a href="settings-wm-messaging-default.dsp">Change Default Connection Alias</a></li>
          <li><a href="settings-wm-messaging.dsp">Refresh Page</a></li>
          
        </ul>
      </td>                                                                                                                       
    </tr>
    
    <tr>
      <td><img src="images/blank.gif" height=10 width=9></td>
      <td>

        <!-- Connection Alias -->

        <table class="tableView" width="100%">

          <!-- Headers -->

          <tr>
            <td class="heading" colspan=7>webMethods Messaging Connection Alias Definitions</td>
          </tr>

          <tr>
            <td class="oddcol">Default</td>
            <td class="oddcol-l">Type</td>
            <td class="oddcol-l" nowrap>Connection Alias Name</td>
            <td class="oddcol-l">Description</td>
            <td class="oddcol-l">CSQ Count</td>
            <td class="oddcol">Enabled</td>
            <td class="oddcol">Delete</td>
          </tr> 
          
          %loop aliasDataList%
          
            <tr>
              <!-- Default flag -->
              <script>writeTD("rowdata");</script>
                %ifvar defaultAlias equals('false')%
                  &nbsp;
                %else%
                  <img style="width: 13px; height: 13px;" alt="enabled" border="0" src="images/green_check.gif"></a>              
                %endif%
              </td>
              
              <!-- Type -->            
              <script>writeTD("row-l");</script>
                %ifvar type equals('BROKER')%
                  Broker
                %else%
                  UM      
                %endif%
              </td>
              
              <!-- Alias Name -->                           
              %ifvar type equals('BROKER')%
                <script>writeTD("row-l");</script><a href="settings-wm-broker-detail.dsp?aliasName=%value aliasName encode(url)%">
              %else%
                <script>writeTD("row-l");</script><a href="settings-wm-um-detail.dsp?aliasName=%value aliasName encode(url)%">
              %endif%
                %value aliasName%</a>
              </td>
                
              <!-- Description -->              
              <script>writeTD("row-l");</script>%value description%</td>
              
              <!-- Transaction Mode - NOT SUPPORTED YET      
              <script>writeTD("row-l");</script>
                %switch transactionType%
                  %case '0'%NO TRANSACTION<br>
                  %case '1'%LOCAL TRANSACTION<br>
                  %case '2'%XA TRANSACTION<br>
                  %case%&nbsp;<br>
                %end%
              </td>
               -->   
                          
              <!-- CSQ Count -->
              <script>writeTD("row-l");</script>
                %value messageCount%
              </td>

              <!-- Enabled -->
              <script>writeTD("rowdata");</script>
              
              %ifvar isUpdated equals('true')%
                
                <!-- Broker specific logic (when Broker settings were changed) -->
                %ifvar updatedEnabledFlag equals('false')%
                  <a href="settings-wm-messaging.dsp?action=changeState&aliasName=%value aliasName encode(url)%&setEnabled=true">No</a>&nbsp;[Pending&nbsp;Restart]
                %else%
                  %ifvar updatedEnabledFlag equals('true')%
                    <a href="settings-wm-messaging.dsp?action=changeState&aliasName=%value aliasName encode(url)%&setEnabled=false"><img style="width: 13px; height: 13px;" alt="enabled" border="0" src="images/yellow_check.gif">Yes</a>&nbsp;[Pending&nbsp;Restart]
                  
                  %else%
                  
                    %ifvar connected equals('false')%
                      %ifvar enabled equals('false')%
                        <a href="settings-wm-messaging.dsp?action=changeState&aliasName=%value aliasName encode(url)%&setEnabled=true">No</a>&nbsp;[Pending&nbsp;Restart]
                      %else%
                        <a href="settings-wm-messaging.dsp?action=changeState&aliasName=%value aliasName encode(url)%&setEnabled=false"><img style="width: 13px; height: 13px;" alt="enabled" border="0" src="images/green_check.gif">Yes</a>&nbsp;[Pending&nbsp;Restart]
                      %endif%
                    %else%
                      <a href="settings-wm-messaging.dsp?action=changeState&aliasName=%value aliasName encode(url)%&setEnabled=false"><img style="width: 13px; height: 13px;" alt="enabled" border="0" src="images/yellow_check.gif">Yes</a>&nbsp;[Pending&nbsp;Restart]           
                    %endif%
                  
                  %endif%
                %endif%
                
              %else%
                
                %ifvar connected equals('false')%
                  %ifvar enabled equals('false')%
                    <a href="settings-wm-messaging.dsp?action=changeState&aliasName=%value aliasName encode(url)%&setEnabled=true">No</a>
                  %else%
                    %ifvar lastError%
                      <a href="settings-wm-messaging.dsp?action=changeState&aliasName=%value aliasName encode(url)%&setEnabled=false"><img style="width: 13px; height: 13px;" alt="enabled" border="0" src="images/yellow_check.gif">Yes</a>&nbsp;[Not&nbsp;Connected]
                    %else%
                      <a href="settings-wm-messaging.dsp?action=changeState&aliasName=%value aliasName encode(url)%&setEnabled=false"><img style="width: 13px; height: 13px;" alt="active" border="0" src="images/yellow_check.gif">Yes</a>&nbsp;[Not&nbsp;Connected]
                    %endif%
                  %endif%
                %else%
                  <a href="settings-wm-messaging.dsp?action=changeState&aliasName=%value aliasName encode(url)%&setEnabled=false"><img style="width: 13px; height: 13px;" alt="enabled" border="0" src="images/green_check.gif">Yes</a>              
                %endif%
              %endif%

              <!-- Delete --> 
              <script>writeTD("rowdata");</script>
                %ifvar enabled equals('true')%
                  <img style="width: 13px; height: 13px;" alt="active" border="0" src="icons/delete_disabled.gif">
                %else%
                  %ifvar defaultAlias equals('true')%
                    <img style="width: 13px; height: 13px;" alt="active" border="0" src="icons/delete_disabled.gif">
                  %else%
                    %ifvar updatedEnabledFlag equals('true')%
                      <img style="width: 13px; height: 13px;" alt="active" border="0" src="icons/delete_disabled.gif">
                    %else%
                      %ifvar hasTriggers equals('true')%
                        <a href="settings-wm-messaging.dsp?action=delete&aliasName=%value aliasName encode(url)%" onClick="javascript:return confirm('The connection alias %value aliasName% is associated with one or more triggers. Are you sure you want to delete this connection alias?')">
                          <img style="width: 13px; height: 13px;" alt="active" border="0" src="icons/delete.gif">
                        </a>
                      %else%
                        <a href="settings-wm-messaging.dsp?action=delete&aliasName=%value aliasName encode(url)%" onClick="javascript:return confirm('Are you sure you want to delete Connection Alias %value aliasName%?')">
                          <img style="width: 13px; height: 13px;" alt="active" border="0" src="icons/delete.gif">
                        </a>
                      %endif%
                    %endif%
                  %endif%
                %endif%
              <td>
              
              <!-- Error Message --> 
              %ifvar lastError%
                <tr>
                  <!-- <td class="subheading" colspan=6> -->
                  <script>writeTDspan("row-l", 7);</script>
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
     <td class="message" colspan=2>G%value errorService%<br>%value error%<br>%value errorMessage%<br></td>
   </tr>
                  
   %endinvoke%

  </table>
</body>
</html>