<HTML>

<HEAD>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">


 <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
 <SCRIPT SRC="webMethods.js.txt"></SCRIPT>


</HEAD>

<BODY>
<TABLE width="100%">

<TR>
%ifvar edit%
    <td class="title" colspan="9">Edit Remote Server</td>
%else%
    <td class="title" colspan="9">Remote Servers</td>
%endif%
</TR>
%ifvar action%
%switch action%
%case 'add'%
  %invoke wm.server.remote:addServer%
  <TR><td id="message" colspan=9>%value message%</td></TR>
  %endif%
%case 'test'%
  %invoke wm.server.remote:testAlias%
  <TR><td id="message" colspan=9>%value message%</td></TR>
  %endif%
%case 'delete'%
  %invoke wm.server.remote:deleteServer%
  <TR><td id="message" colspan=9>%value message%</td></TR>
  %endif%
%endswitch%
%endif%


<SCRIPT LANGUAGE="JavaScript">

  function confirmDelete (alias) {
    var msg = "OK to delete remote server '"+alias+"' from configuration?";
    if (confirm (msg)) {
        document.deleteform.alias.value = alias;
            document.deleteform.submit();
          return false;
    } else return false;
  }
  function test (alias)
  {
    document.testform.alias.value = alias;
      document.testform.submit();
    return false;
  }


  function edit (alias,host,port,user,pass,ssl,privKeyFile,certFiles,acl,timeout) {
    document.editform.alias.value = alias;
    document.editform.host.value = host;
    document.editform.port.value = port;
    document.editform.user.value = user;
    document.editform.pass.value = pass;
    document.editform.ssl.value = ssl;
    document.editform.privKeyFile.value = privKeyFile;
    document.editform.certFiles.value = certFiles;
    document.editform.acl.value = acl;
    document.editform.timeout.value = timeout;
      document.editform.submit();
    return false;
  }

  function onClickFn() {
	if(is_csrf_guard_enabled && needToInsertToken) {
		document.location="remote-servers.dsp?"+_csrfTokenNm_+"="+_csrfTokenVal_;
	} else {
		document.location="remote-servers.dsp";
	}
  }
</SCRIPT>

%ifvar edit%%else%
%invoke wm.server.remote:serverList%
<TR class="heading">
   <td width="10%">Alias</td>
   <td width="10%">Host</td>
   <td width="7%">Port</td>
   <td width="20%">User</td>
   <td width="5%">SSL</td>
   <td width="15%">Execute ACL</td>
   <td width="5%">Timeout</td>
   <td width="10%">Delete</td>
   <td width="10%">Test</td>
</TR>

<FORM name="deleteform" action="remote-servers.dsp" method="POST">
  <INPUT type="hidden" name="action" value="delete">
  <INPUT type="hidden" name="alias">
</FORM>

<FORM name="testform" action="remote-servers.dsp" method="POST">
  <INPUT type="hidden" name="action" value="test">
  <INPUT type="hidden" name="alias">
</FORM>


<FORM name="editform" action="remote-servers.dsp" method="POST">
  <INPUT type="hidden" name="edit" value="true">
  <INPUT type="hidden" name="alias">
  <INPUT type="hidden" name="host">
  <INPUT type="hidden" name="port">
  <INPUT type="hidden" name="user">
  <INPUT type="hidden" name="pass">
  <INPUT type="hidden" name="ssl">
  <INPUT type="hidden" name="privKeyFile">
  <INPUT type="hidden" name="certFiles">
  <INPUT type="hidden" name="acl">
  <INPUT type="hidden" name="timeout">
</FORM>

%loop -struct servers%
%scope #$key%
<TR>
   <TD class="coltext">&nbsp;<a href="" onclick="return edit('%value alias%','%value host%','%value port%','%value user%','%value -code pass%','%value ssl%','%value -code privKeyFile%','%value -code certFiles%','%value acl%','%value timeout%');">%value alias%</a></TD>
   <TD class="coltext">&nbsp;%value host%</TD>
   <TD class="coltext">&nbsp;%value port%</TD>
   <TD class="coltext">&nbsp;%value user%</TD>
   <TD class="coltext">&nbsp;%value ssl%</TD>
   <TD class="coltext">&nbsp;%value acl%</TD>
   <TD class="coltext">&nbsp;%value timeout%</TD>
   <TD class="coldata">
     %ifvar nodelete%
      &nbsp;
     %else%
  <a href="" onClick="return confirmDelete('%value alias%');">
      <img src="icons/delete.gif" border="no"></a>
     %endif%
   </TD>
   <TD class="coldata">&nbsp;<a href="" onclick="return test('%value alias%');"><IMG src="icons/checkdot.gif" border="no"></a></TD>
</TR>

%endscope%
%endloop%
%endinvoke%
%endif%

</TABLE>

%ifvar edit%

<!-- Edit Remote Server -->
<TABLE WIDTH=100%>
<FORM NAME="editform" ACTION="remote-servers.dsp" METHOD="POST">
<INPUT TYPE="hidden" NAME="action" VALUE="add">
<INPUT TYPE="hidden" NAME="oldAlias" VALUE="%value alias%">
<INPUT TYPE="hidden" NAME="args" VALUE="xxx">
<tr>
  <TD colspan=3 class="action"><INPUT type="button" value="Save Changes" onclick="return confirmEdit();">
  <INPUT type="button" value="Cancel" onclick="onClickFn();"></TD>

</tr>
<SCRIPT LANGUAGE="JavaScript">

  function confirmEdit () {
    if ((document.editform.alias.value == "") ||
        (document.editform.port.value == "") ||
        (document.editform.host.value == "") ||
        (document.editform.user.value == "")) {
      alert ("Specify all arguments for the remote server.");
    } else if (confirm('OK to apply changes to this remote server?')) {
      document.editform.submit();
      return true;
    }
    return false;
  }

</SCRIPT>

<TR>
  <td width=25% class="rowlabel">Alias</td>
  <TD width=50% class="rowdata">&nbsp;<INPUT NAME="alias" VALUE="%value alias%">
  </TD>
</TR>
<TR>
  <td width=25% class="rowlabel">Host Name or IP Address</td>
  <TD width=50% class="rowdata">&nbsp;<INPUT NAME="host" VALUE="%value host%">
  </TD>
</TR>
<TR>
  <td width=25% class="rowlabel">Port Number</td>
  <TD width=50% class="rowdata">&nbsp;<INPUT NAME="port" VALUE="%value port%" SIZE=5 MAXLENGTH=5>
  </TD>
</TR>
<TR>
  <td width=25% class="rowlabel">User Name</td>
  <TD width=50% class="rowdata">&nbsp;<INPUT NAME="user" VALUE="%value user%">
  </TD>
</TR>
<TR>
  <td width=25% class="rowlabel">Password</td>
  <TD width=50% class="rowdata">&nbsp;<INPUT NAME="pass" TYPE="password"  autocomplete="off" VALUE="%value ""%" />
  </TD>
</TR>
<TR>
  <td width=25% class="rowlabel">Access Control</td>
  <TD width=50% class="rowdata">
  %invoke wm.server.access.adminui:aclList%
  <SELECT name="acl">
<!--    <OPTION %ifvar ../acl equals()%selected%endif% value="">&lt;Default ACL&gt;</OPTION> -->
  %loop aclgroups%
    <OPTION %ifvar ../acl vequals(name)%selected%endif% value="%value name%">%value name%</OPTION>
  %endloop%
  </SELECT>
  %endinvoke%
  </TD>
</TR>
<TR>
  <td width=25% class="rowlabel">Idle Timeout (in minutes)<BR>0 = none</td>
  <TD width=50% class="rowdata">&nbsp;<INPUT NAME="timeout" VALUE="%value timeout%" SIZE=5 MAXLENGTH=5>
  </TD>
</TR>
<td class="title" colspan="9">Security Settings used to connect to the Remote Server</td>
<TR>
  <td width=25% class="rowlabel">Use SSL</td>
  <TD width=50% class="rowdata">
	<input type="radio" name="ssl" value="yes" %ifvar ssl equals(yes)%checked%endif% >Yes</input>
	<input type="radio" name="ssl" value="no" %ifvar ssl equals(no)%checked%endif% >No</input>
  </TD>
</TR>
<TR>
  <td width=25% class="rowlabel">Private Key</td>
  <TD width=50% class="rowdata">&nbsp;<INPUT NAME="privKeyFile" VALUE="%value privKeyFile%">
  </TD>
</TR>
<TR>
  <td width=25% class="rowlabel">Certificates</td>
  <TD width=50% class="rowdata">&nbsp;<INPUT NAME="certFiles" VALUE="%value certFiles%">
  </TD>
</TR>

</FORM>
</TABLE>

%else%
<!-- Add Remote Server -->
<TABLE WIDTH=100%>
<FORM NAME="addform" ACTION="remote-servers.dsp" METHOD="POST">
<INPUT TYPE="hidden" NAME="action" VALUE="add">
<INPUT TYPE="hidden" NAME="args" VALUE="xxx">

<SCRIPT LANGUAGE="JavaScript">

  function confirmAdd () {
    if ((document.addform.alias.value == "") ||
        (document.addform.port.value == "") ||
        (document.addform.host.value == "") ||
        (document.addform.user.value == "")) {
      alert ("Specify all arguments for the remote server.");
    } else if (confirm('OK to add remote server to the configuration?')) {
      document.addform.submit();
      return true;
    }
    return false;
  }

</SCRIPT>
<TR><td class="heading" colspan=9>Add Remote Server</td></TR>
<TR>
  <td width=25% class="rowlabel">Alias</td>
  <TD width=50% class="rowdata">&nbsp;<INPUT NAME="alias" VALUE="">
  </TD>
  <TD rowspan=1 class="action"><INPUT type="button" value="Add" onclick="return confirmAdd();"></TD>
</TR>
<TR>
  <td width=25% class="rowlabel">Host Name or IP Address</td>
  <TD width=50% class="rowdata">&nbsp;<INPUT NAME="host" VALUE="">
  </TD>
</TR>
<TR>
  <td width=25% class="rowlabel">Port Number</td>
  <TD width=50% class="rowdata">&nbsp;<INPUT NAME="port" VALUE="" SIZE=5 MAXLENGTH=5>
  </TD>
</TR>
<TR>
  <td width=25% class="rowlabel">User Name</td>
  <TD width=50% class="rowdata">&nbsp;<INPUT NAME="user" VALUE="">
  </TD>
</TR>
<TR>
  <td width=25% class="rowlabel">Password</td>
  <TD width=50% class="rowdata">&nbsp;<INPUT NAME="pass" TYPE="password" autocomplete="off" VALUE=""/>
  </TD>
</TR>
<TR>
  <td width=25% class="rowlabel">Execute Access Control</td>
  <TD width=50% class="rowdata">
  %invoke wm.server.access.adminui:aclList%
  <SELECT name="acl">
<!--    <OPTION value="">&lt;Default ACL&gt;</OPTION> -->
  %loop aclgroups%
    <OPTION value="%value name%">%value name%</OPTION>
  %endloop%
  </SELECT>
  %endinvoke%
  </TD>
</TR>
<TR>
  <td width=25% class="rowlabel">Idle Timeout (in minutes)<BR>0 = none</td>
  <TD width=50% class="rowdata">&nbsp;<INPUT NAME="timeout" VALUE="" SIZE=5 MAXLENGTH=5>
  </TD>
</TR>
<td class="title" colspan="9">Security Settings used to connect to the Remote Server</td>
<TR>
  <td width=25% class="rowlabel">Use SSL</td>
  <TD width=50% class="rowdata">
	<input type="radio" name="ssl" value="yes">Yes</input>
	<input type="radio" name="ssl" value="no" checked>No</input>
  </TD>
</TR>
<TR>
  <td width=25% class="rowlabel">Private Key</td>
  <TD width=50% class="rowdata">&nbsp;<INPUT NAME="privKeyFile" VALUE="">
  </TD>
</TR>
<TR>
  <td width=25% class="rowlabel">Certificates</td>
  <TD width=50% class="rowdata">&nbsp;<INPUT NAME="certFiles" VALUE="">
  </TD>
</TR>
</FORM>
</TABLE>

%endif%

</BODY>
</HTML>
