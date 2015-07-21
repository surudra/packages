<HTML>
  <HEAD>
    <TITLE>Integration Server Audit Log</TITLE>
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <META HTTP-EQUIV="Expires" CONTENT="-1">
	<SCRIPT src="webMethods.js"></SCRIPT>       
    <script language="JavaScript1.3">
        var today = new Date();
        var thisMonth = today.getMonth(); 
        var thisYear = today.getFullYear();
        var thisDate = today.getDate();
        var headerExist = false;
        function openCalendar( which ) 
        {
		  if(is_csrf_guard_enabled && needToInsertToken) {
	      	   window.open( "calendar.dsp?month="+thisMonth+"&year="+thisYear+"&date="+thisDate
	    		   +"&which="+escape(which)+"&"+ _csrfTokenNm_ + "=" + _csrfTokenVal_, "calendar", "width=600,height=350,resizable=yes" );
 		   } else {
	    	   window.open( "calendar.dsp?month="+thisMonth+"&year="+thisYear+"&date="+thisDate
	    		   +"&which="+escape(which), "calendar", "width=600,height=350,resizable=yes" );
		   }          
        }
        function getTodayDate() {
    	   return thisYear + "-" + thisMonth + "-" + thisDate;
        }
        
        </script>
         
         
         
            
                          <script> window.setInterval("checkEverything()",90*1000);</script>

    	             
          	
            
    
    
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    <SCRIPT charset="utf-8" src="webMethods.js.txt"></SCRIPT>
    <SCRIPT>
    function checkEverything()
    {
		if (!verifyRequiredNonNegNumber('logform', 'numEntries'))
        {
            alert("Number of entries to display must be a non negative number.");
            return false;
        }
	    if ( document.logform.date != null) 
		{
			var fromDate = document.logform.date.value; 
	        var invalidItems = /\;|\,|\_|\<|\>|\@|\?|\#|\*|\&|\^|\~|\%|\!|\"|\$|\/|[a-zA-Z]/ig;
		  	if (fromDate.match(invalidItems))
       		{
				alert("Date can only contain valid date values in YYYY-MM-DD HH:MM:SS format.");
				return false;
			}
		}
		document.logform.submit(); 
    }
    </SCRIPT>
  </HEAD>
  
  <BODY>
    
  
    
  
     
    <FORM NAME="logform">
   
     
     	       
       
                  
            
          <TABLE width=100%>
            <TR>

              <TD class="menusection-Logs" colspan="2">
                Logs &gt;
                Audit
              </TD>
            </TR>
            <TR>
	       <td colspan=2 class="padding">&nbsp;</TD>
            </TR>
%invoke wm.deployer.gui.UIAuditLog:getAuditLogEntries%

	
			<TR>

               <TD>
                  <TABLE class="tableView">
                    <TR>
                      <TD colspan=4 class="heading">Log display controls</TD>
                    </TR>  
                    <TR>
                      <TD class="oddrow" nowrap align="left">
                        <TABLE align="left">
						%ifvar reverseOrder equals('false')%
                          <TR>
                            <TD align="left">
                              <INPUT TYPE="radio" NAME="reverseOrder" VALUE="false" CHECKED>
                              Display Log Entries oldest to newest starting from the beginning
                            </TD>
                          </TR>
                          <TR>  
                            <TD align="left">
                              <INPUT TYPE="radio" NAME="reverseOrder" VALUE="true">
                              Display Log Entries newest to oldest starting from the end
                            </TD>
                          </TR>
						  %else%
						  <TR>
                            <TD align="left">
                              <INPUT TYPE="radio" NAME="reverseOrder" VALUE="false" >
                              Display Log Entries oldest to newest starting from the beginning
                            </TD>
                          </TR>
                          <TR>  
                            <TD align="left">
                              <INPUT TYPE="radio" NAME="reverseOrder" VALUE="true" CHECKED>
                              Display Log Entries newest to oldest starting from the end
                            </TD>
                          </TR>
						  %endif%
                        </TABLE>
                      </TD>
                      <TD class="oddrow" nowrap align="left">
                        Number of entries to display
						%ifvar -notempty numEntries%
							<INPUT name="numEntries" size=5 value="%value numEntries%">
						%else%
	                        <INPUT name="numEntries" size=5 value="35">
						%endif%
                      </TD>
                      <TD class="oddrow" align="left">  <INPUT type=SUBMIT VALUE="Refresh" onClick="return checkEverything();"></TD>
                    </TR>
                    
			  

			

			  <TR class="oddrow">                   
			  <TD  align="left" nowrap>
			  <br>
				&nbsp;&nbsp;&nbsp;&nbsp;Display Log Entries for the <a href="javascript:openCalendar('Date');"> Date</a>&nbsp;
				%ifvar -notempty date%
				<input name="date" value="%value date%">
				%else%
				<input name="date" value="">
				%endif%
			&nbsp;YYYY-MM-DD HH:MM:SS
			<br>&nbsp;&nbsp;
			  </TD>

			   <TD  nowrap align="right"></TD>
			   <TD  nowrap align="right"></TD>

			   </TR>
			    </TABLE>

			    </TD>
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
			
                  <TR>
                  
                    <TD colspan=14 class="heading">Audit Log Entries for %value logDate%</TD>
                    
                  </TR> 
                  <TR>
                    <TD nowrap class="oddcol">Time Stamp</TD>
                    <TD nowrap class="oddcol">Request Type</TD>
                    <TD nowrap class="oddcol">Message</TD>
					<TD nowrap class="oddcol">Status</TD>
                    <TD nowrap class="oddcol">User Id</TD>
					<TD nowrap class="oddcol" colspan="3">Server</TD>
					<TD nowrap class="oddcol">Thread ID</TD>
                  </TR>
				   <TR>
					<TD nowrap class="oddcol" colspan="5"></TD>
                    <TD nowrap class="oddcol">Type</TD>
                    <TD nowrap class="oddcol">Alias</TD>
                    <TD nowrap class="oddcol">Host IP:Port</TD>
					<TD nowrap class="oddcol" colspan="1"></TD>
				  </TR>
    			  
				   %ifvar message%
						<TR> <TD colspan=10>&nbsp;</TD></TR>
						<TR> <TD class="error" colspan=10>%value -htmlcode message%</TD></TR>
	     		   %endif%
			
				  <TD colspan=10 class="oddrowdata-l"></TD>
				  %loop logEntries%
				  <TR>
                     <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%value timestamp%</TD>
					 <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%value requestType%</TD>
                     <SCRIPT>writeTD("row-l");</SCRIPT>%value -htmlcode message%</TD>
                     <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%value status%</TD>
					 <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%value userId%</TD>
					 <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%value serverType%</TD>
                     <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%value serverAlias%</TD>
                     <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%value serverIPPort%</TD>
                     <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%value threadId%</TD>
                     <SCRIPT>swapRows();</SCRIPT>
                  </TR>
				  %endloop%
				 
                                  </TABLE>
				
              </TD>

            </TR>
			 
			 %endinvoke%        
          </TABLE>
         </FORM>  
    
     </BODY>
</HTML>

