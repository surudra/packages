<HTML>
   <HEAD>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">


      <TITLE>Integration Server Threads
      </TITLE>
      <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
      <SCRIPT src="webMethods.js.txt"></SCRIPT>
   </HEAD>
   <BODY onLoad="setNavigation('stats-general.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Server_ThreadDumpScrn');">
      <DIV class="position">
      	 %invoke wm.server.query:getThreadDump%
         <TABLE width="100%">
            <TR>
               <TD class="menusection-Server" colspan=5>Server &gt; Statistics &gt; System Threads &gt; Thread Dump</TD>
            </TR>
            <TR>
              <TD>
                <UL>
                     %ifvar threadkillsupported equals('true')%
	                     <LI><A HREF="server-threads-new.dsp">Return to System Threads</A></LI>
                     %else%
	                     <LI><A HREF="server-threads.dsp">Return to System Threads</A></LI>
                     %endif%                
                </UL>
              </TD>
            </TR>
         <TABLE class="tableForm" width="100%">
         
          <TR>
            <TD class="heading">Server Thread Dump</TD>
          </TR>

          <TR>
            <TD class="oddcol-l">
              <TABLE width="100%">
                <TR>
                  <TD><PRE class="fixedwidth">%value threadDump%

</PRE>
                  </TD>
                </TR>
                </TABLE>
                </TR>
              </TABLE>
         </TABLE>
      </DIV>
   </BODY>
</HTML>