<HTML>
<HEAD>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">


<LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
<SCRIPT SRC="webMethods.js.txt"></SCRIPT>
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

</SCRIPT>
</HEAD>
<BODY onLoad="setNavigation('settings-remote.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_RemoteServersScrn');">
<TABLE width="100%">
<TR>
    <TD class="menusection-Settings" colspan="2">
    Settings &gt;
    Remote Servers </TD>
</TR>


%ifvar action%
%switch action%
%case 'add'%
  %invoke wm.server.remote:addServer%
        %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
          <TR><TD class="message" colspan="2">%value message%</TD></TR>
        %endif%
  %endif%
%case 'edit'%
  %invoke wm.server.remote:addServer%
        %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
          <TR><TD class="message" colspan="2">%value message%</TD></TR>
        %endif%
  %endif%
%case 'test'%
  %invoke wm.server.remote:testAlias%
        %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
          <TR><TD class="message" colspan="2">%value message%</TD></TR>
        %endif%
  %endif%
%case 'delete'%
  %invoke wm.server.remote:deleteServer%
        %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
          <TR><TD class="message" colspan="2">%value message%</TD></TR>
        %endif%
  %endif%
%endswitch%
%endif%


<TR>
    <TD colspan="2">
        <UL>
            <LI><A HREF="settings-remote-addedit.dsp">Create Remote Server Alias</A></LI>
        </UL>
    </TD>
</TR>
<TR>
    <TD></TD>
    <TD>
    <TABLE class="tableView" width=100%>

    <TR>
        <TD class="heading" colspan=10>Remote Servers List</TD>
    </TR>
%invoke wm.server.remote:serverList%
<TR>
   <TD nowrap class="oddcol-l">Alias</TD>
   <TD nowrap class="oddcol">Host</TD>
   <TD nowrap class="oddcol">Port</TD>
   <TD nowrap class="oddcol">User</TD>
   <TD nowrap class="oddcol">SSL</TD>
   <TD nowrap class="oddcol">Execute ACL</TD>
   <TD nowrap class="oddcol">KeepAlive Conns</TD>
   <TD nowrap class="oddcol">Timeout</TD>
   <TD nowrap class="oddcol">Test</TD>
   <TD nowrap class="oddcol">Delete</TD>
</TR>

%loop -struct servers%
%scope #$key%
<TR>
    <script>writeTD("rowdata-l");</script>

        <a
	   href="settings-remote-addedit.dsp?action=edit&retryServer=%value -urlencode retryServer%&alias=%value -urlencode alias%&host=%value -urlencode host%&port=%value -urlencode port%&user=%value -urlencode user%&ssl=%value -urlencode ssl%&keyStoreAlias=%value -urlencode keyStoreAlias%&keyAlias=%value -urlencode keyAlias%&acl=%value -urlencode acl%&keepalive=%value -urlencode keepalive%&timeout=%value -urlencode timeout%&pass=********"
        >%value alias%</a>

    </TD>
    <script>writeTD("rowdata");</script>%value host%</TD>
    <script>writeTD("rowdata");</script>%value port%</TD>
    <script>writeTD("rowdata");</script>%value user%</TD>
    <script>writeTD("rowdata");</script>
      %ifvar ssl equals('yes')%
        <IMG SRC="images/green_check.gif" height=13 width=13>Yes
      %else%
        No
      %endif%
    </TD>
    <script>writeTD("rowdata");</script>
      %ifvar acl%
        %ifvar acl equals('')%
          &lt;none&gt;
        %else%
          %value acl%
        %endif%
      %else%
        &lt;none&gt;
      %endif%</TD>
    <script>writeTD("rowdata");</script>%value keepalive%</TD>
    <script>writeTD("rowdata");</script>
      %ifvar timeout equals('-1')%&nbsp;%else%%value timeout%%endif%</TD>
    <script>writeTD("rowdata");</script><a class="imagelink" href="" onclick="return test('%value alias%');"><IMG src="icons/checkdot.gif" border="none" width="14" height="14" ></a></TD>
    <script>writeTD("rowdata");</script>
     %ifvar nodelete%
      &nbsp;
     %else%
  <a class="imagelink" href="" onClick="return confirmDelete('%value alias%');">
      <img src="icons/delete.gif" border="none"></a>
     %endif%</TD>

</TR>

    <script>swapRows();</script>
%endscope%
%endloop%
%endinvoke%
</TABLE>
</TD>
</TR>
</TABLE>

<FORM name="deleteform" action="settings-remote.dsp" method="POST">
  <INPUT type="hidden" name="action" value="delete">
  <INPUT type="hidden" name="alias">
</FORM>

<FORM name="testform" action="settings-remote.dsp" method="POST">
  <INPUT type="hidden" name="action" value="test">
  <INPUT type="hidden" name="alias">
</FORM>

</BODY>
</HTML>
