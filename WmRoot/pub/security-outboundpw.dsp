<HTML>
  <HEAD>
    <TITLE>Integration Server -- Outbound Password Management</TITLE>

    <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <META HTTP-EQUIV='Content-Type' CONTENT='text/html; charset=UTF-8'>
    <META HTTP-EQUIV="Expires" CONTENT="-1">
    <LINK REL="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css"></LINK>
    <SCRIPT type="text/javascript" SRC="/WmRoot/webMethods.js.txt"></SCRIPT>

  </HEAD>

  <BODY onLoad="setNavigation('security-outboundpw.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_OutboundPasswordsScrn');">

    <FORM method="post" name="propsForm" action="security-outboundpw.dsp">

      <TABLE width="100%">

        <INPUT type="hidden" name="action" value="%value action%"/>
        <INPUT type="hidden" name="expDate" value=""/>
        <INPUT type="hidden" name="expireInterval" value="%value expireInterval%"/>
        <INPUT type="hidden" name="interval" value=""/>
        <INPUT type="hidden" name="expiresIn" value=""/>
        <INPUT type="hidden" name="stateMsg" value=""/>

        <TR>
          <TD class="menusection-Security" colspan="2"> Security &gt; Outbound Passwords </TD>
        </TR>

        %ifvar action equals('reset')%
          %invoke wm.server.internalOutboundPasswords:resetAllPasswords%
            %onerror%
              %ifvar errorMessage%
                <TR><TD colspan="2">&nbsp;</TD></TR>
                <TR><TD class="message" colspan=2>%value errorMessage%</TD></TR>
              %endif%
          %endinvoke%
        %endif%

        %ifvar action equals('updateInterval')%
          %invoke wm.server.internalOutboundPasswords:setMasterExpireInterval%
            %onerror%
              %ifvar errorMessage%
                <TR><TD colspan="2">&nbsp;</TD></TR>
                <TR><TD class="message" colspan=2>%value errorMessage%</TD></TR>
              %endif%
          %endinvoke%
        %endif%

        %ifvar action equals('updateMaster')%
          %invoke wm.server.internalOutboundPasswords:rawMasterUpdate%
            %onerror%
              %ifvar errorMessage%
                <TR><TD colspan="2">&nbsp;</TD></TR>
                <TR><TD class="message" colspan=2>%value errorMessage%</TD></TR>
              %endif%
          %endinvoke%
        %endif%

        %invoke wm.server.internalOutboundPasswords:getMasterPasswordProperties%
          %rename expireDate expDate -copy%
          %rename expireInterval interval -copy%
          %rename daysTilExpire expiresIn -copy%
          %rename statusMessage stateMsg -copy%
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
              <LI><A HREF="masterPwUpdate.dsp">Update Master Password</A></LI>
              <LI><A HREF="masterPwExpire.dsp">Update Expiration Interval</A></LI>
            </UL>
          </TD
        </TR>

        <TR>
          <TD></TD>
          <TD>
            <TABLE class="tableForm" width="60%">
              <TR>
                <TD class="heading" colspan=2>Master Password Properties</TD>
              </TR>
              <script>resetRows();</script>
              <TR>
                <TD class="oddrow">Expiration Date</TD>
                <TD class="oddrowdata-l">%value expDate%</TD>
              </TR>
              <TR>
                <TD class="evenrow">Expiration Interval (in days)</TD>
                <TD class="evenrow-l">%value interval%</TD>
              </TR>
              <TR>
                <TD class="oddrow">Number of Days to Expiration</TD>
                <TD class="oddrowdata-l">%value expiresIn%</TD>
              </TR>
              <TR>
                <TD class="evenrow">Status</TD>
                <TD class="evenrowdata-l">%value stateMsg%</TD>
              </TR>
            </TABLE>
          </TD>
        </TR>

      </TABLE>
    </FORM>

  </BODY>

</HTML>

