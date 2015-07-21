<HTML>
  <HEAD>
  <meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <META HTTP-EQUIV="Expires" CONTENT="-1">
  <TITLE>Integration Server -- Subscriber Packages</TITLE>
  <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
  <SCRIPT SRC="webMethods.js.txt"></SCRIPT>
  <SCRIPT LANGUAGE="JavaScript">

    function onAdd()
    {
    var package = document.subadd.package.value;
    var pullemail = document.subadd.pullemail.value;
    var password = document.subadd.reppass.value;

    if ( package == null || package == "" ) {
      alert("Package is required.");
      return false;
    } else if ( password == null || password == "" ) {
      alert("Password is required.");
      return false;
    }
    else if( document.subadd.autopull[0].checked== true && ( pullemail == null || pullemail == "") ) {
      alert("Automatic Pull Email is required when you selected Automatic Pull option.");
      return false;
    } else {
      return true;
    }

    }
  </SCRIPT>
  </HEAD>
  <BODY onLoad="setNavigation('package-subscribing.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Packages_SubRemotePkgScrn');">
    <TABLE width="100%">
      <TR>
	<TD class="menusection-Packages" colspan=2>
	  Packages &gt;
	  Subscribing &gt;
	  Subscribe To Remote Package
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
	    <FORM NAME="subadd" ACTION="package-subscribing.dsp" METHOD="POST">
		<TR>
		<INPUT TYPE="hidden" NAME="action" VALUE="add"></input>
		<INPUT TYPE="hidden" NAME="refresh" VALUE="true"></input>
		  <TD class="heading" colspan=2>Remote Package</TD>
		</TR>
		<tr>
		  <TD class="oddrow-l">Package</TD>
		  <TD class="oddrow-l"><INPUT NAME="package" ></INPUT></td>
		</tr>
		<tr><TD class="evenrow-l"><A HREF="settings-remote.dsp">Publisher Alias</A></TD>
		  <TD class="evenrow-l">
		    <SELECT NAME="alias">
		      %invoke wm.server.remote:serverList%
		      %loop -struct servers%
		      %scope #$key%
		      <OPTION value="%value alias%">%value alias%</OPTION>
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
		      <option value='%value key%'>%value protocol%@%value port%</option>
		      %case 'http'%
		      <option value='%value key%'>%value protocol%@%value port%</option>
		      %case 'HTTPS'%
		      <option value='%value key%'>%value protocol%@%value port%</option>
		      %case 'https'%
		      <option value='%value key%'>%value protocol%@%value port%</option>
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
		      <OPTION value="%value name%">%value name%</OPTION>
		      %endloop%

		      %endinvoke%
		    </SELECT>
		  </td>
		</tr>
		<tr><TD class="evenrow-l">Local Password</TD>
		  <TD class="evenrow-l">
		    <INPUT NAME="reppass" TYPE="password" autocomplete="off"></INPUT>
		  </td>
		</tr>
		<tr><TD class="oddrow-l">Notification Email</TD>
		  <TD class="oddrow-l">
		    <INPUT NAME="email"></INPUT>
		  </td>
		</tr>

		<tr><TD class="evenrow-l">Automatic Pull</TD>
		  <TD class="evenrow-l">
		    <input type="radio" NAME="autopull" value="yes">Yes</input>
		    <input type="radio" NAME="autopull" value="no" checked>No</input>
		  </td>
		</tr>
		<tr><TD class="oddrow-l">Automatic Pull Email</TD>
		  <TD class="oddrow-l">
		    <INPUT NAME="pullemail"></INPUT>
		  </td>
		</tr>
		<tr>
		  <TD class="action" colspan=2>
		    <INPUT TYPE="submit" VALUE="Start Subscription" onclick="return onAdd(); return false;"></INPUT>
		  </td>
		</tr>
	    </FORM>
	  </table>
	</TD>
      </TR>
    </TABLE>
  </BODY>
</HTML>
