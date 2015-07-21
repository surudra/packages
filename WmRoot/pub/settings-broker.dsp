<HTML>
<HEAD>


<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">


<LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
<SCRIPT SRC="webMethods.js.txt"></SCRIPT>
</HEAD>

<BODY onLoad="setNavigation('settings-broker.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Msging_BrokerScrn');">

  <TABLE width="100%">
    <TR>
      <TD class="menusection-Settings" colspan="2">Settings &gt; Messaging &gt; Broker Settings</TD>
    </TR>

%ifvar action equals('edit')%
  %ifvar isChanged equals('true')%
    %invoke wm.server.dispatcher.adminui:setBrokerSettings%    
    
    <TR>
      <TD colspan="2">&nbsp;</td>
      </TR>
    <TR>
      <TD class="message" colspan=2>%value message%</TD>
    </TR>
    
    %endinvoke%
  %else%
    <TR>
      <TD colspan="2">&nbsp;</td>
    </TR>
    <TR>
      <TD class="message" colspan=2>No changes made to Broker Configuration Settings.</TD>
    </TR>
  %endif%
%endif%

    <TR>
      <TD colspan="2">
        <UL>
          <LI><A HREF="settings-messaging.dsp">Return to Messaging</A></LI>
          <LI><A HREF="settings-broker-edit.dsp">Edit Broker Settings</A></LI>
        </UL>
      </TD>
    </TR>
    <TR>
      <TD><IMG SRC="images/blank.gif" height=10 width=10></TD>
      <TD>
        <TABLE class="tableView">

%invoke wm.server.dispatcher.adminui:isBrokerConfigured%
  %ifvar BROKERCONFIGURATION equals('true')%
    %invoke wm.server.dispatcher.adminui:getBrokerSettings%
    
          <TR>
            <TD class="heading" colspan=2>Broker Connection</TD>
          </TR>
          <TR>
            <TD class="oddrow">Broker Host</TD>
            <TD class="oddrowdata-l">%value brokerHost%</TD>
          </TR>
          <TR>
            <TD class="evenrow">Broker Name</TD>
            <TD class="evenrowdata-l">%value brokerName%</TD>
          </TR>
          <TR>
            <TD class="oddrow">Client Group</TD>
            <TD class="oddrowdata-l">%value clientGroupName%</TD>
          </TR>
          <TR>
            <TD class="evenrow">Client Prefix</TD>
            <TD class="evenrowdata-l">%value CLIENTPREFIX%</TD>
          </TR>
          <TR>
            <TD class="oddrow">Share Client Prefix</TD>
            <TD class="oddrowdata-l"> %ifvar isISClustered equals('true')% Yes %else% %ifvar isClientPrefixShared equals('true')% Yes %else% No %endif% %endif% </TD>
          </TR>
          <TR>
            <TD class="evenrow">Client Authentication</TD>
            
            %ifvar clientAuth equals('none')%
	    	<TD class="evenrowdata-l">None</TD>
	    %endif%

            %ifvar clientAuth equals('ssl')%
	    	<TD class="evenrowdata-l">SSL</TD>
	    %endif%
            
            %ifvar clientAuth equals('basic')%
	    	<TD class="evenrowdata-l">Username/Password</TD>
	    %endif%
            
          </TR>
          <TR>
            <TD class="oddrow">Connected</TD>
            <TD class="oddrowdata-l"> %ifvar isConnected equals('true')% Yes %else% No %endif% </TD>
          </TR>
                        
      %ifvar action equals('edit')%
      %else%
        %ifvar -notempty lastError%
    
          <tr>
            <td colspan=2 class="padding">&nbsp;</td>
          </tr>
          <TR>
            <TD class="message" colspan=2>Unable to connect to Broker: %value lastError%</TD>
          </TR>
    
        %endif%
      %endif%
    %endinvoke%
  %else%
    
          <TR>
            <TD class="heading" colspan=2>General</TD>
          <TR>
            <TD class="oddrow">Broker Configuration</TD>
            <TD class="oddrowdata-l">Not Configured</TD>
          </TR>

  %endif%
  
        %ifvar isUpdated equals('true')%
          <tr>
            <td class="subheading" colspan=4> 
              * Settings have been modified. Server restart is required.
            </td>
          </tr>
        %endif%	   	
  
  
%endinvoke%

         
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
</BODY>
</HTML>
