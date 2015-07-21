<HTML>
<HEAD>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">


<LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
<SCRIPT SRC="webMethods.js.txt"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">
  function confirmDelete (alias) {
    var msg = "OK to delete alias '"+alias+"' from configuration?";
    if (confirm (msg)) {
        document.deleteform.alias.value = alias;
            document.deleteform.submit();
          return false;
    } else return false;
  }

</SCRIPT>
</HEAD>
<BODY onLoad="setNavigation('settings-alias.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_URL_Aliases');">
<TABLE width="100%">
<TR>
    <TD class="menusection-Settings" colspan="2">
    Settings &gt;
    URL Aliases </TD>
</TR>

%value message%

%ifvar action%
%switch action%
%case 'add'%
  %invoke wm.server.httpUrlAlias:addAlias%
        %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
          <TR><TD class="message" colspan="2">%value message%</TD></TR>
        %endif%
  %endinvoke%
%case 'edit'%
  %invoke wm.server.httpUrlAlias:updateAlias%
        %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
          <TR><TD class="message" colspan="2">%value message%</TD></TR>
        %endif%
  %endinvoke%
%case 'delete'%
  %invoke wm.server.httpUrlAlias:deleteAlias%
        %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
          <TR><TD class="message" colspan="2">%value message%</TD></TR>
        %endif%
  %endinvoke%
%endswitch%
%endif%


<TR>
    <TD colspan="2">
        <UL>
            <LI><A HREF="settings-alias-addedit.dsp?association=1&isDev=false">Create URL Alias</A></LI>
        </UL>
    </TD>
</TR>
<TR>
    <TD></TD>
    <TD>
    <TABLE class="tableView" width=100%>

    <TR>
        <TD class="heading" colspan=10>HTTP URL Alias List</TD>
    </TR>
%invoke wm.server.httpUrlAlias:listAlias%
<TR>
   <TD class="oddcol-l">Alias</TD>
   <TD class="oddcol">URL Path</TD>
   <TD class="oddcol">Association</TD>
   <TD class="oddcol">Package</TD>
   <TD class="oddcol">Delete</TD>
</TR>

%loop aliasList%
<TR>
    <script>writeTD("rowdata-l");</script>
        <a
	   href="settings-alias-addedit.dsp?action=edit&alias=%value -urlencode alias%&urlPath=%value -urlencode urlPath%&association=%value -urlencode association%&package=%value -urlencode package%&isDev=%switch association%%case '0'%false%case '1'%false%case%true%endif%"
        >%value alias%</a>
    </TD>
    <script>writeTD("rowdata");</script>%value urlPath%</TD>
    <script>writeTD("rowdata");</script>
      %switch association%
      %case '0'%
        Server
      %case '1'%
        Package
      %case%
        %value association%
      %endif%
    </TD>  
    <script>writeTD("rowdata");</script>%value package%</TD>
    <script>writeTD("rowdata");</script>
     %ifvar nodelete%
      &nbsp;
     %else%
  <a class="imagelink" href="" onClick="return confirmDelete('%value alias%');">
      <img src="icons/delete.gif" border="none"></a>
     %endif%</TD>

</TR>

    <script>swapRows();</script>
%endloop%
%endinvoke%
</TABLE>
</TD>
</TR>
</TABLE>

<FORM name="deleteform" action="settings-alias.dsp" method="POST">
  <INPUT type="hidden" name="action" value="delete">
  <INPUT type="hidden" name="alias">
</FORM>

</BODY>
</HTML>
