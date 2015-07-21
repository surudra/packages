<HTML>
<HEAD>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">


  <TITLE>Integration Server Mime Type Settings</TITLE>
  <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
  <SCRIPT SRC="webMethods.js.txt"></SCRIPT>
</HEAD>

%ifvar mode equals('edit')%
<BODY onLoad="setNavigation('settings-mimetypes.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_MimeTypesScrn_Edit', 'foo');">
%else%
<BODY onLoad="setNavigation('settings-mimetypes.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_MimeTypesScrn', 'foo');">
%endif%
  <TABLE WIDTH="100%">
    <TR>
    %ifvar mode equals('edit')%
      <TD class="menusection-Settings" colspan="4">
        Settings &gt; 
		Resources &gt; 
		Mime Types &gt;
		Edit </TD>
    %else%
      <TD class="menusection-Settings" colspan="4">
        Settings &gt; 
		Resources &gt; 
		Mime Types </TD>
    %endif%
    </TR>
    <TR>

%ifvar action equals('change')%
  %invoke wm.server.mimetypes:writeMimeTypes%
    %ifvar message%
      <tr><td colspan="4">&nbsp;</td></tr>
      <TR><TD class="message" colspan="4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value message%</TD></TR>
    %endif%
  %endinvoke%
%endif%
%ifvar action equals('reload')%
  %invoke wm.server.mimetypes:initMimeTypes%
    %ifvar message%
      <tr><td colspan="4">&nbsp;</td></tr>
      <TR><TD class="message" colspan="4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value message%</TD></TR>
    %endif%
  %endinvoke%
%endif%

    <TR>
      <TD colspan=2>
        <UL>
          %ifvar mode equals('edit')%
          <LI><A HREF="settings-mimetypes.dsp">Return to Mime Types Settings</A></LI>
          %else% 
		  <LI><A HREF="settings-resources.dsp">Return to Resource Settings</A></LI>
          <LI><A HREF="settings-mimetypes.dsp?mode=edit">Edit Mime Types Settings</A></LI>
          <LI><A HREF="settings-mimetypes.dsp?action=reload">Reload Mime Types Settings</A></LI>
          %endif%
        </UL>
    </TR>
    <TR>
      <TD><IMG SRC="images/blank.gif" height=10 width=10 border=0></TD>
      <TD>
          <FORM action="settings-mimetypes.dsp" method="POST">
          <INPUT type="hidden" name="action" value="change">

        <TABLE class="tableForm" %ifvar mode equals('edit')%width="100%"%endif% >
%invoke wm.server.mimetypes:readMimeTypes%

          <TR>
            <TD class="heading">Mime Types Settings</TD>
          </TR>

          <TR>
            <TD class="oddcol-l">Content-Type  File Extension(s)</TD>
          </TR>

          <TR>
            <TD class="evenrow-l">
              %ifvar mode equals('edit')%
              <TEXTAREA style="width:100%" wrap="off" rows=15 cols=40 name="mimeTypes">%value mimeTypes%</TEXTAREA>
              %else%
              <TABLE width=100%>
                <TR>
                  <TD><PRE class="fixedwidth">%value mimeTypes%








</PRE>
                  </TD>
                </TR>
              </TABLE>
              %endif%
            </TD>
          </TR>
          %ifvar mode equals('edit')%
          <TR>
            <TD class="action">
              <INPUT type="submit" name="submit" value="Save Changes">
            </TD>
          </TR>
          %endif%
          </FORM>
          <TR>
            <TD class="oddrow-l">These settings go into the Integration Server <i>lib</i> directory and are used to define what HTTP Content-Type files of the listed extensions are.</TD>
          </TR>

%endinvoke%
        </TABLE>
      </TD>
    </TR>
  </TABLE>
</BODY>
