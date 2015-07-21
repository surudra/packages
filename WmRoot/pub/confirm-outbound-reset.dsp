<HTML>
  <HEAD>
    <TITLE>Integration Server -- Confirm Outbound Password Clearing</TITLE>

    <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <META HTTP-EQUIV='Content-Type' CONTENT='text/html; charset=UTF-8'>
    <META HTTP-EQUIV="Expires" CONTENT="-1">
    <LINK REL="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css"></LINK>
    <SCRIPT type="text/javascript" SRC="/WmRoot/webMethods.js.txt"></SCRIPT>

    <SCRIPT type="text/javascript">
      function goAhead() {
        if ( confirm( "WARNING: This operation can not be undone!\nAre you sure you want to reset all outbound passwords?" ) ) {
          document.resetForm.action.value = "reset";
          document.resetForm.submit();
          return true;
        }
        return false;
      }
    </SCRIPT>

  </HEAD>

  <BODY onLoad="setNavigation('confirm-outbound-reset.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_ResetAllPasswordsScrn');">

    <FORM method="post" name="resetForm" action="security-outboundpw.dsp">

      <INPUT type="hidden" name="action" value=""/>

      <TABLE width="100%">
        <TR>
          <TD class="menusection-Security" colspan="2"> Security &gt;
                                                        Outbound Passwords &gt;
                                                        Reset All Outbound Passwords
          </TD>
        </TR>

        <TR>
          <TD colspan="2">
            <UL>
              <LI><A HREF="masterPwUpdate.dsp">Return to Update Master Password</A></LI>
            </UL>
          </TD>
        </TR>
        <TR>
          <TD class="message" colspan="2">WARNING! This operation is NOT reversible</TD>
        </TR>
        <TR>
          <TD><IMG SRC="images/blank.gif" height="20" width="10"></TD>
          <TD>
            <TABLE class="tableForm" width="80%">
              <TR>
                <TD class="heading" colspan="2">Reset All Outbound Passwords</TD>
              </TR>
              <TR>
                <TD class="evenrow"></TD>
              </TR>
              <TR>
                <TD class="oddrowdata-l">
                  Perform this procedure only if your Integration Server
                  encrypts outbound passwords using Password-Based
                  Encryption (PBE) and you have lost your master password.
                  This procedure clears (blanks out) the stored outbound
                  passwords and resets the master password to the default value.
                </TD>
              <TR>
                <TD class="evenrow"></TD>
              </TR>
              <TR>
                <TD class="oddrowdata-l">
                  After you reset the passwords, the Integration Server will
                  no longer be able to connect to the applications/subsystems
                  for which the passwords are required. You must manually
                  re-enter the appropriate passwords for all
                  applications/subsystems on their respective configuration
                  screens in the Server Administrator. In addition, you
                  must reset the master password to be something other than
                  the default value.
                </TD>
              </TR>
              <TR>
                <TD class="action">
                  <INPUT class="data" type="button" value="Reset Passwords"
                         onclick="goAhead();"></INPUT>
                </TD>
              </TR>
      </TABLE>
    </FORM>

  </BODY>

</HTML>

