
<HTML>
   <HEAD>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">
      <TITLE>Server &gt; Statistics
      </TITLE>
      <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
  <SCRIPT SRC="webMethods.js.txt"></SCRIPT>
  </HEAD>

   <BODY onLoad="setNavigation('stats-general.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Server_SrvrStatsScrn');">

      <TABLE width=100% cellpadding="0" cellspacing="0">
         <TR>
            <TD class="menusection-Server" colspan="3">Server &gt; Statistics</TD>
         </TR>

	  %invoke wm.server.query:getReadOnlyConfigFiles%
	  %ifvar noOfFiles equals('0')%
		%else%
      <tr><td colspan="3">&nbsp;</td></tr>
			<TR>
	  			<TD class="message" colspan="3">
				The following configuration files are read-only. You may not be able to save configuration changes	until you make them 'writable'
				%loop  configFiles%
				<br>%value name % 
				%endloop%
				</TD>
			</TR>
		%endif%
		%endinvoke%

	  %invoke wm.server.query:getClusterError%
	  %ifvar clusterError equals('true')%
      <tr><td colspan="3">&nbsp;</td></tr>
			<TR>
	  			<TD class="message" colspan="3">
				Unable to create or join the cluster.  Clustering has been disabled.  Check the clustering configuration.
				</TD>
			</TR>
		%endif%
		%endinvoke%

	  %invoke wm.server.query:getStats%
	  %invoke wm.server.query:getThreadList%
         <TR>
            <TD width="10">
               <IMG border="0" src="images/blank.gif" width="10" height="10">
            </TD>
            <TD width="10">
               <IMG border="0" src="images/blank.gif" width="10" height="10">
            </TD>
            <TD width="10">
               <IMG border="0" src="images/blank.gif" width="10" height="10">
            </TD>
         </TR>
         <TR>
            <TD valign="top">
               <TABLE class="tableView" width="100%">
                  <TR>
                     <TD width="100%" colspan="4" class="heading">Usage</TD>

                  </TR>
                  <TR>
                     <TD nowrap class="oddrow">&nbsp;</TD>
                     <TD nowrap class="oddcol">Current</TD>
                     <TD nowrap class="oddcol">Peak</TD>
                     <TD nowrap class="oddcol">Limit</TD>
                  </TR>
                  <TR>
                     <TD nowrap class="evenrow">Total Sessions</TD>
                     <TD nowrap class="evenrowdata"><A HREF="server-cluster.dsp">%value conn%</A></TD>
                     <TD nowrap class="evenrowdata">%value connMax%</TD>
                     <TD nowrap class="evenrowdata">-</TD>
                  </TR>
                  <TR>
                     <TD nowrap class="oddrow">Licensed Sessions</TD>
                     <TD nowrap class="oddrowdata">%value ssnUsed%</TD>
                     <TD nowrap class="oddrowdata">%value ssnPeak%</TD>
                     <TD nowrap class="oddrowdata">%value ssnMax%</TD>
                  </TR>
                  <TR>
                     <TD nowrap class="evenrow">Stateful Sessions</TD>
                     <TD nowrap class="evenrowdata">%value connStatefulSessionsCurrent%</TD>
                     <TD nowrap class="evenrowdata">%value connStatefulSessionsPeak%</TD>
                     <TD nowrap class="evenrowdata">%value connStatefulSessionsLimit%</TD>
                  </TR>
                  <TR>
                     <TD nowrap class="oddrow">Service Instances</TD>
                     <TD nowrap class="oddrowdata">%value svrT%</TD>
                     <TD nowrap class="oddrowdata">%value svrTMax%</TD>
                     <TD nowrap class="oddrowdata">-</TD>
                  </TR>
                  
                  <TR>
                     <TD nowrap class="evenrow">Service Threads</TD>
                     <TD nowrap class="evenrowdata">%value srvThreadCount%</TD>
                     <TD nowrap class="evenrowdata">%value srvThreadCountPeak%</TD>
                     <TD nowrap class="evenrowdata">-</TD>
                  </TR>
                  
                  <TR>
                     <TD nowrap class="oddrow">System Threads</TD>
                     
                     %ifvar threadkillsupported equals('true')%
	                     <TD nowrap class="oddrowdata"><A HREF="server-threads-new.dsp">%value sysT%</A></TD>
                     %else%
	                     <TD nowrap class="oddrowdata"><A HREF="server-threads.dsp">%value sysT%</A></TD>
                     %endif%

                     <TD nowrap class="oddrowdata">%value sysTMax%</TD>
                     <TD nowrap class="oddrowdata">-</TD>
                  </TR>
                  <TR>
                     <TD nowrap class="evenrow">Uptime</TD>
                     <TD nowrap class="evenrowdata" colspan=3>%value uptime%</TD>
                  </TR>
               </TABLE> </TD>
            <TD width="10"><IMG border="0" src="images/blank.gif" width="10" height="10"></TD>
            <TD valign="top">
               <TABLE class="tableView" width="100%">
                  <TR>
                     <TD width="100%" colspan="3" class="heading">Requests
                     </TD>
                  </TR>
                  <TR>
                     <TD nowrap class="oddrow">&nbsp;</TD>
                     <TD nowrap class="oddcol">Current</TD>
                     <TD nowrap class="oddcol">Lifetime</TD>
                  </TR>
                  <TR>
                     <TD nowrap class="evenrow">Completed Req's</TD>
                     <TD nowrap class="evenrowdata">%value reqTotal%</TD>
                     <TD nowrap class="evenrowdata">-</TD>
                  </TR>
                  <TR>
                     <TD nowrap class="oddrow">Average Time</TD>
                     <TD nowrap class="oddrowdata">%value reqAvg% ms</TD>
                     <TD nowrap class="oddrowdata">%value reqTotAvg% ms</TD>

                  </TR>
                  <TR>
                    <TD class="evenrow">Service Errors</TD>
                    <TD class="evenrowdata"><A HREF="log-error-recent.dsp?returnto=stats-general">%value errSvc%</A></TD>
                    <TD class="evenrowdata">-</TD>
                  </TR>
                  <TR>
                     <TD nowrap class="oddrow">&nbsp;</TD>
                     <TD nowrap class="oddcol">Started</TD>
                     <TD nowrap class="oddcol">Ended</TD>
                  </TR>
                  <TR>
                     <TD nowrap class="evenrow">Req's per minute</TD>
                     <TD nowrap class="evenrowdata">%value newReqPM%/min</TD>

                     <TD nowrap class="evenrowdata">%value endReqPM%/min</TD>

                  </TR>
               </TABLE> </TD>
         </TR>
         <TR>
            <TD width="10"><IMG border="0" src="images/blank.gif" width="10" height="10"></TD>
            <TD width="10"><IMG border="0" src="images/blank.gif" width="10" height="10"></TD>
            <TD width="10"><IMG border="0" src="images/blank.gif" width="10" height="10"></TD>
         </TR>
         <TR>
            <TD valign="top" colspan=3>
               <TABLE class="tableForm" width="100%">
                  <TR>
                     <TD class="heading">Memory</TD>
                  </TR>
                  <TR>
                    <TD>


               <TABLE width="100%" cellpadding=0 cellspacing=0 >
                  <TR>
                    <TD>
                      <TABLE width=100% cellpadding=0>

                  <TR>
                     <TD nowrap class="evenrow">Maximum</TD>
                     <TD nowrap class="evenrowdata-r">%value maxMem% KB</TD>

                     <TD nowrap class="evenrowdata-r">&nbsp;</TD>
                     <TD nowrap class="evenrowdata-l" width="100%">&nbsp;
                        </TD>
                  </TR>

                  <TR>
                     <TD nowrap class="oddrow">Committed</TD>
                     <TD nowrap class="oddrowdata-r">%value totalMem% KB</TD>

                     <TD nowrap class="oddrowdata-r">&nbsp;</TD>
                     <TD nowrap class="oddrowdata-l" width="100%">&nbsp;
                        </TD>
                  </TR>


                  <TR>
                     <TD nowrap class="evenrow">Used</TD>
                     <TD nowrap class="evenrowdata-r">%value usedMem% KB</TD>

                     <TD nowrap class="evenrowdata-r">%value usedMemPer%%</TD>

                     <TD nowrap class="evenrowdata-l" width="100%">


                     <table width=%value usedMemPer%%><tr>
<td height="6" bgcolor=#187863><IMG border="0" src="images/pixel.gif" width="1" height="6"></td>
</tr>
</table>
</TD>
                  </TR>
                  <TR>
                     <TD nowrap class="oddrow">Free</TD>
                     <TD nowrap class="oddrowdata-r">%value freeMem% KB</TD>

                     <TD nowrap class="oddrowdata-r">%value freeMemPer%%</TD>
                     <TD nowrap class="oddrowdata-l" width="100%">

                     <table width=%value freeMemPer%% ><tr>

<td bgcolor=#08419C ><IMG border="0" src="images/pixel.gif" height="6" width="1" ></td>
</tr>
</table>

</TD>

                  </TR>


                      </TABLE>
                    </TD>
                  </TR>


                  <TR>
                    <TD colspan=4 width=100% >
                    <table border=0 width=100% cellpadding=0 cellspacing=2><tr><td  class="evenrowdata" >
                       <TABLE cellpadding=2 cellspacing=0 border=0 align=center>
                          <TR>
                            <TD nowrap class="evenrowdata"><img src="images/blank.gif" height=10 width=10></TD>
              <TD nowrap class="evenrowdata" colspan=24>Memory Usage (average per hour)</TD>
                            <TD  style="font-weight: normal;" class="evenrowdata-l">%value memArrayMax% KB</TD>
              </TR>
                          <TR>
                            <TD nowrap class="evenrowdata">&nbsp;</TD>
                                %loop -struct memArray%
                                 <TD nowrap class="memgraph"><IMG border="0" src="images/greenpixel.gif"
                                    width="12"
                                    height="%value percent%"
                                    ALT="%ifvar $key equals('1')%%value $key% hour ago: %value actual% KB (%value percent%%) used
                                         %else%%value $key% hours ago: %value actual% KB (%value percent%%) used
                                         %endif% 
                                         "/>
                                        
                                     </TD>
                                %endloop%
                             <TD nowrap class="evenrowdata-l"><IMG border="0" width="14" height="100" src="images/memory_guage.gif"></TD>
                          </TR>
                          <TR>
                                %loop -struct memArray%
                                  %switch $key%
                                    %case '1'%
                                    %case '2'%
                                      <TD nowrap class="evenrowdata" colspan=2>&nbsp;-1h</TD>
                                    %case '11'%
                                    %case '12'%
                                      <TD nowrap class="evenrowdata" colspan=3>&nbsp;-12h</TD>
                                    %case '13'%
                                    %case '23'%
                                    %case '24'%
                                      <TD nowrap class="evenrowdata" colspan=3>&nbsp;-24h</TD>
                                    %case%
                                      <TD nowrap class="evenrowdata">&nbsp;</TD>
                                  %endswitch%
                                %endloop%
                                <TD nowrap style="font-weight: normal;" class="evenrowdata-l">0 KB</TD>
            </TR>
                       </TABLE>
          </td></tr></table>
                     </TD>
                   </TR>
                  </TABLE>
                 </TD>
               </TR>
             </TABLE>
           </TD>
         </TR>
      </TABLE>
   </BODY>
</HTML>
