<HTML>
  <HEAD>
    <meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <META HTTP-EQUIV="Expires" CONTENT="-1">
    <TITLE>Package Exchange</TITLE>
    <SCRIPT SRC="webMethods.js.txt"></SCRIPT>
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
  </HEAD>

  <BODY onLoad="setNavigation('package-subscribing.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Packages_SubscribingScrn');">
    <TABLE width=100%>
      <TR>
        <TD class="menusection-Packages" colspan=2>
            Packages &gt;
            Subscribing
        </TD>
      </TR>

%ifvar action%
%switch action%

%case 'svcPull'%
      <tr><td colspan="2">&nbsp;</td></tr>
  %invoke wm.server.replicator:distributeViaSvcPull%
  <TR><td class="message" colspan=2>%value encode(htmlall) message%</td></TR>
  %endinvoke%

%case 'ftpPull'%
      <tr><td colspan="2">&nbsp;</td></tr>
  %invoke wm.server.replicator:pullPackageViaFtp%
  <TR><td class="message" colspan=2>%value encode(htmlall) message%</td></TR>
  %endinvoke%

%case 'updateall'%
  %invoke wm.server.replicator:getRefreshedSubscriptions%
  %endinvoke%

%case 'cancel'%
      <tr><td colspan="2">&nbsp;</td></tr>
  %invoke wm.server.replicator.adminui:subscriptionCancel%
  <TR><td class="message" colspan=2>%value encode(htmlall) message%</td></TR>
  %onerror%
  <TR><td class="message" colspan=2>%value encode(htmlall) errorOutputs/message%</td></TR>
  %endinvoke%

%case 'add'%
      <tr><td colspan="2">&nbsp;</td></tr>
  %invoke wm.server.replicator.adminui:subscriptionAdd%
  <TR><td class="message" colspan=2>%value encode(htmlall) message%</td></TR>
  %onerror%
  <TR><td class="message" colspan=2>%value encode(htmlall) errorMessage%</td></TR>
  %endinvoke%

%case 'edit'%
      <tr><td colspan="2">&nbsp;</td></tr>
  %invoke wm.server.replicator.adminui:subscriptionEdit%
  <TR><td class="message" colspan=2>%value encode(htmlall) message%</td></TR>
  %onerror%
  <TR><td class="message" colspan=2>%value encode(htmlall) errorMessage%</td></TR>
  %endinvoke%

%case 'pull'%
      <tr><td colspan="2">&nbsp;</td></tr>
  %invoke wm.server.replicator:distributeViaSvcPull%
  <TR><td class="message" colspan=2>%value encode(htmlall) message%</td><TR>
  %onerror%
  <TR><td class="message" colspan=2>%value error% &nbsp; %value encode(htmlall) errorMessage%</td></TR>
  %endinvoke%

%case%
      <tr><td colspan="2">&nbsp;</td></tr>
    <TR><TD class="message" colspan=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Unknown action %value action%</TD></TR>

%endswitch%
%endif%

	%invoke wm.server.replicator:getSubscriptions%

        <TR>
            <TD colspan=2>
                <UL>
                    %invoke wm.server.query:isRemoteInvokeLicensed%
	            %ifvar isLicensed equals('true')%
	               <LI><A HREF="settings-remote.dsp">Remote Server Settings</A></LI>
	            %endif%
	            %endinvoke%
                    
                    <LI><A HREF="package-subscribe.dsp">Subscribe to Remote Package</A></LI>
                    <LI><A HREF="package-unsubscribe.dsp">Update and Unsubscribe from Remote Package</A></LI>
                    <LI><A HREF="package-subscribing.dsp?action=updateall">Update All Subscription Details</A>
                    <div class="info">Last updated: %ifvar updateTime%%value updateTime%%else%Unknown%endif%</div></LI>
                </UL>
            </TD>
        </TR>

        <TR>
            <TD><IMG SRC="images/blank.gif" height=10 width=10></TD>

            <TD valign=top>
                <TABLE class="tableView" width=100%>
                  <TR>
                    <TD class="heading" colspan=6>Subscriptions Initiated Locally</TD>
                  </TR>
				 <TR>
					<TD class="subheading" colspan=6>These packages can be retrieved locally or delivered by the publisher.</TD>
				</TR>


				  <TR>
					  <TD class="oddcol">Publisher</TD>
					  <TD class="oddcol" nowrap>Package<BR>(Release Name)<BR></TD>
					  <TD class="oddcol">Version</TD>
					  <TD class="oddcol">Build</TD>
					  <TD class="oddcol">Created on</TD>
					  <TD class="oddcol">Retrieve</TD>
				  </TR>
				  <script>resetRows();</script>




            %ifvar publishers%

            %loop publishers%

            <script>
            var publisher_name = "%value name%";
            </script>
                %ifvar subscriptions%
                %loop subscriptions%
                    <TR>
                        <script>writeTDrowspan("rowdata-l",2);</script>
                            <script>document.write(publisher_name)</script></TD>


                        <script>writeTDrowspan("rowdata-l",2);</script>
                            %value source_pkg_name%<BR><img src="images/blank.gif" height=3 width=3><BR><span style="font-weight: normal;">%ifvar name%(%value name%)%else%(No Releases)%endif%</span></TD>
                        <script>writeTD("rowdata");</script>
                            %ifvar version%%value version%%else%-%endif%</TD>
                        <script>writeTD("rowdata");</script>
                            %ifvar build%%value build%%else%-%endif%</TD>
                        <script>writeTD("rowdata");</script>
                            %ifvar time%%value time%%else%-%endif%</TD>
                        <script>writeTDrowspan("rowdata",2);</script>
							%ifvar norelease%
							-
							%else%
                            <a href="package-subscribing.dsp?action=svcPull&package=%value name%&alias=%value -urlencode ../name%">Via Service Invocation</A><BR><img src="images/blank.gif" height=5 width=5><BR>
                            <a href="package-pull-ftp.dsp?package=%value name%&alias=%value -urlencode ../name%">Via FTP Download</A>
                        	%endif%
                        </TD>
                    </TR>
                    <TR>
                        <script>writeTDspan("rowdata-l",3);</script><span style="font-weight: normal;">
                            %ifvar description equals('')%
                              -
                            %else%
                              %ifvar description%%value description%%else%-%endif%
                            %endif%
                        </span></TD>
                    </TR>
                    <script>swapRows();</script>
                %endloop%
                %else%
					<TR>
						<script>writeTDrowspan("rowdata-l",2);</script>
							<script>document.write(publisher_name)</script></TD>


						<script>writeTDrowspan("rowdata-l",2);</script>
							No Releases</TD>
						<script>writeTD("rowdata");</script>
							-</TD>
						<script>writeTD("rowdata");</script>
							-</TD>
						<script>writeTD("rowdata");</script>
							-</TD>
						<script>writeTDrowspan("rowdata",2);</script>
							-
						</TD>
					</TR>
					<TR>
						<script>writeTDspan("rowdata-l",3);</script>
							  <span style="font-weight: normal;">-</span>
						</TD>
					</TR>
					<script>swapRows();</script>

                %endif%

                %endloop%
                %else%
                <TR>
					<td class="evenrowdata-l" colspan="6">
					No locally initiated subscriptions</td>
				</TR>
                %end if%
			%endinvoke%

                </TABLE>
            </TD>
        </TR>

        <TR>
        <TD><IMG SRC="images/blank.gif" height=10 width=10></TD>
            <TD valign=top>
                <TABLE  class="tableView" width=100%>
                  <TR>
                      <TD class="heading" colspan=2>Subscriptions Initiated by Remote Publisher</TD>
                </TR>

				 <TR>
				 	<TD class="subheading" colspan=2>These packages can only be delivered by the publisher.</TD>
				</TR>

            %invoke wm.server.replicator:remoteSubscribedList%

                    <TR>
						<TD class="oddcol-l">Publisher</TD>
                        <TD class="oddcol-l">Package Name</TD>
                    </TR>
                    <script>resetRows();</script>


			%ifvar subscribed%
            %loop subscribed%

                %ifvar packageList%
                %loop packageList%
                    <TR>
						<script>writeTD("rowdata-l");</script>
						%value publisher%</td>
                        <script>writeTD("rowdata-l");</script>
                            %value%</TD>


                    </TR>
                    <script>swapRows();</script>
                %endloop%
                %else%
				<TR>
					<script>writeTD("rowdata-l");</script>
					%value publisher%</td>
					<script>writeTD("rowdata-l");</script><span style="font-weight: normal;">
						No packages</span></TD>
				</TR>
				<script>swapRows();</script>

                %endif%

            %endloop%
            %else%
                    <script>resetRows();</script>
				<TR>
					<td class="evenrowdata-l" colspan="2">
					No remotely published subscriptions</td>
				</TR>
			%end if%
            %endinvoke%
                  </TR>
                </TABLE>
            </TD>
        </TR>
    </TABLE>
    </BODY>
</HTML>
