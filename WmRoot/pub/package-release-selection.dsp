
<HTML>
  <HEAD>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">


    <TITLE>Integration Server</TITLE>

    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    <SCRIPT SRC="webMethods.js.txt"></SCRIPT>
  </HEAD>
  <BODY onLoad="setNavigation('package-exchange.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Packages_CreateDelRelsScrn');">
    <TABLE width="100%">
      <TR>
        <TD class="menusection-Packages" colspan=2>
          Packages &gt;
          Publishing &gt;
          Create and Delete Releases
        </TD>
      </TR>

      %ifvar action equals('unrelease')%
          %invoke wm.server.replicator:packageUnRelease%
      <tr><td colspan="2">&nbsp;</td></tr>
                  <TR><TD class="message" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Release %value releasedPackages% Deleted</TD></TR>
          %onerror%
              %ifvar errorMessage%
      <tr><td colspan="2">&nbsp;</td></tr>
                  <TR><TD class="message" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Error: %value none errorMessage%</TD></TR>
              %endif%
          %endinvoke%
      %endif%

      <TR>
        <TD colspan=2>
          <UL>
            <LI><A HREF="package-exchange.dsp">Return to Publishing</A></LI>
          </UL>
        </TD>
      </TR>
      <TR>
        <TD><IMG src="images/blank.gif" height=10 width=10 border=0></TD>
        <TD>
          <TABLE class="tableView" width=100%>
            %invoke wm.server.replicator:getDetailedReleasedList%

<tr>
  <TD class="heading" colspan=2>Packages and Releases</td>

</tr>

<tr>
  <TD class="oddcol-l">Package</td>
  <TD class="oddcol-l">Releases</td>
</tr>

<script>swapRows();</script>
            %loop packages%

                    <TR>
<script>writeTDrowspan("rowdata-l",2);</script>
%value name%</TD>
<script>writeTD("rowdata-l");</script>
%ifvar name equals('WmRoot')%
Not Available
%else%
<A HREF="package-archive.dsp?package=%value -urlencode name%&release=true">Create Release</A>
%endif%
</td><tr>


<td style="padding: 0px;"><table class="tableInline" width=100% cellspacing=1>
%ifvar name equals('WmRoot')%
<tr><td>&nbsp;</td></tr>
%else%
%ifvar released%
<script>swapRows();</script>
                    <TR>
                        <script>writeTD("col-l");</script>Release Name</TD>
                        <script>writeTD("col");</script>Version</TD>
                        <script>writeTD("col");</script>Build</TD>
                        <script>writeTD("col-l");</script>Created on</TD>
                        <script>writeTD("col");</script>Delete</TD>
                    </TR>
<script>swapRows();</script>
                %loop released%

                    <TR>
                        <script>writeTDrowspan("rowdata-l",2);</script>
                            %value name%</TD>
                        <script>writeTD("rowdata");</script>
                            %value version%</TD>
                        <script>writeTD("rowdata");</script>
                            %value build%</TD>
                        <script>
                          writeTD("rowdata-l");
                          </script>
                          %value time%
                        </TD>
                        <script>writeTDrowspan("rowdata",2);</script>
                            <A class ="imagelink" href="package-release-selection.dsp?action=unrelease&releasedPackages=%value -urlencode name%"><IMG
                                SRC="icons/delete.gif" border=0
                                alt="Delete %value name%"></A></TD>
                    </TR>
                    <TR>
                        <script>writeTDspan("rowdata-l",3);</script>
                            %ifvar description equals('')%
                              &nbsp;
                            %else%
                              %value description%
                            %endif%
                        </TD>
                    </TR>
%endloop%

                %else%

                                <tr><script>writeTD("row-l");</script>No Releases</TD></tr>



%endif%
%endif%

</table></td>

</tr>

<script>swapRows();</script>
            %endloop%

            %endinvoke%
          </TABLE>
        </TD>
      </TR>
    </TABLE>
  </BODY>
</HTML>
