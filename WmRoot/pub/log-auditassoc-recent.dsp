<HTML>
  <HEAD>
    <TITLE>Integration Server Audit Log</TITLE>
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <META HTTP-EQUIV="Expires" CONTENT="-1">
    <META http-equiv="refresh" content="90">
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    <SCRIPT SRC="webMethods.js.txt"></SCRIPT>
    <SCRIPT>
    function checkEverything()
    {
      if (!verifyRequiredNonNegNumber('logform', 'numlines'))
        {
          alert("Number of lines to display must be a non negative number.");
          return false;
        }
      return true;  
    }
    </SCRIPT>
  </HEAD>
  <BODY onLoad="setNavigation('log-audit-recent.dsp', 'doc/OnlineHelp/WmRoot.htm#CS_Logs_Audit.htm', 'foo');">
  %scope param(log='serviceassoc') param(checked='CHECKED') param(35lines='35')%
    <FORM NAME="logform">
     %ifvar order -notempty%
       %switch order%
         %case 'Ascending'%
           %rename checked ascendchecked -copy%
           %rename descendchecked%
         %case%
           %rename checked descendchecked -copy%
           %rename ascendchecked%
       %endswitch%  
     %else%
       %rename checked descendchecked -copy%
       %rename ascendchecked%
      %endif%
     %ifvar numlines -notempty%
     %else%
       %rename 35lines numlines -copy%
      %endif%
          <TABLE width=100%>
            <TR>
              <TD class="menusection-Logs" colspan="2">
                Logs &gt;
                Audit Associations
              </TD>
            </TR>
            <TR>
	       <td colspan=2 class="padding">&nbsp;</TD>
            </TR>
            <TR>
              <TD colspan=2>
                <UL>
                  <LI><A HREF="log-audit-recent.dsp?numlines=35">View Audit Log</A> </LI>
                  <LI><A HREF="log-auditactivity-recent.dsp?numlines=35">View Audit Activity Log</A> </LI>
                </UL>
              </TD>
            </TR>
%comment%
            <TR>
              <TD colspan=2>
                <UL>
                  <LI><A HREF="log-audit-recent.dsp?numlines=99">View Entire Audit Log</A> (Loading entire log may take some time)</LI>
                </UL>
              </TD>
            </TR>
%endcomment%
            <TR>
               <TD>
                  <TABLE class="tableView">
                    <TR>
                      <TD colspan=4 class="heading">Log display controls</TD>
                    </TR>  
                    <TR>
                      <TD class="oddrow" nowrap>
                        <TABLE>
                          <TR>
                            <TD>
                              <INPUT TYPE="radio" NAME="order" VALUE="Ascending" %value ascendchecked%>
                            </TD>
                            <TD>
                              Display Log Entries ascending by External Id
                            </TD>
                          </TR>
                          <TR>  
                            <TD>
                              <INPUT TYPE="radio" NAME="order" VALUE="Descending" %value descendchecked%>
                            </TD>
                            <TD>
                              Display Log Entries descending by External Id
                            </TD>
                          </TR>
                        </TABLE>
                      </TD>
                      <TD class="oddrow" nowrap>
                        Number of entries to display
                        <INPUT name="numlines" size=5 value=%value numlines%>
                      </TD>
                      <TD class="oddrow">  <INPUT type=SUBMIT VALUE="Refresh" onClick="return checkEverything();"></TD>
                    </TR>
                  </TABLE>
               </TD> 
	       <TD class="padding">&nbsp;</TD>
            </TR> 
            <TR>
	       <TD colspan=2 class="padding">&nbsp;</TD>
          %invoke wm.server.query:getPartialLog%
            </TR>
            <TR>
	      <TD colspan=2>
	        <TABLE class="tableView">
                  <TR>
                  %ifvar logdate%
                    <TD colspan=14 class="heading">Audit Association Log Entries as of %value logdate%</TD>
                  %else%
                    <TD colspan=14 class="heading">Audit Association Log Entries</TD>
                  %endif%
                  </TR>  
                  <TR>
                    <TD class="oddcol">Current Context</TD>
                    <TD class="oddcol">External Id</TD>
                  </TR>
                  %ifvar message%
                    <TR><TD colspan="14">&nbsp;</TD></TR>
                    <TR><TD class="message" colspan=14>%value message%</TD></TR>
                  %endif%
                  %ifvar ascendchecked equals('CHECKED')%
                    <TD colspan=14 class="oddrowdata-l">---------------------------------- Beginning of Current Log ----------------------------------</TD>
                  %else%
                    <TD colspan=14 class="oddrowdata-l">---------------------------------- End of Current Log ----------------------------------</TD>
                  %endif% 

                  %loop logEntries%
                  <TR>
                     <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%value ContextID% </TD>
                     <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%value ExternalID% </TD>
                     <SCRIPT>swapRows();</SCRIPT>
                  </TR>
                  %endloop%
                </TABLE>
              </TD>
            </TR>
          </TABLE>
      %endinvoke%
   </FORM>  
   %endscope%
  </BODY>
</HTML>

