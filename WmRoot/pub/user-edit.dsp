<html>
  <head>
  <meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <META HTTP-EQUIV="Expires" CONTENT="-1">
  <title>User Edit</title>
  <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
</head>
<body>
  <table width="100%">
    <TR>
      <TD class="menusection-Security" colspan="2">
        Security&gt;
        Users &amp; Groups&gt;
        Change Password</TD>
    </TR>
    <TR>
      <TD colspan=2>
        <UL>
          <LI><A HREF="users.dsp">Return to Users and Groups</A></LI>
        </UL>
      </TD>
    </TR>

    <TR>
      <TD><IMG SRC="images/blank.gif" height=10 width=10></TD>
      <TD>
        <TABLE class="tableForm">

<SCRIPT src="webMethods.js.txt"></SCRIPT>
<script>


function checkEverything()
{
  if (!verifyRequiredField('setPassword', 'password'))
    {
      alert("A new password is required.");
      return false;
    }

  if (!verifyRequiredField('setPassword', 'password2'))
    {
      alert("The password must be typed in twice to verify it is typed in correctly.");
      return false;
    }
  
  try {
   var pw = document.forms['setPassword'].password.value;  
  if ( pw.search(/^\*+/) >= 0 )
    {
      alert("The password must not start with *");
      return false;
    }
  } catch (e) {
    alert('password error = ' + e);
  }

	if (document.setPassword.allowDigestAuthentication.checked)
	{
		document.setPassword.allowDigestAuth.value = true;
	}
	else
	{
		document.setPassword.allowDigestAuth.value = false;
	}
  return verifyFieldsEqual('setPassword', 'password', 'password2');

}
</script>
		%invoke wm.server.access:isDigestAuthAllowedForUser%
		

        <FORM NAME="setPassword" METHOD="POST" ACTION="users.dsp">
        <INPUT TYPE="hidden" NAME="username" VALUE="%value username%">
        <INPUT TYPE="hidden" NAME="action" VALUE="setPassword">
		<input type="hidden" name="allowDigestAuth" value="false">
          <TR>
            <TD class="heading" colspan=2>Change Password</TD>
          </TR>
          <TR>
            <TD class="oddrow">User</TD>
            <TD class="oddrow-l"><b>%value username%</b>
            </TD>
          </TR>


          <TR><TD class="evenrow">New Password</TD>
            <TD class="evenrow-l"><INPUT type="password" name="password" autocomplete="off"></INPUT></TD>
          </TR>


          <TR><TD class="oddrow">Confirm Password</TD>
            <TD class="oddrow-l"><INPUT type="password" name="password2" autocomplete="off"></INPUT></TD>
          </TR>

		 <tr>
			<td class="evenrow">Allow Digest Authentication</td>
            <td class="evenrow-l">
				<input type="checkbox" name="allowDigestAuthentication" id="allowDigestAuthentication" %ifvar allowDigestAuthentication equals('true')%checked%endif% >
            </td>
          </tr>


          <TR>
            <TD class="action" colspan=2>
            <INPUT class="data" type="submit" onclick="return checkEverything();" value="Save Password">
            </TD>
          </TR>
        </FORM>
%endinvoke%



</table>
</td></tr></table>
</body>

</html>
