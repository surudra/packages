<HTML>
  <HEAD>
    <meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <META HTTP-EQUIV="Expires" CONTENT="-1">
    <TITLE>Integration Server -- Manage Packages</TITLE>
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    <SCRIPT src="webMethods.js.txt"></SCRIPT>
   </HEAD>

  <BODY onLoad="setNavigation('package-list.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Packages_InboundRelScrn');">
    <TABLE WIDTH=100%>
      <TR>
        <TD class="menusection-Packages" colspan=2>
          Packages &gt;
          Management &gt;
          Install Inbound Releases
        </TD>
      </TR>


      %ifvar action%
        %switch action%
          %case 'install'%
            %invoke wm.server.packages:packageInstall%
              %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
                <TR><TD class="message" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value message%</TD></TR>
              %endif%
            %endinvoke%
        %endswitch%
      %endif%


      %scope param(additional='all')%
      %invoke wm.server.packages:packageList%
      <TR>
	<td colspan="2">
          <UL><LI><A HREF="package-list.dsp">Return to Package Management</A></LI></UL>
	</td>
      </tr>
	<tr><td><img src="images/blank.gif" height="10" width="10" border="0"></td>
	  <td>
          <TABLE class="tableForm">
            <FORM name="inbound" action="package-inbound.dsp" method="POST">
            <TR>
            <INPUT type="hidden" name="action" value="install">
              <TD class="heading" colspan=2>Inbound Releases</TD>
            </TR>
            %ifvar inbound%
              <TR>
                <TD class="oddrow">Release file name</TD>
                <TD class="oddrow-l">
                  <SELECT NAME="file" WIDTH=150> %loop inbound%
                    <OPTION VALUE="%value%">%value%</OPTION> %endloop%
                  </SELECT>
                </TD>
              </TR>
              <TR>
                <TD class="evenrow">Option</TD>
                <TD class="evenrow-l">
                  <INPUT type="checkbox" name="activateOnInstall"
                  checked> Activate upon installation</INPUT><BR/>
		    <INPUT type="checkbox" name="archiveOnInstall"
		    checked> Archive upon installation</INPUT>
                </TD>
              </TR>
              <TR>
                <TD class="action" colspan=2>
                  <INPUT type="submit" value="Install Release">
                </TD>
              </TR>
            %else%
              <TR>
                <TD class="oddcol" colspan=2>No inbound releases</TD>
              </TR>
            %endif%
            </FORM>
       </TABLE>
     </TD>
   </TR>
   %endinvoke%
   %endscope%
 </TABLE>
</BODY>
</HTML>
