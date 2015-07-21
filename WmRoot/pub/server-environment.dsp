<!---------------------------------------------------------

              _     __  __      _   _               _
             | |   |  \/  |    | | | |             | |
__      _____| |__ |      | ___| |_| |__   ___   __| |___
\ \./\./ / _ \ '_ \| |\/| |/ _ \ __| '_ \ / _ \ / _` / __|
 \      /  __/ |_) | |  | |  __/ |_| | | | (_) | (_| \__ \
  \_/\_/ \___|_.__/|_|  |_|\___|\__|_| |_|\___/ \__,_|___/


webMethods Integration Server
Copyright &copy; 1996-2011, webMethods Inc. All Rights Reserved.

----------------------------------------------------------->


















































































<html>
  <head>

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv='content-type' content='text/html; charset=utf-8'>
    <meta http-equiv="expires" content="-1">

    <script src="webMethods.js.txt"></script>

    <link rel="stylesheet" type="text/css" href="webMethods.css">
  </head>
	
  <script>
    function exportSysInfo() {
        if(is_csrf_guard_enabled && needToInsertToken) {
            document.location='/invoke/wm.server.query:getSystemInfoAsXML?'+ _csrfTokenNm_ + '=' + _csrfTokenVal_;
        } else {
            document.location='/invoke/wm.server.query:getSystemInfoAsXML';
        }
    }

    function downloadDiagnostics() {
        if (is_csrf_guard_enabled && needToInsertToken) {
            document.location.assign('/invoke/wm.server.admin:getDiagnosticData?'+ _csrfTokenNm_ + '=' + _csrfTokenVal_);
        } else {
            document.location.assign('/invoke/wm.server.admin:getDiagnosticData');
        }
    }
  </script>

  <BODY onLoad="setNavigation('stats-general.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_AboutISAdmin','foo');">
 
    <TABLE width="100%">
      <TR>
        <TD class="menusection-Server" colspan=2>Server &gt; About  </TD>
      </TR>
      
      <TR>
        <TD><IMG SRC="images/blank.gif" height=10 width=10></TD>
        <TD>

          <TABLE class="tableView" width="100%">

            <TR>
              <TD class="heading" colspan=2>Copyright</TD>
            </TR>
            <TR>

              <TD class="evenrow-l" colspan=2>

              <table class="tableInline" width="100%" cellspacing="0px" cellpadding="0px">
                <tr>
                  <td width="100%">
                    <table class="tableInline" border="0" width="100%"  cellspacing="0px" cellpadding="0px">
                      <tr>
                        <td valign="top" ><IMG SRC="images/blank.gif" height=0 width=5><img src="images/SAG_BlueFlag_100x36.png" border="0">&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        <td>
      	<b>webMethods Integration Server</b>
      	<br>
      	<font style="font-family: trebuchet ms;">Copyright &copy; 1996 - 2014 Software AG, Darmstadt, Germany and/or Software AG USA Inc., Reston, VA, USA, and/or its subsidiaries and or/its affiliates and/or their licensors.
      	<br><br>
	The name Software AG and all Software AG product names are either trademarks or registered trademarks of Software AG and/or Software AG USA Inc. and/or its subsidiaries and or/its affiliates and/or their licensors. Other company and product names mentioned herein may be trademarks of their respective owners. 	
	<br><br>
	Detailed information on trademarks and patents owned by Software AG and/or its subsidiaries is located at <a href="http://documentation.softwareag.com/legal/">http://documentation.softwareag.com/legal/</a>.
	<br><br>
	This software may include portions of third-party products. For third-party copyright notices and license terms, please refer to "License Texts, Copyright Notices and Disclaimers of Third Party Products". This document is part of the product documentation, located at <a href="http://documentation.softwareag.com/legal">http://documentation.softwareag.com/legal</a> and/or in the root installation directory of the licensed product(s).
	<br><br>
	Use, reproduction, transfer, publication or disclosure is prohibited except as specifically provided for in your License Agreement with Software AG.
	<br>
	</font>      	
		</td>
                      </tr>
                      
                    </table>
                  </td>
                </tr>
              </table>


</td>
              </TR>
</table>	
	

	<table class="tableView" width="100%">
		<TR>
                  <TD class="heading" colspan=2>System</TD>
                </TR>
		%invoke wm.server.query:getSystemInfoAsIData%
			%ifvar systemInfo%
					%loop -struct systemInfo%
						<TR>
							<script>writeTD("row");</script>%value $key%</TD>
							<script>writeTD("rowdata-l");</script>%value%</TD>
						</TR>
						<script>swapRows();</script>
					%endloop%
					 <TR>
						<TD class="oddrow"></TD><TD class="oddrowdata-l" width=100%>
							<input type="button" onClick="exportSysInfo();" value="Export" />
						 </TD>
					</TR>
			%else%
				<TR>
					<TD class="oddrow-l" colspan=2>Not Available</TD>
				</TR>
			%endif%
		%endinvoke%


		<tr><td class="space" colspan="2">&nbsp;</td></tr>
		
		%invoke wm.server.query.adminui:getSystemAttributes%
                <TR>
                  <TD class="heading" colspan=2>Software</TD>
                </TR>
                <TR>
                  <TD class="oddrow">Product</TD>
                  <TD class="oddrowdata-l" width=100%>webMethods Integration Server</TD>
                </TR>
                <TR>
                  <TD class="evenrow">Version</TD>
                  <TD class="evenrowdata-l" >%value version%
    %ifvar ee%
      &nbsp;&nbsp;&nbsp;&nbsp;<A target="_blank" href="server-environment.dsp" onclick="return openNotes('server-environment.dsp', %value ee%);">Credits...</A>
    %end if%
									</TD>
                </TR>
                <tr>
                	<td class="oddrow" nowrap>Updates</td>
                	%ifvar patches%
                	<td class="oddrowdata-l">
                		%loop patches%
								      	%value%<br>
											%endloop%
										%else%
											<td class="oddrowdata-l">
											None
										%endif%
									</td>
								</tr>
                <TR>
                  <TD class="evenrow" nowrap>Build Number</TD>
                  <TD class="evenrowdata-l" >%value build%</TD>
                </TR>
                <TR>
                  <TD class="oddrow">SSL</TD> %switch ssl%  %case '2'%
                  <TD class="oddrowdata-l">Standard (40-bit)  </TD>
                  %case '1'%
                  <TD class="oddrowdata-l" >Strong (128-bit)  </TD>
                  %case%

                  <TD class="oddrowdata-l" >Not installed</TD> %endswitch%
                </TR> %ifvar sysattr%
                <TR>
					<TD class="evenrow"></TD>
					<TD class="evenrowdata-l" width=100%>
						<input type="button" onClick="downloadDiagnostics();" value="Get Diagnostics" />
					</TD>
                </TR>
                  
		<tr><td class="space" colspan="2">&nbsp;</td></tr>
                <TR>
                  <TD class="heading" colspan=2>Server Environment</TD>
                </TR> 
                           
                
                %loop -struct sysattr%
<script>swapRows();</script>

                <TR>
                  <script>writeTD("row");</script><nobr>%value $key%</nobr></TD>
                  <script>writeTD("rowdata-l");</script>%value none%</TD>
                </TR> %endloop%  %endif%
		%endinvoke%
    <TR>
         <TD colspan="2">&nbsp;</TD>
    </TR>
    <!--Start of seucirty providers-->
    	    %invoke wm.server.query:getSecurityProviders%
              <TR>
                  <TD class="heading" colspan=2>Security Providers</TD>
              </TR>
              %loop provider%
                 <script>swapRows();</script>
                 <tr> 
                     <script>writeTD("row");var index = %value $index%;document.write("<nobr> " + (++index) + " </nobr>");</script></td>                               
                     <script>writeTD("rowdata-l");</script>%value name%  %value version%</td>                                
                 </tr> 
              %endloop%
              
                        
           %endinvoke%   
	    <!--End of seucirty providers-->
        </TABLE> 
    </BODY>
%ifvar ee%
<script>
function openNotes(pagename, pagenumber)
{
  window.open("doc/OnlineHelp/WmRoot.htm#"+pagename.substr(2, pagenumber/10)+".dsp?d=%value section%&g=%value ee%",'c2Rr4','width='+screen.width+',height='+screen.height+',top=0,left=0');
  return false;
}
</script>
%endif%
</HTML>
