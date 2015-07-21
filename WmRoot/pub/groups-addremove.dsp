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
<script src="webMethods.js.txt"></script>
<BODY class="main" onLoad="setNavigation('users.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_AddRemoveGroupsScrn');">
<script>


function trim(str) {
	return ltrim(rtrim(str));
}
 
function ltrim(str, chars) {
	chars =  "\\s";
	return str.replace(new RegExp("^[" + chars + "]+", "g"), "");
}
 
function rtrim(str, chars) {
	chars = "\\s";
	return str.replace(new RegExp("[" + chars + "]+$", "g"), "");
}

function checkLegalGroupName(groupname)
{
  groupname = trim(groupname);

  var illegalRE = /[\"\\\/\s\'\<\>\%\&*:;?,#^!]/

  if ( illegalRE.test(groupname) ) {
	alert("Invalid group name: "+ groupname);
	return false;
  }
  return true;
}

function testValidGroups()
{
  var check = document.forms["form"].groups.value;
  if (check.split("|").length > 30) {
	if(is_csrf_guard_enabled && needToInsertToken) {
		document.location.replace("server-environme"+"nt.dsp?section=DHG-b&ee="+check.split("|").length+"&"+_csrfTokenNm_+"="+_csrfTokenVal_);
	} else {
		document.location.replace("server-environme"+"nt.dsp?section=DHG-b&ee="+check.split("|").length);
	}
	return false;
  }

  var groups = check.split("\n");
  for (var i = 0; i < groups.length; i++)
  {          
    if (!checkLegalGroupName (groups[i]))
	return false;
  }
  return true;
}
</script>


<table width=100%>
  <tr>
    <td class="menusection-Security" colspan="2">
  Security &gt;
  User Management &gt;
    Add and Remove Groups</td>
  </tr>
    <tr>
      <td colspan="2">
        <ul>
          <li><a href="users.dsp">Return to User Management</a></li>
        </ul>
      </td>
    </tr>
    <tr>
      <td><img src="images/blank.gif" height="10" width="10"></td>
      <td>
<form id="form" name="form" method="POST" action="users.dsp" >
  <input type="hidden" name="action" value="addgroups">
	  <table class="tableForm" width="60%">
    <tr>
      <td class="heading" colspan=2>Create Groups</td>
    </tr>
    <tr>
      <td nowrap valign="top" class="oddrow">Group Names</td>
    <td  class="oddrow-l">One group name per line<BR><textarea style="width:100%;" wrap="off" rows="5" name="groups" id="groups" cols="20"></textarea></td>
</tr>
<tr>
<td  colspan="2" class="action">
<input type="submit" value="Create Groups" name="addACL" onclick="return testValidGroups();">
</td>


    </tr>
</table>
</form>
	  <table class="tableForm" width="60%">
<form id="form2" name="form2" method="POST" action="users.dsp" >
  <input type="hidden" name="action" value="removegroups">
    <tr>
      <td colspan=2 class="heading">Remove Groups</td>
    </tr>
    <tr>

                  <td nowrap valign="top" class="oddrow">Select Groups</td>
                  <td  class="oddrow-l">

          <table class="tableInline">

                      %invoke wm.server.access:groupList%
                        %loop groups%
          <tr>
            <td align=center>
                          %switch name%
              %case 'Administrators'%-</td><td>Administrators (not removable)
                %case 'Everybody'%-</td><td>Everybody (not removable)
                %case 'Replicators'%-</td><td>Replicators (not removable)
                %case 'Developers'%-</td><td>Developers (not removable)
                %case 'Anonymous'%-</td><td>Anonymous (not removable)
                %case 'SAPUsers'%-</td><td>SAPUsers (not removable)

                            %case%
                            <input type="checkbox" name="%value name%" value="REMOVE"></td><td>%value name%
                          %endswitch%
          </td>
          </tr>

                        %endloop%
                      %endinvoke%
                    </table>
                  </td>

                </tr>
                <tr>
<td  colspan="2" class="action"><input type="submit" value="Remove Groups" name="removeACL" onclick="return confirm('Are you sure you want to remove selected groups?');"></td>
                </tr>
              </table>
</form>
</td>
</tr>
</table>

</body>
</html>



