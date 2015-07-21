<HTML>
<HEAD>


<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">


<LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
<SCRIPT SRC="webMethods.js.txt"></SCRIPT>
</HEAD>

<BODY onLoad="setNavigation('settings-broker.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Messaging_webMMsgingSettings_ConnectionAlias_BrokerDetailScrn');">

  <TABLE width="100%">
    <TR>
      <TD class="menusection-Settings" colspan="2">Settings &gt; Messaging &gt; webMethods Messaging Settings &gt; Broker Connection Alias</TD>
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
    %endif%
    
    %ifvar action equals('create')%
      
        %invoke wm.server.messaging:createConnectionAlias%
        <TR>
          <TD colspan="2">&nbsp;</td>
        </TR>
        <TR>
          <TD class="message" colspan=2>%value message%</TD>
        </TR>
        %endinvoke%
    %endif%

    <TR>
      <TD colspan="2">
        <UL>
          <LI><A HREF="settings-wm-messaging.dsp">Return to webMethods Messaging Settings</A></LI>
          <LI><A HREF="settings-wm-broker-edit.dsp?aliasName=%value aliasName%">Edit Broker Connection Alias</A></LI>
        </UL>
      </TD>
    </TR>
    
    <tr>
      <td><img src="images/blank.gif" height=10 width=10></td>
      <td>
        <table class="tableView" width="85%">

          <form>
          
          %invoke wm.server.messaging:getConnectionAliasReport%
                    
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
            <TD class="evenrowdata-l"> %ifvar isISClustered equals('true')% Yes %else% %ifvar isClientPrefixShared equals('true')% Yes %else% No %endif% %endif% </TD>
          </TR>
          
          <!--                     -->
          <!-- Connection Settings -->
          <!--                     -->
          
          <tr>
            <td class="heading" colspan=2>Connection Settings</td>
          </tr>
    
          <!-- Broker Host -->
          <TR>
            <TD class="oddrow-l">Broker Host</TD>
            <TD class="oddrowdata-l">%value brokerHost%</TD>
          </TR>
          
          <!-- Broker Name -->
          <TR>
            <TD class="evenrow-l">Broker Name</TD>
            <TD class="evenrowdata-l">%value brokerName%</TD>
          </TR>
          
          <!-- Client Group -->
          <TR>
            <TD class="oddrow-l">Client Group</TD>
            <TD class="oddrowdata-l">%value clientGroupName%</TD>
          </TR>

          <!-- Client Authentication -->
          <TR>
            <TD class="evenrow-l">Client Authentication</TD>
            
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
         
          %endinvoke%
          
          %ifvar isUpdated equals('true')%
            <tr>
              <td class="subheading" colspan=4> 
                * Settings have been modified. Server restart is required.
              </td>
            </tr>
          %endif%	   	
 
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