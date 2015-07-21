<html>

<head>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <meta http-equiv="Expires" content="-1">
  <link rel="stylesheet" type="text/css" href="webMethods.css">
  <script src="webMethods.js.txt"></script>
  
  <script language ="javascript"> 
    var _isLocal = true;
    function setLocal(local) {
      _isLocal = local;
    }
    
    function getLocal() {
      return _isLocal;
    } 
    </script>
    
    <TITLE>Integration Server</TITLE>
  </HEAD>

  <BODY onLoad="setNavigation('security-ports.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Messaging_webMMsgingSettings_ChangeDefaultConnectionAliasScrn');">

    <TABLE width="100%">

    <TR>
      <TD class="menusection-Security" colspan=2>Settings &gt; Messaging &gt; webMethods Messaging Settings &gt; Change Default Connection Alias
      </TD>
    </TR>
    <TR><TD colspan="2">
    <UL><LI><A HREF="settings-wm-messaging.dsp">Return to webMethods Messaging Settings</A></LI></UL>

    </TD>
    </TR>

    <TR>
      <TD><IMG SRC="images/blank.gif" height=10 width=10></TD>
      <TD>
        <TABLE class="tableForm">

        <tr>
          <td class="heading" colspan="2">Select New Default Connection Alias</td>
        </tr>
        
        
        
        <form name="primary" action="settings-wm-messaging.dsp" method="post">
        <input type="hidden" name="operation" value="setPrimary">
        <tr>
            <td class="oddrow">Connection Alias Name</td>
            <td class="oddrow-l">
                %invoke wm.server.messaging:getConnectionAliasReport%
                <select name="aliasName">
                  %loop aliasDataList%
                    <option value='%value aliasName%' %ifvar defaultAlias equals('true')%selected%endif%>%value aliasName%</option>
                    %ifvar defaultAlias equals('true')%
                      <script>setLocal(false);</script>
                    %endif%
                  %endloop%
                  <script>
                    if (getLocal()) {
                      document.write("<option value='[LOCAL]' selected>[LOCAL ONLY]</option>");
                    } else {
                     document.write("<option value='[LOCAL]'>[LOCAL ONLY]</option>");
                    }
                  </script>
                  
                </select>
                %endinvoke%
            </td>
        </tr>
        <tr>
            <td class="action" colspan="2">
              <input name="action" type="hidden" value="changeDefaultConnectionAlias">
              <input type="submit" value="Update">
            </td>
            
            
        </tr>

        </form>
      </TABLE>
    </TD>
  </TR>
</TABLE>
</BODY>
</HTML>
