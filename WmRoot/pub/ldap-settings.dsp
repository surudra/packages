<HTML>
  <HEAD>
    <meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">
    <TITLE>Package Exchange</TITLE>
    <SCRIPT SRC="webMethods.js.txt"></SCRIPT>
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    <script>
    <!--
    function wrap(s, n) {
        var ret='';
        while(true) {
            var len = s.length;
            if(len <= n) {
                ret += s;
                return ret;
            }
            ret+= ((s.substring(0,n))+'<BR/>');
            s = s.substring(n);
        }
    }

    function confirmDelete(url) {
       return confirm("Are you sure you want to delete the configuration for\n"+wrap(url,60)+"?");

    }
    //-->
    </script>
  </HEAD>
  <BODY onLoad="setNavigation('users.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_ExternalUserMgmtConfigScrn');">
    <TABLE WIDTH=100%>

    <TR>
      <TD class="menusection-Security" colspan=2>
        Security &gt;
        Users &amp; Groups &gt;
        LDAP Configuration</TD>
    </TR>

%ifvar action equals('delete')%
  %invoke wm.server.ldap:deleteConfiguredServer%
      %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
  <TR><TD class="message" colspan=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value message%</TD></TR>
      %endif%
  %endinvoke%
%endif%

%ifvar action equals('priority')%
  %invoke wm.server.ldap:updatePriority%
      %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
  <TR><TD class="message" colspan=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value message%</TD></TR>
      %endif%
  %endinvoke%
%endif%

%ifvar action equals('edit')%
  %invoke wm.server.ldap:editConfiguredServer%
      %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
  <TR><TD class="message" colspan=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value message%</TD></TR>
      %endif%
  %endinvoke%
%endif%

%ifvar action equals('add')%
  %invoke wm.server.ldap:addConfiguredServer%
      %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
  <TR><TD class="message" colspan=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value message%</TD></TR>
      %endif%
  %endinvoke%
%endif%



%invoke wm.server.ldap:getSettings%

    <TR>
      <TD colspan=2>
        <UL>
      <LI><A HREF="users.dsp">Return to User Management</A></LI>
            <LI><A HREF="jndi-settings.dsp?doc=edit">Edit LDAP Configuration</A></LI>

      </TD>
    </TR>

    <TR>
      <TD><IMG SRC="images/blank.gif" height=10 width=10></TD>
      <TD>
        <TABLE class="tableView">
          <TR>
            <TD class="heading" colspan=2>
              LDAP Configuration
            </TD>
          </TR>
          <TR>
            <script>writeTD("row");</script>
                Provider
            </TD>
            <script>writeTD("rowdata-l")</script>LDAP
            </TD>
          </TR>
            <script>swapRows();</script>
          <TR>
            <script>writeTD("row");</script>
                Cache Size (Number of Users)
            </TD>
            <script>writeTD("rowdata-l");writeEdit("%value doc%","%value -code CacheSize%","%value -code CacheSize%");</script></TD>

          </TR>
            <script>swapRows();</script>
          %comment% <!-- not going to expose CacheTTL in the UI -->
          <TR>
            <script>writeTD("row");</script>
                Cache Time-to-Live (Hours)
            </TD>
            <script>writeTD("rowdata-l");writeEdit("%value doc%","%value -code CacheTTL%","%value -code CacheTTL%");</script></TD>

          </TR>
            <script>swapRows();</script>
          %endcomment%
          <TR>
            <script>writeTD("row");</script>
                Credential Time-to-Live (Minutes)
            </TD>
            <script>writeTD("rowdata-l");writeEdit("%value doc%","%value -code CacheExpire%","%value -code CacheExpire%");</script></TD>

          </TR>
            <script>swapRows();</script>

        </TABLE>
<!-- ================================= -->

<TR>
    <TD colspan="2">
        <UL>
            <LI><A HREF="ldap-addedit.dsp">Add LDAP Directory</A></LI>
        </UL>
    </TD>
</TR>
<TR>
    <TD><IMG SRC="images/blank.gif" height=10 width=10></TD>
    <TD>
    <TABLE class="tableView" width=100%>

    <TR>
        <TD class="heading" colspan=9>LDAP Directory List</TD>
    </TR>
<TR>
   <TD class="evencol-l" width="70%">Directory URL</TD>
   <TD class="evencol-l">Delete</TD>
   <TD class="evencol-l">Priority</TD>
</TR>

%loop ConfiguredServers%
<TR valign=top>
   <script>writeTD("rowdata-l");</script>
   <a href="ldap-addedit.dsp?action=edit&index=%value $index%"><script>document.writeln(wrap('%value  url%', 90));</script></a>
   </TD>
   <!--
   <script>writeTD("rowdata");</script>
    <a href="ldap-acl.dsp?index=%value $index%">Map</a>
    </TD>
    -->
   <script>writeTD("rowdata");</script>
    <a class="imagelink" href="ldap-settings.dsp?action=delete&index=%value $index%" onClick="return confirmDelete('%value -code url%');">
      <img src="icons/delete.gif" border="none"></a>
    </TD>
   <script>writeTD("rowdata");</script>
    <a href="ldap-settings.dsp?action=priority&direction=up&index=%value $index%"><img id = "link_up_%value $index%" src="icons/moveup_enabled.png" border="none"></a> 
    <a href="ldap-settings.dsp?action=priority&direction=down&index=%value $index%"><img id = "link_down_%value $index%" src="icons/movedown_enabled.png" border="none"></a> 
    %ifvar $index equals('0')%
          <script>
                var firstUp =   document.getElementById('link_up_%value $index%');
                var lastDown;
          </script>
    %endif%
    <script>
        lastDown =  document.getElementById('link_down_%value $index%');
    </script> 
   </TD>
</TR>
    <script>swapRows();</script>
%endloop%    
%endinvoke%
<script>
    function disableDirectionImage(link,direction){
         if('UP' == direction){
            link.src='icons/moveup_disabled.png';
         }
         else{
            link.src='icons/movedown_disabled.png';
         }
         link.disabled=true;
         link.style.color='gray';
         link.style.cursor='default';
         link.onclick=function (){return false;}
    }
    disableDirectionImage(firstUp,'UP');
    disableDirectionImage(lastDown,'DOWN');
</script>

<!-- ================================= -->


        </FORM>

        </TD>
      </TR>
    </TABLE>

</BODY>
</HTML>
