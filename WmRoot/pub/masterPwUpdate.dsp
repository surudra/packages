<HTML>
  <HEAD>

    <TITLE>Integration Server - Outbound Password Master Password</TITLE>

    <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <META HTTP-EQUIV='Content-Type' CONTENT='text/html; charset=UTF-8'>
    <META HTTP-EQUIV="Expires" CONTENT="-1">
    <LINK REL="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css"></LINK>
    <SCRIPT type="text/javascript" SRC="/WmRoot/webMethods.js.txt"></SCRIPT>

    <SCRIPT>

      function checkPasses(protocol, local)
      {
        if ( !local && protocol == 'HTTP' ) {
          var msg = "Warning: Sending password information over non-SSL protocol is not secure, it is recommended that password information be submitted over SSL connections only.  Do you wish to continue?";

          if ( ! confirm( msg ) ) {
            return false;
          }
        }

        var covered = true;

        var passField1 = document.form.newPass.value;
        var passField2 = document.form.repass.value;
        var mismatchMsg = "Values for new password and re-entered new password do not match";

        if( (passField1 == "") && (passField2 != "") )
        {
          covered = false;
          alert(mismatchMsg);
        }
        else if( (passField1 != "") && (passField2 == "") )
        {
          covered = false;
          alert(mismatchMsg);
        }
        else
        {
          if( (passField1 != "") && (passField2 != "") )
          {
            if(passField1 != passField2)
            {
              covered = false;
              alert(mismatchMsg);
              return covered;
            }
          }
        }

        if ( covered ) {
          document.form.oldPassword.value=document.form.oldPass.value;
          document.form.newPassword.value=passField1;
          document.form.action.value="updateMaster";
          document.form.submit();
        }
        return covered;
      }
    </SCRIPT>
  </HEAD>


  <BODY onLoad="setNavigation('masterPw.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_UpdateMasterPasswordScrn');">

    <TABLE width=100%>
      <TR>
        <TD colspan=2 class="menusection-Security" >
            Security &gt;
            Outbound Passwords &gt;
            Update Master Password</TD>
      </TR>

      <FORM id="form" name="form" method="POST" action="security-outboundpw.dsp">
        <INPUT type="hidden" name="action" value=""></INPUT>
        <INPUT type="hidden" name="oldPassword" value=""></INPUT>
        <INPUT type="hidden" name="newPassword" value=""></INPUT>
        <INPUT type="hidden" name="encryptCode" value=""></INPUT>
        <INPUT type="hidden" name="protocolInUse" value=""></INPUT>

        <!-- %invoke wm.server.pki.admin:getProtocolInfo% -->
          <!-- %rename subprotocol protocolInUse -copy% -->
          <!-- %rename local clientIsLocal -copy% -->
        <!-- %endinvoke% -->

        <TR>
          <TD colspan="2">
            <UL>
              <LI><A HREF="confirm-outbound-reset.dsp">Reset All Outbound Passwords</A></LI>
              <LI><A HREF="security-outboundpw.dsp">Return to Outbound Passwords</A></LI>
            </UL>
          </TD>
        </TR>
        <TR>
          <TD></TD>
          <TD>
            <TABLE class="tableForm" width="60%">
              <TR>
                <TD class="heading" colspan=2>Current Password</TD>
              </TR>
              <TR>
                <TD class="oddrow">Password</TD>
                <TD class="oddrow-l">
                  <INPUT type="password" name="oldPass" id="oldPass" autocomplete="off"
                         value=""</INPUT></TD>
              </TR>
              <TR>
                <TD class="space" colspan=2>&nbsp;</TD>
              </TR>
              <TR>
                <TD class="heading" colspan=2>New Password</TD>
              </TR>
              <TR>
                <TD class="oddrow">Password</TD>
                <TD class="oddrow-l">
                  <INPUT type="password" name="newPass" id="newPass" autocomplete="off"
                         value=""></INPUT></TD>
              </TR>
              <TR>
                <TD class="evenrow">Re-Enter Password</TD>
                <TD class="evenrow-l">
                  <INPUT type="password" name="repass" id="repass" autocomplete="off"
                         value=""></INPUT></TD>
              </TR>
              <TR>
                <TD class="action" colspan=2>
                  <INPUT type="submit" value="Change Password" name="submit"
                         onClick="return checkPasses('%value protocolInUse%', '%value clientIsLocal%');"></INPUT>
                </TD>
              </TR>
            </TABLE>
          </TD>
        </TR>
      </FORM>
    </TABLE>

  </BODY>
</HTML>


