<HTML>
  <HEAD>
    <TITLE>Integration Server Error Log</TITLE>
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <META HTTP-EQUIV="Expires" CONTENT="-1">
	<LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    <SCRIPT SRC="webMethods.js.txt"></SCRIPT>
    <script language="JavaScript1.3">
	function checkEverything()
    {
		if (!verifyRequiredNonNegNumber('logform', 'numlines'))
        {
          alert("Number of lines to display must be a non negative number.");
          return false;
        }
		if ( document.logform.qfromdate != null &&
	        document.logform.qtodate != null ) {

			var fromDate = document.logform.qfromdate.value;

			var invalidItems = /\;|\,|\_|\<|\>|\@|\?|\#|\*|\&|\^|\~|\%|\!|\"|\$|\/|[a-zA-Z]/ig;

			if (fromDate.match(invalidItems))
			{
				alert("From Date can only contain valid date values in YYYY-MM-DD HH:MM:SS format.");
				return false;
			}

			var toDate = document.logform.qtodate.value;
			if (toDate.match(invalidItems))
			{
				 alert("To Date can only contain valid date values in YYYY-MM-DD HH:MM:SS format.");
				 return false;
			}
		}
		
			var alertMaxEntries = document.getElementById("alertMaxEntries").value;
			var numEntries = document.getElementById("numlines").value;
			
			if( isEmpty(alertMaxEntries) || isNaN(alertMaxEntries) || parseInt(alertMaxEntries) < 1 || !isInteger(alertMaxEntries))
			{
				return true;
			}
			alertMaxEntries = parseInt(alertMaxEntries);
			numEntries = parseInt(numEntries);
			if(numEntries > alertMaxEntries)
			{
				var choice=confirm("Number of entries to display exceed the value specified for the watt.server.log.alertMaxEntries property.\n\nIncreasing the number of entries displayed can slow system performance.\n\nDo you wish to continue?" );
				if (choice==false)
				{
					document.getElementById("numlines").value = document.getElementById("oldNumLines").value;
					return false;
				}
			}
    }
	
      	   function refreshSearch() {
            document.queryform.action = "svc_queryframe.dsp"
        	   document.queryform.target = "query"
        	   document.queryform.submit();                  // Submit the page
            }

            var today = new Date();
            var thisMonth = today.getMonth();
            var thisYear = today.getFullYear();
            var thisDate = today.getDate();
            var headerExist = false;
            function openCalendar( which )
            {
        	   window.open( "calendar.dsp?month="+thisMonth+"&year="+thisYear+"&date="+thisDate
        		   +"&which="+escape(which), "calendar", "width=600,height=350,resizable=yes" );
            }
            function getTodayDate() {
        	   return thisYear + "-" + thisMonth + "-" + thisDate;
            }

            </script>

             %scope param(property='watt.server.log.refreshInterval')%
             %invoke wm.server.query:getSetting%
                %ifvar property -notempty%
                %ifvar property matches('-*')%
          	%else%
                  <script> window.setInterval("checkEverything()",%value property%*1000);</script>
        	%endif%
              %else%
                  <script> window.setInterval("checkEverything()",90*1000);</script>
              %endif%
              %endinvoke%
      %endscope%

    
    <SCRIPT>
    
    </SCRIPT>
  </HEAD>
  <BODY onLoad="setNavigation('log-error-recent.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Logs_ErrorScrn');">
    %scope param(property='watt.server.log.alertMaxEntries')%
		%invoke wm.server.query:getSetting%   
			<input type="hidden" name="alertMaxEntries" id="alertMaxEntries" value="%value property%">
		%endinvoke%	
	%endscope%
	%ifvar numlines -notempty%
       %scope param(watt.server.log.maxEntries=numlines)%
            	%rename numlines watt.server.log.maxEntries -copy%
            	%invoke wm.server.admin:setSettings%
					%onerror%
					%ifvar errorMessage%
					<TR><TD class="message" colspan=2>%value errorMessage%</TD></TR>
					%endif%
				%endinvoke%
        %endscope%
    %endif%
	%scope param(property='watt.server.log.maxEntries')%
		%invoke wm.server.query:getSetting%
		%scope param(log='error') param(checked='CHECKED') param(35lines=property)%

  <FORM NAME="logform">
  %rename ../../order order -copy%
     %rename ../../expandstack expandstack -copy%
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
     %ifvar expandstack equals('on')%
        %rename checked expandchecked -copy%
     %else%
        %rename expandchecked%
     %endif%
          <TABLE width=100%>
            <TR>
              <TD class="menusection-Logs" colspan="2">
                Logs &gt;
                Error
              </TD>
            </TR>
            <TR>
	       <td colspan=2 class="padding">&nbsp;</TD>
            </TR>
%comment%
            <TR>
              <TD colspan=2>
                <UL>
                  <LI><A HREF="log-error-recent.dsp?numlines=99">View Entire Error Log</A> (Loading entire log may take some time)</LI>
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
                              Display Log Entries oldest to newest starting from the beginning
                            </TD>
                          </TR>
                          <TR>
                            <TD>
                              <INPUT TYPE="radio" NAME="order" VALUE="Descending" %value descendchecked%>
                            </TD>
                            <TD>
                              Display Log Entries newest to oldest starting from the end
                            </TD>
                          </TR>
                        </TABLE>
                      </TD>

                      <TD class="oddrow" nowrap>
                        Number of entries to display
                        <INPUT name="numlines" id="numlines" size="5" value="%value property%">
						<input name="oldNumlines" id="oldNumLines" type="hidden" value="%value property%"/>
                      </TD>



                      <TD class="oddrow">  <INPUT type="Submit" VALUE="Refresh" onClick="return checkEverything();"></TD>
		       </TR>

                    <TR class="oddrow">
		  <TD class="oddrow-l" colspan=1>
			  <TABLE>
			    <TR>
			      <TD><INPUT TYPE="checkbox" NAME="expandstack"  %value expandchecked%></TD>
			      <TD>Expand Stack Trace Data</TD>
			    </TR>
			  </TABLE>
                      </TD>
                     %scope param(property='watt.server.auditStore')%
			%invoke wm.server.auditing:getDestination%
			%ifvar property equals('database')%
		   <TD align="right">
		   <br>

		<a href="javascript:openCalendar('From Creation Date');"> From:</a>
		<input name="qfromdate">

		<br><a href="javascript:openCalendar('To Creation Date');">To:</a>
		<input name="qtodate">

		<br>
		YYYY-MM-DD HH:MM:SS
		   </TD>
		   <TD  nowrap align="right"></TD>
		   </TR>
		    </TABLE>
		    </TD>
		    </TR>

		%endif%
 		%endinvoke%
 		%endscope%
 		</TABLE>
		     </TD>
	       <TD class="padding">&nbsp;</TD>
		  </TR>
		  <TR>
	       <TD colspan=2 class="padding">&nbsp;</TD>
	    </TR>
          %rename property numlines -copy%
	  %rename ../../qfromdate qfromdate -copy%
          %rename ../../qtodate qtodate -copy%

          %invoke wm.server.query:getPartialLog%
            <TR>
	      <TD colspan=2>
	        <TABLE class="tableView">
                  <TR>
                  %ifvar logdate%
                    <TD colspan=8 class="heading">Error Log Entries as of %value logdate%</TD>
                  %else%
                    <TD colspan=8 class="heading">Error Log Entries</TD>
                  %endif%
                  </TR>
                  <TR>
                    <TD nowrap class="oddcol">Time Stamp</TD>
                    <TD nowrap class="oddcol">Service Name</TD>
                    <TD nowrap class="oddcol">Service Stack</TD>
                    <TD nowrap class="oddcol">Error Message</TD>
                    <TD nowrap class="oddcol">Stack Trace</TD>
                    <TD nowrap class="oddcol">Root Context</TD>
                    <TD nowrap class="oddcol">Parent Context</TD>
                    <TD nowrap class="oddcol">Current Context</TD>
                  </TR>
                  %ifvar message%
                    <TR><TD colspan="8">&nbsp;</TD></TR>
                    <TR><TD class="message" colspan=8>%value message%</TD></TR>
                  %endif%
                  %ifvar ascendchecked equals('CHECKED')%
                    <TD colspan=8 class="oddrowdata-l">---------------------------------- Beginning of Current Log ----------------------------------</TD>
                  %else%
                    <TD colspan=8 class="oddrowdata-l">---------------------------------- End of Current Log ----------------------------------</TD>
                  %endif%

                  %loop logEntries%
                  <TR>
                     <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%value AuditTimestamp% </TD>
                     <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%ifvar ServiceName equals(NULL)%%else%%value ServiceName%%endif%</TD>
                     <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                         <TABLE>
                           %loop ServiceStack%
                            <TR><TD nowrap>%value ServiceStack%</TD></TR>
                           %endloop%
                         </TABLE>
					 </TD>
                     <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                         <TABLE>
                           %loop ErrorMessage%
                            <TR><TD nowrap>%value ErrorMessage%</TD></TR>
                           %endloop%
                         </TABLE>
					 </TD>
                     %ifvar ../expandchecked equals('CHECKED')%
                       <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                         <TABLE>
                           %loop ErrStackTrace%
                            <TR><TD nowrap>%value ErrStackTrace%</TD></TR>
                           %endloop%
                         </TABLE>
                     %else%
                       <SCRIPT>writeTDnowrap("row-l");</SCRIPT>Stack trace data ...</TD>
                     %endif%
                     <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%value RootContextID% </TD>
                     <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%value ParentContextID% </TD>
                     <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%value ContextID% </TD>
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
   %endinvoke%
 %endscope%
  </BODY>
</HTML>

<script>
if ( document.logform.qfromdate != null && document.logform.qtodate != null )
{
logform.qfromdate.value="%value qfromdate%";
logform.qtodate.value="%value qtodate%";
}
</script>