<HTML>
  <HEAD>
    <meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">
    <TITLE>Package Exchange</TITLE>
    <SCRIPT SRC="webMethods.js.txt"></SCRIPT>
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
  </HEAD>

  <BODY onLoad="setNavigation('package-exchange.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Packages_PublishingPkgsScrn');">
    <TABLE width=100%>
      <TR>
        <TD class="menusection-Packages" colspan="2">
            Packages &gt;
            Publishing </TD>
      </TR>

%ifvar action%
%switch action%

%case 'release'%
    %invoke wm.server.replicator:packageRelease%
        %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
            <TR><TD class="message" colspan=2>%value message%</TD></TR>
        %endif%
    %onerror%
        %ifvar errorMessage%
      <tr><td colspan="2">&nbsp;</td></tr>
            <TR><TD class="message" colspan=2>%value encode(htmlall) errorMessage%</TD></TR>
        %endif%
    %endinvoke%

%case 'sendrelease'%
    %invoke wm.server.replicator.adminui:packageSendZip%
        %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
            <TR><TD class="message" colspan=2>%value message%
        %endif%
    %onerror%
        %ifvar errorMessage%
      <tr><td colspan="2">&nbsp;</td></tr>
            <TR><TD class="message" colspan=2>%value encode(htmlall) errorMessage%</TD></TR>
        %endif%
    %endinvoke%

%case 'add'%
    %invoke wm.server.replicator.adminui:subscriberAdd%
        %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
            <TR><TD class="message" colspan=2>%value message%</TD></TR>
        %endif%
    %onerror%
        %ifvar errorMessage%
      <tr><td colspan="2">&nbsp;</td></tr>
            <TR><TD class="message" colspan=2>%value encode(htmlall) errorMessage%</TD></TR>
        %endif%
    %endinvoke%

%case 'updateall'%
  %invoke wm.server.replicator:getRefreshedSubscriptions%
  %endinvoke%

%case 'edit'%
    %invoke wm.server.replicator.adminui:subscriberEdit%
        %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
            <TR><TD class="message" colspan=2>%value message%</TD></TR>
        %endif%
    %onerror%
        %ifvar errorMessage%
      <tr><td colspan="2">&nbsp;</td></tr>
            <TR><TD class="message" colspan=2>%value encode(htmlall) errorMessage%</TD></TR>
        %endif%
    %endinvoke%


%case%
      <tr><td colspan="2">&nbsp;</td></tr>
    <TR><TD class="message" colspan=2>%value action%</TD></TR>

%endswitch%
%endif%

        <TR>
            <TD colspan=2>
                <UL>
                    <LI><A HREF="package-release-selection.dsp">Create and Delete Releases</A></LI>
                    <LI><A HREF="package-add-subscriber.dsp">Add Subscribers</A></LI>
                    <LI><A HREF="package-remove-subscriber.dsp">Update and Remove Subscribers</A></LI>
                </UL>
            </TD>
        </TR>
%invoke wm.server.packages:packageList%
        <TR>
          <TD><IMG SRC="images/blank.gif" height=10 width=10></TD>
          <TD valign=top>
<TABLE class="tableView" width=100%>
                <TR>
                    <TD class="heading" colspan=2>Available Releases</TD>
                </TR>

<script>swapRows();</script>
        %invoke wm.server.replicator:getDetailedReleasedList%

<script>
var Releases = 0;

</script>
%ifvar packages%
        %loop packages%

            %ifvar released%





                <script>writeTDrowspan("rowdata-l",2);</script>
                 %value name%</TD>
          <td class="oddrow-l" style="padding: 0px;">


                    %ifvar subscribers%
                  <table class="tableInline" cellspacing=1 >
                  <tr>
                  <td class="oddrow">Subscribers:</td>
                  <td>
                  <table class="tableInline" cellspacing=1 >

                  %loop subscribers%

                  <tr><td class="oddrow-l">
                  %value%
                  </td></tr>
                      %endloop%

                    </tr>
                    </table>
                    </td>
                    </tr>
                    </table>

                    %else%

                    Subscribers: none

                    %endif%
                  </TD>

                </TR>


                <TR>

                  <TD style="padding: 0px;">
                    <TABLE class="tableInline" width=100% cellspacing=1>

                      <TR>
                    <script>writeTD("col-l");</script><nobr>Release Name</nobr></TD>
                    <script>writeTD("col");</script>Version</TD>
                    <script>writeTD("col");</script>Build</TD>
                    <script>writeTD("col");</script>Created on</TD>
                    <script>writeTD("col");</script><nobr>&nbsp;</nobr></TD>
                    </TR>
<script>swapRows();</script>
            %loop released%

                <TR>
                    <script>writeTDrowspan("rowdata-l",2);</script>
                        %value name%</td>
                    <script>writeTD("rowdata");</script>
                        %value version%</TD>
                    <script>writeTD("rowdata");</script>
                        %value build%</TD>
                    <script>writeTD("rowdata");</script>
          %value time%
                        </TD>

      <script>writeTDrowspan("rowdata-r",2);</script>
                %ifvar ../subscribers%
                <A href="package-send-release-select-subscribers.dsp?release=%value -urlencode name%&package=%value -urlencode ../name%"><nobr>Send Release</nobr></A>
                %else%
                <nobr>No subscribers</nobr>
                %endif%
                </TD>

                </TR>
                <TR>


                    <script>writeTDspan("rowdata-l",3);</script>
                        %ifvar description equals('')%
                          -
                        %else%
                          <span style="font-weight: normal;">%value description%</span>
                        %endif%
                    </TD>
                </TR>

            %endloop%
            </TABLE></TD></TR>
<script>swapRows();</script>
<script>Releases++;</script>
            %endif%


        %endloop%

%endif%

<script>
if (Releases==0)
{	document.write("<TR><TD class='oddrow-l' colspan=2>No Releases</TD></TR>"); }
</script>

        %endinvoke%
            </TABLE>
          </TD>
        </TR>
    </TABLE>
    </BODY>
</HTML>
