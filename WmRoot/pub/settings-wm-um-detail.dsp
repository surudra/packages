<HTML>
<HEAD>


<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">


<LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
<SCRIPT SRC="webMethods.js.txt"></SCRIPT>

<style>

.disabledLink
{
   color:#0D109B;
}

</style>


</HEAD>

<BODY onLoad="setNavigation('settings-broker.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Messaging_webMMsgingSettings_ConnectionAlias_UMDetailScrn');">
  
  
  <TABLE width="100%">
    <TR>
      <TD class="menusection-Settings" colspan="2">Settings &gt; Messaging &gt; webMethods Messaging Settings &gt; Universal Messaging Connection Alias</TD>
    </TR>
    
    %ifvar action equals('edit')%
      
        %invoke wm.server.messaging:updateConnectionAlias%
        <TR>
          <TD colspan="2">&nbsp;</td>
        </TR>
        <TR>
          <TD class="message" colspan=2>%value message%</TD>
        </TR>
        %endinvoke%
    %else% %ifvar action equals('create')%
      
        %invoke wm.server.messaging:createConnectionAlias%
        <TR>
          <TD colspan="2">&nbsp;</td>
        </TR>
        <TR>
          <TD class="message" colspan=2>%value message%</TD>
        </TR>
        %endinvoke%
    %endif%
    %endif%
    
    %invoke wm.server.messaging:getConnectionAliasReport%
    
    <TR>
      <TD colspan="2">
        <UL>
          <LI><A HREF="settings-wm-messaging.dsp">Return to webMethods Messaging Settings</A></LI>
          
          %ifvar enabled equals('true')%
            <li><div class="disabledLink">Edit Universal Messaging Connection Alias</div></li>
          %else%
            <LI><A HREF="settings-wm-um-edit.dsp?aliasName=%value aliasName%">Edit Universal Messaging Connection Alias</A></LI>
          %endif%
        
        </UL>
      </TD>
    </TR>
    
    <tr>
      <td><img src="images/blank.gif" height=10 width=10></td>
      <td>
        <table class="tableView" width="85%">

          <form>
                    
          <tr>
            <td class="heading" colspan=2>General Settings</td>
          </tr>

          <!-- Connection Alias Name -->
          <tr>
            <td width="40%" class="oddrow-l" nowrap="true">Connection Alias Name</td>
            <td class="oddrowdata-l">%value aliasName%</td>
          </tr>

          <!-- Enabled 
          <tr>
            <td class="evenrow-l">Enabled</td>
              <td class="evenrowdata-l"><img style="width: 13px; height: 13px;" alt="enabled" border="0" src="images/green_check.gif">
                Yes%ifvar isConnected equals('false')%&nbsp;(Not Connected)%endif%
              </td>
          </tr>
          -->

          <!-- Description -->
          <tr>
            <td class="evenrow-l">Description</td>
            <td class="evenrowdata-l">%value description%</td>
          </tr>
          
          <!-- Client Prefix -->
          <TR>
            <TD class="oddrow-l">Client Prefix</TD>
            <TD class="oddrowdata-l">%value CLIENTPREFIX%</TD>
          </TR>
          
          <!-- Share Client Prefix -->
          <TR>
            <TD class="evenrow-l">Share Client Prefix</TD>
            <TD class="evenrowdata-l"> %ifvar isClientPrefixShared equals('true')% Yes %else% %ifvar isClientPrefixShared equals('on')% Yes %else% No %endif% %endif% </TD>
          </TR>
          
          <!--                     -->
          <!-- Connection Settings -->
          <!--                     -->
          
          <tr>
            <td class="heading" colspan=2>Connection Settings</td>
          </tr>
    
          <!-- Realm URL -->
          <TR>
            <TD class="oddrow-l">Realm URL</TD>
            <TD class="oddrowdata-l">%value um_rname%</TD>
          </TR>

          <TR>
            <TD class="evenrow-l">Maximum Reconnection Attempts</TD>
            <TD class="evenrowdata-l">%value um_tryAgainMaxAttempts%</TD>
          </TR>

          <!--                     -->
          <!-- Producer Settings   -->
          <!--                     -->
          
          <tr>
            <td class="heading" colspan=2>Producer Settings</td>
          </tr>
    
          <!-- Enable CSQ -->
          <TR>
            <TD class="oddrow-l">Enable CSQ</TD>
            <TD class="oddrowdata-l">
            %ifvar useCSQ equals('true')%
              Yes
            %else% %ifvar useCSQ equals('on')%
              Yes
            %else%
              No
            %endif%
            %endif%
            </TD>
          </TR>
          
          <!-- Maximum CSQ Size -->
          <TR>
            <TD class="evenrow-l">Maximum CSQ Size (messages)</TD>   
            <TD class="evenrowdata-l">%ifvar csqSize equals('-1')%UNLIMITED%else%%value csqSize%%endif%</TD>
          </TR>
          
          <!-- Drain CSQ in Order -->
          <TR>
            <TD class="oddrow-l">Drain CSQ in Order</TD>
            <TD class="oddrowdata-l">%ifvar csqDrainInOrder equals('true')%Yes%else%No%endif%</TD>
          </TR>      
          
          <!-- Publish Wait Time (while reconnection) -->
          <TR>
            <TD class="evenrow-l">Publish Wait Time while Reconnecting (milliseconds)</TD>
            <TD class="evenrowdata-l">%value um_publishWaitTime%</TD>
          </TR>
          
          <!-- Include All Envelope Data 
          <TR>
            <TD class="oddrow-l">Include All Envelope Fields</TD>
            <TD class="oddrowdata-l">%ifvar includeFullEnvelope equals('true')% Yes %else% %ifvar includeFullEnvelope equals('on')% Yes %else% No %endif% %endif% </TD>
          </TR>  -->
          
          <!--                     -->
          <!-- Consumer Settings   -->                         
          <!--                     -->
                          
          <tr>
            <td class="heading" colspan=2>Consumer Settings</td>
          </tr>
          
          <!-- Request-Reply -->   
          <TR>
            <TD class="oddrow-l">Enable Request-Reply Channel and Listener</TD>
            <TD class="oddrowdata-l">%ifvar enableRequestReply equals('true')% Yes %else% %ifvar enableRequestReply equals('on')% Yes %else% No %endif% %endif% </TD>
          </TR>         
          
        </TABLE>
      </td>
    </TR>
    <tr>
      <TD><IMG SRC="images/blank.gif" height=10 width=10></TD>
      <td>
        <TABLE class="tableView">
          <TR>      
          </TR>
        </table>
      </td>
    <tr>
  </TABLE>
  %endinvoke%
</BODY>
</HTML>