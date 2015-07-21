
<HTML>
  <HEAD>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">


    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    <SCRIPT SRC="webMethods.js.txt">
    </SCRIPT>
  </HEAD>
  <BODY onLoad="setNavigation('users.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_MapGroupsToACLsScrn');">
    <TABLE width="100%">
      <TR>
        <TD class="menusection-Settings" colspan="2">
            Settings &gt;
            LDAP Directory &gt;
            Map Groups to ACLs
        </TD>
      </TR>
      <TR>
        <TD colspan="2">
          <UL>
            <LI><A HREF="ldap-settings.dsp">Return to External User Management</A></LI>
          </UL>
        </TD>
      </TR>
      %ifvar action equals('list')%
      <TR>
        <TD colspan="2">
          <UL>
            <LI><A HREF="ldap-acl.dsp?index=%value index%">Return to Find LDAP Groups</A></LI>
          </UL>
        </TD>
      </TR>
      %endif%
      <TR>
        <TD><IMG SRC="images/blank.gif" height="10" width="10"></TD>
        <TD>
          <FORM NAME="addform" ACTION="ldap-acl.dsp" METHOD="POST">
      <TABLE class="tableForm">
%ifvar action equals('create')%
%invoke wm.server.ldap:createMappings%
        %ifvar message%
        <tr><td colspan="2">&nbsp;</td></tr>
        <TR><TD class="message" colspan=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value message%</TD></TR>
        %else%
        <tr><td colspan="2">&nbsp;</td></tr>
        <TR><TD class="message" colspan=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Mappings created successfully.</TD></TR>
        %endif%
%endinvoke%
%endif%
%ifvar action equals('list')%
%invoke wm.server.ldap:findLDAPGroups%
        %ifvar message%
        <tr><td colspan="2">&nbsp;</td></tr>
        <TR><TD class="message" colspan=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value message%</TD></TR>
        %endif%
        <TR>
            <TD colspan="2" class="heading">Map LDAP Groups to
                                            %value aclgroup% ACL</TD>
        </TR>
        <TR>
            <SCRIPT>
              function select(v) {
                if(document.addform.mapping) {
                for(i=0;i<document.addform.mapping.length;i++) {
                  document.addform.mapping[i].checked=v;
                }
                }
              }
            </SCRIPT>
            <TD class="oddcol">Select<br>
                <a onClick="javascript:select(true); return false;" href="">all</a>|<a onClick="javascript:select(false); return false;" href="">none</a></TD>
            <TD class="oddcol-l">Group Name</TD>
        </TR>
%loop -struct groups%
        <TR>
            <script>writeTD("rowdata");</script>
                <input type="checkbox" name="mapping" value="%value $key%;%value%">
            </TD>
            <script>writeTD("rowdata-l");</script>
                %value $key%
            </TD>
        </TR>
        <script>swapRows();</script>
%endloop%
%endinvoke%
        <TR>
          <TD colspan=2 class="action">
            <INPUT type="hidden" name="action" value="create">
            <INPUT TYPE="hidden" NAME="index" VALUE="%value index%">
            <INPUT TYPE="hidden" NAME="aclgroup" VALUE="%value aclgroup%">
            <INPUT type="hidden" name="filter" value="%value filter%">
            <INPUT type="hidden" name="grouproot" value="%value grouproot%">
            <INPUT type="hidden" name="gnattr" value="%value gnattr%">
            <INPUT type="submit" value="Create Mappings">
          </TD>
        </TR>
%else%
        <TR>
            <TD colspan="2" class="heading">Find LDAP Groups</TD>
        </TR>
          <TR>
            <TD class="oddrow">ACL</TD>
            <TD class="oddrow-l">
              %invoke wm.server.access:aclList%
              <SELECT name="aclgroup">
                 %loop aclgroups%
                 <OPTION value="%value name%">%value name%</OPTION>
                 %endloop%
              </SELECT>
              %endinvoke%
              </TD>
          </TR>
          <TR>
            <TD class="evenrow">Group Root</TD>
            <TD class="evenrow-l">
              <INPUT NAME="grouproot" SIZE=50 VALUE="%value grouproot%"> </TD>
          </TR>
          <TR>
            <TD class="oddrow">Filter</TD>
            <TD class="oddrow-l">
              <INPUT NAME="filter" SIZE=50 VALUE="%value filter%"> </TD>
          </TR>
          <TR>
            <TD class="evenrow">Group Name Attribute</TD>
            <TD class="evenrow-l">
              <INPUT NAME="gnattr" SIZE=50 VALUE="%value gnattr%"> </TD>
          </TR>
          <TR>
            <TD colspan=2 class="action">
              <INPUT type="hidden" name="action" value="list">
              <INPUT TYPE="hidden" NAME="index" VALUE="%value index%">
              <INPUT type="submit" value="Run Query">
            </TD>
          </TR>
%endif%
      </TABLE>
        </FORM>
    </TD>
  </TR>
</TABLE>

    </BODY>
  </HTML>
