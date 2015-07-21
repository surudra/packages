<HTML>
  <HEAD>
    <meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    <SCRIPT SRC="webMethods.js.txt">
    </SCRIPT>
    <TITLE>Integration Server -- Port Access Management</TITLE>
  </HEAD>

  <BODY onLoad="setNavigation('security-ports.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_ChgPrimaryPortScrn');">

    <TABLE width="100%">

    <TR>
      <TD class="menusection-Security" colspan=2>
        Security &gt;
        Ports &gt;
        Change Primary Port
      </TD>
    </TR>
    <TR><TD colspan="2">
    <UL><LI><A HREF="security-ports.dsp">Return to Ports</A></LI></UL>

    </TD>
    </TR>

    <TR>
      <TD><IMG SRC="images/blank.gif" height=10 width=10></TD>
      <TD>
        <TABLE class="tableForm">

        <tr>
          <td class="heading" colspan="2">Select New Primary Port</td>
        </tr>
        <form name="primary" action="security-ports.dsp" method="post">
        <input type="hidden" name="operation" value="setPrimary">
        <tr>
            <td class="oddrow">Primary Port</td>
            <td class="oddrow-l">
                %invoke wm.server.ports:listListeners%
                <select name="primaryListener">
                %loop listeners%
                %ifvar matches('HTTP*') protocol%
                %ifvar equals('true') enabled%
                %ifvar equals('WmRoot') pkg%
          %ifvar equals('Regular') listenerType%
                    <option value='%value key%' %ifvar primary equals('true')%selected%endif%>
                      %value protocol%@%value port%
                    </option>
          %endif%
                %endif%
                %endif%
                %endif%
                %endloop%
                </select>
                %endinvoke%
            </td>
        </tr>
        <tr>
            <td class="action" colspan="2"><input type="submit" value="Update"></td>
        </tr>

        </form>
      </TABLE>
    </TD>
  </TR>
</TABLE>
</BODY>
</HTML>
