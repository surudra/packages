<HTML>
  <HEAD>
  <meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <META HTTP-EQUIV="Expires" CONTENT="-1">
  <TITLE>Integration Server -- Subscriber Packages</TITLE>
  <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
  <SCRIPT SRC="webMethods.js.txt"></SCRIPT>

  <SCRIPT LANGUAGE="JavaScript">

    function onSave()
    {
    var package = document.subedit.package.value;
    var pullemail = document.subedit.pullemail.value;
    var password = document.subedit.reppass.value;

    if ( package == null || package == "" ) {
      alert("Package is required.");
      return false;
    } else if ( password == null || password == "" ) {
      alert("Password is required.");
      return false;
    }
    else if( document.subedit.autopull[0].checked== true && ( pullemail == null || pullemail == "") ) {
      alert("Automatic Pull Email is required when you selected Automatic Pull option.");
      return false;
    } else {
      return true;
    }

    }
  </SCRIPT>

  </HEAD>
  <BODY onLoad="setNavigation('package-subscribing.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Packages_EditSubscriptionScrn');">

 %invoke wm.server.replicator:getSubscriptionValues%

   <TABLE width="100%">
      <TR>
	<TD class="menusection-Packages" colspan=2>
	  Packages &gt;
	  Subscribing &gt;
	  Edit Subscription
	</TD>
      </TR>
      <TR>
	<TD colspan="2">
	  <UL>
	    <LI>
	      <a href="package-subscribing.dsp">Return to Subscribing</a>
	    </LI>
	  </UL>
	</TD>
      </TR>
      <TR>
	<TD><IMG SRC="images/blank.gif" height=10 width=10></TD>
	<TD>
	  <TABLE class="tableForm">
	    <FORM NAME="subedit" ACTION="package-subscribing.dsp" METHOD="POST">
		<TR>
		<INPUT TYPE="hidden" NAME="action" VALUE="edit"></input>
		<INPUT TYPE="hidden" NAME="refresh" VALUE="true"></input>
        <INPUT TYPE="hidden" NAME="oldname", VALUE="%value pkgname%">
        <INPUT TYPE="hidden" NAME="oldhostport", VALUE="%value hostport%">
		<TR>
		  <TD class="heading" colspan=2>Remote Package</TD>
		</TR>

		<TR>
		  <TD class="oddrow-l">Package</TD>
		  <TD class="oddrow-l"><INPUT NAME="package" VALUE=%value pkgname%></INPUT></td>
		</TR>
		<tr><TD class="evenrow-l"><A HREF="settings-remote.dsp">Publisher Alias</A></TD>
		  <TD class="evenrow-l">
		    <SELECT NAME="alias">
		      %invoke wm.server.remote:serverList%
		      %loop -struct servers%
		      %scope #$key%
		      <OPTION value="%value alias%" %ifvar alias vequals(/alias)% selected %endif%>%value alias%</OPTION>
		      %endscope%
		      %endloop%
		      %endinvoke%
		    </SELECT>
		  </td>
		</tr>
		<tr><TD class="oddrow-l">Local Port</TD>
		  <TD class="oddrow-l">
		    %invoke wm.server.net.listeners:listListeners%
		    <select name="locallistener">
		      %loop listeners%
		      %ifvar equals('true') enabled%
		      <!--check for valid listeners HTTP or HTTPS -->
		      %switch protocol%
		      %case 'HTTP'%
		      <option value='%value key%' %ifvar port vequals(/localport)% selected %endif%>%value protocol%@%value port% </option>
		      %case 'http'%
		      <option value='%value key%' %ifvar port vequals(/localport)% selected %endif%>%value protocol%@%value port% </option>
		      %case 'HTTPS'%
		      <option value='%value key%' %ifvar port vequals(/localport)% selected %endif%>%value protocol%@%value port% </option>
		      %case 'https'%
		      <option value='%value key%' %ifvar port vequals(/localport)% selected %endif%>%value protocol%@%value port% </option>
		      %endcase%
		      %endif%
		      %endloop%
		    </select>
		    %endinvoke%
		  </td>
		 </tr>
		<tr><TD class="evenrow-l">Local User Name</TD>
		  <TD class="evenrow-l">
		    <SELECT NAME="repuser">
		      %invoke wm.server.access:getAclGroupUsers%
		      %loop repusers%
		      <OPTION value="%value name%" %ifvar name vequals(/localuser)% selected %endif%>%value name%</OPTION>
		      %endloop%

		      %endinvoke%
		    </SELECT>
		  </td>
		</tr>
		<tr><TD class="evenrow-l">Local Password</TD>
		  <TD class="evenrow-l">
		    <INPUT NAME="reppass" TYPE="password" autocomplete="off" VALUE=%value reppass%></INPUT>
		  </td>
		</tr>
		<tr><TD class="oddrow-l">Notification Email</TD>
		  <TD class="oddrow-l">
		    <INPUT NAME="email" VALUE=%value email%></INPUT>
		  </td>
		</tr>
		<tr><TD class="evenrow-l">Automatic Pull</TD>
		  <TD class="evenrow-l">
		    <input type="radio" NAME="autopull" value="yes" %ifvar autopull equals('yes')% checked %endif%>Yes</input>
		    <input type="radio" NAME="autopull" value="no" %ifvar autopull equals('no')% checked %endif%>No</input>
		  </td>
		</tr>
		<tr><TD class="oddrow-l">Automatic Pull Email</TD>
		  <TD class="oddrow-l">
		    <INPUT NAME="pullemail" VALUE=%value pullemail%></INPUT>
		  </td>
		</tr>
		<tr>
		  <TD class="action" colspan=2>
		    <INPUT TYPE="submit" VALUE="Submit Changes" onclick="return onSave(); return false;"></INPUT>
		  </td>
		</tr>

	  </table>
	</TD>
      </TR>
    </TABLE>
%endinvoke%
  </BODY>
</HTML>
