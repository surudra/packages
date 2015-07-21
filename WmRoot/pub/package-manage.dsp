<HTML>
  <HEAD>
    <meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <META HTTP-EQUIV="Expires" CONTENT="-1">
    <TITLE>Integration Server -- Manage Packages
    </TITLE> <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    <SCRIPT src="webMethods.js.txt"></SCRIPT>
  </HEAD>

  <BODY onLoad="setNavigation('package-list.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Packages_ActivatePkgsScrn');">
    <TABLE WIDTH=100%>
      <TR>
        <TD class="menusection-Packages" colspan=2>
          Packages &gt;
          Management &gt;
          Activate Package
        </TD>
      </TR>

      %ifvar action%
          %switch action%
              %case 'activate'%
                  %invoke wm.server.packages.adminui:packageActivate%
                      %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
                          <TR><TD class="message" colspan="2">%value none message%</TD></TR>
                      %endif%
                  %endinvoke%
          %endswitch%
      %endif%

      <TR>
        <TD colspan=2>
          <UL>
            <LI><A HREF="package-list.dsp">Return to Package Management</A></LI>
          </UL>
        </TD>
      </TR>


        %scope param(additional='all')%
        %invoke wm.server.packages:packageList%
        <TR>
            <TD><IMG SRC="images/blank.gif" height=10 width=10 border=0></TD>
            <TD>
              <TABLE class="tableForm">
                <FORM name="activate" action="package-manage.dsp" method="POST">

                 <INPUT type="hidden" name="action" value="activate">
                 <TR>
                    <TD class="heading" colspan=3>Inactive Packages</TD>
                 </TR>
                 <TR>
                  %ifvar inactive%
                    <TD class="oddrow">Package name</TD>
                    <TD class="oddrow-l">
                       <SELECT NAME="package" WIDTH=150> %loop inactive%
                          <OPTION VALUE="%value%">%value%</OPTION> %endloop%
                       </SELECT>
                       <BR> </TD>
                  </TR>
                  <TR>
                    <TD class="action" colspan=2>
                       <INPUT type="submit" value="Activate Package"> </TD>
                    %else%
                    <TD class="oddrow" colspan=3>
                       No inactive packages
                    </TD>

                  %endif%
                 </TR>
              </FORM> %endinvoke%  %endscope%
         </TABLE>
      </TD></TR></TABLE>
</BODY>
</HTML>
