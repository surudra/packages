<html>
<head>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <meta http-equiv="Expires" content="-1">
  <link rel="stylesheet" TYPE="text/css" href="webMethods.css">
  <script src="webMethods.js.txt"></script>
</head>

<body onLoad="setNavigation('settings-broker.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Msging_JNDIsetScrn');">

  <table width="100%">
    <tr><td class="menusection-Settings" colspan="2">Settings &gt; Messaging &gt; JNDI Settings</td></tr>

    %switch action%
      %case 'create'%
        %invoke wm.server.jndi:setJNDIAliasData%    
          <tr><td colspan="2">&nbsp;</td></tr>
          <tr><td class="message" colspan=2>%value message%</td></tr>
        %onerror%
          <tr><td colspan="2">&nbsp;</td></tr>
          <tr><td class="message" colspan=2>%value errorMessage%</td></tr>
        %endinvoke%
        %rename jndiAliasName createdAliasName%
    
      %case 'delete'%
        %invoke wm.server.jndi:deleteJNDIAliasData%
          <tr><td colspan="2">&nbsp;</td></tr>
          <tr><td class="message" colspan=2>%value message%</td></tr>
        %onerror%
          <tr><td colspan="2">&nbsp;</td></tr>
          <tr><td class="message" colspan=2>%value errorMessage%</td></tr>
        %endinvoke%
        %rename jndiAliasName deletedAliasName%
      
      %case 'test'%
        %invoke wm.server.jndi:testJNDILookup%
          
          
          %loop messages%
          
           
           <tr><td class="message" colspan=2>%value messages%</td></tr>
           
           %endloop%
           
        
        %onerror%
          <tr><td colspan="2">&nbsp;</td></tr>
          <tr><td class="message" colspan=2>%value errorMessage%</td></tr>
        %endinvoke%
        %rename jndiAliasName testedAliasName%
      %end%
    
    %invoke wm.server.jndi:getJNDIAliasData%
    
    %onerror%
      <tr><td class="message" colspan=2>%value errorMessage%</td></tr>
    %endinvoke%

    <tr>
      <td colspan="2">
        <ul>
          <li><a href="settings-messaging.dsp">Return to Messaging</a></li>
          <li><a href="settings-jndi-create.dsp">Create JNDI Provider Alias</a></li>
        </ul>
      </td>
    </tr>

    <tr>
      <td><img src="images/blank.gif" height=10 width=10></td>
      <td>
        <table class="tableView" width="100%">

          <tr>
            <td class="heading" colspan=4>JNDI Provider Alias Definitions</td>
          </tr>
 
          <!-- Row Heading -->
 
          <tr>
            <td class="oddcol-l">JNDI Alias Name</td>
            <td class="oddcol-l">Description</td>
            <td class="oddcol">Test Lookup</td>
            <td class="oddcol">Delete</td>
          </tr> 
          
          %loop aliasDataAry%
   
          <tr>
          
            <!-- Alias Name -->
            
            <script>writeTD("row-l");</script><a href="settings-jndi-detail.dsp?jndiAliasName=%value aliasName encode(url)%">%value aliasName%</a></d>
            
            <!-- Description -->
            
            <script>writeTD("row-l");</script>%value description%</d>
            
            <!-- Test link -->
            
            <script>writeTD("rowdata");</script><a href="settings-jndi.dsp?action=test&jndiAliasName=%value aliasName encode(url)%"><IMG src="icons/checkdot.gif" border="none"></a></d>
            
            <!-- Delete link -->
            
            <script>writeTD("rowdata");</script>
              <a href="settings-jndi.dsp?action=delete&jndiAliasName=%value aliasName encode(url)%" onClick="javascript:return confirm('Are you sure you want to delete JNDI Provider Alias %value encode(javascript) aliasName%?')">
              <img style="width: 13px; height: 13px;" alt="active" border="0" src="icons/delete.gif"></a>&nbsp;
            </td>
            
          </tr>
          
          %ifvar ../testedAliasName vequals(aliasName)%
          
            <tr>
              <script>writeTDspan("row-l", 4);</script>
                %loop ../jndiLookupData%
                  %value nameClassPair%<br>
                %endloop%
              </td>
            </tr>
            
          %endif%
          <script>swapRows();</script>
          %endloop%
          
        </table>   
      </td>
    </tr>
    
  </table>
</body>
</html>
