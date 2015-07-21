<HTML>
  <HEAD>
    <meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <META HTTP-EQUIV="Expires" CONTENT="-1">
    <TITLE>Package Exchange</TITLE>
    <SCRIPT SRC="webMethods.js.txt"></SCRIPT>
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
  </HEAD>

  <BODY onLoad="setNavigation('package-subscribing.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Packages_UpdateUnsubRemotePkgScrn');">
    <TABLE width=100%>
      <TR>
        <TD class="menusection-Packages" colspan=2>
            Packages &gt;
            Subscribing &gt;
            Update and Unsubscribe
        </TD>
      </TR>

%ifvar action equals('unsub')%
  %invoke wm.server.replicator.adminui:subscriptionCancel%
    %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
      <TR>
        <TD class="message" colspan=2>%value message%</TD>
      </TR>
    %endif%
  %endinvoke%
%endif%

        <TR>
            <TD colspan=2>
                <UL>
                    <LI><A HREF="package-subscribing.dsp?refresh=true">Back to Subscribing</A></LI>
                </UL>
            </TD>
        </TR>
  %invoke wm.server.packages:packageList%
        <TR>
            <TD><IMG SRC="images/blank.gif" height=10 width=10></TD>

            <TD valign=top>
                <TABLE class="tableView">
                  <TR>
                    <TD class="heading" colspan=3>Available Subscriptions</TD>
                  </TR>

            %invoke wm.server.replicator:subscribedList%
      %ifvar subscribed%
            %loop subscribed%
                    <TR>
                        <TD class="subHeading" colspan=3>Publisher: %value publisher%</TD>
                    </TR>

                    <TR>
                        <TD class="oddcol">Package Name</TD>
                        <TD class="oddcol">Update</TD>
                        <TD class="oddcol">Unsubscribe</TD>
                    </TR>

                    <script>resetRows();</script>

                 %ifvar remote equals('no')%
                	%ifvar packageList%
                		%loop packageList%
                    	<TR>
                        <script>writeTD("rowdata-l");</script>
                            %value%</TD>
                        <script>writeTD("rowdata");</script>

                        	<A HREF="package-edit-subscription.dsp?hostport=%value publisher%&package=%value%">Edit</A>
                        	</TD>
                        <script>writeTD("rowdata");</script>

                            <a href="package-unsubscribe.dsp?action=unsub&package=%value%&hostport=%value publisher%"><IMG
                            SRC="icons/delete.gif" BORDER=0></A>
                        </TD>
                    	</TR>
                    	<script>swapRows();</script>
                		%endloop%
                	%else%
                		<tr><td class="oddcol">No packages.</td></tr>
                	%endif%
                %else%
                	%ifvar packageList%
                		%loop packageList%
                    	<TR>
                        <script>writeTD("rowdata-l");</script>
                            %value%</TD>
                        <script>writeTD("rowdata");</script>

                        	Not Available
                        	</TD>
                        <script>writeTD("rowdata");</script>

                            <a href="package-unsubscribe.dsp?action=unsub&package=%value%&hostport=%value publisher%"><IMG
                            SRC="icons/delete.gif" BORDER=0></A>
                        </TD>
                    	</TR>
                    	<script>swapRows();</script>
                		%endloop%
                	%else%
                		<tr><td class="oddcol">No packages.</td></tr>
                	%endif%
                %endif%
                %endloop%
                %else%
                <tr><td colspan="3" class="oddcol">No subscriptions.</td></tr>
                %end if%

            %endinvoke%

                </TABLE>
            </TD>
        </TR>
    </TABLE>
    </BODY>
</HTML>
