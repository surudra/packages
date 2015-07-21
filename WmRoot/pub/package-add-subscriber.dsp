<HTML>
    <HEAD>
      <meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
      <META HTTP-EQUIV="Expires" CONTENT="-1">
      <TITLE>Package Exchange</TITLE>
      <SCRIPT SRC="webMethods.js.txt"></SCRIPT>
      <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    </HEAD>

    <BODY onLoad="setNavigation('package-exchange.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Packages_AddSubsScrn');">

    <SCRIPT LANGUAGE="JavaScript">

      function onAdd()
      {
      var host = document.subadd.host.value;
      var port = document.subadd.port.value;
      var username = document.subadd.remoteuser.value;
      var password = document.subadd.remotepass.value;

      if ( host == null || host == "" ) {
        alert("Host Name is required.");
        return false;
      } else if( port == null || port == "" ) {
        alert("Host Port is required.");
        return false;
      } else if( username == null || username == "" ) {
        alert("Remote User Name is required.");
        return false;
      } else if( password == null || password == "" ) {
        alert("Remote Password is required.");
        return false;
      } else {
        return true;
      }

      }
    </SCRIPT>

    <TABLE width=100%>
        <TR>
            <TD class="menusection-Packages" colspan="3">
                Packages &gt;
                Publishing &gt;
                Add Subscriber
            </TD>
        </TR>
        <TR>
          <TD colspan=2>
            <UL>
              <LI><A HREF="package-exchange.dsp">Return to Publishing</A></LI>
            </UL>
          </TD>
        </TR>
        <TR>
            <TD><IMG SRC="images/blank.gif" height=10 width=10></TD>
            <TD valign=top>
                <TABLE class="tableForm">
                <TR>
                    <TD class="heading" colspan="2">Add Subscriber</TD>
                </TR>
      <FORM NAME="subadd" ACTION="package-exchange.dsp" METHOD="POST">
      <INPUT TYPE="hidden" NAME="action" VALUE="add">
                <tr>
                  <TD class="evenrow">Packages</TD>
                  <TD class="evenrow-l">
                    <SELECT name="package">
          %invoke wm.server.packages:packageList%
                    %loop packages%
                    <option value="%value name%">%value name%</option>
                    %endloop%
                    </SELECT>
                  </TD>
                </tr>
                <tr>
                  <TD class="oddrow">Host Name</TD>
                  <TD class="oddrow-l"><INPUT NAME="host" VALUE=""></INPUT></td>
                </tr>
                <tr>
                  <TD class="evenrow" class="evenrow">Host Port</TD>
                  <TD class="evenrow-l"><INPUT NAME="port" VALUE=""></INPUT></td></tr>
                <tr>
                  <TD class="oddrow">Transport</TD>
                  <TD class="oddrow-l">
                    <SELECT NAME="ssl">
                    <OPTION  value="HTTP">HTTP</OPTION>
                    <OPTION  value="HTTPS">HTTPS</OPTION>
                    </SELECT>
                  </TD>
                </tr>
                <tr>
                  <TD class="evenrow">Remote User Name</TD>
                  <TD class="evenrow-l"><INPUT NAME="remoteuser" ></INPUT></td>
                </tr>
                <tr>
                  <TD class="oddrow">Remote Password</TD>
                  <TD class="oddrow-l"><INPUT TYPE="password" NAME="remotepass" autocomplete="off"></INPUT></td>
                </tr>
                <tr>
                  <TD class="evenrow">Notification Email</TD>
                  <TD class="evenrow-l">
                    <INPUT NAME="email"></INPUT>
                  </td>
                </tr>

                <tr>
                  <td colspan=2 class="action">
                    <INPUT type="submit" name="submit" onclick="return onAdd(); return false;" value="Add Subscriber">
                  </td>
                </tr>
              </table>

            </TD>
        </TR>
       </FORM>
  </table>
</BODY>
</HTML>
