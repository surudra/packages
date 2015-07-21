<HTML>
  <HEAD>
    <META http-equiv="refresh" content="90">
    <meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <META HTTP-EQUIV="Expires" CONTENT="-1">
    <TITLE>Settings Cluster</TITLE>
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    <SCRIPT src="webMethods.js.txt"></SCRIPT>
 </HEAD>
 <BODY onLoad="setNavigation('stats-general.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Server_TotalSessionsScrn');">
         <TABLE width=100%>
            <TR>
               <TD class="menusection-Server" colspan=2>
                Server &gt;
                Statistics &gt;
                Sessions</TD>
            </TR>
             <TR>
              <TD colspan=2>
                <UL>
%ifvar equals('shutdown') returnto%
<LI><A HREF="server-shutdown.dsp">Return to Shut Down and Restart</A></LI>
%else%
                  <LI><A HREF="stats-general.dsp">Return to Server Statistics</A></LI>
%endif%
                </UL>
              </TD>
            </TR>

            <TR>
               <td><img src="images/blank.gif" height="10" width="10" border="0"></td>
               <TD>
                  <TABLE class="tableView" width=100%>
                     %ifvar action equals('kill')%  %invoke wm.server.admin:killSession%
                        %ifvar message%
							<script>
								 if(is_csrf_guard_enabled && needToInsertToken) {
									parent.topmenu.location.replace("top.dsp?message=%value -urlencode message%&"+ _csrfTokenNm_ + "=" + _csrfTokenVal_);
								 } else {
									parent.topmenu.location.replace("top.dsp?message=%value -urlencode message%");
								 }
							</script>	 
						%endif%
                     %endinvoke%  %endif%

                     %invoke wm.server.query:getSessionList%
                     <TR>
                        <TD class="heading" colspan=8>Current Sessions</TD>
                     <TR>
                        <TD class="oddcol-l">User</td>
                        <TD class="oddcol">From</td>
                        <TD class="oddcol">Stateful</td>
                        <TD class="oddcol">Requests</td>
                        <TD class="oddcol-r" nowrap>Connect Time</td>
                        <TD class="oddcol-r" nowrap>Last Request</td>
                        <TD class="oddcol-r" nowrap>Session Expires</td>
                        <TD class="oddcol">Kill</td>
                        <script>resetRows();</script>
                     </TR> %loop sessions%
                     <TR>
                        <script>writeTD('rowdata-l');</script>%value user%</TD>
                        <script>writeTD('rowdata');</script>%value name%</TD>
                        <script>writeTD('rowdata');</script>%value stateful%</TD>
                        <script>writeTD('rowdata');</script>%value calls%</TD>
                        <script>writeTD('rowdata-r');</script>%value time% sec</TD>
                        <script>writeTD('rowdata-r');</script>%value last% sec</TD>
                        <!-- <script>writeTD('rowdata-r');</script>%value expires% sec</TD> -->
                        <script>writeTD('rowdata-r');</script><script>expiredOrSeconds(%value expires%)</script></TD>
                        <script>writeTD('rowdata');</script>
						   <A class="imagelink" href="server-cluster.dsp?action=kill&sessionID=%value ssnid -urlencode%"><IMG src="icons/delete.gif" border=0></A></TD>   
						   </TR> <script>swapRows();</script>%endloop%
                  </TABLE> %endinvoke%  </TD>
            </TR>
         </TABLE>
   </BODY>
</HTML>
