<HTML>
  <HEAD>
    <TITLE>Integration Server -- Outbound Password Management</TITLE>

    <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <META HTTP-EQUIV='Content-Type' CONTENT='text/html; charset=UTF-8'>
    <META HTTP-EQUIV="Expires" CONTENT="-1">
    <LINK REL="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css"></LINK>
    <SCRIPT type="text/javascript" SRC="/WmRoot/webMethods.js.txt"></SCRIPT>

    <SCRIPT type="text/javascript">
      function changeProps()
      {
        var newInt = document.propsForm.newInterval.value;
        document.propsForm.action.value = "updateInterval";
        document.propsForm.expireInterval.value = newInt;
        document.propsForm.submit();
        return true;
      }
    </SCRIPT>

  </HEAD>

  <BODY onLoad="setNavigation('masterPwExpire.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_UpdateExpirationScrn');">

    <FORM method="post" name="propsForm" action="security-outboundpw.dsp">

      <TABLE width="100%">

        <INPUT type="hidden" name="action" value="%value action%"/>
        <INPUT type="hidden" name="expireInterval" value="%value expireInterval%"/>
        <INPUT type="hidden" name="interval" value=""/>

        <TR>
          <TD class="menusection-Security" colspan="2"> Security &gt; Outbound Passwords &gt; Update Expiration Interval</TD>
        </TR>

        %invoke wm.server.internalOutboundPasswords:getMasterPasswordProperties%
          %rename expireInterval interval -copy%
          %onerror%
            %ifvar errorMessage%
              <TR><TD colspan="2">&nbsp;</TD></TR>
              <TR><TD class="message" colspan=2>%value errorMessage%</TD></TR>
            %endif%
        %endinvoke%

        %invoke wm.server.internalOutboundPasswords:getMasterExpireMessage%
          %ifvar expireMessage%
            <TR><TD colspan="2">&nbsp;</TD></TR>
            <TR><TD class="message" colspan="2">%value expireMessage%</TD></TR>
          %endif%
        %endinvoke%

        %ifvar message%
          <TR><TD colspan="2">&nbsp;</TD></TR>
          <TR><TD class="message" colspan="2">%value message%</TD></TR>
        %endif%

        <TR>
          <TD colspan="2">
            <UL>
              <LI><A HREF="security-outboundpw.dsp">Return to Outbound Passwords</A></LI>
            </UL>
          </TD
        </TR>

        <TR>
          <TD></TD>
          <TD>
            <TABLE class="tableForm" width="60%">
              <TR>
                <TD class="heading" colspan=2>Master Password Expiration Interval</TD>
              </TR>
              <script>resetRows();</script>
              <TR>
                <TD class="evenrow">Expiration Interval (in days)</TD>
                <TD class="evenrow-l">
                  <INPUT type="text" name="newInterval" SIZE="4"
                         value="%value interval%"/></TD>
              </TR>
              <TR>
                <TD class="action" colspan=2>
                  <INPUT class="data" type="submit" value="Save Changes"
                         name="ok" onClick="return changeProps();"/>
                </TD>
              </TR>
            </TABLE>
          </TD>
        </TR>

      </TABLE>
    </FORM>

  </BODY>

</HTML>

