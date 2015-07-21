
<HTML>
  <HEAD>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">


    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    <SCRIPT SRC="webMethods.js.txt">
    </SCRIPT>
  </HEAD>
  %ifvar action equals('edit')%
  <BODY onLoad="setNavigation('users.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_LDAPdirectoryScrn');">
  %else%
  <BODY onLoad="setNavigation('users.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_LDAPdirectoryScrn');">
  %endif%
    <TABLE width="100%">
      <TR>
        <TD class="menusection-Settings" colspan="2">
            Settings &gt;
            LDAP Directory &gt;
            %ifvar action equals('edit')%
                Edit
            %else%
                Add
            %endif%
        </TD>
      </TR>
      <TR>
        <TD colspan="2">
          <UL>
            <LI><A HREF="ldap-settings.dsp">Return to User Management</A></LI>
          </UL>
        </TD>
      </TR>
      <TR>
        <TD><IMG SRC="images/blank.gif" height="10" width="10"></TD>
        <TD>
      <TABLE class="tableForm">
        <TR>
            <TD colspan="3" class="heading">LDAP Directory Settings</TD>
        </TR>
          <FORM NAME="addform" ACTION="ldap-settings.dsp" METHOD="POST">
          <SCRIPT LANGUAGE="JavaScript">
          var passwordChanged = false;
          function confirmEdit () {
            if((document.addform.url.value.indexOf('ldap://') != 0 ||
                document.addform.url.value.length < 8) && 
               (document.addform.url.value.indexOf('ldaps://') != 0 ||
                document.addform.url.value.length < 9)) {
              alert ("The Directory URL is required and must begin with ldap:// or ldaps://.");
              document.addform.url.focus();
              return false;
            }
            if(!isInteger(document.addform.timeout.value)) {
              alert ("The Connection Timeout must be an integer number of seconds.");
              document.addform.timeout.focus();
              return false;
            }
            if(!isIntegerGreaterThan(document.addform.poolmin.value, -1)) {
              alert ("The Minimum Connection Pool Size must be greater than or equal to zero.");
              document.addform.poolmin.focus();
              return false;
            }
            if(!isIntegerGreaterThan(document.addform.poolmax.value, document.addform.poolmin.value-1)) {
              alert ("The Maximum Connection Pool Size must be greater than or equal to the Minimum Connection Pool Size.");
              document.addform.poolmax.focus();
              return false;
            }
            // mattr or group needs to be set
            if(document.addform.mattr.value == '' &&
               document.addform.group.selectedIndex == 0) {
               alert ("You must provide a value for at least one of the Default Group or the Group Member Attribute fields.");
               document.addform.mattr.focus();
               return false;
            }
            
            //Validate guid & group dn
            if(document.addform.gidprop.value == '' ) {
	                   alert ("You must provide a value for Group ID Property.");
	                   document.addform.gidprop.focus();
	                   return false;
            }
            

            // do this last because we don't want to click okay and then
            // get more warnings.
            if(!isIntegerGreaterThan(document.addform.timeout.value, 0)) {
              if(!confirm("Setting a Connection Timeout less than zero will cause a request to fail immediately if no resources are available, and a value equal to zero will cause the server to wait forever for resources to become available.  Any non-positive value will cause the connection timeout to be the default value for TCP on your system.")) {
                document.addform.timeout.focus();
                return false;
              }
            }


            if(!passwordChanged) {
                // don't want to change pw to '********'!!
                document.addform.cred.value = ""; 
            }
            document.addform.submit();
            return true;
          }
          function confirmAdd () {
            return confirmEdit();
          }
          
          </SCRIPT>
          %invoke wm.server.ldap:getConfiguredServer%
          <TR>
            <TD colspan=2 class="evenrow">Directory URL</TD>
            <TD class="evenrow-l">
              <INPUT NAME="url" size="40" VALUE="%ifvar url%%value url%%else%ldap://%endif%"> </TD>
          </TR>
          <TR>
            <TD colspan=2 class="oddrow">Principal</TD>
            <TD class="oddrow-l">
              <INPUT NAME="prin" size="40" VALUE="%value prin%"> </TD>
          </TR>
          <TR>
            <TD colspan=2 class="evenrow">Credentials</TD>
            <TD class="evenrow-l">
              <INPUT NAME="cred" size="40" TYPE="password" autocomplete="off" %ifvar action equals('edit')%VALUE="%ifvar -notempty prin%********%endif%"%endif% onChange="javascript:passwordChanged=true;" /> </TD>
          </TR>
          <TR>
            <TD colspan=2 class="oddrow">Connection Timeout (seconds)</TD>
            <TD class="oddrow-l">
              <INPUT NAME="timeout" size="5" VALUE="%ifvar timeout%%value timeout%%else%5%endif%"> </TD>
          </TR>
          <TR>
            <TD colspan=2 class="evenrow">Minimum Connection Pool Size</TD>
            <TD class="evenrow-l">
              <INPUT NAME="poolmin" size="5" VALUE="%ifvar poolmin%%value poolmin%%else%0%endif%"> </TD>
          </TR>
          <TR>
            <TD colspan=2 class="oddrow">Maximum Connection Pool Size</TD>
            <TD class="oddrow-l">
              <INPUT NAME="poolmax" size="5" VALUE="%ifvar poolmax%%value poolmax%%else%10%endif%"> </TD>
          </TR>
          <TR>
            <TD rowspan=2 class="evenrow-l"><input %ifvar useaf equals('false')%%else%checked%endif% type="radio" name="useaf" value="true"
              onClick="this.form.dnprefix.disabled=false;this.form.dnsuffix.disabled=false;this.form.uidprop.disabled=true;this.form.userrootdn.disabled=true;"
              >Synthesize DN</TD>
              <td class="evenrow">DN Prefix</td>
              <td class="evenrow-l"><INPUT %ifvar useaf equals('false')%disabled%endif% NAME="dnprefix" size="40" VALUE="%value dnprefix%"></td></tr>

              <tr><td class="evenrow">DN Suffix</td>
              <td class="evenrow-l"><INPUT %ifvar useaf equals('false')%disabled%endif% NAME="dnsuffix" size="40" VALUE="%value dnsuffix%"></td>
          </TR>
          <TR>
            <TD rowspan=2 class="oddrow-l"><input type="radio" %ifvar useaf equals('false')%checked%endif% name="useaf" value="false"
              onClick="this.form.dnprefix.disabled=true;this.form.dnsuffix.disabled=true;this.form.uidprop.disabled=false;this.form.userrootdn.disabled=false;"
              >Query DN</TD>
              <td class="oddrow">UID Property</td>
              <td class="oddrow-l"><INPUT %ifvar useaf equals('false')%%else%disabled%endif% NAME="uidprop" size="40" VALUE="%value uidprop%"></td></tr>

              <tr><td class="oddrow">User Root DN</td>
              <td class="oddrow-l"><INPUT %ifvar useaf equals('false')%%else%disabled%endif% NAME="userrootdn" size="40" VALUE="%value userrootdn%"></td>
          </TR>
          <TR>
            <TD colspan=2 class="evenrow">Default Group</TD>
            <TD class="evenrow-l">

                %invoke wm.server.access:groupList%
                <SELECT NAME="group">
                    <OPTION value="">&lt;None&gt;</OPTION>
                    %loop groups%
                    <OPTION value="%value name%"
                    %ifvar name vequals('../group')% selected %endif%
                    >%value name%</OPTION>
                    %endloop%
                </SELECT>
                %endinvoke%
            </TD>
          </TR>
          <TR>
            <TD colspan=2 class="oddrow">Group Member Attribute</TD>
            <TD class="oddrow-l">
              <INPUT NAME="mattr" size="20" VALUE="%value mattr%"> </TD>
          </TR>
	  <TR>
	      <TD colspan=2 class="evenrow">Group ID Property</TD>
	      <TD class="evenrow-l">
		<INPUT NAME="gidprop" size="40" VALUE="%value gidprop%"> </TD>
	  </TR>
	  <TR>
	      <TD colspan=2 class="oddrow">Group Root DN</TD>
	      <TD class="oddrow-l">
		<INPUT NAME="grouprootdn" size="40" VALUE="%value grouprootdn%"> </TD>
          </TR>
	  
          <TR>
            <TD colspan=3 class="action">
            %ifvar action equals('edit')%
              <INPUT TYPE="hidden" NAME="index" VALUE="%value index%">
              <INPUT TYPE="hidden" NAME="action" VALUE="edit">
              <INPUT type="button" value="Save Changes" onclick="return confirmEdit();">
            %else%
              <INPUT TYPE="hidden" NAME="action" VALUE="add">
              <INPUT type="button" value="Save Changes" onclick="return confirmAdd();">
            %endif%
            </TD>
          </TR>
          %endinvoke%

          
        </FORM>
      </TABLE>
    </TD>
  </TR>
</TABLE>

    </BODY>
  </HTML>
