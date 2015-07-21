<html>
<head>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">


<title>ServerUI</title>
<LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
<base target="_self">
<style>
  .listbox  { width: 100%; }
</style>
</head>

<script src="client.js.txt"></script>
<script src="acls.js.txt"></script>
<script src="webMethods.js.txt"></script>


	<!-- SUB -->
	<SCRIPT>
	  var oTo;
	  function callback(val){
	  	insertGroup(oTo, val);
	  }
	</SCRIPT>


<BODY class="main" onLoad="setNavigation('acls.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_ACLsScrn');" onbeforeunload="checkDirty();">


<table width="100%">
  <tr>
    <td class="menusection-Security" colspan="2">
      Security &gt;
      Access Control Lists
    </td>
  </tr>

%ifvar action equals('update')%
    %invoke wm.server.access:updateACLs%
        %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
            <TR><TD colspan="2" class="message">&nbsp;&nbsp;%value message%</TD></TR>
        %endif%
    %endinvoke%
%endif%

%ifvar action equals('add')%
    %invoke wm.server.access:addACLS%
        %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
            <TR><TD colspan="2" class="message">&nbsp;&nbsp;%value message%</TD></TR>
        %endif%
    %endinvoke%
%endif%

%ifvar action equals('changePrecedence')%
    %invoke wm.server.access:setDefaultAccess%
        %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
            <TR><TD colspan="2" class="message">&nbsp;&nbsp;%value message%</TD></TR>
        %endif%
    %endinvoke%
%endif%

%ifvar action equals('remove')%
    %invoke wm.server.access:removeACLs%
        %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
            <TR><TD colspan="2" class="message">&nbsp;&nbsp;%value message%</TD></TR>
        %endif%
    %endinvoke%
%endif%

    <tr>
      <TD colspan="2">
        <ul>
          <li><a href="acl-addremove.dsp">Add and Remove ACLs</a></li>
        </ul>
      </td>
    </tr>
    <tr>
	<TD></TD>
<form id="form" name="form" method="POST" action="acls.dsp" onsubmit="return submitForm();" >
    <input type="hidden" name="acldata" value="">
    <input type="hidden" name="action" value="submit">
    <input type="hidden" name="precedence" value="deny">

      <td>
      
        <table class="tableForm" width="95%">
          <tr>
            <td class="heading">ACL Membership</td>
          </tr>
          <tr>
            <td class="evencol-l">
              <table class="tableInline" border="0" cellspacing="0" cellpadding="0" width="50%">
                <tr>
                  <td colspan=2><img border="0" src="images/blank.gif" width="5" height="5"></td>
                </tr>
                      <tr>
                        <td class="evenrow" nowrap>Select ACL </td>
                        <td class="evenrow-l" width="100%"><select onchange="changeACL(this.options[this.selectedIndex].value);" size="1" name="acl" class="listbox">
                <option selected>---none---</option>
                <option>placeholder placeholder</option>
                <option>placeholder placeholder</option>
                <option>placeholder placeholder</option>
                <option>placeholder placeholder</option>
                <option>placeholder placeholder</option>
                <option>placeholder placeholder</option>
                <option>placeholder placeholder</option>

              </select></td>
                      </tr>
                <tr>
                  <td colspan=2><img border="0" src="images/blank.gif" width="5" height="5"></td>
                </tr>
              </table>
            </td>
          </tr>
          <tr>
            <td class="oddcol">
              <table class="tableInline" border="0" cellspacing="1" cellpadding="4" width="100%">
                <tr>
                  <td valign="top" colspan="3">
                    Group associations for this ACL:
                  </td>
                </tr>
                <tr>
                  <td valign="top" width="40%">
          <table cellspacing="0" cellpading="0" width="100%">
          <tr><td align="center" class="grouping-positive">Allowed</td></tr>
                    <tr><td class="oddcol">
                    <select class="listbox" onchange="unselect(this, deny,groups);" size="10" id="allow" name="allow" multiple>
                    <option>-----none-----</option>
          </select>
                  </td></tr>
                  <tr><td class="oddcol" align="right">
		<link rel="stylesheet" type="text/css" href="subLookup.css" />
		<script type="text/javascript" src="subLookup.js"></script>
		   <a style="text-decoration: none" class="submodal" href="subGroupLookup.dsp"><input onclick="oTo=allowList" type="button" value="Add"></a>
                  <input onclick="removeGroup(allowList);" type="button" value="Remove"></td></tr>
                    </table>
                  </td>
                  
                  
                  
                  <td valign="top" width="40%">
                  <table cellspacing="0" cellpading="0" width="100%"> 
                  <tr><td align="center" class="grouping-negative">Denied</td></tr>
                  <tr><td class="oddcol">
                    <select class="listbox" onchange="unselect(this, allow,groups);"  size="10" name="deny" multiple>
                  <option>-----none-----</option>
                  </select>
                  </td></tr>
                  <tr><td class="oddcol" align="left">
                  <tr><td class="oddcol" align="right">
                  <a style="text-decoration: none" class="submodal" href="subGroupLookup.dsp"><input onclick="oTo=denyList" type="button" value="Add"></a>
                  <input onclick="removeGroup(denyList);" type="button" value="Remove">                  
                  </td></tr>
                </table>
              </td>
                </tr>
        <tr><td colspan=3>
        <center>
                    Resulting local users in this ACL with access:<br>
                    <textarea class="oddrow-l" onfocus="allowList.focus();" rows="3" name="users" cols="35">-----none----</textarea>
                </center>
        </td></tr>
              </table>
            </td>
          </tr>
          <tr>
            <td class="action">
              <input type="submit" onclick="saveChanges();"  value="Save Changes" name="OK">
            </td>
          </tr>
      </table>

      </form>
    </td>
  </tr>
</table>
<script>
  //declare form objects as variables
  var TheForm = document.forms["form"];
  var userBox = TheForm.users;
  var allowList = TheForm.allow;
  var denyList = TheForm.deny;
  var aclList = TheForm.acl;
  var newACL = TheForm.newACL;
  var precedence = TheForm.precedence;
  var hiddenSave = TheForm.acldata;
    var hiddenAction = TheForm.action;
</script>

 
<script>
%invoke wm.server.access:groupList%
%loop groups%
addGroup("%value name%", [%loop membership%"%value%"%loopsep ', '% %endloop%]);
%endloop%
%endinvoke%

%invoke wm.server.access.adminui:aclList%
%loop aclgroups%
addACL("%value name%", [%loop allow%"%value%"%loopsep ', '%%endloop%],[%loop deny%"%value%"%loopsep ', '%%endloop%]);
%endloop%
%endinvoke%
</script>



<script>
setupPage();
</script>

</body>
</html>


