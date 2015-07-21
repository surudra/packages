<HTML>
  <HEAD>
    <meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <META HTTP-EQUIV="Expires" CONTENT="-1">
    <TITLE>Package Exchange</TITLE>
    <SCRIPT SRC="webMethods.js.txt"></SCRIPT>
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
  </HEAD>

  <BODY onLoad="setNavigation('package-subscribing.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Packages_FtpPullScrn');">
    <TABLE width=100%>
      <TR>
        <TD class="menusection-Packages" colspan=2>
            Packages &gt;
            Subscribing &gt;
            FTP Pull
        </TD>
      </TR>
      <TR>
        <TD>
          &nbsp;
        </TD>
      </TR>
      <TR>
        <TD><IMG SRC="images/blank.gif" height=10 width=10></TD>
        <TD>
          <TABLE class="tableForm">
            <FORM NAME="ftpform" action="package-subscribing.dsp" method="POST">
            <INPUT type="hidden" name="action" value="ftpPull">
            <INPUT type="hidden" name="pkgname" value="%value package%">
            <INPUT type="hidden" name="publisher" value="%value alias%">

            <TR>
              <TD class="heading" colspan=2>FTP Pull Information</TD>
            </TR>
            <TR>
              <TD class="oddrow">Release Name</TD>
              <TD class="oddrow-l"><b>%value package%</b></TD>
            </TR>

            <TR>
              <TD class="evenrow">Remote Server Alias</TD>
              <TD class="evenrow-l"><b>%value alias%</b></TD>
            </TR>

            <TR>
              <TD class="oddrow">Remote Server FTP Port</TD>
              <TD class="oddrow-l">
                <INPUT NAME="port"></INPUT>
              </TD>
            </TR>

            <TR>
              <TD class="evenrow">Remote User Name</TD>
              <TD class="evenrow-l">
                <INPUT NAME="user"></INPUT>
              </TD>
            </TR>

            <TR>
              <TD class="oddrow">Remote Password</TD>
              <TD class="oddrow-l">
                <INPUT NAME="pass" TYPE="password" autocomplete="off"></INPUT>
              </TD>
            </TR>
            <TR>
              <TD class="action" colspan=2>
                <INPUT type="submit" value="FTP Retrieve">
              </TD>
            </TR>
            </FORM>
          </TABLE>
        </TD>
      </TR>
    </TABLE>
  </BODY>
</HTML>
