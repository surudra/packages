<HTML>
  <HEAD>
 
    <script src="webMethods.js.txt"></script>
    <TITLE>Integration Server Log</TITLE>
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <META HTTP-EQUIV="Expires" CONTENT="-1">
    <script>
		function checkEverything()
		{

		  if (!verifyRequiredNonNegNumber('logform', 'startline'))
			{
			  alert("First line to display must be a non negative number.");
			  return false;
			}
		  if (!verifyRequiredNonNegNumber('logform', 'numlines'))
			{
			  alert("Number of entries to display must be a non negative number.");
			  return false;
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
    

    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
  </HEAD>
  <BODY onLoad="setNavigation('log-server-recent.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Logs_ServerScrn');">
      
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
  %scope param(log='server') param(checked='CHECKED') param(35lines=property) param(zero='0')%
    <FORM NAME="logform">
    %rename ../../order order -copy%
    %rename ../../startline startline -copy%
    
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
       %rename ascendchecked%
       %rename checked descendchecked -copy%
      %endif%
     %ifvar numlines -notempty%
     %else%
       %rename 35lines numlines -copy%
      %endif%
     %ifvar startline -notempty%
     %else%
       %rename zero startline -copy%
      %endif%
      
        <TABLE width=100%>
            <TR>
              <TD class="menusection-Logs" colspan="2">
                Logs &gt;
                Server
              </TD>
            </TR>
            <TR>
	       <td colspan=2 class="padding">&nbsp;</TD>
            </TR>
            <TR>
               <TD>
                  <TABLE class="tableView">
                    <TR>
                      <TD colspan=4 class="heading">Log display controls</TD>
                    </TR>  
                    <TR class="oddrow">
                      <TD class="oddrow" nowrap>
                        <TABLE>
                          <TR>
                            <TD>
                              <INPUT TYPE="radio" NAME="order" VALUE="Ascending" %value ascendchecked%>
                            </TD>
                            <TD>
                              Ascending sequence
                            </TD>
                          </TR>
                          <TR>  
                            <TD>
                              <INPUT TYPE="radio" NAME="order" VALUE="Descending" %value descendchecked%>
                            </TD>
                            <TD>
                              Descending sequence
                            </TD>
                          </TR>
                        </TABLE>
                      </TD>
                      <TD nowrap align="left">
                              First line to display
                              <INPUT name="startline" size="5" value="%value startline%">
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                          Number of entries to display

			    <INPUT name="numlines" id="numlines" size="5" value="%value property%">
				<input name="oldNumlines" id="oldNumLines" type="hidden" value="%value property%"/>
			
			  </TD>
			     <TD class="oddrow">  <INPUT type="submit" VALUE="Refresh" onClick="return checkEverything();"></TD>
			     </TR>
			
			
			</TABLE>
               </TD> 
	       <TD class="padding">&nbsp;</TD>
            </TR> 
            <TR>
	       <TD colspan=2 class="padding">&nbsp;</TD>
            </TR>
            <TR>
	      <TD colspan=2>
	        <TABLE class="tableView">
	        %rename property numlines -copy% 
		%rename ../../qfromdate qfromdate -copy%
	          %rename ../../qtodate qtodate -copy%
                  %invoke wm.server.query:getPartialLog%
                  <TR>
                    <TD colspan=2 class="heading">Server Log Entries as of %value logdate%</TD>
                  </TR>  
                  %ifvar message%
                    <TR><TD colspan="2">&nbsp;</TD></TR>
                    <TR><TD class="message" colspan=14>%value message%</TD></TR>
                  %endif%
                  %loop logEntries%
                  <TR>
                     <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%value logEntries encode(xml)%</TD>
                     <SCRIPT>swapRows();</SCRIPT>
                  </TR>
                  %endloop%
                </TABLE>
              </TD>
            </TR>
          </TABLE>
      %endinvoke%
      %endinvoke%
   </FORM>  
   %endscope%
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

