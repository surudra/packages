<HTML>
<HEAD>
	<META http-equiv="Pragma" content="no-cache">
	<META http-equiv='Content-Type' content='text/html; charset=UTF-8'>
	<META HTTP-EQUIV="Expires" CONTENT="-1">

	<TITLE>Integration Server Settings</TITLE>
	<LINK REL="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css">
	<LINK REL="stylesheet" TYPE="text/css" HREF="metadata.css">
	<SCRIPT SRC="/WmRoot/webMethods.js.txt"></SCRIPT>
	<SCRIPT SRC="jquery-1.11.1.min.js"></SCRIPT>
	<SCRIPT SRC="metadata.js"></SCRIPT>
<SCRIPT>
function submitForm(){
  if (!verifyRequiredField("applicationForm", "username")) {
     alert("User Name is required.");
     return false;
     }
  if (!(verifyRequiredField("applicationForm", "iliveURL")) {
     alert("webMethods Cloud URL is required.");
     return false;
     }

  return true;
}
</SCRIPT>
</HEAD>


<BODY onLoad="setNavigation('integration-live-tenant-account.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_webMethodsCloud_SettingsScrn');">

<FORM id ="applicationForm" NAME="applicationForm" action="integration-live-tenant-account.dsp" method="POST">

  <TABLE WIDTH="100%">

            <TR>
                <TD class="menusection-Settings" colspan="3">
                   webMethods Cloud &gt; Settings

                </TD>
            </TR>
     %ifvar operation -notempty%
		%invoke wm.client.integrationlive.account:updateAccountInfo%
			%ifvar message%
				<tr><td colspan="2">&nbsp;</td></tr>
				<tr><td class="message" colspan="2">%value message%</td></tr>
			%endif%
			%onerror%
				<tr><td colspan="2">&nbsp;</td></tr>
				<tr><td class="message" colspan=2>%value errorMessage%</td></tr>
			%endinvoke%
 	%endif%

            <TR>
           	 <TD width="2%">
			  &nbsp;
			 </TD>
            <TD width="70%">

            	<TABLE WIDTH="100%">
            		<TR>
            			<TD class="heading" colspan="2">Settings</TD>
            		</TR>
            		%invoke wm.client.integrationlive.account:getAccountInfo%
            		<TR>
            			<TD class="evenrow" nowrap>User Name</TD>
            			<TD class="evenrow-l">
            			 		<INPUT NAME="username" TYPE="TEXT" VALUE="%value username%" SIZE="50" >
            			 </TD>
            		</TR>
            		<TR>
            			<TD class="evenrow" nowrap>Password</TD>
            			<TD class="evenrow-l">
            			 		<INPUT NAME="password" TYPE="PASSWORD" VALUE="%value password%" SIZE="50" >
            			 </TD>
            		</TR>
            		<TR>
            			<TD class="oddrow" nowrap>webMethods Cloud URL</TD>
            			<TD class="oddrow-l">
            			 		<INPUT NAME="iliveURL" TYPE="TEXT" VALUE="%value iliveURL%" SIZE="50" >
            			 </TD>
            		</TR>
            		%endinvoke%
            	</TABLE>

            </TD>
             <TD width="28%">
			  &nbsp;
			</TD>
			</FORM>
            </TR>
            <TR>
            	<input type="hidden" name="operation" value="save"/>
             	<TD width="2%">
            	&nbsp;
            	</TD>
				<TD  class="action" >
					<input type="submit" name="submit" value="Update Settings" onclick="return submitForm()"/>
				</TD>
				 <TD width="28%">
			  	&nbsp;
				</TD>
			</TR>
    </TABLE>



</BODY>

</HTML>